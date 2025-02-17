package com.gem.bbs.entity;

import lombok.Data;

import java.util.Date;

@Data
public class qaUserInteraction {
    private Long id; // 交互ID
    private Long userId; // 用户ID
    private Long questionId; // 问题ID
    private String interactionType; // 交互类型：view, like, favorite, answer
    private Date createDate; // 交互时间
}
