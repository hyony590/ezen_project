package toystory.utils.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;
import toystory.common.member.model.MemberModel;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter {

	private void saveDest(HttpServletRequest req) {

		String uri = req.getRequestURI();
		String query = req.getQueryString();

		// 기존 URI에 parameter가 있을 경우, 이를 포함
		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}

		if (req.getMethod().equals("GET")) {
			log.info("dest: " + (uri + query));
			req.getSession().setAttribute("dest", uri + query);
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("AuthInterceptor : PreHandle");
		System.out.println("AuthInterceptor : PreHandle");

		HttpSession session = request.getSession();

		String uri = request.getRequestURI();

		if (!uri.equals("/login/loginPro.toy") && session.getAttribute("loginNum") == null) {

			log.info("로그인이 필요한 서비스");

			saveDest(request);

			// 로그인하지 않은 사용자일 경우 로그인 페이지로 이동
			response.sendRedirect("/login/login.toy");
			return false;
		}

		if (uri.equals("/main.toy") && session.getAttribute("loginNum") != null) {
			// 이전 destination 불러오기 // response.sendRedirect("/");
			Object dest = session.getAttribute("dest");
			log.info("여기로 가질까" + dest);

			response.sendRedirect(dest != null ? (String) dest : "/");

			return false;
		}

		return true;
	}

	/*
	 * @Override public void postHandle(HttpServletRequest request,
	 * HttpServletResponse response, Object handler,
	 * 
	 * @Nullable ModelAndView modelAndView) throws Exception {
	 * log.info("postHandler : ");
	 * 
	 * HttpSession session = request.getSession(); MemberModel loginMember =
	 * (MemberModel) session.getAttribute("loginMember");
	 * 
	 * if (loginMember != null) {
	 * 
	 * // 이전 destination 불러오기 // response.sendRedirect("/"); Object dest =
	 * session.getAttribute("dest"); log.info("여기로 가질까" + dest);
	 * 
	 * response.sendRedirect(dest != null ? (String) dest : "/");
	 * 
	 * } }
	 */

	/*
	 * @Override public void afterCompletion(HttpServletRequest request,
	 * HttpServletResponse response, Object handler,
	 * 
	 * @Nullable Exception ex) throws Exception { log.info("postHandler : ");
	 * 
	 * String uri = request.getRequestURI();
	 * 
	 * HttpSession session = request.getSession(); MemberModel loginMember =
	 * (MemberModel) session.getAttribute("loginMember");
	 * 
	 * if (uri.equals("/login/loginPro.toy") && loginMember != null) {
	 * 
	 * // 이전 destination 불러오기 // response.sendRedirect("/"); Object dest =
	 * session.getAttribute("dest"); log.info("여기로 가질까" + dest);
	 * 
	 * response.sendRedirect(dest != null ? (String) dest : "/");
	 * 
	 * } }
	 */
}
