package com.gem.bbs.common;

import com.gem.bbs.entity.qaUserInteraction;
import com.gem.bbs.mapper.QaUserInteractionsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class userInteraction {
    @Autowired
    private QaUserInteractionsMapper qaUserInteractionsMapper;
    public String recordUserActivity(qaUserInteraction qaUserInteraction){
        qaUserInteractionsMapper.insertInteraction(qaUserInteraction);
        return "101";
    }
    public String deleUserActivity(qaUserInteraction qaUserInteraction){
        qaUserInteractionsMapper.deleUserAct(qaUserInteraction);
        return "101";
    }
    public List<qaUserInteraction> selectUserActivity(qaUserInteraction qaUserInteraction){
        List<qaUserInteraction> userinteractions = qaUserInteractionsMapper.getInteractionsByCondition(qaUserInteraction);
        return userinteractions;
    }
}
