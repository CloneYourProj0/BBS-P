package com.gem.bbs.service.impl;

import com.gem.bbs.entity.DataTablesResult;
import com.gem.bbs.entity.Message;
import com.gem.bbs.mapper.MessageMapper;
import com.gem.bbs.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Override
    public void saveMessage(Message message) {
        messageMapper.insert(message);
    }

    @Override
    public List<Message> getUnreadMessages(Integer userId) {
        return messageMapper.selectUnreadMessages(userId);
    }

    @Override
    public void markAsRead(Integer messageId) {
        messageMapper.updateMessageStatus(messageId, 2); // 2表示已读
    }

    @Override
    public List<Message> getOfflineMessages(Integer userId) {
        return messageMapper.selectOfflineMessages(userId);
    }

    @Override
    public void markAsSent(Integer messageId) {
        messageMapper.updateMessageStatus(messageId, 1); // 1表示已发送
    }



    @Override
    public int countByToUserId(Integer toUserId) {
        return messageMapper.countByToUserId(toUserId);
    }

    @Override
    public List<Message> findByToUserIdLimit(Integer toUserId, Integer startIndex, Integer pageSize) {
        return messageMapper.findByToUserIdLimit(toUserId, startIndex, pageSize);
    }

    @Override
    public void updateStatus(Integer messageId) {
        messageMapper.updateStatus(messageId);
    }
}
