import com.gem.bbs.entity.Question;
import com.gem.bbs.mapper.QuestionMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml","classpath:spring-context.xml"})
public class test {
    @Autowired
    private QuestionMapper questionMapper;
    @Test
    public void questtoid(){
        Question question = new Question();
        question.setTitle("Test Title");
        question.setDescription("Test Description");
        question.setCoin(10);
        question.setUserId(1);
        question.setCreatetime(new Date());
        int id = questionMapper.insertQuestion(question);
        System.out.println("xxx:"+question.getId());
    }
    public String sendRequest(Map<String, String> map, String prompt, String modelType) {
        // 创建一个用于存储排序后的键值对的列表
        List<String> sortedContent = new ArrayList<>();

        // 定义我们希望的顺序
        List<String> keyOrder = Arrays.asList("questionUser", "resourceAnswer", "answerUser");

        // 遍历预定义的顺序，加入相应的内容
        for (String key : keyOrder) {
            if (map.containsKey(key)) {
                sortedContent.add(map.get(key));
            }
        }

        // 这里可以根据需要进一步处理 sortedContent 列表
        // 例如，将列表中的元素组合成一个字符串
        String combinedContent = String.join("\n", sortedContent);

        // 现在使用 combinedContent 进行API请求
        // 这里假设你有一个方法来发送API请求
        return sendAPIRequest(combinedContent, prompt, modelType);
    }

    // 假设的API请求发送方法
    private String sendAPIRequest(String content, String prompt, String modelType) {
        // 实现API请求的逻辑
        // 这里只是一个示例
        System.out.println("Sending API request with content: " + content);
        return "API response"; // 这里应该返回实际的API响应
    }

}
