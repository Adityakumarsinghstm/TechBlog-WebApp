
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>

<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.*"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page errorPage="error_page.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>profile_page</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="CSS/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(0 0, 100% 0, 100% 93%, 67% 100%, 34% 93%, 0 100%);
}
body{
background:url("img/about3.jpg");
background-size:cover;
background-attachment: fixed;

}
</style>

</head>
<body>

	<!--STart of navbar  -->

	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"> <span
			class="fa fa-asterisk"></span> Tech Blog
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"> <span
						class="	fa fa-bell-o"></span> LearnCodeWithAadi <span
						class="sr-only">(current)</span></a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="	fa fa-check-square-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>

				<li class="nav-item"><a class="nav-link" href="#"> <span
						class="	fa fa-address-card-o"></span> Contact
				</a></li>

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal"> <span
						class="	fa fa-asterisk"></span> Do Post
				</a></li>



			</ul>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"> <span
						class="fa fa-user-circle "></span> <%=user.getName()%>
				</a></li>

				<li class="nav-item"><a class="nav-link" href="LogoutServlet">
						<span class="fa fa-user-plus "></span> Logout
				</a></li>
			</ul>
		</div>
	</nav>

	<!-- End of Navbar -->


	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>

	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%>

	</div>
	<%
	session.removeAttribute("msg");

	}
	%>

	<!-- Main body of the page -->

	<main>
		<div class="container">
			<div class="row mt-4">
				<!-- First Column -->
				<div class="col-md-4">
					<div class="list-group">
						<a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action active">
							All Posts</a>
						<!-- Categories -->
						<%
						PostDao d = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list1 = d.getAllCategories();
						for (Category cc : list1) {
						%>

						<a href="#" onclick="getPosts(<%=cc.getCid() %>,this)" class=" c-link list-group-item list-group-item-action "> <%=cc.getName()%></a>


						<%
						}
						%>

					</div>


				</div>
				<!-- Second Column -->
				<div class="col-md-8" id="post-container">
					<!-- Posts -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-4">Loading...</h3>

					</div>
					<div class="container-fluid" id="post-container">
					
					
					</div>


				</div>

			</div>
		</div>
	</main>
	<!-- end main body of the page	 -->

	<!-- Start of Modal -->



	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="image-fluid"
							style="border-radius: 50%; max-width: 150px"> <br>
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!-- Creating tables -->

						<div id="profile-details">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">Id:</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>

									</tr>

									<tr>
										<th scope="row">Status:</th>
										<td><%=user.getAbout()%></td>

									</tr>

									<tr>
										<th scope="row">Registered on:</th>
										<td><%=user.getDateTime().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>

						<!-- Edit Profile -->

						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>Id :</td>
										<td><%=user.getId()%></td>
									</tr>

									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>

									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>

									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>


									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>

									<tr>
										<td>About :</td>
										<td><textarea rows="3" class="form-control"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>

									<tr>
										<td>Profile Pic:</td>
										<td><input type="file" name="image" class="form-control">
										</td>
									</tr>

								</table>


								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>
							</form>




						</div>





					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- End of Modal -->


	<!-- Add Post Modal -->




	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						Post Details....</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="post">

						<div class="form-group">

							<select class="form-control" name="cid">
								<option selected disabled>---Select Categories---</option>

								<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postd.getAllCategories();
								for (Category c : list) {
								%>

								<option value="<%=c.getCid()%>"><%=c.getName()%></option>


								<%
								}
								%>
							</select>

						</div>


						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Enter Post Title"
								class="form-control" />

						</div>

						<div class="form-group">
							<textarea name="pContent" class="form-control"
								placeholder="Enter your content" style="height: 200px"></textarea>

						</div>

						<div class="form-group">
							<textarea name="pCode" class="form-control"
								placeholder="Enter your code (if any)" style="height: 200px"></textarea>

						</div>

						<div class="form-group">
							<label>Select your pic...</label> <br> <input type="file"
								name="pic">

						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>

						</div>

					</form>

				</div>



			</div>
		</div>
	</div>




	<!-- End Post Modal -->




	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>



	<script src="js/myjs.js" type="text/javascript"></script>

	<script>
		$(document).ready(function() {

			let editStatus = false;

			$('#edit-profile-button').click(function() {
				// alert("button Clicked")
				if (editStatus == false) {
					$('#profile-details').hide()

					$('#profile-edit').show();
					editStatus = true;
					$(this).text("Back");
				}

				else {
					$('#profile-details').show()

					$('#profile-edit').hide();
					editStatus = false;
					$(this).text("Edit");

				}
			})

		});
	</script>


	<!-- Now Add Post JS -->

	<script>
		$(document)
				.ready(
						function(e) {
							// alert("loaded...")

							$("#add-post-form")
									.on(
											"submit",
											function(event) {

												//this code gets called when form submitted
												event.preventDefault();
												console
														.log("you have clicked on submitted....")

												let form = new FormData(this);
												//now requesting to server
												$
														.ajax({

															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																//success
																console
																		.log(data);
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"saved successfully!",
																			"success");
																} else {
																	swal(
																			"Error!",
																			" went wrong try again!",
																			"success");
																}

															},

															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																//error...
																swal(
																		"Error!",
																		"Something went wrong try again!",
																		"success");

															},
															processData : false,
															contentType : false

														})
											})
						})
	</script>
	<!-- Loading post using ajax -->
	<script >
	function getPosts(catId,temp)
    {
		$("#loader").show();
		$("#post-container").hide()
		$(".c-link").removeClass('active');
		  $.ajax({
				url:"load_posts.jsp",
				data:{cid: catId},
			    success: function(data,textStatus,jqXHR)
			    {
			    	console.log(data);
			    	$("#loader").hide();
			    	$("#post-container").show();
			    	$("#post-container").html(data);
			    	$(temp).addClass('active');
			    }
		  })
    }
	  $(document).ready (function (e){
		  let allPostRef = $('.c-link')[0]
		  getPosts(0,allPostRef)
		
		  
	  })
	
	</script>

</body>
</html>