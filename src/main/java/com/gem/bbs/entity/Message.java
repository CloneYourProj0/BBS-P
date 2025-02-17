package com.gem.bbs.entity;


import lombok.Data;

import java.util.Date;

@Data
public class Message {
    private Integer id;
    private Integer fromUserId;
    private Integer toUserId;
    private String content;
    private Date createTime;
    private Integer status;  // 0：未发送 1：已发送 2：已读
    private Integer messageType; // 0：普通消息 1：系统消息
    private Integer resourseId; // 父消息ID，用于消息回复关联
    private Integer resourceAnswerId;
    private String fromUserName;

    private  Integer isRead;
}

