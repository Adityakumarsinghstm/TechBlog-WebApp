package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.entities.*;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import com.tech.blog.entities.*;
import com.tech.blog.dao.*;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public final String directory = "D:\\servlet_workspace\\TechBlog\\src\\main\\webapp\\blog_pics";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		PrintWriter out = response.getWriter();
		int cid = Integer.parseInt(request.getParameter("cid"));
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");
		Part part = request.getPart("pic");
		
		//Getting Current userId
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		
				
		//out.println("your pTitle is :"+pTitle);
		//out.println(part.getSubmittedFileName());
		
		Post p = new Post(pTitle, pContent, pCode,part.getSubmittedFileName(),null,cid,user.getId());
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		
		if(dao.savePost(p))
		{
			
		
			/*
			 * String path = request.getRealPath("/") + "blog_pics" + File.separator +
			 * part.getSubmittedFileName(); Helper.saveFile(part.getInputStream(), path);
			 * out.println("done");
			 */
			
			
			 //String uploadDir = request.getServletContext().getRealPath("/") + "blog_pics" + File.separator;

		        // Create the directory if it does not exist
				/*
				 * File dir = new File(uploadDir); if (!dir.exists()) { dir.mkdirs(); }
				 */

		        // Save the image to the specified directory
				/* String imagePath = uploadDir + part.getSubmittedFileName(); */
		       try {
				Files.copy(part.getInputStream(),Paths.get(directory+File.pathSeparator+part.getSubmittedFileName()),StandardCopyOption.REPLACE_EXISTING);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

		        out.println("done");
		}
		else
		{
			out.println("error");
		}
	}

}
