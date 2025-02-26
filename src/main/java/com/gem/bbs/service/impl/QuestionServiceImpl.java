package com.gem.bbs.service.impl;

import com.gem.bbs.common.ApiService;
import com.gem.bbs.entity.*;
import com.gem.bbs.mapper.AnswerMapper;
import com.gem.bbs.mapper.QuestionMapper;
import com.gem.bbs.mapper.botMapper;
import com.gem.bbs.service.AnswerService;
import com.gem.bbs.service.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 10:47
 * @Description:
 */
@Service
@Slf4j
public class QuestionServiceImpl implements QuestionService {
    @Autowired
    private QuestionMapper questionMapper;

    @Autowired
    private ApiService apiService;

    @Autowired
    private AnswerMapper answerMapper;

    @Autowired
    private botMapper botmapper;

    @Override
    public List<Question> matchQuestion(String content) {
        List<Question> questions = questionMapper.matchQuestion(content);
        return questions;
    }

    @Override
    public Question selectOne(Integer id) {
        return questionMapper.selectOneByPrimaryKey(id);
    }

    @Override
    public List<Question> selectTop5QuestionsByViewCountInWeek() {
        return questionMapper.countQuestions();
    }

    @Override
    public int save(Question question,HttpSession session,String modelName) {
        question.setCreatetime(new Date());
        User user = (User) session.getAttribute("user");
        question.setUserId(user.getId());//记录当前登录用户信息
        Integer questionId = question.getId();

        questionMapper.insertQuestion(question);
        if (modelName != null && !modelName.isEmpty()) {
            List<bot> userAiBot = botmapper.getUserAiBot(user.getId(), modelName);
            if (userAiBot != null && userAiBot.size() > 0) {
                log.error(userAiBot.toString());
                String prompt = userAiBot.get(0).getPrompt();
                String model = userAiBot.get(0).getModelName();
                HashMap<String, String> map = new HashMap<>();
                map.put("questionUser",question.getDescription());
                String AiAnswer = apiService.sendRequest(map, prompt, model);
                if (AiAnswer.equals("false")) {
                    return -4;
                }else {
                    Answer answer = new Answer();
                    answer.setContent(AiAnswer);
                    answer.setCreatetime(new Date());
                    answer.setQuestionId(question.getId());
//                从bot表中获取id再转化成负数
                    answer.setUserId(-userAiBot.get(0).getId());
//                answer.setUserId(-1);
                    answerMapper.insertAnswer(answer);
                }
            }
        }
        return 1;
    }

    @Override
    public Integer getTotalPage(Integer pageCount, String title) {
        if (title == null) title = "";
        Integer total = questionMapper.getTotal(title);
        return (total - 1) / pageCount + 1;
    }

    @Override
    public List<Question> findAll(Integer currentPage, Integer pageCount, String title) {
        return questionMapper.selectAll((currentPage - 1) * pageCount,pageCount,title);
    }

    @Override
    public void updateTopStatus(int id,int status) {
         questionMapper.updataTopStatus(id, status);

    }

//    @Override
//    public List<Question> FindQuestionByUserid(int id) {
//        List<Question> questionList = questionMapper.FindQuestionByUserId(id);
//        return questionList;
//    }
    public List<Question> FindQuestionByUserid(int userId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return questionMapper.findQuestionsByUserId(userId, offset, pageSize);
    }

    @Override
    public int countQuestionsByUserid(int userId) {
        return questionMapper.countQuestionsByUserId(userId);
    }

//    @Override
//    public List<Answer> FindAnswerByUserId(int id) {
//        List<Answer> answerList = questionMapper.FindAnswerByUserId(id);
//        return answerList;
//    }
    @Override
    public List<Answer> FindAnswerByUserId(int userId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return questionMapper.findAnswersByUserId(userId, offset, pageSize);
    }

    @Override
    public int countAnswersByUserId(int userId) {
        return questionMapper.countAnswersByUserId(userId);
    }


//    public List<Question> getQuestionsByUserId(Integer userId) {
//        return questionMapper.getQuestionsByUserId(userId);
//    }

    public Question getQuestionById(Integer id) {
        return questionMapper.getQuestionById(id);
    }

    public void updateQuestion(Question question) {
        questionMapper.updateQuestion(question);
    }

    public void deleteQuestion(Integer id) {
        questionMapper.deleteQuestion(id);
    }


    //*****************************************************************************

    @Override
    public List<Question> getQuestions(QuestionQuery query) {
        return questionMapper.queryQuestions(query);
    }

    @Override
    public int countQuestions(QuestionQuery query) {
        return questionMapper.countQuestionsbyadmin(query);
    }

    //*****************************************************************************

}
