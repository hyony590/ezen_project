package toystory.utils.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class RankInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("Interceptor : PreHandle");

		HttpSession session = request.getSession();

		String rank = (String) session.getAttribute("loginRank");
//		String loginId = (String) session.getAttribute("loginId");

		// 관리자 일때 관리자 메인페이지로 redirect
		if(rank != null) {
			
			if (!rank.equals("A")) {
				response.sendRedirect("/main.toy");
				return false;
			}
			
		}else if(rank == null) {
			response.sendRedirect("/main.toy");
			return false;
		}

		return true;
	}
}
