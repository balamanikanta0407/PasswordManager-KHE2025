package com.pm.khepasswordmanager;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;


import java.io.File;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Base64;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

@Controller
public class KhePm {
	
	
	
	static Connection connection;
	static PreparedStatement pstmt = null;
	static ResultSet rst = null;
	
	 byte[] cipherText =null;
	 KeyGenerator keyGen =null;
	 SecretKey skey = null;
	
	 
	@GetMapping("/login")
	public String loginPage() throws NoSuchAlgorithmException, NoSuchPaddingException  {
		
		
		keyGen = keyGen.getInstance("AES");
	    skey = keyGen.generateKey();  
		
		return "login";
	}
	
	
	
	// In this post method consuming the username and password from client and authneticating with database password
	
	@PostMapping("/login")
	public String login(ModelMap model, @RequestParam String userId, @RequestParam String password) throws SQLException {
		
		
		//master login authentication
		String dbpass = masterpasswords(userId);
		System.out.println("test1 "+dbpass);
		if(password.equals(dbpass))
		{
			return "home";
		}
		model.put("errorMsg", "Incorrect username and Password");
		return "login";
		
	}
	
	

	@PostMapping("/home")
	public String homepage (ModelMap model, @RequestParam String website, @RequestParam String username, @RequestParam String password) throws InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, SQLException, NoSuchAlgorithmException {
		dbconnection();
		try
		{
		

	        	        LocalDate currentDate = LocalDate.now();

	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        String formattedDate = currentDate.format(formatter);
			
	        Statement stmt =connection.createStatement();
		
		String pass = passwordencryptdecrypt("encrypt",password);
		
		String sql = "insert into webcred values(?,?,?,?)";
		
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1,website);
		pstmt.setString(2, username);
		pstmt.setString(3, pass);
		
		pstmt.setString(4, formattedDate);
		
		
		pstmt.executeUpdate();
		
		
	        
		model.put("successMsg", "Data added successfully");
		}
		catch(SQLException ex)
		{
		ex.printStackTrace();
		}
		connection.close();
		return "home";
	}
	
	
	@GetMapping("/passwordmanager")
	public String fetch() {
		System.out.println("test2");
		return "passwordmanager";
	}
	
	
	@PostMapping("/passwordmanager")
	public String fetchdetails(ModelMap model, @RequestParam String website, @RequestParam String username) throws SQLException, InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, NoSuchAlgorithmException {
		String pass="";
		dbconnection();
		try {
			pstmt = connection.prepareStatement("select password from webcred where website = '"+website+"' and username = '"+username+"';");
			rst = pstmt.executeQuery();
			
			while(rst.next()) {
	            
	            pass=rst.getString(1);
	            
	         }
			
			pass=passwordencryptdecrypt("decrypt",pass);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		model.put("website", website);
		model.put("username", username);
		model.put("password", pass);
		connection.close();
		return "passwordmanager";
	}
	
	@GetMapping("/home")
	public String home() {
		System.out.println("test2");
		return "home";
	}
	
	public String passwordencryptdecrypt(String str, String password) throws NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, NoSuchAlgorithmException {
		
		Cipher cipher = Cipher.getInstance("AES");
		 String decpass="";
		 
		 //encyption
		if(str.equals("encrypt"))
		{
			password=password+"123";
			cipher.init(Cipher.ENCRYPT_MODE, skey);
		    cipherText = cipher.doFinal(password.getBytes(StandardCharsets.UTF_8));
		    
		    return Base64.getEncoder().encodeToString(cipherText);
		}
		//decryption
		else 
		{
			cipher.init(Cipher.DECRYPT_MODE, skey);
		    byte[] plaintext = cipher.doFinal(cipherText);
		    String string = new String(plaintext);
		    
		    
		    String dstr=string.substring(0, string.length() - 3);
		    
		    return dstr;
		    		
		}
		    
		    
		
	}
	
   
	public String masterpasswords(String userId) throws SQLException {
		
		dbconnection();
		String usrpass="";
		try {
			pstmt = connection.prepareStatement("select * from masterlogin where username = (?)");
			pstmt.setString(1, userId);			
			rst = pstmt.executeQuery();
			while(rst.next()) {
	            
	            usrpass=rst.getString(2);
	            System.out.println("Password "+usrpass);
	         }
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		connection.close();
		
		return usrpass;
	}

	public static Connection dbconnection()
	{
		String dbUrl="jdbc:mysql://localhost:3306/PasswordManager";
		String username="root";
		String pass="root@6976";
		 
		
		try {
			System.out.println("print");
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("print");
			
			connection=DriverManager.getConnection(dbUrl, username, pass);
			
			
			

			System.out.println(connection);
			return connection;

			
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("b");

		return connection;

		
	}
	
	
	
	
	
	
	
	
}
