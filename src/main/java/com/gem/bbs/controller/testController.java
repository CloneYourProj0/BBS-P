package com.gem.bbs.controller;

import com.gem.bbs.entity.Message;
import com.gem.bbs.entity.dto.InteractionQueryDTO;
import com.gem.bbs.mapper.botMapper;
import com.gem.bbs.service.MessageService;
import com.gem.bbs.service.UserInteractionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class testController {
    @Autowired
    private botMapper botmapper;

    @RequestMapping("/test")
    public String test() {
        return "test";
    }

    @RequestMapping("/@test")
    public String test2() {
        return "tijitest";
    }

    @RequestMapping("/example")
    public String example() {
        return "example";
    }


    @Autowired
    private MessageService messageService;

    @RequestMapping("/message")
    public String message(
            @RequestParam("userId") Integer userId,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "3") Integer pageSize,
            Model model) {

        // 计算总记录数
        int total = messageService.countByToUserId(userId);

        // 计算总页数，考虑边界情况：当总记录数为0时，totalPage应为1
        int totalPage = total == 0 ? 1 : (total + pageSize - 1) / pageSize;

        // 校验当前页码
        if (pageNum < 1) {
            pageNum = 1;
        }
        if (pageNum > totalPage) {
            pageNum = totalPage;
        }

        // 计算开始索引
        int startIndex = (pageNum - 1) * pageSize;

        // 查询当前页数据
        List<Message> messageList = messageService.findByToUserIdLimit(userId, startIndex, pageSize);

        // 传递分页信息到页面
        model.addAttribute("messageList", messageList);
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("total", total);
        model.addAttribute("userId", userId);

        return "messagetest";
    }

    @ResponseBody
    @RequestMapping("/updateMessageStatus")
    public String updateMessageStatus(@RequestParam("messageId") Integer messageId) {
        messageService.updateStatus(messageId);
        return "success";
    }
//    @RequestMapping("/message/list")
//    @ResponseBody
//    public List<Message> getmessage(@RequestParam("userId") Integer userId) {
//        return messageService.findByUserId(userId);}

    @RequestMapping("/hisoryLog")
    private String hisoryLog() {
        return "historyLog";
    }

        @Autowired
        private UserInteractionService userInteractionService;

        @GetMapping("/api/user/interactions/list")
        @ResponseBody
        public Map<String, Object> getList(InteractionQueryDTO queryDTO, @RequestParam(required = false) String dateRange) {
            if (StringUtils.hasText(dateRange)) {
                String[] dates = dateRange.split(" - ");
                if (dates.length == 2) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        queryDTO.setStartDate(sdf.parse(dates[0].trim()));
                        queryDTO.setEndDate(sdf.parse(dates[1].trim()));
                    } catch (ParseException e) {
                        log.error("Date parsing error", e);
                    }
                }
            }
            log.info(queryDTO.toString());
            Map<String, Object> result = new HashMap<>();
            result.put("code", 200);
            result.put("msg", "success");
            result.put("count", userInteractionService.getInteractionCount(queryDTO));
            result.put("data", userInteractionService.getInteractionList(queryDTO));
            return result;
        }

        @RequestMapping("/testindex")
        public String index(){
            return "matchtest";
        }
}

