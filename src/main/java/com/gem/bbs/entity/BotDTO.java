package com.gem.bbs.entity;

import lombok.Data;

import java.util.Date;

@Data
public class BotDTO {
    private Long id;
    private String name;
    private String prompt;
    private String modelName;
    private Date createdTime;
    private Date updatedTime;

    private Long createrId;

}

