package com.gem.bbs.service.impl;

import com.gem.bbs.common.ApiService;
import com.gem.bbs.common.userInteraction;
import com.gem.bbs.entity.*;
import com.gem.bbs.mapper.AnswerMapper;
import com.gem.bbs.mapper.botMapper;
import com.gem.bbs.service.AnswerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 15:29
 * @Description:
 */
@Service
@Slf4j
public class AnswerServiceImpl implements AnswerService {
    @Autowired
    private AnswerMapper answerMapper;
    @Autowired
    private botMapper botmapper;
    @Autowired
    private ApiService apiService;
    @Autowired
    private userInteraction userInteraction;


    @Override
    public List<Map<String, Object>> selectListByAnswerId(Integer id) {
        return answerMapper.selectListByAnswerId(id);
    }

    @Override
    public void save(Answer answer,HttpSession session) {
        answer.setCreatetime(new Date());
        User user = (User) session.getAttribute("user");
        if (user == null) {
            answer.setUserId(0);//匿名
        } else {
            answer.setUserId(user.getId());
//            记录用户操作记录
            qaUserInteraction qaUserInteraction = new qaUserInteraction();
            qaUserInteraction.setCreateDate(new Date());
            qaUserInteraction.setUserId(Long.valueOf(user.getId()));
            qaUserInteraction.setInteractionType("answer");
            qaUserInteraction.setQuestionId(Long.valueOf(answer.getQuestionId()));
            userInteraction.recordUserActivity(qaUserInteraction);
        }
        answerMapper.insertAnswer(answer);
    }

//    此为ai自动生成，没有考虑到前面也就是第一个方法其实就已经实现了，可以复用；
//    public List<Answer> getAnswersByUserId(Integer userId) {
//        return answerMapper.getAnswersByUserId(userId);
//    }

    public Answer getAnswerById(Integer id) {
        return answerMapper.getAnswerById(id);
    }

    public void deleteAnswer(Integer id) {
        answerMapper.deleteAnswer(id);
    }

    // 其他方法...

    /*
    点赞功能
     */
    @Override
    public void addLike(int answerId,HttpSession session) {
        Answer answer = answerMapper.selectByPrimaryKey(answerId);
        int newLikes = answer.getLikes() + 1;
        answerMapper.updateLikesById(answerId, newLikes);
        LikeAnswerIds likeAnswerIds = new LikeAnswerIds();
        likeAnswerIds.setAnswerId(answerId);
        likeAnswerIds.setCreateTime(new Date());
        User user=(User)session.getAttribute("user");
        likeAnswerIds.setUserId(user.getId());
        answerMapper.insertLikeAnswerIds(likeAnswerIds);
        //记录用户点赞记录
        qaUserInteraction qaUserInteraction = new qaUserInteraction();
        qaUserInteraction.setQuestionId(Long.valueOf(answer.getQuestionId()));
        qaUserInteraction.setCreateDate(new Date());
        qaUserInteraction.setInteractionType("like");
        qaUserInteraction.setUserId(Long.valueOf(user.getId()));
        List<qaUserInteraction> userInteractions = userInteraction.selectUserActivity(qaUserInteraction);
        if (userInteractions != null) {
            userInteraction.recordUserActivity(qaUserInteraction);
        }
    }
    @Override
    public void cancelLike(int answerId,HttpSession session) {
        Answer answer = answerMapper.selectByPrimaryKey(answerId);
        int newLikes = Math.max(0, answer.getLikes() - 1);
        answerMapper.updateLikesById(answerId, newLikes);
        LikeAnswerIds likeAnswerIds = new LikeAnswerIds();
        likeAnswerIds.setAnswerId(answerId);
        likeAnswerIds.setCreateTime(new Date());
        User user=(User)session.getAttribute("user");
        likeAnswerIds.setUserId(user.getId());
        answerMapper.deleLikeAnswerIds(likeAnswerIds);
        //记录用户点赞记录
        qaUserInteraction qaUserInteraction = new qaUserInteraction();
        qaUserInteraction.setQuestionId(Long.valueOf(answer.getQuestionId()));
        qaUserInteraction.setCreateDate(new Date());
        qaUserInteraction.setInteractionType("like");
        qaUserInteraction.setUserId(Long.valueOf(user.getId()));
        userInteraction.deleUserActivity(qaUserInteraction);
    }


    /*
    获取用户点赞记录
     */
    public List<Integer> getLikedAnswerIds(int userid){
        List<Integer> listAnswerId=answerMapper.getLikedAnswerIds(userid);
        return listAnswerId;
    };

}
