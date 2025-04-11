package com.gem.bbs.controller;

import com.gem.bbs.entity.Question;
import com.gem.bbs.entity.QuestionAndUserAvater;
import com.gem.bbs.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


@Controller
public class IndexController {
    @Autowired
    private QuestionService questionService;

    //访问首页
    @RequestMapping("/index")
    public String index(String title, String page, Model model) {

        System.out.println("什么jb编码格式");
        //当前页
        int currentPage = 1;
        int pageCount = 10; //每页显示的记录数
        //获取用户提交数据
        if (title == null) {
            title = "";
        }
        if(page != null) {
            currentPage = Integer.valueOf(page);
        }

        List<QuestionAndUserAvater> list = questionService.findAll(currentPage,pageCount,title);
        int totalPage = questionService.getTotalPage(pageCount,title);

        //将数据包装到request对象中
        model.addAttribute("questionList", list);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("title", title);
        return "testindexv2";
    }


}
