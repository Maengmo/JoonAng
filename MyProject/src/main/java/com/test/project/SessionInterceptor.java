package com.test.project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception{
		
		if(request.getSession().getAttribute("userId") == null) {
			if(request.getSession().getAttribute("adminId") != null) {
				return true;
			}
			response.sendRedirect("/project/login.do");
			return false;
		}
		return true;
	}
	
}
