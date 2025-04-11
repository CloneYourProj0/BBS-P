package com.gem.bbs.controller;

import com.gem.bbs.common.MessageManager;
import com.gem.bbs.entity.Message;
import com.gem.bbs.entity.User;
import com.gem.bbs.service.MessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/message")
@Slf4j
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private MessageManager messageManager;

    // 建立SSE连接（在用户登录成功后调用）
    @GetMapping("/connect")
    public SseEmitter connect(HttpSession session) {
        // 获取用户ID
        User user = (User)session.getAttribute("user");
        Integer userId=user.getId();

        if (userId == null) {
            throw new RuntimeException("用户未登录");
        }

        boolean hasConnection = messageManager.hasConnection(userId);
        SseEmitter emitter ;
        if (hasConnection) {
            log.info("用户 {} 已经有SSE连接", userId);
            emitter = messageManager.getSseEmitter(userId);
        }else {
             emitter = messageManager.createSseEmitter(userId);
        }
        // 获取并发送离线消息
        List<Message> offlineMessages = messageService.getOfflineMessages(userId);
        if (!offlineMessages.isEmpty()) {
            for (Message message : offlineMessages) {
                messageManager.sendMessage(userId,
                        "收到来自用户" + message.getFromUserId() + "的新消息：" + message.getContent());
                messageService.markAsSent(message.getId());
            }
        }

        return emitter;
    }

    // 发送消息
    @PostMapping("/reply")
    public String reply(@RequestBody Message message, HttpSession session) {
        Integer fromUserId = (Integer) session.getAttribute("userId");
        if (fromUserId == null) {
            return "用户未登录";
        }

        message.setFromUserId(fromUserId);
        message.setCreateTime(new Date());

        // 如果接收用户有SSE连接，直接发送
        if (messageManager.hasConnection(message.getToUserId())) {
            messageManager.sendMessage(message.getToUserId(),
                    "收到来自用户" + fromUserId + "的新消息：" + message.getContent());
            message.setStatus(1); // 已发送
        } else {
            message.setStatus(0); // 未发送（离线消息）
        }

        // 保存消息
        messageService.saveMessage(message);

        return "101";
    }

    // 标记消息已读
    @PostMapping("/read/{messageId}")
    public String markAsRead(@PathVariable Integer messageId) {
        messageService.markAsRead(messageId);
        return "101";
    }

    // 获取未读消息
    @GetMapping("/unread")
    public Object getUnreadMessages(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "用户未登录";
        }

        List<Message> messages = messageService.getUnreadMessages(userId);
        return messages;
    }
}
