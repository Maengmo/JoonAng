package com.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.TalkDTO;
import com.test.domain.TanswerDTO;
import com.test.domain.TogetherDTO;
import com.test.domain.WorkDTO;
import com.test.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;

	@Override
	public List<TalkDTO> getTalkList() {
		
		List<TalkDTO> list = mapper.getTalkList();
		
		return list;
		
	}

	@Override
	public List<WorkDTO> getLocation() {
		
		List<WorkDTO> list = mapper.getLocation();
		
		return list;
	}

	@Override
	public List<TogetherDTO> getComunication() {
		
		List<TogetherDTO> list2 = mapper.getComunication();
		
		return list2;
	}

	@Override
	public String getPwd(String username) {
		
		String pw = mapper.getPwd(username);
		
		return pw;
	}

	@Override
	public int signup(CustomerDTO dto) {
		
		int result = mapper.signup(dto);
		
		return result;
		
	}

	@Override
	public List<AnswerDTO> getAnswer() {
		
		List<AnswerDTO> list2 = mapper.getAnswer();
		
		return list2;
	}

	@Override
	public List<AnswerDTO> getTalkDetailsByTalkNum(int talknum) {
		
		List<AnswerDTO> detailsList = mapper.getTalkDetailsByTalkNum(talknum);
		
		return detailsList;
	}

	@Override
	public int addAnswer(AnswerDTO answerDTO) {
		
		int result = mapper.addAnswer(answerDTO);
		
		return result;
	}

	@Override
	public int addtalk(TalkDTO dto) {
		
		int result = mapper.addtalk(dto);
		
		return result;

	}

	@Override
	public List<TalkDTO> getTalkList2(int depnum) {
		
		List<TalkDTO> list = mapper.getTalkList2(depnum);
		
		return list;
	}

	@Override
	public int addTanswer(TogetherDTO dto) {
		
		int result = mapper.addTanswer(dto);
		
		return result;
	}

	@Override
	public List<WorkDTO> getWorkList(int depnum) {
		
		List<WorkDTO> list = mapper.getWorkList(depnum);
		
		return list;
	}

	@Override
	public List<TalkDTO> searchList(String name) {
		
		List<TalkDTO> list = mapper.searchList(name);
		
		return list;
	}

	@Override
	public int checkid(String id) {
		
		int result = mapper.checkid(id);
		
		return result;
	}

	@Override
	public List<CustomerDTO> getMyList(String id) {
		
		List<CustomerDTO> list = mapper.getMyList(id);
		
		return list;
	}
	
}
