package ch03;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class chatroom
 */
public class ChatRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String htmltxta = "<!DOCTYPE html><html><head><meta charset=\"GBK\"><title>¡ƒÃÏ “</title></head><body>",
			htmltxtb = "<!DOCTYPE html><html><head><meta charset=\"GBK\"><title>¡ƒÃÏ “</title><meta http-equiv=\"refresh\" content=\"1\"></head><body>",
			htmltxte = "</body></html>";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChatRoom() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		if (request.getParameter("get") == null) {
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("username"), loginvalue = "";
			if (username != null)
				loginvalue = username;
			response.getWriter()
					.print(htmltxta
							+ "<form accept-charset=\"GBK\" method=\"post\" action=\"chatroom\"><input type=\"text\" name=\"login\" value=\""
							+ loginvalue
							+ "\"/><input type=\"submit\"/></form>" + htmltxte);
		} else {
			String text = (String) getServletContext().getAttribute("text");
			response.getWriter().print(
					htmltxtb + "<pre>" + (text == null ? "" : text) + "</pre>"
							+ htmltxte);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		HttpSession session = request.getSession(true);
		String username = request.getParameter("login"), text = (String) getServletContext()
				.getAttribute("text");
		if (username != null)
			session.setAttribute("username", username);
		else
			username = (String) session.getAttribute("username");
		if (text == null)
			text = "";
		if (request.getParameter("word") != null
				&& request.getParameter("word").length() > 0) {
			text = text + '\n' + username + '£∫' + request.getParameter("word");
			getServletContext().setAttribute("text", text);
		}
		response.getWriter()
				.print(htmltxta
						+ "<iframe src=\"chatroom?get=0\" style=\"width:500px;height:500px\"></iframe><form method=\"post\" action=\"chatroom\"><input name=\"word\" type=\"text\"/><input type=\"submit\"/></form>"
						+ htmltxte);
	}

}
