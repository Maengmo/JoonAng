package com.test.service;

import java.util.List;
import java.util.Map;

import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.TalkDTO;
import com.test.domain.TanswerDTO;
import com.test.domain.TogetherDTO;
import com.test.domain.WorkDTO;

public interface BoardService {

	List<TalkDTO> getTalkList();

	List<WorkDTO> getLocation();

	List<TogetherDTO> getComunication();

	String getPwd(String username);

	int signup(CustomerDTO dto);

	List<AnswerDTO> getAnswer();

	List<AnswerDTO> getTalkDetailsByTalkNum(int talknum);

	int addAnswer(AnswerDTO answerDTO);

	int addtalk(TalkDTO dto);

	List<TalkDTO> getTalkList2(int depnum);

	int addTanswer(TogetherDTO dto);

	List<WorkDTO> getWorkList(int depnum);

	List<TalkDTO> searchList(String name);

	int checkid(String id);

	List<CustomerDTO> getMyList(String id);

}
