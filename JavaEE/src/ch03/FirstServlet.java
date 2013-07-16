package ch03;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FirstServlet
 */
public class FirstServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String htmltxta = "<!DOCTYPE html><html><head><meta charset=\"GBK\"><title>��ӭ</title></head><body>",
			htmltxte = "</body></html>";
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("GBK");
		PrintWriter out=response.getWriter();
		out.print(htmltxta+"���ҵĵ�һ��Java Servlet����<br/>������10300240007��<br/>��ӭʹ�ñ�ϵͳ"+htmltxte);
	}

}
