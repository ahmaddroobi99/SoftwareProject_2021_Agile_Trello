/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package software.project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;

/**
 *
 * @author YousefHanbali
 */
public class User {
    
    
    public static Date getBirth(String username) throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        Statement stmt = con.createStatement();
        String Search = "SELECT birth FROM USER where username = '"+username+"'";
        ResultSet rs = stmt.executeQuery(Search);
        if(rs.next()){
            return rs.getDate(1);
        }else return null;
    }
    
    public static boolean checkAccount(String user,String currency) throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        Statement stmt = con.createStatement();
        String Search = "SELECT * FROM account where ownerusername = '"+user+"' and currency = '"+currency+"'";
        ResultSet rs = stmt.executeQuery(Search);
        if(rs.next())
            return true;
        else return false;
    }
    
    public static boolean addSubAccount(String user,String currency) throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);

        String insert = "INSERT INTO ACCOUNT(CURRENCY,BALANCE,OWNERUSERNAME) VALUES(?,?,?);";
        PreparedStatement pstmt = con.prepareStatement(insert);
        pstmt.setString(1, currency);
        pstmt.setInt(2, 0);
        pstmt.setString(3, user);
        int r = pstmt.executeUpdate();
        if (r >= 1)
            return true;
        else return false;
    }
    
    public static boolean updateUser(String user,String[] info,Date d) throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        String update = "UPDATE USER SET Username =?,firstName=?,lastName=?,email=?,phone=?,birth=?,address=?,gender=? where username=?";
        PreparedStatement stmt = con.prepareStatement(update);
        stmt.setString(1, info[0]);
        stmt.setString(2, info[1]);
        stmt.setString(3, info[2]);
        stmt.setString(4, info[3]);
        stmt.setInt(5, Integer.parseInt(info[4]));
        stmt.setDate(6, d);
        stmt.setString(7, info[5]);
        stmt.setString(8, info[6]);
        stmt.setString(9, user);
        // user,first,last,email,phone,birth,address,gender
        int t = stmt.executeUpdate();
        if(t >=1) return true;
        else return false;
    }
    
    public static boolean changePass(String user,String pass) throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        Statement stmt = con.createStatement();
        String updatePass ="UPDATE USER SET PASSWORD='"+pass+"' WHERE username='"+user+"'";
        int t = stmt.executeUpdate(updatePass);
        if(t >= 1)
        return true;
        else return false;
    }
    
}
