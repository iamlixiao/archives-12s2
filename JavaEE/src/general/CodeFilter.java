package general;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CodeFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpSession session = ((HttpServletRequest) arg0).getSession();
		session.getAttribute("logged");
		Boolean logged = (Boolean) session.getAttribute("logged");
		if (logged != null) {
			if (logged)
				arg2.doFilter(arg0, arg1);
		} else
			((HttpServletResponse) arg1).sendRedirect("../loginpage?redir="
					+ ((HttpServletRequest) arg0).getRequestURI());
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
