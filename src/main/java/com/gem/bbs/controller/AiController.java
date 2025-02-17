package com.gem.bbs.controller;

import com.gem.bbs.common.ApiService;

import com.gem.bbs.entity.BotAndUser;
import com.gem.bbs.entity.BotDTO;
import com.gem.bbs.entity.User;
import com.gem.bbs.entity.bot;
import com.gem.bbs.mapper.botMapper;
import com.gem.bbs.service.BotService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.Bean;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequestMapping("/AiService")
@Controller
public class AiController {
    @Autowired
    private ApiService apiService;

    @Autowired
    private botMapper botmapper;
    @Autowired
    private BotService botService;

    @RequestMapping("/gpt")
    public String accessGPT(@RequestParam("inputData")String message, Model model){
        log.info("用户输入："+message);
//        String content = apiService.sendRequest(message);
//        model.addAttribute("message",content);
        return "AiChat";
    }
    @RequestMapping("/quest")
    public String aaaa(){
        return "AiChat";
    }

//    ------------------------------------------------------------------

    @RequestMapping("/botlist")
    public String botlist(){
        return "botshow";
    }
    @GetMapping("/getUserList")
    public ResponseEntity<?> getUserList(@RequestParam(value = "query", required = false) String query, int id){
        // 从数据库或其他数据源获取用户列表
        String botname=null;
        List<bot> bots = botmapper.getUserAiBot(id,botname);

        // 将用户数据转换为前端需要的格式
        List<Map<String, String>> botList = bots.stream()
                .map(bot -> {
                    Map<String, String> map = new HashMap<>();
                    map.put("username", bot.getName());
                    map.put("id", String.valueOf(bot.getId()));
                    return map;
                })
                .collect(Collectors.toList());

        // 创建响应 Map，包含 status 和 data
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("data", botList);

        return ResponseEntity.ok(response);
    }
//    @GetMapping("/getMyBotss")
//    public ResponseEntity<?> getMyBotss(
//            @RequestParam(value = "page", defaultValue = "1") int page,
//            @RequestParam(value = "limit", defaultValue = "10") int limit,
//            HttpSession session) {
//
//        User user = (User) session.getAttribute("user");
//        Long userId= Long.valueOf(user.getId());
//        List<BotAndUser> botAndUserList = botService.getMyBots(userId, page, limit);
//        int totalCount = botService.getMyBotCount(userId);
//
//        Map<String, Object> data = new HashMap<>();
//        data.put("list", botAndUserList);
//        data.put("totalCount", totalCount);
//
//        Map<String, Object> responseBody = new HashMap<>();
//        responseBody.put("code", 0);
//        responseBody.put("msg", "获取成功");
//        responseBody.put("data", data);
//
//        return ResponseEntity.ok(responseBody);
//    }
//
//    @GetMapping("/getBotByName")
//    public ResponseEntity<?> getBotByName(@RequestParam("name") String name) throws UnsupportedEncodingException {
//        String dname = URLDecoder.decode(name, "UTF-8");
//        log.info("name is :"+dname);
//        bot bot = botService.getBotByName(dname);
//
//        Map<String, Object> responseBody = new HashMap<>();
//
//        if (bot == null) {
//            responseBody.put("code", 1);
//            responseBody.put("msg", "Bot不存在");
//        } else {
//            responseBody.put("code", 0);
//            responseBody.put("msg", "获取成功");
//            responseBody.put("data", bot);
//        }
//
//        return ResponseEntity.ok(responseBody);
//    }








    //**********************************************************************************************************
    // 获取当前用户的Bot列表
    @GetMapping("/getMyBots")
    public ResponseEntity<?> getMyBots(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "limit", defaultValue = "10") int limit,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("code", 1);
            responseBody.put("msg", "用户未登录");
            return ResponseEntity.status(401).body(responseBody);
        }

        Long userId = Long.valueOf(user.getId());
        int offset = (page - 1) * limit;

        List<BotDTO> botDTOList = botService.getMyBots(userId, offset, limit);
        int totalCount = botService.getMyBotCount(userId);

        Map<String, Object> data = new HashMap<>();
        data.put("list", botDTOList);
        data.put("totalCount", totalCount);

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("code", 0);
        responseBody.put("msg", "获取成功");
        responseBody.put("data", data);

        return ResponseEntity.ok(responseBody);
    }

    // 根据Bot ID获取Bot详情
    @GetMapping("/getBotById")
    public ResponseEntity<?> getBotById(@RequestParam("id") Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("code", 1);
            responseBody.put("msg", "用户未登录");
            return ResponseEntity.status(401).body(responseBody);
        }

        bot bot = botService.getBotById(id);

        Map<String, Object> responseBody = new HashMap<>();

        if (bot == null) {
            responseBody.put("code", 1);
            responseBody.put("msg", "Bot不存在");
        } else {
            // 可选：检查当前用户是否有权限查看该Bot
            responseBody.put("code", 0);
            responseBody.put("msg", "获取成功");
            responseBody.put("data", bot);
        }

        return ResponseEntity.ok(responseBody);
    }

    // 创建Bot
    @PostMapping("/createBot")
    public ResponseEntity<?> createBot(@RequestBody BotDTO bot, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("code", 1);
            responseBody.put("msg", "用户未登录");
            return ResponseEntity.status(401).body(responseBody);
        }

        bot.setCreaterId(Long.valueOf(user.getId()));
        botService.createBot(bot);

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("code", 0);
        responseBody.put("msg", "创建成功");

        return ResponseEntity.ok(responseBody);
    }

    // 更新Bot
    @PostMapping("/updateBot")
    public ResponseEntity<?> updateBot(@RequestBody bot bot, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("code", 1);
            responseBody.put("msg", "用户未登录");
            return ResponseEntity.status(401).body(responseBody);
        }

        // 可选：检查当前用户是否有权限编辑该Bot
        botService.updateBot(bot);

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("code", 0);
        responseBody.put("msg", "更新成功");

        return ResponseEntity.ok(responseBody);
    }

    // 删除Bot
    @PostMapping("/deleteBot")
    public ResponseEntity<?> deleteBot(@RequestParam("id") Long botId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> responseBody = new HashMap<>();
            responseBody.put("code", 1);
            responseBody.put("msg", "用户未登录");
            return ResponseEntity.status(401).body(responseBody);
        }

        // 可选：检查当前用户是否有权限删除该Bot
        botService.deleteBot(botId);

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("code", 0);
        responseBody.put("msg", "删除成功");

        return ResponseEntity.ok(responseBody);
    }

}


