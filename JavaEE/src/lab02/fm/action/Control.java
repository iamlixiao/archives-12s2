package lab02.fm.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lab02.fm.service.Guessnum;

/**
 * Servlet implementation class Control
 */
public class Control extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Control() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession s = request.getSession();
		response.setCharacterEncoding("GBK");
		Guessnum gs = (Guessnum) s.getAttribute("data");
		if (gs == null) {
			gs = new Guessnum();
			gs.setNum((int) Math.round((Math.random() * 120 + 40)));
			s.setAttribute("data", gs);
		}
		if (request.getParameter("num") == null)
			response.getWriter().print("请输入数字！");
		else if (request.getParameter("num").length() == 0)
			response.getWriter().print("请输入数字！");
		else {
			response.getWriter()
					.print("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\" /><title>Insert title here</title></head><body>"
							+ pd(Integer.parseInt(request.getParameter("num")),
									gs, s) + "</body></html>");

		}
	}

	String pd(int n, Guessnum gs, HttpSession s) {
		if (n == gs.getNum()) {
			Guessnum g = new Guessnum();
			g.setVsn(1);
			g.setNum((int) Math.round((Math.random() * 120 + 40)));
			s.setAttribute("data", g);
			return "恭喜你！猜中了！重新开始";
		} else if (gs.getGsn() < 10) {
			gs.setGsn(gs.getGsn() + 1);
			return "错误,"+String.valueOf(gs.getGsn());
		} else {
			s.removeAttribute("data");
			Guessnum g = new Guessnum();
			g.setVsn(1);
			g.setNum((int) Math.round((Math.random() * 120 + 40)));
			s.setAttribute("data", g);
			return "你已经没有机会了，重新开始";
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
