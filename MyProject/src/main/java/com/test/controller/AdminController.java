package com.test.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.domain.AdminDTO;
import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.TalkDTO;
import com.test.domain.TogetherDTO;
import com.test.domain.WorkDTO;
import com.test.service.AdminService;

@Controller
public class AdminController {
		
	@Autowired
	private AdminService service;

//-------------------------------------------- 메인 페이지 및 로그인 -------------------------------------
	//admin 메인 페이지
	@GetMapping("admin.do")
	public String Admin(Model model, Principal p) {
		
		//List<TalkDTO> list = service.TalkList();
		
		List<TalkDTO> list = service.RecentTalk();
		List<TalkDTO> list2 = service.BestTalk();

	    model.addAttribute("list", list);
	    model.addAttribute("list2", list2);
		
		return "admin/adminPage";
		
	}
	
	//admin 로그인 페이지
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
	
	// 로그아웃 처리
	@GetMapping("adminLogout.do")
	public String adminLogout(HttpServletRequest request, HttpSession session) {
	    // 세션에서 사용자 아이디 제거
	    session.removeAttribute("adminId");

	    System.out.println("로그아웃");
	    
	    // 로그아웃 후 리다이렉트
	    return "redirect:/board.do";
	}
//-------------------------------------------- 마이페이지 ----------------------------------------
	//admin 마이페이지
	@GetMapping("adminMyPage.do")
	public String adminMyPage(HttpServletRequest request, Model model) {
		
		String id = (String) request.getSession().getAttribute("adminId"); 
		
		List<AdminDTO> list = service.getAmdin(id);
		
		model.addAttribute("list", list);
		
		return "admin/adminMyPage";
	}

//-------------------------------------------- 회원정보 관리 페이지 -------------------------------------
	//admin 회원정보 관리 페이지
	@GetMapping("adminUser.do")
	public String adminUser(HttpServletRequest request, Model model) {
		
		List<CustomerDTO> list = service.UserList();
		
		model.addAttribute("list", list);
		
		return "admin/adminUser";
	}
	
	//admin 회원정보 관리 페이지 -> detail
	@GetMapping("/adminUser{id}")
	@ResponseBody
	public List<CustomerDTO> adminUserDetail(HttpServletRequest request, Model model, @PathVariable String id) {
		
		List<CustomerDTO> detailList = service.adminUserDetail(id);
		
		if(detailList.get(0).getCus_state().equals("1")) {
			detailList.get(0).setCus_state_name("활동 중 회원 😊");
		}else {
			detailList.get(0).setCus_state_name("정지된 회원 🫥");
		}
		
		return detailList;
	}
	
	//admin 회원정보 관리 페이지 -> 정지 처리
	@GetMapping("/stopUser{id}")
	@ResponseBody
	public String stopUser(HttpServletRequest request, Model model, @PathVariable String id) {
		
		int result = service.stopUser(id);
		
		if(result == 1) {
			return id;
		}else {
			return "정지 실패";
		}
		
	}
	
	//admin 회원정보 관리 페이지 -> 복구 처리
	@GetMapping("/comebackUser{id}")
	@ResponseBody
	public String comebackUser(HttpServletRequest request, Model model, @PathVariable String id) {
		
		int result = service.comebackUser(id);
		
		if(result == 1) {
			return id;			
		}else {
			return "복구 실패";
		}
		
	}
	
	//admin 회원정보 관리 페이지 -> 탈퇴 처리
	@GetMapping("/delUser{id}")
	@ResponseBody
	public String delUser(HttpServletRequest request, Model model, @PathVariable String id) {

		int result = service.delUser(id);
		
		if(result == 1) {
			service.delState(id);
			return id;			
		}else {
			return "탈퇴 실패";
		}
		
	}
	
	//admin 회원정보 관리 페이지 -> 부서별 검색
	@GetMapping("/adminUser/dep{depnum}")
	@ResponseBody
	public List<CustomerDTO> getUserList(@PathVariable int depnum) {
		
	    List<CustomerDTO> detailsList = service.getUserList(depnum);

	    return detailsList;
	}
	
	//admin 회원정보 관리 페이지 -> 회원명 검색
	@GetMapping("/adminUser/text{search}")
	@ResponseBody
	public List<CustomerDTO> adminUser(@PathVariable String search, Model model) {
	    
	    List<CustomerDTO> searchList = service.searchList(search);
	    
	    return searchList;
	}
	
	//admin 회원정보 관리 페이지 -> 정지 회원 검색
	@GetMapping("/adminUser/stopList")
	@ResponseBody
	public List<CustomerDTO> stopList(Model model) {
		
		List<CustomerDTO> stopList = service.stopList();
		
		return stopList;
	}
	
	//admin 회원정보 관리 페이지 -> 정지 회원 검색
	@GetMapping("/adminUser/activeList")
	@ResponseBody
	public List<CustomerDTO> activeList(Model model) {
		
		List<CustomerDTO> activeList = service.activeList();
		
		return activeList;
	}

//-------------------------------------------- 게시물 관리 페이지(talk) -------------------------------------

	@GetMapping("adminTalk.do")
	public String adminTalk(Model model) {
		
		List<TalkDTO> talkList = service.TalkList();
		
		model.addAttribute("talkList", talkList);
		
		return "admin/adminTalk";
	}
	
	//글 삭제
	@GetMapping("/adminTalk/delTalk.do")
	public String delTalk(Model model, String talk_num) {
		
		int result = service.delTalk(talk_num);
		
		if (result == 1) {
			service.delTalk_like(talk_num);
		}
		
		return "redirect:/adminTalk.do";
	}
	
	//댓글 삭제
	@GetMapping("/adminTalk/delAnswer")
	@ResponseBody
	public List<AnswerDTO> delAnswer(HttpServletRequest request, Model model) {
		
		String talk_num = request.getParameter("talk_num");
		String ans_num = request.getParameter("ans_num");
		
		int result = service.delAnswer(ans_num);
		
		if(result == 1) {
			List<AnswerDTO> list = service.answerList(talk_num);
			return list;
		}
		
		return null;
	}
	
	//인기순 정렬
	@GetMapping("/adminTalk/popular")
	@ResponseBody
	public List<TalkDTO> popularTalk(Model model) {
		
		List<TalkDTO> list = service.popularTalk();
		
		return list;
	}
	
	//최신순 정렬
	@GetMapping("/adminTalk/latest")
	@ResponseBody
	public List<TalkDTO> latestTalk(Model model) {
		
		List<TalkDTO> list = service.TalkList();
		
		return list;
	}

//-------------------------------------------- 게시물 관리 페이지(together) -------------------------------------	
	
	//관리자 - 함께해요 메인 페이지
	@GetMapping("adminTogether.do")
	public String adminTogether(Model model) {
		
		List<TogetherDTO> list = service.togetherList();
		
		model.addAttribute("list", list);
		
		List<WorkDTO> wlist = service.workList();
		
		model.addAttribute("wlist", wlist);
		
		return "admin/adminTogether";
	}
	
	//관리자 - 함께해요 상세 페이지
	@GetMapping("adminTogether/getDetail")
	@ResponseBody
	public List<TogetherDTO> getDetail(HttpServletRequest request, Model model) {
		
		String sta_num = request.getParameter("sta_num");
		
		List<TogetherDTO> list = service.getDetail(sta_num);
		
		return list;
	}
	
	//관리자 - 함께해요 Select 처리
	@GetMapping("adminTogether/dep")
	@ResponseBody
	public List<WorkDTO> getDepList(HttpServletRequest request, Model model) {
		
		String dep_num = request.getParameter("dep_num");
		int depnum = Integer.parseInt(dep_num);
		
		List<WorkDTO> list = service.getDepList(depnum);
		
		return list;
	}
	
	//관리자 - 함께해요 Search 처리
	@GetMapping("adminTogether/text")
	@ResponseBody
	public List<WorkDTO> getSearchList(HttpServletRequest request) {
		
		String sValue = request.getParameter("sValue");
		
		List<WorkDTO> list = service.getSearchList(sValue);
		
		return list;
	}
	
	//관리자 - 함께해요 댓글 삭제
	@GetMapping("/adminTogether/delTogether")
	@ResponseBody
	public List<TogetherDTO> delTogether(HttpServletRequest request, Model model) {
		
		String to_num = request.getParameter("to_num");
		String sta_num = request.getParameter("sta_num");
		
		int result = service.delTogether(to_num);
		
		if(result == 1) {
			List<TogetherDTO> list = service.getDetail(sta_num);
			return list;
		}
		
		return null;
	}
	
	//관리자 - 함께해요 인기 있는 게시물
	@GetMapping("/adminTogether/popular")
	@ResponseBody
	public List<WorkDTO> popularTogether(HttpServletRequest request, Model model) {
		
		List<WorkDTO> list = service.popularTogether();
		
		return list;
		
	}
	
	//관리자 - 함께해요 최신 댓글 게시물
	@GetMapping("/adminTogether/latest")
	@ResponseBody
	public List<WorkDTO> latestTogether(Model model) {
		
		List<WorkDTO> list = service.latestTogether();
		List<WorkDTO> list2 = new ArrayList<>();

		for (WorkDTO dto : list) {
		    boolean isDuplicate = false;

		    // list2에 이미 해당 work_num이 있는지 확인
		    for (WorkDTO existingDto : list2) {
		        if (existingDto.getWork_num().equals(dto.getWork_num())) {
		            isDuplicate = true;
		            break;
		        }
		    }

		    // 중복이 없다면 list2에 추가
		    if (!isDuplicate) {
		        list2.add(dto);
		    }
		}
		
		
		
		return list2;
		
	}
	
	
	
}
