package com.gem.bbs.controller;

import com.gem.bbs.common.ApiService;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class RecommenderController {
    @Autowired
    private ApiService apiService;

    @ResponseBody
    @RequestMapping("/recomment")
    public List<Map<String,Object>> recommender(@Param("userId") Long userId, HttpSession session) {
//        Long userId = 1l; // 假设当前用户ID
        List<Map<String, Object>> recommendations =null;
        try {
            recommendations = apiService.getRecommendations(userId);
            session.setAttribute("recomment",recommendations);
            log.info(recommendations.toString());
            // 输出推荐结果
            System.out.println("\n为用户 " + userId + " 推荐的问题：");
            for (Map<String, Object> recommendation : recommendations) {
                for (Map.Entry<String, Object> entry : recommendation.entrySet()) {
                    String questionText = entry.getKey();
                    Double score = Double.valueOf(entry.getValue().toString());

                    System.out.println("Question: " + questionText + ", Score: " + score);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return recommendations;
    }
}


