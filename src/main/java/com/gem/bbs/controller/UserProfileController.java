package com.gem.bbs.controller;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.Question;
import com.gem.bbs.entity.User;
import com.gem.bbs.service.QuestionService;
import com.gem.bbs.service.UserService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@Slf4j
public class UserProfileController {

    @Autowired
    private UserService userService;
    @Autowired
    private QuestionService questionService;
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
//    public String UserProfile(
//            @RequestParam(value = "page", defaultValue = "1") int page, // 当前页码，默认为1
//            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize, // 每页显示条数，默认为10
//            int id,
//            Model model,
//            HttpServletRequest request){
//
//        // 获取当前登录的用户
//        User user = (User) request.getSession().getAttribute("user");
//        String role = user.getRole();
//
//        User userProfile = userService.findUserProfile(id);
//        model.addAttribute("userData", userProfile);
//
//        // 获取用户的发帖信息（分页）
//        List<Question> questionList = questionService.FindQuestionByUserid(id, page, pageSize);
//        model.addAttribute("questionList", questionList);
//
//        // 获取用户的提问总数
//        int totalQuestions = questionService.countQuestionsByUserid(id);
//        model.addAttribute("totalQuestions", totalQuestions);
//
//        // 计算总页数
//        int totalPage = (int) Math.ceil((double) totalQuestions / pageSize);
//        model.addAttribute("currentPage", page);
//        model.addAttribute("totalPage", totalPage);
//
//        // 获取用户的回答信息
//        List<Answer> answerList = questionService.FindAnswerByUserId(id);
//        model.addAttribute("Answerlist", answerList);
//
//        return "profile";
//    }

//    public String UserProfile(int id, Model model, HttpServletRequest request){
//        // 获取当前登录的用户
//        User user = (User) request.getSession().getAttribute("user");
//        String role =user.getRole();
//
//            User userProfile = userService.findUserProfile(id);
//            model.addAttribute("userData", userProfile);
//            //            获取用户的发帖信息
//            List<Question> questionList = questionService.FindQuestionByUserid(id);
//            model.addAttribute("questionList", questionList);
//            // 获取用户的回答信息
//            List<Answer> answerList = questionService.FindAnswerByUserId(id);
//            model.addAttribute("Answerlist", answerList);
//            return "profile";
//
//    }

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
}
