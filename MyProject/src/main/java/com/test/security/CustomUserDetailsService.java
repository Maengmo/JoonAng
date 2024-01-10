package com.test.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.test.domain.AdminDTO;
import com.test.domain.CustomUser;
import com.test.domain.CustomerDTO;
import com.test.mapper.BoardMapper;

public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private PasswordEncoder encoder = new BCryptPasswordEncoder();
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
	
		int result = mapper.checkMember(username);
		int result2 = mapper.checkAdmin(username);
		
		if(result == 1) {
			
			CustomerDTO dto = mapper.readMember(username);
			dto.setCus_pw(encoder.encode(dto.getCus_pw()));
			return dto != null ? new CustomUser(dto) : null;

		}else if(result2 == 1) {
			
			AdminDTO dto = mapper.readAdmin(username);
			dto.setAd_pw(encoder.encode(dto.getAd_pw()));
			return dto != null ? new CustomUser(dto) : null;
			
		}
		return null;
		
	}
	
}
