<%@page import="com.User.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.Db.DBConnect"%>
<%@page import="com.DAO.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
UserDetails user3 = (UserDetails) session.getAttribute("userD");

if (user3 == null) {
	response.sendRedirect("login.jsp");

	session.setAttribute("login-error", "Please Login..");

}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Notes</title>

<%@include file="all_component/allcss.jsp"%>

</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<%
	
	  String updateMsg =(String)session.getAttribute("updateMsg");
	if(updateMsg!=null)
	{%>
	
	 <div class="alert alert-success" role="alert"><%=updateMsg%></div>
	
	<% 
	
	session.removeAttribute("updateMsg");
		
	}
	%>
	
		<%
	
	  String wrongMsg =(String)session.getAttribute("wrongMsg");
	if(wrongMsg!=null)
	{%>
	
	 <div class="alert alert-danger" role="alert"><%=wrongMsg%></div>
	
	<% 
	
	session.removeAttribute("wrongMsg");
		
	}
	%>
	


	<div class="container">


<div style="display: flex; justify-content: center; align-items: center; gap: 20px; margin-top: 20px ">    <img alt="" src="img/shownotes.jpg" 
                                 style="max-width: 70px; max-height: 90px;">
<h2 class="text-center">All Notes</h2>
		</div>
		

		<div class="d-flex flex-row flex-wrap justify-content-center">
    <% if (user3 != null) {
        PostDAO ob = new PostDAO(DBConnect.getConn());
        List<Post> post = ob.getData(user3.getId());
        int i = 0;
        for (Post po : post) {
            if (i % 2 == 0) { %>
                <div class="row no-gutters" style="width: 100%">
            <% } %>
            <div class="col-md-6">
                <div class="card card-horizontal m-3" style="background-color: #f1f0f0; border: 3px solid rgba(0,0,0,.125); border-radius: 0.75rem; height: 16rem ;" >
                    <div class="row no-gutters">
                        <div class="col-md-8">
                            <div class="card-body">
                                <h5 class="card=title"> Title - <%= po.getTitle() %></h5>
                                <p class="card-text" style="width: 30rem; "> Content - <%= po.getContent() %>.</p>
                                <p class="card-text">
                                    <b class="text-sucess" style = " font-weight: 490; ">Published By:<%= user3.getName() %></b> </br>
                                    <b class="text-primary"></b>
                                </p>
                                <p class="card-text">
                                    <b class="text-sucess" style = " font-weight: 490; " >Published Date:<%= po.getPdate() %></b> </br>
                                    <b class="text-sucess"></b>
                                </p>
                                <div class="container text-center mt-2" style="display: flex; gap: 0.4rem; padding-left: 0px;">
                                    <a href="deleteServlet?note_id=<%= po.getId() %>"
                                       class="btn btn-danger">Delete</a>
                                    <a href="edit.jsp?note_id=<%=po.getId() %>"
                                       class="btn btn-primary">Edit</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% if (i % 2 == 1 || i == post.size() - 1) { %>
                </div>
            <% } 
            i++;
        }
    } %>
</div>


	<%@include file="all_component/footer.jsp"%>
</body>
</html>