package com.gem.bbs.entity.dto;

import lombok.Data;

import java.util.Date;

@Data
public class InteractionQueryDTO {
    private String interactionType;
    private Date startDate;
    private Date endDate;
    private Integer page;
    private Integer limit;
}