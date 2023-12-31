package com.test.controller;
 
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
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

        if (password.equals(pwd)) {
            
            // 세션 객체 가져오기 (없으면 새로 생성)
            HttpSession session = request.getSession(true);

            // 세션에 사용자 아이디 저장
            session.setAttribute("userId", username);

            // 로그인 성공
            model.addAttribute("message", "로그인 성공! 다양한 서비스를 즐겨보세요!!");
            
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
		
		model.addAttribute("success",success);
		
		return "board/signup";
    }
	
	//중복 아이디 검사
	@GetMapping("/idcheck")
	public @ResponseBody int idcheck(String id) {
		
		int result = service.checkid(id);
		
		System.out.println(result);
		
		return result;
		
	}
	
//---------------------------------------- 와글와글 게시판 ----------------------------------------
	@GetMapping("/talk.do")
	public String talk(Model model, Principal p) {
		
		List<TalkDTO> list = service.getTalkList();
		List<AnswerDTO> list2 = service.getAnswer();
		
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		
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
	
	//댓글추가
	@PostMapping("/talk/addAnswer")
	public String addAnswer(HttpServletRequest request, Model model) {
	    AnswerDTO answerDTO = new AnswerDTO();
	    
	    String userId = (String) request.getSession().getAttribute("userId");
	    
	    // request에서 필요한 값들을 가져와서 DTO에 주입
	    answerDTO.setCus_id(userId);
	    answerDTO.setTalk_num(request.getParameter("talk_num"));
	    answerDTO.setAns_content(request.getParameter("ans_content"));

	    int result = service.addAnswer(answerDTO);

	    String success = (result == 1) ? "성공적으로 완료되었습니다." : "실패했습니다.";

	    model.addAttribute("message", success);

	    return success;
	}
		
	//글 작성
	@PostMapping("/addtalk.do")
    public String addtalk(HttpServletRequest request, TalkDTO dto, Model model) {
		
		String userId = (String) request.getSession().getAttribute("userId");
		
		dto.setCus_id(userId);
		
		int success = service.addtalk(dto);
		
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
	
	//게시글 -> 검색
	@GetMapping("/talk/text")
	public String searchTalk(@RequestParam String search, Model model) {
		
	    List<TalkDTO> searchList = service.searchList(search);

	    model.addAttribute("searchList", searchList);
	    
	    return "forward:/talk.do";
	}

//------------------------------------- 함꼐해요 중앙 --------------------------------------------
	
	//지도를 이용한 소통 공간 페이지
	@GetMapping("/together.do")
	public String together(Model model, Principal p) {
		
		List<WorkDTO> list = service.getLocation();
		List<TogetherDTO> list2 = service.getComunication();
		
		model.addAttribute("list", list);
		model.addAttribute("list2", list2);
		
		return "board/together";
	}
	
	//Together 댓글등록
	@PostMapping("/together/addTanswer")
    public String addTanswer(HttpServletRequest request, Model model) {
		
		TogetherDTO dto = new TogetherDTO();
		
		String userId = (String) request.getSession().getAttribute("userId");
		
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
		
		return result;
    }
	
	//부서별 마커 찍어주기
	@GetMapping("/together/dep{depnum}")
	@ResponseBody
	public List<WorkDTO> getWorkList(@PathVariable int depnum) {
	    
		List<WorkDTO> detailsList = service.getWorkList(depnum);
	    
	    return detailsList;
	}

//-------------------------------------------- 마이페이지 ----------------------------------------

	@GetMapping("/mypage.do")
	public String mypage(HttpServletRequest request, Model model, Principal p) {
		
		String id = (String) request.getSession().getAttribute("userId");
		
		List<CustomerDTO> list = service.getMyList(id);
		
		model.addAttribute("list", list);
		
		return "board/mypage";
	}
		
	
}



