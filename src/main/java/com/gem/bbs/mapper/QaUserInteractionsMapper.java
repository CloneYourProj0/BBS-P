package com.gem.bbs.mapper;

import com.gem.bbs.entity.dto.InteractionQueryDTO;
import com.gem.bbs.entity.qaUserInteraction;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface QaUserInteractionsMapper {
    // 插入新的交互记录
    int insertInteraction(qaUserInteraction interaction);

    // 根据用户 ID 获取交互记录
    List<qaUserInteraction> getInteractionsByUserId(@Param("userId") Long userId);

    // 获取所有交互记录
    List<qaUserInteraction> getAllInteractions();

    // 根据条件查询交互记录（可选）
    List<qaUserInteraction> getInteractionsByCondition(qaUserInteraction qaUserInteraction);

    void deleUserAct(qaUserInteraction qaUserInteraction);

//    历史页面的数据查询
    List<qaUserInteraction> selectInteractions(InteractionQueryDTO queryDTO);
    int countInteractions(InteractionQueryDTO queryDTO);
}
