package com.gem.bbs.entity;

import lombok.Data;

import java.util.Date;

@Data
public class LikeAnswerIds {
    private int id;
    private int userId;
    private int answerId;
    private Date createTime;
}
