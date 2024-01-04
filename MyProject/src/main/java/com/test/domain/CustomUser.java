package com.test.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

//UserDetails 인터페이스 구현 < 유저 정보 객체
//UserDetails <-- User 클래스 (이미 구현된 놈) 이놈꺼 상속 받기

@Getter
public class CustomUser extends User {

	private CustomerDTO member;
	
	public CustomUser(String username, String password,
						Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(CustomerDTO dto) {
		
		super(dto.getCus_id(), dto.getCus_pw(), getAuthorities(dto));
		this.member = dto;
	}
	
    private static Collection<GrantedAuthority> getAuthorities(CustomerDTO dto) {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_MEMBER"));
        // 추가적인 권한이 있다면 아래와 같이 추가 가능
        // authorities.add(new SimpleGrantedAuthority("ROLE_ANOTHER_ROLE"));
        
        return authorities;
    }
    
}

















