package com.gem.bbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
public class ssetestController {
    // 用于存储每个用户的 SseEmitter 实例
    private static final Map<String, SseEmitter> SSE_EMITTER_MAP = new ConcurrentHashMap<>();
    @RequestMapping("/ssetest")
    public String ssejsp(){
        return "ssetest";
    }
    @GetMapping("/sse")
    @ResponseBody
    public SseEmitter handleSse() {
        SseEmitter emitter = new SseEmitter();
        SSE_EMITTER_MAP.put("1",emitter);
        return emitter;
    }
    @GetMapping("/sentmessage")
    @ResponseBody
    public void publisher() throws IOException {
        SseEmitter emitter = SSE_EMITTER_MAP.get("1");
        emitter.send("这是你的订阅内容！！！！");
    }
}
