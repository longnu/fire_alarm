package com.controller;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.command.Command;
import com.model.memberDAO;
import com.model.memberDTO;

public class JoinServiceCon implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String moveURL = null;
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String email = request.getParameter("name");
		String tel = request.getParameter("tel");
		String address = request.getParameter("address");
			
		memberDTO dto = new memberDTO(id, pw, email, tel, address);
		memberDAO dao = new memberDAO();
		
		int cnt = dao.join(dto);
		
			if(cnt > 0) {
				System.out.println("회원가입 성공");
				
				HttpSession session = request.getSession();
				session.setAttribute("email", email);
				
				moveURL = "intro.jsp#menu";
			}
			else {	
				System.out.println("회원가입 실패");
				
				moveURL = "intro.jsp";
			}
		
			return moveURL;
	}

}
