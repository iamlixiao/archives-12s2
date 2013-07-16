package cusinfo;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

public class CusinfoAccess {
	ResultSet allData;

	public ResultSet getAllData() {
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from cusinfo";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			allData=rs;
		} catch (Exception e) {
			e.printStackTrace();
			allData=null;
		}
		return allData;
	}

	public void setAllData(ResultSet allData) {
		this.allData = allData;
	}
	public ResultSet getData(String id){
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select * from cusinfo where cid='"+id+'\'';
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
			rs=null;
		}
		return rs;
	}
	public void setData(String id,String item,String value){
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "update cusinfo set "+item+"='"+value+"' where cid='"+id+'\'';
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void removeRecord(String id){
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "delete from cusinfo where cid='"+id+'\'';
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getMaxId(){
		Statement stat = null;
		Connection con = null;
		ResultSet rs = null;
		String c=null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "select max(cid+0) as newid from cusinfo";
			stat = con.createStatement();
			rs=stat.executeQuery(sql);
			rs.next();
			c=String.valueOf(rs.getInt("newid")+1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	public void addRecord(String cid,String cname,String phone,String mobile,String address){
		Statement stat = null;
		Connection con = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			con = DriverManager.getConnection(
					"jdbc:mysql://10.12.8.28/je1024007", "je1024007", "278156");
			String sql = "insert into cusinfo values('"+cid+"','"+cname+"','"+phone+"','"+mobile+"','"+address+"')";
			stat = con.createStatement();
			stat.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
}