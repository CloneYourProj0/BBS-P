package com.gem.bbs.service;

import com.gem.bbs.entity.dto.InteractionQueryDTO;
import com.gem.bbs.entity.qaUserInteraction;

import java.util.Date;
import java.util.List;

public interface UserInteractionService {
    /*
    下面注释中的都是弃用的
     */
//     插入新的交互记录
//    public int addInteraction(qaUserInteraction interaction) ;
//    // 获取指定用户的交互记录
//    public List<qaUserInteraction> getInteractionsByUserId(Long userId) ;
//    // 获取所有交互记录
//    public List<qaUserInteraction> getAllInteractions() ;
    // 根据条件获取交互记录
//    public List<qaUserInteraction> getInteractionsByCondition(String interactionType, Date startDate, Date endDate);


    public List<qaUserInteraction> getInteractionList(InteractionQueryDTO queryDTO);

    public int getInteractionCount(InteractionQueryDTO queryDTO);
}
