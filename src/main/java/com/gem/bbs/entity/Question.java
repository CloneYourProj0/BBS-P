package com.gem.bbs.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


@Data
public class Question {
    private Integer id;
    private String title;
    private String description;
    private Integer coin;
    private Integer userId;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;
    private String isUp;
    private boolean aiResponseRequested;
    private int viewCount;
}
