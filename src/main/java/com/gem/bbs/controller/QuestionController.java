package com.gem.bbs.controller;

import com.gem.bbs.common.userInteraction;
import com.gem.bbs.entity.QuestionAndUserAvater;
import com.gem.bbs.entity.qaUserInteraction;
import com.gem.bbs.entity.Question;
import com.gem.bbs.entity.User;
import com.gem.bbs.service.AnswerService;
import com.gem.bbs.service.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;
import java.util.stream.Stream;


@Controller
@RequestMapping("/ques")
@Slf4j
public class QuestionController {
    @Autowired
    private QuestionService questionService;
    @Autowired
    private AnswerService answerService;
    @Autowired
    private userInteraction userinteraction;

    @RequestMapping("/form")
    public String form() {
        return "questionForm";
    }

    @RequestMapping("/save")
    public String save(Question question, HttpSession session,@RequestParam(defaultValue = "") String aiResponseContent,Model model, RedirectAttributes redirectAttributes) {
        if (model.getAttribute("error")!=null) {
            model.asMap().remove("error");
        }
        if (aiResponseContent.length()>1){
            if (!aiResponseContent.startsWith("@") ) {
                log.error(String.valueOf(aiResponseContent.length()));
                // 返回错误信息
                model.addAttribute("error", "呼唤bot 必须以 '@' 开头");
                return "questionForm";
            }
            String trim = aiResponseContent.trim();
            String modelName = trim.substring(1);
            int signal = questionService.save(question, session, modelName);
            if (signal == -4) {
                redirectAttributes.addFlashAttribute("aiError", "服务商服务异常，请等待管理员联系服务商恢复服务");
            }
            Integer questionId = question.getId();
            return "redirect:/ques/detail?id="+questionId;
        }
        questionService.save(question, session,null);
        Integer questionId = question.getId();
        return "redirect:/ques/detail?id="+questionId;
    }

    /**
     * 获取问题详情内容
     */
    @RequestMapping("/detail")
    public String detail(Integer id, Model model, HttpSession session) {
        // 增加问题的阅读次数
        questionService.incrementViewCount(id);
        
        // 获取问题详情
        QuestionAndUserAvater question = questionService.selectOne(id);
        // 获取该问题的回复
        List<Map<String, Object>> answerList = answerService.selectListByAnswerId(id);

        model.addAttribute("question", question);
        model.addAttribute("answerList", answerList);
        User user = (User) session.getAttribute("user");
        if (user != null) {
            log.info("记录用户信息");
            qaUserInteraction qaUserInteraction = new qaUserInteraction();
            qaUserInteraction.setQuestionId(question.getId().longValue());
            qaUserInteraction.setInteractionType("View");
            qaUserInteraction.setUserId(Long.valueOf(user.getId()));
            qaUserInteraction.setCreateDate(new Date());
            List<com.gem.bbs.entity.qaUserInteraction> listactionbyuser = userinteraction.selectUserActivity(qaUserInteraction);
            if (listactionbyuser!=null & !listactionbyuser.isEmpty()){
                Optional<com.gem.bbs.entity.qaUserInteraction> interactionStream = listactionbyuser.stream()
                                .max(Comparator.comparing(com.gem.bbs.entity.qaUserInteraction::getCreateDate));
                        log.info(interactionStream.toString());
                com.gem.bbs.entity.qaUserInteraction interaction = interactionStream.get();
                long interactionTime = interaction.getCreateDate().getTime();
                long date = new Date().getTime();
                if (interactionTime-date>(60*60*1000)) {
                    userinteraction.recordUserActivity(qaUserInteraction);
                }
            }else {
                userinteraction.recordUserActivity(qaUserInteraction);
            }
        }
        return "questionDetail";
    }

    @RequestMapping("/top")
    public String topThisQuestion(@RequestParam("id") int id, @RequestParam("status") int status, Model model) {
        System.out.println(status);
        // 根据 status 参数判断是置顶还是取消置顶
                String message;
                questionService.updateTopStatus(id,status);
                QuestionAndUserAvater question = questionService.selectOne(id);
                //获取该问题的回复
                List<Map<String, Object>> answerList = answerService.selectListByAnswerId(id);

                model.addAttribute("question",question);
                model.addAttribute("answerList",answerList);
                model.addAttribute("status",status);
                // 返回原页面
                return "questionDetail";  // 重定向回原来的页面
    }

    @RequestMapping("/getTopQuestion")
    @ResponseBody
    public String selectTop5QuestionsByViewCountInWeek(HttpSession session){
        List<Question> questions = questionService.selectTop5QuestionsByViewCountInWeek();
        session.setAttribute("hotQuestion",questions);
        return "101";
    }

    @RequestMapping("/matchQuestion")
    @ResponseBody
    public List<Question> matchQuestion(@RequestParam("content")String content){
        log.info(content);
        try {
            // 手动重新编码
             content = URLDecoder.decode(content, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        log.info(content);
        List<Question> questions=questionService.matchQuestion(content);
        return questions;
    }


}
