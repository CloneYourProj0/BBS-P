//import java.net.URI;
//import java.net.http.HttpClient;
//import java.net.http.HttpRequest;
//import java.net.http.HttpResponse;
//import java.net.http.HttpHeaders;
//
//public class ApiService {
//    public static void main(String[] args) {
//        try {
//            // 创建 JSON 数据字符串
//            String json = """
//                {
//                    "model": "gpt-3.5-turbo",
//                    "messages": [
//                        {
//                            "role": "system",
//                            "content": "Answer questions seriously and in a sincere and friendly manner"
//                        },
//                        {
//                            "role": "user",
//                            "content": "你叫什么名字？?"
//                        },
//                        {
//                            "role": "assistant",
//                            "content": "hat is your name?"
//                        },
//                        {
//                            "role": "user",
//                            "content": "我是问你叫什么名字？?"
//                        }
//                    ]
//                }
//            """;
//
//            // 创建 HTTP 客户端
//            HttpClient client = HttpClient.newHttpClient();
//
//            // 构建请求
//            HttpRequest request = HttpRequest.newBuilder()
//                    .uri(URI.create("https://api.chatanywhere.tech/v1/chat/completions"))
//                    .header("Authorization", "Bearer sk-niJsYvJgg6nvk2xyhYaH4RbxTQTivPUPrFUze4LiV1CZJzZ8")  // 替换为实际的 Bearer Token
//                    .header("Content-Type", "application/json")
//                    .POST(HttpRequest.BodyPublishers.ofString(json))
//                    .build();
//
//            // 发送请求并获取响应
//            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//
//            // 输出响应
//            System.out.println("Response Code: " + response.statusCode());
//            System.out.println("Response Body: " + response.body());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}
//
