package ch03;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OnlineTest
 */
public class OnlineTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String htmltxta = "<!DOCTYPE html><html><head><meta charset=\"GBK\"><title>���߲���</title><style type=\"text/css\">form div div:last-child{margin: 0.3em 2em;font-size: 22px;color: #28f;}</style></head><body>",
			htmltxte = "</body></html>",
			htmltxtc = "<form accept-charset=\"GBK\" method=\"post\" action=\"onlinetest\"><div><div>һ������⣨25�֣�</div><div>�¶���24Сʱ��һ�֣�<input name=\"1.1\" type=\"text\"></div></div><div><div>������ѡ�⣨25�֣�</div><div>��仰�м����֣�<input name=\"2.1\" value=\"5\" type=\"radio\">5��<input name=\"2.1\" value=\"6\" type=\"radio\">6��<input name=\"2.1\" value=\"7\" type=\"radio\">7��<input name=\"2.1\" value=\"8\" type=\"radio\">8��</div></div><div><div>������ѡ�⣨32�֣�</div><div>��仰���ļ����֣�<input value=\"1\" name=\"3.1\" type=\"checkbox\">��<input value=\"2\" name=\"3.1\" type=\"checkbox\">��<input value=\"3\" name=\"3.1\" type=\"checkbox\">��<input value=\"4\" name=\"3.1\" type=\"checkbox\">��<input value=\"5\" name=\"3.1\" type=\"checkbox\">��<input value=\"6\" name=\"3.1\" type=\"checkbox\">��<input value=\"7\" name=\"3.1\" type=\"checkbox\">��<input value=\"8\" name=\"3.1\" type=\"checkbox\">��</div></div><div><div>�ġ��ж��⣨18�֣�</div><div>��һ��������û�У�<input name=\"4.1\" style=\"width:30px\" type=\"text\">��T��F��</div></div><div><input type=\"reset\"/><input type=\"submit\" value='�ύ'/></div></form>";

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("GBK");
		response.getWriter().print(htmltxta + htmltxtc + htmltxte);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		response.setContentType("text/html;charset=GBK");
		String[] checked = request.getParameterValues("3.1");
		int score;
		if (checked != null) {
			score = checked.length;
			boolean p = false;
			for (int i = 0; i < checked.length; ++i)
				if (checked[i].equals("5"))
					p = true;
			if (p)
				score -= 1;
			else if (score == 7)
				score = 8;
		} else
			score = 0;
		int total = (request.getParameter("1.1").equals("��") ? 25 : 0)
				+ score
				* 4
				+ (request.getParameter("4.1").equals(
						request.getParameter("1.1").length() == 0 ? "F" : "T") ? 18
						: 0);
		if (request.getParameter("2.1") != null)
			total += request.getParameter("2.1").equals("7") ? 25 : 0;
		response.getWriter().print(
				htmltxta + "<div style=\"background:"
						+ (total > 59 ? "#1d1" : "#d11") + "\">��ĵ÷�Ϊ��"
						+ String.valueOf(total) + "</div>" + htmltxtc
						+ htmltxte);
	}

}
