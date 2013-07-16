package numconv;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class Convert extends BodyTagSupport {
	public int doEndTag() throws JspException {
		String[] nums = getBodyContent().getString().split("[.]");
		String num = nums[0];
		JspWriter out = pageContext.getOut();
		int l = num.length(), l0 = (l - 1) % 16, l1 = (l - 1) % 8, l2 = (l - 1) % 4;
		boolean zero = false, head0 = true,head1=true;
		try {
			if (num.length() < 17) {
				for (int i = 0; i < num.length(); ++i) {
					switch (num.charAt(i)) {
					case '0':
						zero = true;
						break;
					case '1':
						if (zero)
							out.print('Áã');
						out.print("Ò¼");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '2':
						if (zero)
							out.print('Áã');
						out.print("·¡");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '3':
						if (zero)
							out.print('Áã');
						out.print("Èş");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '4':
						if (zero)
							out.print('Áã');
						out.print("ËÁ");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '5':
						if (zero)
							out.print('Áã');
						out.print("Îé");
						head0 = true;
						zero = false;
						break;
					case '6':
						if (zero)
							out.print('Áã');
						out.print("Â½");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '7':
						if (zero)
							out.print('Áã');
						out.print("Æâ");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '8':
						if (zero)
							out.print('Áã');
						out.print("°Æ");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					case '9':
						if (zero)
							out.print('Áã');
						out.print("¾Á");
						head0 = true;
						head1 = true;
						zero = false;
						break;
					}
					switch (l2) {
					case 0:
						l2 = 3;
						break;
					case 1:
						if (!zero)
							out.print('Ê°');
						--l2;
						break;
					case 2:
						if (!zero)
							out.print('°Û');
						--l2;
						break;
					case 3:
						if (!zero)
							out.print('Çª');
						--l2;
						break;
					}
					switch (l1) {
					case 4:
						if (head0&head1)
							out.print('Íò');
						head1 = false;
						zero=false;
						--l1;
						break;
					case 0:
						l1 = 7;
						break;
					default:
						--l1;
					}
					switch (l0) {
					case 8:
						if (head0)
							out.print('ÒÚ');
						head0 = false;
						zero=false;
						--l0;
						break;
					case 0:
						l0 = 15;
						break;
					default:
						--l0;
					}
				}
				out.print('Ôª');
				if (nums.length > 1) {
					String cha = nums[1];
					if (cha.length() > 0) {
						out.print(num2shu(cha.charAt(0)));
						out.print('½Ç');
					}
					if (cha.length() > 1) {
						String n = cha.substring(1, 2) + '.' + cha.substring(2);
						long c = Math.round(Double.parseDouble(n));
						out.print(num2shu(String.valueOf(c).charAt(0)));
						out.print('·Ö');
					}
				}
			}
			else out.print("°¡¹ş¹ş£¬ÌìÆø²»´í£¬·ç¶ùÓĞµãĞúÏùÄØ");
		} catch (java.io.IOException e) {
		}
		return EVAL_PAGE;
	}

	char num2shu(char a) {
		switch (a) {
		case '0':
			return 'Áã';
		case '1':
			return 'Ò¼';
		case '2':
			return '·¡';
		case '3':
			return 'Èş';
		case '4':
			return 'ËÁ';
		case '5':
			return 'Îé';
		case '6':
			return 'Â½';
		case '7':
			return 'Æâ';
		case '8':
			return '°Æ';
		default:
			return '¾Á';
		}
	}
}
