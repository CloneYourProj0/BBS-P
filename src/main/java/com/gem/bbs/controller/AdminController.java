package com.gem.bbs.controller;


import com.gem.bbs.entity.User;
import com.gem.bbs.entity.Question;
import com.gem.bbs.entity.Answer;
import com.gem.bbs.service.UserService;
import com.gem.bbs.service.QuestionService;
import com.gem.bbs.service.AnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
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

    // 显示管理员首页
    @GetMapping("/dashboard")
    public String adminDashboard(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            return "redirect:/user/loginPage";
        }
        List<User> userList = userService.getAllUsers();
        model.addAttribute("userList", userList);
        return "admin";
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

    // 查看用户的帖子
    @GetMapping("/viewUserPosts")
    public String viewUserPosts(@RequestParam("id") Integer userId, Model model, HttpSession session) {
        List<User> userList = userService.getAllUsers();
        List<Question> questionList = questionService.getQuestionsByUserId(userId);
        model.addAttribute("userList", userList);
        model.addAttribute("questionList", questionList);
        model.addAttribute("selectedUserId", userId);
        return "admin";
    }

    // 查看用户的回复
    @GetMapping("/viewUserAnswers")
    public String viewUserAnswers(@RequestParam("id") Integer userId, Model model, HttpSession session) {
        List<User> userList = userService.getAllUsers();
        List<Map<String, Object>> answerList = answerService.selectListByAnswerId(userId);
        model.addAttribute("userList", userList);
        model.addAttribute("answerList", answerList);
        model.addAttribute("selectedUserId", userId);
        return "admin";
    }

    // 编辑帖子
    @GetMapping("/editQuestion")
    public String editQuestion(@RequestParam("id") Integer id, Model model) {
        Question question = questionService.getQuestionById(id);
        model.addAttribute("question", question);
        return "editQuestion";
    }

    @PostMapping("/updateQuestion")
    public String updateQuestion(Question question) {
        questionService.updateQuestion(question);
        return "redirect:/admin/dashboard";
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

