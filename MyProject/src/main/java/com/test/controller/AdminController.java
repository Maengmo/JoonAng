package com.test.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.test.service.AdminService;

@Controller
public class AdminController {
		
	@Autowired
	private AdminService service;
	
	@GetMapping("admin.do")
	public String Admin(Model model, Principal p) {
		
		
		
		
		return "admin/adminPage";
		
	}
	
	@GetMapping("adminLogin.do")
	public String AdminLogin(Model model, Principal p) {
		
		
		return "admin/adminLogin";
	}
	
	//로그인 처리
	@PostMapping("/adminLogin.do")
    public String login(HttpServletRequest request, String adminName, String password, Model model) {
        
		
		String pwd = service.getPwd(adminName);

        if (password.equals(pwd)) {
            
            // 세션 객체 가져오기 (없으면 새로 생성)
            HttpSession session = request.getSession(true);

            // 세션에 사용자 아이디 저장
            session.setAttribute("adminId", adminName);

            // 로그인 성공
            model.addAttribute("message", "로그인 성공! 다양한 서비스를 즐겨보세요!!");
            
            return "admin/adminLogin";
            
        } else {
           
        	// 로그인 실패
            model.addAttribute("message", "로그인 실패. 아이디 또는 패스워드가 일치하지 않습니다.");
            
            return "admin/adminLogin";
            
        }
    }
	
}
