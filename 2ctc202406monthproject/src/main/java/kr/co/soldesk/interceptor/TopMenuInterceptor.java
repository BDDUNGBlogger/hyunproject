package kr.co.soldesk.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.TopMenuService;


public class TopMenuInterceptor implements HandlerInterceptor{
	
	//@Autowired : Interceptor처리된 클래스에서는 오토와이어드를 사용할 수 없음
	private TopMenuService topMenuService;
	private UserBean loginUserBean;
	//DI
	public TopMenuInterceptor(TopMenuService topMenuService, UserBean loginUserBean) {
		this.topMenuService=topMenuService;
		this.loginUserBean=loginUserBean;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		List<BoardInfoBean> topMenuList=topMenuService.getTopMenuList(); //4개 게시판
		request.setAttribute("topMenuList", topMenuList);
		request.setAttribute("loginUserBean", loginUserBean);
		return true;
	}
	
	

}