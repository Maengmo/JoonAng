package com.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.domain.AdminDTO;
import com.test.domain.AnswerDTO;
import com.test.domain.CustomerDTO;
import com.test.domain.TalkDTO;
import com.test.domain.TogetherDTO;
import com.test.domain.WorkDTO;
import com.test.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminMapper mapper;

	@Override
	public String getPwd(String adminName) {
		
		String pwd = mapper.getPwd(adminName);
		
		return pwd;
	}

	@Override
	public List<TalkDTO> TalkList() {
		
		List<TalkDTO> list = mapper.TalkList();
		
		return list;
	}

	@Override
	public List<TalkDTO> RecentTalk() {
		
		List<TalkDTO> list = mapper.RecentTalk();
		
		return list;
	}

	@Override
	public List<TalkDTO> BestTalk() {
		
		List<TalkDTO> list2 = mapper.BestTalk();
		
		return list2;
	}

	@Override
	public List<AdminDTO> getAmdin(String id) {
		
		List<AdminDTO> list = mapper.getAdmin(id);
		
		return list;
	}

	@Override
	public List<CustomerDTO> UserList() {
		
		List<CustomerDTO> list = mapper.UserList();
		
		return list;
	}

	@Override
	public List<CustomerDTO> adminUserDetail(String id) {
		
		List<CustomerDTO> detailList = mapper.adminUserDetail(id);
		
		return detailList;
	}

	@Override
	public int stopUser(String id) {
		
		int result = mapper.stopUser(id);
		
		return result;
	}

	@Override
	public int comebackUser(String id) {
		
		int result = mapper.comebackUser(id);
		
		return result;
	}

	@Override
	public int delUser(String id) {
		
		int result = mapper.delUser(id);
		
		return result;
	}

	@Override
	public void delState(String id) {
		
		mapper.delState(id);
		
	}

	@Override
	public List<CustomerDTO> getUserList(int depnum) {
		
		List<CustomerDTO> list = mapper.getUserList(depnum);
		
		return list;
	}

	@Override
	public List<CustomerDTO> searchList(String search) {
		
		List<CustomerDTO> list = mapper.searchList(search);
		
		return list;
	}

	@Override
	public List<CustomerDTO> stopList() {
		
		List<CustomerDTO> list = mapper.stopList();
		
		return list;
	}

	@Override
	public List<CustomerDTO> activeList() {
		
		List<CustomerDTO> list = mapper.activeList();
		
		return list;
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
	public int delAnswer(String ans_num) {
		
		int result = mapper.delAnswer(ans_num);
		
		return result;
	}

	@Override
	public List<AnswerDTO> answerList(String talk_num) {
		
		List<AnswerDTO> list = mapper.answerList(talk_num);
		
		return list;
	}

	@Override
	public List<TalkDTO> popularTalk() {
		
		List<TalkDTO> list = mapper.popularTalk();
		
		return list;
	}

	@Override
	public List<TogetherDTO> togetherList() {
		
		List<TogetherDTO> list = mapper.togetherList();
		
		return list;
	}

	@Override
	public List<WorkDTO> workList() {
		
		List<WorkDTO> list = mapper.workList();
		
		return list;
	}

	@Override
	public List<TogetherDTO> getDetail(String sta_num) {
		
		List<TogetherDTO> list = mapper.getDetail(sta_num);
		
		return list;
	}

	@Override
	public List<WorkDTO> getDepList(int dep_num) {
		
		List<WorkDTO> list = mapper.getDepList(dep_num);
		
		return list;
	}

	@Override
	public List<WorkDTO> getSearchList(String sValue) {
		
		List<WorkDTO> list = mapper.getSearchList(sValue);
		
		return list;
	}

	@Override
	public int delTogether(String to_num) {
		
		int result = mapper.delTogether(to_num);
		
		return result;
	}

	@Override
	public List<WorkDTO> popularTogether() {
		
		List<WorkDTO> list = mapper.popularTogether();
		
		return list;
	}

	@Override
	public List<WorkDTO> latestTogether() {
		
		List<WorkDTO> list = mapper.latestTogether();
		
		return list;
	}

}
