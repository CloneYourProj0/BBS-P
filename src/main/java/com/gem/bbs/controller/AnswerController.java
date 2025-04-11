package com.gem.bbs.controller;

import com.gem.bbs.common.ApiService;
import com.gem.bbs.common.MessageManager;
import com.gem.bbs.entity.*;
import com.gem.bbs.mapper.AnswerMapper;
import com.gem.bbs.mapper.QuestionMapper;
import com.gem.bbs.mapper.botMapper;
import com.gem.bbs.service.AnswerService;
import com.gem.bbs.service.MessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.*;


@Controller
@Slf4j
@RequestMapping("/ans")
public class AnswerController {
    @Autowired
    private AnswerService answerService;

    @Autowired
    private MessageManager messageManager;

    @Autowired
    private MessageService messageService;

    @Autowired
    private QuestionMapper questionMapper;
    @Autowired
    private ApiService apiService;
    @Autowired
    private botMapper botmapper;

    @Autowired
    private AnswerMapper answermapper;

    @RequestMapping("/save")
    public String save(Answer answer, @RequestParam(defaultValue = "")String aiResponseContent, HttpSession session, Model model,RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("user");
        try {
            if (model.getAttribute("error")!=null) {
                model.asMap().remove("error");
            }
            // 保存回答
            // 本模块的操作记录选择在service层完成
            answerService.save(answer, session);

            // 如果是回复其他人的回答
            Integer toAnswerId = answer.getToanswerid();
            if (Objects.nonNull(toAnswerId)  && answer.getToanswerid() > 0) {
                // 获取原回答的作者ID
                Answer originalAnswer= answerService.getAnswerById(answer.getToanswerid());

                //启用了ai回复但是不是回复别人
                if (aiResponseContent.length() > 1 ) {
                    if (!aiResponseContent.startsWith("@")) {
                        log.error(String.valueOf(aiResponseContent.length()));
                        // 添加错误信息到模型
                        model.addAttribute("error", "aiResponseContent 必须以 '@' 开头");
                        // todo 修改遇到不当操作的返回值
                        return "questionForm";
                    }
                    String trim = aiResponseContent.trim();
                    String modelName = trim.substring(1);
                    Integer answerQuestionId = answer.getQuestionId();
                    Question question = questionMapper.getQuestionById(answerQuestionId);
                    String answerContent = answer.getContent();
                    String description = question.getDescription();
                    List<bot> userAiBot = botmapper.getUserAiBot(currentUser.getId(), modelName);
                    String prompt = userAiBot.get(0).getPrompt();
                    String modelType = userAiBot.get(0).getModelName();
                    Answer Toanswer = answerService.getAnswerById(answer.getToanswerid());
                    HashMap<String, String> map = new HashMap<>();
                    map.put("answerUser", answerContent);
                    map.put("questionUser", description);
                    map.put("resourceAnswer",Toanswer.getContent());
                    String AiAnswer = apiService.sendRequest(map, prompt, modelType);
                    if (AiAnswer.equals("false")) {
                        redirectAttributes.addFlashAttribute("aiError", "服务商服务异常，请等待管理员联系服务商恢复服务");
                    }else {
                        // 保存ai回复内容
                        Answer answerByAi = new Answer();
                        answerByAi.setContent(AiAnswer);
                        answerByAi.setCreatetime(new Date());
                        answerByAi.setQuestionId(question.getId());
                        //  从bot表中获取id再转化成负数
                        answerByAi.setUserId(-userAiBot.get(0).getId());
                        answermapper.insertAnswer(answerByAi);
                    }

                }

//                sse功能模块
                if (originalAnswer != null && originalAnswer.getUserId() != currentUser.getId()) {
                    // 发送消息通知
                    String notificationContent = currentUser.getLoginname() +
                            "回复了你的回答：" + answer.getContent();

                    // 如果用户在线，通过SSE发送通知
                    if (messageManager.hasConnection((Integer) originalAnswer.getUserId())) {
                        messageManager.sendMessage((Integer) originalAnswer.getUserId(), notificationContent);
                    }

                    // 保存消息记录
                    Message message = new Message();
                    message.setFromUserId(currentUser.getId());
                    message.setToUserId((Integer) originalAnswer.getUserId());
                    message.setContent(notificationContent);
                    message.setCreateTime(new Date());
                    message.setStatus(messageManager.hasConnection((Integer) originalAnswer.getUserId()) ? 1 : 0);
                    message.setIsRead(0);
                    message.setMessageType(0);
                    message.setResourseId(originalAnswer.getQuestionId());
                    message.setResourceAnswerId(answer.getId());
                    messageService.saveMessage(message);
                }
            }
            else {
                //启用了ai回复但是不是回复别人
                if (aiResponseContent.length() > 1) {
                    if (!aiResponseContent.startsWith("@")) {
                        log.error(String.valueOf(aiResponseContent.length()));
                        // 添加错误信息到模型
                        model.addAttribute("error", "aiResponseContent 必须以 '@' 开头");
                        // todo 修改遇到不当操作的返回值
                        return "questionForm";
                    }
                    String trim = aiResponseContent.trim();
                    String modelName = trim.substring(1);
                    Integer answerQuestionId = answer.getQuestionId();
                    Question question = questionMapper.getQuestionById(answerQuestionId);
                    String answerContent = answer.getContent();
                    String description = question.getDescription();
                    List<bot> userAiBot = botmapper.getUserAiBot(currentUser.getId(), modelName);
                    String prompt = userAiBot.get(0).getPrompt();
                    String modelType = userAiBot.get(0).getModelName();
                    HashMap<String, String> map = new HashMap<>();
                    map.put("answerUser",answerContent);
                    map.put("questionUser",description);
//                    map.put("resourceAnswer",resAnswerContent);
                    String AiAnswer = apiService.sendRequest(map, prompt, modelType);
                    if (AiAnswer.equals("false")) {
                        redirectAttributes.addFlashAttribute("aiError", "服务商服务异常，请等待管理员联系服务商恢复服务");
                    }else
                    {
                        //  保存ai回复内容
                        Answer answerByAi = new Answer();
                        answerByAi.setContent(AiAnswer);
                        answerByAi.setCreatetime(new Date());
                        answerByAi.setQuestionId(question.getId());
                        //  从bot表中获取id再转化成负数
                        answerByAi.setUserId(-userAiBot.get(0).getId());
                        answermapper.insertAnswer(answerByAi);
                    }
                }
            }
            return "redirect:/ques/detail?id=" + answer.getQuestionId();
        } catch (Exception e) {
            e.printStackTrace();
            return "保存失败";
        }
//        return "redirect:/ques/detail?id=" + answer.getQuestionId();
    }

    @RequestMapping("/updatalike")
    @ResponseBody
    public String updateAnswerLike(@RequestParam("answerId") int answerId, @RequestParam("isLiked") boolean isLiked,HttpSession session) {
        try {
            if (isLiked) {
                answerService.cancelLike(answerId,session);

            } else {
                answerService.addLike(answerId,session);

            }
            return "101";
        } catch (Exception e) {
            return "404";
        }
    }

    @RequestMapping("/likedAnswers")
    @ResponseBody
    public Map<String, Object> getLikedAnswers(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser != null) {
            List<Integer> likedAnswerIds = answerService.getLikedAnswerIds(currentUser.getId());
            result.put("success", true);
            result.put("likedAnswerIds", likedAnswerIds);
        } else {
            result.put("success", false);
            result.put("message", "用户未登录");
        }
        return result;
    }



}
