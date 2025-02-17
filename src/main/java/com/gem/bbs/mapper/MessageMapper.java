package com.gem.bbs.mapper;

import com.gem.bbs.entity.Message;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface MessageMapper {

    // 插入新消息
    int insert(Message message);

    // 批量插入消息
    int batchInsert(@Param("messages") List<Message> messages);

    // 更新消息状态
    int updateMessageStatus(@Param("id") Integer id, @Param("status") Integer status);

    // 获取未读消息列表
    List<Message> selectUnreadMessages(@Param("userId") Integer userId);

    // 获取离线消息列表
    List<Message> selectOfflineMessages(@Param("userId") Integer userId);

    // 获取消息详情
    Message selectById(@Param("id") Integer id);

    // 获取消息对话列表
    List<Message> selectConversation(
            @Param("userId1") Integer userId1,
            @Param("userId2") Integer userId2,
            @Param("limit") Integer limit
    );

    // 获取未读消息数量
    int countUnreadMessages(@Param("userId") Integer userId);

    // 批量更新消息状态
    int batchUpdateStatus(
            @Param("ids") List<Integer> messageIds,
            @Param("status") Integer status
    );

    // 删除消息
    int deleteById(@Param("id") Integer id);

    // 获取用户的所有消息
    List<Message> selectUserMessages(
            @Param("userId") Integer userId,
            @Param("startTime") Date startTime,
            @Param("endTime") Date endTime
    );

    // 获取总记录数
    int countByToUserId(Integer toUserId);

    // 分页查询
    List<Message> findByToUserIdLimit(@Param("toUserId") Integer toUserId,
                                      @Param("startIndex") Integer startIndex,
                                      @Param("pageSize") Integer pageSize);

    void updateStatus(@Param("messageId") Integer messageId);
}
