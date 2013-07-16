package cusinfo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CusCtl extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CusCtl() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String act = request.getParameter("act");
		if (act.equals("del")) {
			CusinfoAccess cas = new CusinfoAccess();
			cas.removeRecord(request.getParameter("cid"));
			response.sendRedirect("../cusinfo.jsp");
		} else if (act.equals("mod")) {
			request.getSession().setAttribute("cid",
					request.getParameter("cid"));
			response.sendRedirect("../cusmod.jsp");
		} else if (act.equals("new")) {
			CusinfoAccess cas = new CusinfoAccess();
			request.getSession().setAttribute("cid", cas.getMaxId());
			request.getSession().setAttribute("new", "true");
			response.sendRedirect("../cusnew.jsp");
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		CusinfoAccess cas = new CusinfoAccess();
		String cid = (String) request.getSession().getAttribute("cid");
		if (request.getSession().getAttribute("new") == null) {
			cas.setData(cid, "cname", request.getParameter("cname"));
			cas.setData(cid, "phone", request.getParameter("phone"));
			cas.setData(cid, "mobile", request.getParameter("mobile"));
			cas.setData(cid, "address", request.getParameter("address"));
			response.sendRedirect("../cusinfo.jsp");
		} else if (((String) request.getSession().getAttribute("new"))
				.equals("true")) {
			HttpSession s = request.getSession();
			s.setAttribute("cname", request.getParameter("cname"));
			s.setAttribute("phone", request.getParameter("phone"));
			s.setAttribute("mobile", request.getParameter("mobile"));
			s.setAttribute("address", request.getParameter("address"));
			response.sendRedirect("../cusconfirm.jsp");
			request.getSession().setAttribute("new", "confirm");
		} else if (((String) request.getSession().getAttribute("new"))
				.equals("confirm")) {
			HttpSession s = request.getSession();
			cas.addRecord(cid, (String) s.getAttribute("cname"), (String) s
					.getAttribute("phone"), (String) s.getAttribute("mobile"),
					(String) s.getAttribute("address"));
			response.sendRedirect("../cusinfo.jsp");
			request.getSession().setAttribute("new", null);
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the POST method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
