package pj;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.*;
import java.text.*;

public class Account {
	ResultSet allAccounts;

	public ResultSet getAllAccounts() {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from account";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			allAccounts = rs;
		} catch (Exception e) {
			e.printStackTrace();
			allAccounts = null;
		}
		return allAccounts;
	}

	public void setAllAccounts(ResultSet allAccounts) {
		this.allAccounts = allAccounts;
	}

	public int addAccount(String anick, String pwd) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select max(aid+0) as newid from account";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			rs.next();
			int c = rs.getInt("newid") + 1;
			sql = "insert into account (aid,anick,pwd,birthday) values("
					+ String.valueOf(c) + ",'" + anick + "','" + pwd
					+ "','1900-1-1')";
			stat.executeUpdate(sql);
			return c;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public ResultSet getAccounts(int pagen, int pages) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from account order by aid limit "
					+ String.valueOf(pages * pagen) + ','
					+ String.valueOf(pages);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			rs = null;
		}
		return rs;
	}

	public void modifyAccount(String aid, String pwd, String anick,
			String email, String birthday, String comment, String s1, String s2) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			Date d = new Date();
			String sql = "update account set pwd='" + pwd + "',anick='" + anick
					+ "',email='" + email + "',birthday='" + birthday
					+ "',comment='" + comment + "',s1=" + s1 + ",s2='" + s2
					+ "' where aid=" + aid;
			stat = con.createStatement();
			stat.executeUpdate(sql);
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean validate(String usn, String pwd) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from account where anick='" + usn
					+ "' and pwd='" + pwd + "'";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean validate(int aid, String pwd) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from account where aid="
					+ String.valueOf(aid) + " and pwd='" + pwd + "'";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public Integer getIdByNick(String nick) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		Integer c;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select aid from account where anick='" + nick + "'";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			rs.next();
			c = rs.getInt("aid");
		} catch (Exception e) {
			e.printStackTrace();
			c = null;
		}
		return c;
	}

	public String getNickById(int id) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		String c;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select anick from account where aid="
					+ String.valueOf(id);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			rs.next();
			c = rs.getString("anick");
		} catch (Exception e) {
			e.printStackTrace();
			c = null;
		}
		return c;
	}

	public boolean validateNick(String nick) {
		if (nick.length() < 1)
			return false;
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		String c;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from account where anick='" + nick + '\'';
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			return !rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ResultSet getRecords(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select rid,datetime,content from record where aid="
					+ String.valueOf(aid) + " order by datetime desc";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public void delRecord(int rid) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "delete from record where rid=" + String.valueOf(rid);
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void addRecord(int aid, String txt) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date d = new Date();
			String sql = "insert into record (aid,datetime,content) values("
					+ String.valueOf(aid) + ",'" + f.format(d) + "','" + txt
					+ "')";
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ResultSet getFriendsRecords(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select R.datetime,R.content,R.aid from record R where R.aid in (select a2id from aa where aa.a1id="
					+ String.valueOf(aid) + ") order by R.datetime desc";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet getFriends(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select a2id from aa where a1id="
					+ String.valueOf(aid);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet friendsGet(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select a1id from aa where a2id="
					+ String.valueOf(aid)
					+ " and a1id not in (select a2id from aa where a1id="
					+ String.valueOf(aid) + ')';
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet randomFriends(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select aid from account as A join (select round(rand()*(select max(aid) from account)) as id) as t2 where A.aid>t2.id and A.aid not in (select a2id from aa where a1id="
					+ String.valueOf(aid)
					+ ") and not A.aid="
					+ String.valueOf(aid) + " order by A.aid asc limit 10";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public boolean isFriend(int a1id, int a2id) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from aa where a1id=" + String.valueOf(a1id)
					+ " and a2id=" + String.valueOf(a2id);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ResultSet getData(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select aid,anick,email,birthday,comment,s2 from account where aid="
					+ String.valueOf(aid);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	public String getS2(int aid){
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		String c="";
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select s2 from account where aid="
					+ String.valueOf(aid);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			rs.next();
			c=rs.getString("s2");
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	public boolean modifyData(int aid, String anick, String email,
			Date birthday, String comment,String s2) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
			Date d = new Date();
			String sql = "update account set anick='" + anick + "',email='"
					+ email + "',birthday='" + f.format(birthday)
					+ "',comment='" + comment + "',s2='"+s2+"' where aid="
					+ String.valueOf(aid);
			stat = con.createStatement();
			stat.executeUpdate(sql);
			con.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean modifyPwd(int aid, String pwd) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "update account set pwd='" + pwd + "' where aid="
					+ String.valueOf(aid);
			stat = con.createStatement();
			stat.executeUpdate(sql);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public void delFriend(int a1id, int a2id) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "delete from aa where a1id=" + String.valueOf(a1id)
					+ " and a2id=" + String.valueOf(a2id);
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void addFriend(int a1id, int a2id) {
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "insert into aa (a1id,a2id) values ("
					+ String.valueOf(a1id) + ',' + String.valueOf(a2id) + ')';
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ResultSet getSettings(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select anick,email,birthday,comment,s2 from account where aid="
					+ String.valueOf(aid);
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public boolean isAdmin(int aid) {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		boolean c;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from account where aid="
					+ String.valueOf(aid) + " and s1=1";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			c = rs.next();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			c = false;
		}
		return c;
	}

	public static void main() {
		System.out.println((new Account()).getAllAccounts());
	}
}
