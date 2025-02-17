package com.gem.bbs.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class bot {
    private Integer id;
    private String name;
    private String prompt;
    private String modelName;
    private Integer createrId;
}
