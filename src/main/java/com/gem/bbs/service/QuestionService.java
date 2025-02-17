package com.gem.bbs.service;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.Question;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 10:46
 * @Description:
 */
public interface QuestionService {

    /*
    模糊查询
     */
    List<Question> matchQuestion(String content);
    /**
     * 根据主键查询问题
     */
    Question selectOne(Integer id);

    /*
    获取一周内阅读量最多的问题
     */
    List<Question> selectTop5QuestionsByViewCountInWeek();


    /**
     * 保存问题
     */
    int save(Question question, HttpSession session, String modelName);

    /**
     * 获取总页数
     */
    Integer getTotalPage(Integer pageCount,String title);

    /**
     * 获取记录数
     */
    List<Question> findAll(Integer currentPage, Integer pageCount,String title);

    /**
     * 更新帖子置顶状态
     * @param id
     * @param status
     */
    void updateTopStatus(int id,int status);

    /**
     * 获取用户发布的帖子
     */
    List<Question> FindQuestionByUserid(int userId, int page, int pageSize);

    /**
     *计算用户发帖总数
     */
    int countQuestionsByUserid(int userId);

    /**
     * 获取用户回复信息
     */
//    List<Answer> FindAnswerByUserId(int id);
    List<Answer> FindAnswerByUserId(int userId, int page, int pageSize);
    int countAnswersByUserId(int userId);

    /*
    by gpt o1
     */
    List<Question> getQuestionsByUserId(Integer userId);
    Question getQuestionById(Integer id);
    void updateQuestion(Question question);
    void deleteQuestion(Integer id);

    // 其他方法...
}
