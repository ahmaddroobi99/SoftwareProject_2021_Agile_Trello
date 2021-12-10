/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package software.project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author YousefHanbali
 */
public class AdminController {
    

    
    
    public static Object[][] fetchAllUsers() throws SQLException{
        Object[][] data;
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        Statement stmt = con.createStatement();
        String Search = "SELECT USERNAME,FIRSTNAME,LASTNAME FROM USER";
        
        ResultSet rs = stmt.executeQuery(Search);
        int i  = 0;
        while(rs.next()){
            i++;
        }
        data = new Object[i][3];
        rs = stmt.executeQuery(Search);
        while(rs.next()){
            data[rs.getRow()-1] = new Object[]{rs.getString("USERNAME"),rs.getString("FIRSTNAME"),rs.getString("LASTNAME")};
        }
        
        return data;
    }
    
    
    public static String[] searchUser(String username) throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        Statement stmt = con.createStatement();
        String Search = "SELECT Username, firstName, lastName, userType, email, phone, address, gender FROM USER where username = '"+username+"'";
        ResultSet rs = stmt.executeQuery(Search);
        if(rs.next()){
            String[] info = new String[8];
            for(int i = 0;i<8;i++){
                info[i] = rs.getString(i+1);
            }
            return info;
        }else return null;
    }
    
    public static boolean addService(String serviceName,String accountNum)throws SQLException{
        Connection con = DriverManager.getConnection(ConnectionInfo.url,ConnectionInfo.username,ConnectionInfo.password);
        Statement stmt = con.createStatement();
        String insert = "INSERT INTO SERVICE(SERVICENAME,ACCOUNTNO) VALUES('"+serviceName+"','"+accountNum+"');";
        int t =stmt.executeUpdate(insert);
        if(t >= 1)
            return true;
        else return false;
    }
    
}
