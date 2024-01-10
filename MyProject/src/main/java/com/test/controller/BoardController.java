package com.test.controller;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.SocialDTO;
import com.test.domain.TalkDTO;
import com.test.domain.TogetherDTO;
import com.test.domain.WorkDTO;
import com.test.project.ResourceNotFoundException;
import com.test.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService service;
	
//--------------------------------------- 예외 처리 ---------------------------------------------	
	@GetMapping("/nonexistentPage")
	public String nonexistentPage() {
	    throw new ResourceNotFoundException("페이지를 찾을 수 없습니다.");
	}
	
	@GetMapping("/simulateError")
	public String simulateError() {
	    throw new RuntimeException("서버 내부 오류를 시뮬레이션합니다.");
	}
	
//---------------------------------------- 메인 페이지	-------------------------------------------
	@GetMapping("/board.do")
	public String board(Model model, Principal p) {
		
		/*
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 현재 로그인한 사용자의 정보
        String username = authentication.getName();
        boolean isAuthenticated = authentication.isAuthenticated();

        // 사용자의 권한 목록
        List<String> authorities = authentication.getAuthorities()
            .stream()
            .map(GrantedAuthority::getAuthority)
            .collect(Collectors.toList());
        
        System.out.println(username);
        System.out.println(isAuthenticated);
        System.out.println(authorities);
        */
		return "board/board";
	}

//---------------------------------------- 로그인 페이지 -----------------------------------------
	//로그인 페이지
	@GetMapping("/login.do")
	public String login(Model model, Principal p) {
		
		return "board/login";
	}
	
	//로그인 처리
	@PostMapping("/login.do")
    public String login(HttpServletRequest request, String username, String password, Model model) {
        
		String pwd = service.getPwd(username);
		String state = service.getState(username);
		
		int stateNum = Integer.parseInt(state);

        if (password.equals(pwd) && stateNum == 1) {
            
            // 세션 객체 가져오기 (없으면 새로 생성)
            HttpSession session = request.getSession(true);

            // 세션에 사용자 아이디 저장
            session.setAttribute("userId", username);

            // 로그인 성공
            model.addAttribute("message", "로그인 성공! 다양한 서비스를 즐겨보세요!!");
            
            return "board/login";
            
        } else if (password.equals(pwd) && stateNum == 0) {
           
        	// 로그인 실패
            model.addAttribute("message", "로그인 실패. 정지된 회원 입니다..");
            
            return "board/login";
            
        } else {
        	
        	// 로그인 실패
            model.addAttribute("message", "로그인 실패. 아이디 또는 패스워드가 일치하지 않습니다.");
            
            return "board/login";
        	
        }

    }
	
	// 로그아웃 처리
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest request, HttpSession session) {
	    // 세션에서 사용자 아이디 제거
	    session.removeAttribute("userId");

	    // 로그아웃 후 리다이렉트
	    return "redirect:/board.do";
	}
	
//---------------------------------------- 회원가입 페이지 ----------------------------------------
	@GetMapping("/signup.do")
	public String signup(Model model, Principal p) {
		
		
		return "board/signup";
	}
	
	//회원가입 처리
	@PostMapping("/signup.do")
    public String signup(CustomerDTO dto, Model model) {
		
		int success = service.signup(dto);
		
		String id = dto.getCus_id();
		
		if(success == 1) {
			service.addState(id);
		}
		
		model.addAttribute("success",success);
		
		return "board/signup";
    }
	
	//중복 아이디 검사
	@GetMapping("/idcheck")
	public @ResponseBody int idcheck(String id) {
		
		int result = service.checkid(id);
		
		return result;
		
	}
	
//---------------------------------------- 와글와글 게시판 ----------------------------------------

	@GetMapping("/talk.do")
	public String talk(Model model, Principal p, HttpServletRequest request) {
		
		List<TalkDTO> list = service.getTalkList();
		List<AnswerDTO> list2 = service.getAnswer();
		
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		/*
		if(userId == null) {
			return "board/login";
		}
		*/
		
		return "board/talk";
	}
	
	//소통창구 게시판
	@GetMapping("/addtalk.do")
	public String addtalk(Model model, Principal p) {
		
		
		return "board/addtalk";
	}
	
	//상세보기 및 댓글 보기
	@GetMapping("/talk/{talknum}")
	@ResponseBody
	public List<AnswerDTO> getTalkDetails(@PathVariable int talknum) {
	    List<AnswerDTO> detailsList = service.getTalkDetailsByTalkNum(talknum);
	    
	    return detailsList;
	}
	
	//게시글 좋아요
	@GetMapping("/talk/like")
	@ResponseBody
	public String TalkLike(HttpServletRequest request, Model model) {
	    
		String talkNum = request.getParameter("talkNum");
		String likeNum = request.getParameter("likeNum");
		
		
		int talknum2 = Integer.parseInt(talkNum);
		int likeNum2 = Integer.parseInt(likeNum);
		
		int like = service.addLike(talkNum);
		
		return (likeNum2+1) + "";
	}
	
	//댓글추가
	@RequestMapping(value = "/talk/addAnswer", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String addAnswer(HttpServletRequest request, Model model) {
	    AnswerDTO answerDTO = new AnswerDTO();
	    
	    String userId = (String) request.getSession().getAttribute("userId");
	    String adminId = (String) request.getSession().getAttribute("adminId");
	    
	    if(userId == null) {
	    	userId="관리자👨🏻‍💼" + "(" + adminId + ")";
	    }
	    
	    // request에서 필요한 값들을 가져와서 DTO에 주입
	    answerDTO.setCus_id(userId);
	    answerDTO.setTalk_num(request.getParameter("talk_num"));
	    answerDTO.setAns_content(request.getParameter("ans_content"));

	    int result = service.addAnswer(answerDTO);

	    String success = (result == 1) ? "성공적으로 완료되었습니다." : "실패했습니다.";

	    model.addAttribute("message", success);

	    return userId;
	}
		
	//글 작성
	@PostMapping("/addtalk.do")
    public String addtalk(HttpServletRequest request, TalkDTO dto, Model model) {
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		dto.setCus_id(userId);
		
		int success = service.addtalk(dto);
		
		if (success == 1) {
			service.addtalk2();
		}
		
		model.addAttribute("success",success);
		
		return "redirect:/talk.do";
    }
	
	//부서 별 게시글
	@GetMapping("/talk/dep{depnum}")
	@ResponseBody
	public List<TalkDTO> getTalkList(@PathVariable int depnum) {
	    List<TalkDTO> detailsList = service.getTalkList2(depnum);

	    return detailsList;
	}
	
	@GetMapping("/talk/text{search}")
	@ResponseBody
	public List<TalkDTO> searchTalk(@PathVariable String search, Model model) {
	    
	    List<TalkDTO> searchList = service.searchList(search);
	    
	    return searchList;
	}

//------------------------------------- 함꼐해요 중앙 --------------------------------------------
	
	//지도를 이용한 소통 공간 페이지
	@GetMapping("/together.do")
	public String together(Model model, Principal p, Authentication authentication, HttpServletRequest request) {
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		List<WorkDTO> list = service.getLocation();
		List<TogetherDTO> list2 = service.getComunication();
		
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		
		/*
		if(userId == null) {
			return "board/login";
		}
		*/
		
		return "board/together";
	}
	
	//Together 댓글등록
	@RequestMapping(value = "/together/addTanswer", produces = "application/text; charset=UTF-8")
	@ResponseBody
    public String addTanswer(HttpServletRequest request, Model model) {
		
		TogetherDTO dto = new TogetherDTO();
		
		String userId = (String) request.getSession().getAttribute("userId");
		String adminId = (String) request.getSession().getAttribute("adminId");
		
		if(userId == null) {
	    	userId="관리자👨🏻‍💼" + "(" + adminId + ")";
	    }
		
		dto.setCus_id(userId);
	    dto.setSta_num(request.getParameter("sta_num"));
	    dto.setTo_content(request.getParameter("to_content"));
		
		int success = service.addTanswer(dto);
		
		model.addAttribute("success",success);
		model.addAttribute("dto", dto);
		
		String result = "";
		
		if(success != 1) {
			result = "성공적으로 완료";
		}else {
			result = "실패";
		}
		
		return userId;
    }
	
	//부서별 마커 찍어주기
	@GetMapping("/together/dep{depnum}")
	@ResponseBody
	public List<WorkDTO> getWorkList(@PathVariable int depnum) {
	    
		List<WorkDTO> detailsList = service.getWorkList(depnum);
	    
	    return detailsList;
	}

//-------------------------------------------- 마이페이지 ----------------------------------------
	//마이페이지
	@GetMapping("/mypage.do")
	public String mypage(HttpServletRequest request, Model model, Principal p) {
		
		String id = (String) request.getSession().getAttribute("userId");
		
		List<CustomerDTO> list = service.getMyList(id);
		
		model.addAttribute("list", list);
		
		return "board/mypage";
	}
	
	//마이페이지 - 이메일 수정
	@GetMapping("/mypage/editEmail")
	@ResponseBody
	public String editEmail(HttpServletRequest request, Model model, String cus_email) {
		
		String id = (String) request.getSession().getAttribute("userId");
		
		CustomerDTO dto = new CustomerDTO();
		
		dto.setCus_id(id);
		dto.setCus_email(cus_email);
		
		int result = service.editEmail(dto);
		
		if(result == 1) {
			return "redirect:/mypage.do";
		}else {
			return "board.do";
		}
		
	}
	
	//마이페이지 - 비밀번호 수정
	@GetMapping("/mypage/editPw")
	@ResponseBody
	public String editPw(HttpServletRequest request, Model model, String cus_pw) {
		
		String id = (String) request.getSession().getAttribute("userId");
		
		System.out.println(id);
		System.out.println(cus_pw);
		
		CustomerDTO dto = new CustomerDTO();
		
		dto.setCus_id(id);
		dto.setCus_pw(cus_pw);
		
		int result = service.editPw(dto);
		
		if(result == 1) {
			return "redirect:/mypage.do";
		}else {
			return "board.do";
		}
		
	}
//-------------------------------------------- 마이페이지 상세보기(Talk) ------------------------------------
	@GetMapping("/mypage_talk.do")
	public String mypage_talk(HttpServletRequest request, Model model) {
		
	    String id = (String) request.getSession().getAttribute("userId"); 

	    List<TalkDTO> list = service.getMyTalk(id);

	    model.addAttribute("list", list);

	    return "board/mypage_talk";
	}
	
	@GetMapping("/mypage_talkEdit.do")
	public String mypage_talkEdit(HttpServletRequest request, Model model, String talk_num) {
		
		String id = (String) request.getSession().getAttribute("userId");
		
		List<TalkDTO> list = service.getTalkList3(talk_num);
		
		model.addAttribute("list", list);
		
		return "board/mypage_talkEdit";
		
	}
	
	//글 수정
	@PostMapping("/editTalk.do")
    public String editTalk(HttpServletRequest request, TalkDTO dto, Model model) {
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		dto.setCus_id(userId);
		
		int success = service.editTalk(dto);
		
		model.addAttribute("success",success);
		
		return "redirect:/mypage_talk.do";
    }
	
	//글 삭제
	@GetMapping("/delTalk.do")
	public String delTalk(Model model, String talk_num) {
		
		int result = service.delTalk(talk_num);
		
		if (result == 1) {
			service.delTalk_like(talk_num);
		}
		
		return "redirect:/mypage_talk.do";
	}
//-------------------------------------------- 마이페이지 상세보기(Talk) ------------------------------------
	@GetMapping("mypage_together.do")
	public String mypage_together(HttpServletRequest request, Model model) {
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		List<TogetherDTO> list = service.getMyTogether(userId);
		
		model.addAttribute("list", list);
		
		return "board/mypage_together";
	}
	
	@PostMapping("editTogether.do")
	@ResponseBody
	public String editTogether(HttpServletRequest request, Model model) {
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		TogetherDTO dto = new TogetherDTO();
		
		String content = request.getParameter("to_content");
		
		dto.setTo_num(request.getParameter("to_num"));
	    dto.setTo_content(request.getParameter("to_content"));
	    
	    int result = service.editTogether(dto);
		
	    if(result==1) {
	    	return content;
	    }else {
	    	return "";
	    }
	}
	
	//글 삭제
	@GetMapping("/delTogether.do")
	public String delTogether(Model model, String to_num) {
		
		int result = service.delTogether(to_num);
		
		return "redirect:/mypage_together.do";
	}
	
	
//-------------------------------------------- ID,PW 찾기 ----------------------------------------		
	//ID,PW 찾기
	@GetMapping("/find.do")
	public String find(Model model, Principal p) {
		
		
		
		return "board/find";
		
	}
	
	//ID 찾기
	@RequestMapping(value = "/find/id", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String find_id(HttpServletRequest request, HttpServletResponse response, Model model, Principal p) {
		
		CustomerDTO dto = new CustomerDTO();
		
		
		
		String email = request.getParameter("cus_email");
		String depart = request.getParameter("cus_depart");
		
		dto.setCus_email(email);
		dto.setDep_num(depart);
		
		
		String cus_id = service.findId(dto);
		
		if(cus_id == null) {
			cus_id = "입력 하신 정보에 따른 ID가 존재하지 않습니다!!";
		}
		response.setCharacterEncoding("UTF-8");

		return cus_id;
	}
	
	//PW 찾기
	@RequestMapping(value = "/find/pw", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String find_pw(HttpServletRequest request, Model model, Principal p) {
		
		CustomerDTO dto = new CustomerDTO();
		
		String id = request.getParameter("cus_id");
		String email = request.getParameter("cus_email");
		String depart = request.getParameter("cus_depart");
		
		dto.setCus_id(id);
		dto.setCus_email(email);
		dto.setDep_num(depart);
		
		String cus_pw = service.findPw(dto);
		
		if(cus_pw == null) {
			cus_pw = "입력 하신 정보에 따른 PW가 존재하지 않습니다!!";
		}

		return cus_pw;
	}

//--------------------------------- Social Login 구현 --------------------------------------------

	@PostMapping("/socialLogin.do")
	@ResponseBody
	public String socialLogin(HttpServletRequest request, Model model, Principal p) {
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		
		SocialDTO dto = new SocialDTO();
		
		dto.setEmail(email);
		dto.setNickname(nickname);
		
		int result = 0;
		
		result = service.searchUser(dto);
		
		if(result == 1) {
			String id2 = service.getId(dto);
			
			// 세션 객체 가져오기 (없으면 새로 생성)
            HttpSession session = request.getSession(true);

            // 세션에 사용자 아이디 저장
            session.setAttribute("userId", id2);
			
			return "success";
		}else {
			return "failed";
		}
		
		
		
	}

}



