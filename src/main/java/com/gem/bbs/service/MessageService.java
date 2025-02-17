package com.gem.bbs.service;

import com.gem.bbs.entity.DataTablesResult;
import com.gem.bbs.entity.Message;

import java.util.List;

public interface MessageService {
    // 保存消息
    void saveMessage(Message message);

    // 获取用户的未读消息
    List<Message> getUnreadMessages(Integer userId);

    // 标记消息为已读
    void markAsRead(Integer messageId);

    // 获取用户的离线消息
    List<Message> getOfflineMessages(Integer userId);

    // 标记消息为已发送
    void markAsSent(Integer messageId);



    void updateStatus(Integer messageId);
    List<Message> findByToUserIdLimit(Integer userId, Integer startIndex, Integer pageSize);

    int countByToUserId(Integer userId);
}

