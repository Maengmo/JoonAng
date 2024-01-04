package com.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
}
