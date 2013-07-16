package general;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginPage
 */
public class LoginPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String htmltxta = "<!DOCTYPE html><html><head><meta charset=\"GBK\"><title>¡ƒÃÏ “</title></head><body>",
			htmltxte = "</body></html>";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginPage() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.getWriter()
				.print(htmltxta
						+ "<form method=\"post\" action=\"loginpage\"><input type='text' name='usn'/><input type='password' name='pwd'/><input type='submit'/></form>"
						+ htmltxte);
		request.getSession().setAttribute("redir",
				request.getParameter("redir"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String u = request.getParameter("usn"), p = request.getParameter("pwd");
		if (u.equals("lxlx") && p.equals("xlxl")) {
			request.getSession().setAttribute("logged", true);
			response.sendRedirect((String) request.getSession().getAttribute(
					"redir"));
		}
	}

}
