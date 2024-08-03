package kr.co.soldesk.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	//사용자가 지정한 이름을 통해서 사용
//	@Resource(name="loginUserBean")
//	private UserBean loginUserBean;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request) {
//		System.out.println(loginUserBean);
		System.out.println(request.getServletContext().getRealPath("/"));
		return "redirect:/main"; //redirect: -> 주소 재요청
	}
}
