package com.test.mapper;

import java.util.List;

import com.test.domain.AdminDTO;
import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.TalkDTO;
import com.test.domain.TogetherDTO;
import com.test.domain.WorkDTO;

public interface AdminMapper {

	String getPwd(String adminName);

	List<TalkDTO> TalkList();

	List<TalkDTO> RecentTalk();

	List<TalkDTO> BestTalk();

	List<AdminDTO> getAdmin(String id);

	List<CustomerDTO> UserList();

	List<CustomerDTO> adminUserDetail(String id);

	int stopUser(String id);

	int comebackUser(String id);

	int delUser(String id);

	void delState(String id);

	List<CustomerDTO> getUserList(int depnum);

	List<CustomerDTO> searchList(String search);

	List<CustomerDTO> stopList();

	List<CustomerDTO> activeList();

	int delTalk(String talk_num);

	void delTalk_like(String talk_num);

	int delAnswer(String ans_num);

	List<AnswerDTO> answerList(String talk_num);

	List<TalkDTO> popularTalk();

	List<TogetherDTO> togetherList();

	List<WorkDTO> workList();

	List<TogetherDTO> getDetail(String sta_num);

	List<WorkDTO> getDepList(int dep_num);

	List<WorkDTO> getSearchList(String sValue);

	int delTogether(String to_num);

	List<WorkDTO> popularTogether();

	List<WorkDTO> latestTogether();
	
	

}
