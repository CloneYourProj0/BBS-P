package com.gem.bbs.service.impl;

import com.gem.bbs.entity.dto.InteractionQueryDTO;
import com.gem.bbs.entity.qaUserInteraction;
import com.gem.bbs.mapper.QaUserInteractionsMapper;
import com.gem.bbs.service.UserInteractionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserInteractionServiceImpl implements UserInteractionService {
    @Autowired
    private QaUserInteractionsMapper userInteractionMapper;
    /*
    下方被注释的都是弃用的
     */
//    // 插入新的交互记录
//    public int addInteraction(qaUserInteraction interaction) {
//        return interactionMapper.insertInteraction(interaction);
//    }
//    // 获取指定用户的交互记录
//    public List<qaUserInteraction> getInteractionsByUserId(Long userId) {
//        return interactionMapper.getInteractionsByUserId(userId);
//    }
//    // 获取所有交互记录
//    public List<qaUserInteraction> getAllInteractions() {
//        return interactionMapper.getAllInteractions();
//    }
    // 根据条件获取交互记录
//    public List<qaUserInteraction> getInteractionsByCondition(String interactionType, Date startDate, Date endDate) {
//        return interactionMapper.getInteractionsByCondition(interactionType, startDate, endDate);
//    }

    public List<qaUserInteraction> getInteractionList(InteractionQueryDTO queryDTO) {
        return userInteractionMapper.selectInteractions(queryDTO);
    }

    public int getInteractionCount(InteractionQueryDTO queryDTO) {
        return userInteractionMapper.countInteractions(queryDTO);
    }
}
