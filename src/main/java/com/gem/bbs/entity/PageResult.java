package com.gem.bbs.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class PageResult<T> {
    private List<T> data;
    private int currentPage;
    private int pageSize;
    private int total;
    private int totalPages;
}
