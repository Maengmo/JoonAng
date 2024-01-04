package com.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.SocialDTO;
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

	@Override
	public int editEmail(CustomerDTO dto) {
		
		int result = mapper.editEmail(dto);
		
		return result;
	}

	@Override
	public int editPw(CustomerDTO dto) {
		
		int result = mapper.editPw(dto);
		
		return result;
	}

	@Override
	public String findId(CustomerDTO dto) {
		
		String id = mapper.findId(dto);
		
		return id;
	}

	@Override
	public String findPw(CustomerDTO dto) {
		
		String pw = mapper.findPw(dto);
		
		return pw;
	}

	@Override
	public int addLike(String talknum) {
		
		int like = mapper.addLike(talknum);
		
		return like;
	}

	@Override
	public void addtalk2() {
		
		mapper.addtalk2();
		
	}

	@Override
	public List<TalkDTO> getMyTalk(String id) {
		
		List<TalkDTO> list = mapper.getMyTalk(id);
		
		return list;
	}

	@Override
	public List<TalkDTO> getTalkList3(String talk_num) {
		
		List<TalkDTO> list = mapper.getTalkList3(talk_num);
		
		return list;
	}

	@Override
	public int editTalk(TalkDTO dto) {
		
		int result = mapper.editTalk(dto);
		
		return result;
	}

	@Override
	public int delTalk(String talk_num) {
		
		int result = mapper.delTalk(talk_num);
		
		return result;
	}

	@Override
	public void delTalk_like(String talk_num) {
		
		mapper.delTalk_like(talk_num);
		
	}

	@Override
	public List<TogetherDTO> getMyTogether(String userId) {
		
		List<TogetherDTO> list = mapper.getMyTogether(userId);
		
		return list;
	}

	@Override
	public int editTogether(TogetherDTO dto) {
		
		int result = mapper.editTogether(dto);
		
		return result;
	}

	@Override
	public int delTogether(String to_num) {
		
		int result = mapper.delTogether(to_num);
		
		return result;
	}

	@Override
	public int searchUser(SocialDTO dto) {
		
		int result = mapper.searchUser(dto);
		
		return result;
	}
	
	@Override
	public String getId(SocialDTO dto) {
		
		String id = mapper.getId(dto);
		
		return id;
		
	}
}
