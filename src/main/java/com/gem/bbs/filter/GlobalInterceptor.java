package com.gem.bbs.filter;

import com.gem.bbs.common.UserConnectionManager;
import com.gem.bbs.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class GlobalInterceptor implements HandlerInterceptor {
    /*
    后加，用于验证是否建立了sse
     */
    @Autowired
    private UserConnectionManager connectionManager;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 检查 modelAndView 是否为 null
        if (modelAndView != null) {
            // 获取应用路径
            modelAndView.addObject("contextPath", request.getContextPath());
        } else {
            System.err.println("ModelAndView is null");
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 获取请求的URI
        String uri = request.getRequestURI();

        /*
        检验用户是否建立sse
         */
        User userx = (User) request.getSession().getAttribute("user");
        if (userx != null) {
            Integer userId = userx.getId();
//            如果用户已经登录则在连接管理类中登记
            connectionManager.userLogin(userx.getId());
        }

        // 只在访问/admin路径时进行角色验证
        if (uri.startsWith("/admin")) {
            // 获取Session中的用户对象
            User user = (User) request.getSession().getAttribute("user");
            // 如果用户对象为null，表示未登录
            if (user == null) {
                response.sendRedirect("/user/loginPage");
                return false; // 阻止请求继续
            }

            // 获取用户角色
            String role = user.getRole();
            // 如果角色不是admin，重定向到无权限页面
            if (!"admin".equals(role)) {
                response.sendRedirect("/accessDenied.jsp");
                return false;
            }
        }






        return true; // 继续处理请求
    }
}





//38
//        19.9 6 9
//        杂费 2.4