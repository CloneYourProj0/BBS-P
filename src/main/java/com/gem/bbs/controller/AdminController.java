package com.gem.bbs.controller;


import com.gem.bbs.entity.*;
import com.gem.bbs.service.UserService;
import com.gem.bbs.service.QuestionService;
import com.gem.bbs.service.AnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private AnswerService answerService;


    @GetMapping("/dashboard")
    public String adminDashboard(Model model,
                                 HttpSession session,
                                 @RequestParam(defaultValue = "1") int page,
                                 @RequestParam(defaultValue = "10") int pageSize) {

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            return "redirect:/user/loginPage";
        }
        List<User> userList = userService.getAllUsers();
        model.addAttribute("userList", userList);
        return "admin";


//        User currentUser = (User) session.getAttribute("user");
//        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
//            return "redirect:/user/loginPage";
//        }
//
//        PageResult<User> pageResult = userService.getUsersByPage(page, pageSize);
//        model.addAttribute("pageResult", pageResult);
//
//        return "admin";
    }

    @GetMapping("/users")
    @ResponseBody
    public PageResult<User> getUsers(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(required = false) String keyword
    ) {
        if (keyword != null && !keyword.trim().isEmpty() && keyword.contains("%")) {
            try {
                // 手动解码
                keyword = URLDecoder.decode(keyword, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                // 处理异常
                e.printStackTrace();
            }
        }

        // 判断 keyword 是否为空，决定走默认分页或者模糊查询的逻辑
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 如果 keyword 不为空，则调用模糊查询
            return userService.searchUsersByKeyword(page, limit, keyword);
        }
        // 默认分页查询
        return userService.getUsersByPage(page, limit);
    }

    // 显示帖子管理页面
    // 页面接口：返回帖子管理页面（JSP页面）
    @GetMapping("/viewUserPosts")
    public String viewUserPosts(Model model,
                                HttpSession session) {
        // 返回的 JSP 文件路径例如：/WEB-INF/views/admin/postManagement.jsp
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            return "redirect:/user/loginPage";
        }
        return "questionManagement";
    }
    // 数据接口：返回 JSON 数据给 layui 渲染表格
    @GetMapping("/questions")
    @ResponseBody
    public PageResult<Question> listQuestions(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {

        // 构建查询条件对象
        QuestionQuery query = new QuestionQuery();
        query.setUserId(userId);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            if (startTime != null && !startTime.trim().isEmpty()) {
                Date start = sdf.parse(startTime);
                query.setStartTime(start);
            }
            if (endTime != null && !endTime.trim().isEmpty()) {
                Date end = sdf.parse(endTime);
                query.setEndTime(end);
            }
        } catch (ParseException e) {
            // 解析异常，记录日志或返回错误提示（此处简化处理）
            e.printStackTrace();
        }

        // 设置分页参数：计算 offset
        query.setLimit(limit);
        query.setOffset((page - 1) * limit);

        List<Question> list = questionService.getQuestions(query);
        int total = questionService.countQuestions(query);
        int totalPages=(total+limit-1)/limit;
        new PageResult<>(list,page,limit,total,totalPages);

        return new PageResult<>(list,page,limit,total,totalPages);
    }

    // 显示回复管理页面
    @GetMapping("/viewAnswers")
    public String viewAnswersPage() {
        return "answerManagement"; // 对应 JSP 页面路径
    }

    @GetMapping("/answers")
    @ResponseBody
    public PageResult<Answer> listAnswers(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) Integer questionId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {

        AnswerQuery query = new AnswerQuery();
        query.setUserId(userId);
        query.setQuestionId(questionId);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            if (startTime != null && !startTime.trim().isEmpty()) {
                query.setStartTime(sdf.parse(startTime));
            }
            if (endTime != null && !endTime.trim().isEmpty()) {
                query.setEndTime(sdf.parse(endTime));
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        query.setLimit(limit);
        query.setOffset((page - 1) * limit);

        List<Answer> list = answerService.getAnswers(query);
        int total = answerService.countAnswers(query);
        int totalPages=(total+limit-1)/limit;

        return new PageResult<>(list,page,limit,total,totalPages);
    }

    // 编辑用户
    @GetMapping("/editUser")
    public String editUser(@RequestParam("id") Integer id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "editUser";
    }


    @PostMapping("/updateUser")
    public String updateUser(User user) {
        userService.updateUser(user);
        return "redirect:/admin/dashboard";
    }

    // 删除用户
    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam("id") Integer id) {
        userService.deleteUser(id);
        return "redirect:/admin/dashboard";
    }



    // 编辑帖子
    @GetMapping("/editQuestion")
    public String editQuestion(@RequestParam("id") Integer id, Model model) {
        Question question = questionService.getQuestionById(id);
        model.addAttribute("question", question);
        return "editQuestion";
    }

    @PostMapping("/updateQuestion")
    @ResponseBody
    public Map<String, Object> updateQuestion(Question question) {
        Map<String, Object> result = new HashMap<>();
        try {
            questionService.updateQuestion(question);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 删除帖子
    @GetMapping("/deleteQuestion")
    public String deleteQuestion(@RequestParam("id") Integer id) {
        questionService.deleteQuestion(id);
        return "redirect:/admin/dashboard";
    }

    // 编辑回复
    @GetMapping("/editAnswer")
    public String editAnswer(@RequestParam("id") Integer id, Model model) {
        Answer answer = answerService.getAnswerById(id);
        model.addAttribute("answer", answer);
        return "editAnswer";
    }


    // 删除回复
    @GetMapping("/deleteAnswer")
    public String deleteAnswer(@RequestParam("id") Integer id) {
        answerService.deleteAnswer(id);
        return "redirect:/admin/dashboard";
    }
}

