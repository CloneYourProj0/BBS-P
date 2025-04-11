package com.gem.bbs.controller;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.Question;
import com.gem.bbs.entity.User;
import com.gem.bbs.service.QuestionService;
import com.gem.bbs.service.UserService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


@Controller
@Slf4j
public class UserProfileController {

    @Autowired
    private UserService userService;
    @Autowired
    private QuestionService questionService;
    @Value("${upload.path}")
    String uploadPath;

    @RequestMapping("/profile")
    public String UserProfile(
            @RequestParam(value = "pageQ", defaultValue = "1") int pageQ, // 提问当前页码，默认为1
            @RequestParam(value = "pageA", defaultValue = "1") int pageA, // 回答当前页码，默认为1
            @RequestParam(value = "id") int id,
            Model model,
            HttpServletRequest request){

        // 获取当前登录的用户
        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            // 未登录，重定向到登录页面或显示错误
            return "redirect:/login"; // 根据您的应用逻辑调整
        }
        String role = user.getRole();

        User userProfile = userService.findUserProfile(id);
        model.addAttribute("userData", userProfile);

        // 分页参数
        int pageSizeQ = 10; // 提问每页显示10条
        int pageSizeA = 10; // 回答每页显示10条

        // 获取用户的提问信息（分页）
        List<Question> questionList = questionService.FindQuestionByUserid(id, pageQ, pageSizeQ);
        model.addAttribute("questionList", questionList);

        // 获取用户的提问总数
        int totalQuestions = questionService.countQuestionsByUserid(id);
        model.addAttribute("totalQuestions", totalQuestions);

        // 计算提问的总页数
        int totalPageQ = (int) Math.ceil((double) totalQuestions / pageSizeQ);
        model.addAttribute("currentPageQ", pageQ);
        model.addAttribute("totalPageQ", totalPageQ);

        // 获取用户的回答信息（分页）
        List<Answer> answerList = questionService.FindAnswerByUserId(id, pageA, pageSizeA);
        model.addAttribute("Answerlist", answerList);

        // 获取用户的回答总数
        int totalAnswers = questionService.countAnswersByUserId(id);
        model.addAttribute("totalAnswers", totalAnswers);

        // 计算回答的总页数
        int totalPageA = (int) Math.ceil((double) totalAnswers / pageSizeA);
        model.addAttribute("currentPageA", pageA);
        model.addAttribute("totalPageA", totalPageA);

        return "profile";
    }

    @RequestMapping("/updataProfile")
    public String updataProfile(User user, HttpSession session,Model model){
//        userService.upFrofile(user,session);

        try {
//            获取用户个人信息
            userService.upFrofile(user, session);
            User userData = (User) session.getAttribute("user");
            if (userData != null) {
                userData.setLoginname(user.getLoginname());
                session.setAttribute("user", userData);
            } else {
                // 处理userData为null的情况
                log.error("这tm是空的");
                return "errorPage"; // 引导到错误页面
            }
        } catch (Exception e) {
            log.error(e.toString());
            return "errorPage"; // 引导到错误页面
        }
        return "redirect:/profile?id=" + user.getId();
    }

    //***************************************************************************************

    @RequestMapping(value = "/uploadAvatar", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadAvatar(HttpServletRequest request,
                                            @RequestParam("avatar") MultipartFile avatar,
                                            @RequestParam("userId") Integer userId) {
        Map<String, Object> result = new HashMap<>();

        if (avatar == null || avatar.isEmpty()) {
            result.put("code", 1);
            result.put("msg", "请选择要上传的文件");
            return result;
        }

        try {
            // 生成唯一文件名（包含原始文件的扩展名）
            String originalFilename = avatar.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + extension;

            // 1. 保存到 target 目录（例如用于前端即时访问）
            String targetDirPath = request.getSession().getServletContext().getRealPath("/img/avatar");
            File targetDir = new File(targetDirPath);
            if (!targetDir.exists()) {
                targetDir.mkdirs();
            }
            File targetFile = new File(targetDir, newFileName);


            // 这里通过 @Value 注入本地存储路径

            File localDir = new File(uploadPath);
            if (!localDir.exists()) {
                localDir.mkdirs();
            }
            File localFile = new File(localDir, newFileName);

            // 获取上传文件的字节内容
            byte[] bytes = avatar.getBytes();

            // 分别写入 target 和本地目录
            Files.write(targetFile.toPath(), bytes);
            Path write = Files.write(localFile.toPath(), bytes);
//            System.out.println("文件已写入到: " + write.toAbsolutePath());
//            if (localFile.exists()) {
//                System.out.println("文件存在，路径是: " + localFile.getAbsolutePath());
//            } else {
//                System.out.println("文件不存在！");
//            }

            // 构造前端访问 target 目录中存放的文件的 URL
            // 前提是你配置了静态资源映射，使 /avatars/** 映射到 target 下的 /img/avatar（或其他目录）
            String avatarUrl = request.getContextPath() + "/img/avatar/" + newFileName;

            // 更新数据库中用户的头像字段（这里假设有 userService.updateAvatar 方法）
            boolean updateSuccess = userService.updateAvatar(userId, avatarUrl);
            if (updateSuccess) {
                result.put("code", 0);
                Map<String, Object> data = new HashMap<>();
                data.put("avatarUrl", avatarUrl);
                result.put("data", data);
            } else {
                result.put("code", 1);
                result.put("msg", "更新用户头像失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", 1);
            result.put("msg", "文件上传异常：" + e.getMessage());
        }

        return result;
    }

    //**********************************************************************************************
}

