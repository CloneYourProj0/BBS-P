package com.gem.bbs.service;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.AnswerQuery;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


public interface AnswerService {
    /**
     * 根据问题id查询回复列表
     */
    List<Map<String, Object>> selectListByAnswerId(Integer id);

    /**
     * 保存问题
     */
    void save(Answer answer,HttpSession session);

    /*
    by gpt o1
     */
//    此为ai自动生成，没有考虑到前面也就是第一个方法其实就已经实现了，可以复用；
//    List<Answer> getAnswersByUserId(Integer userId);
    Answer getAnswerById(Integer id);

    void deleteAnswer(Integer id);
    // 其他方法...


    /*
    点赞功能
     */
    void addLike(int answerId,HttpSession session);
    void cancelLike(int answerId,HttpSession session);
    /*
    获取用户点赞记录
     */
    public List<Integer> getLikedAnswerIds(int userid);



    //**********************************************************************************
    List<Answer> getAnswers(AnswerQuery query);
    int countAnswers(AnswerQuery query);

    //**********************************************************************************
}
