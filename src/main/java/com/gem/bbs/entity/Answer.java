package com.gem.bbs.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


@Data
public class Answer {
    private Integer id;
    private String content;
    private Integer questionId;
    private Integer userId;
    private String isAccept;//是否被采纳
    private Integer likes;//点赞数
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;

    private int toanswerid;
}
