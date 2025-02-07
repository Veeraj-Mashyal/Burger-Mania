<%-- 
    Document   : contactjsp
    Created on : 7 Jan 2025, 5:47:09 pm
    Author     : admin
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
  
<head>
<title>Contact Us</title>

<!-- navbar imports starts-->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- navbar imports end-->

<style>

/* NAVBAR STARTS */
@import url('https://fonts.googleapis.com/css2?family=Matemasie&display=swap'); 
.logo-name{
  font-family: "Matemasie", sans-serif;
  font-weight: 400;
  font-style:normal;
  
}
.select {
width: 100%;
margin-top:15px;
cursor: pointer;
position: relative;
transition: 300ms;
color: white;
/* overflow: hidden; */
}

.selected {
background-color: #2a2f3b;
padding: 5px;
margin-bottom: 3px;
border-radius: 5px;
position: relative;
z-index: 100000;
font-size: 15px;
display: flex;
align-items: center;
justify-content: space-between;

}

.arrow {
position: relative;
right: 0px;
height: 10px;
transform: rotate(-90deg);
width: 25px;
fill: white;
z-index: 100000;
transition: 300ms;
}

.options {
display: flex;
flex-direction: column;
border-radius: 5px;
padding: 5px;
background-color: #2a2f3b;
position: relative;
top: -100px;
opacity: 0;
transition: 300ms;
}

.select:hover > .options {
opacity: 1;
top: 0;
}

.select:hover > .selected .arrow {
transform: rotate(0deg);
}

.option {
border-radius: 5px;
padding: 5px;
transition: 300ms;
background-color: #2a2f3b;
width: 150px;
font-size: 15px;
}
.option:hover {
background-color: #323741;
}

.options input[type="radio"] {
display: none;
}

.options label {
display: inline-block;
}
.options label::before {
content: attr(data-txt);
}

.options input[type="radio"]:checked + label {
display: none;
}

.options input[type="radio"]#all:checked + label {
display: none;
}

.select:has(.options input[type="radio"]#all:checked) .selected::before {
content: attr(data-default);

}
/* .select:has(.options input[type="radio"]#option-1:checked) .selected::before {
content: attr(data-one);
border: 2px solid yellow;

}
.select:has(.options input[type="radio"]#option-2:checked) .selected::before {
content: attr(data-two);
}
.select:has(.options input[type="radio"]#option-3:checked) .selected::before {
content: attr(data-three);
} */
 
/*  NAVBAR ENDS */

.contact-main-container{
 width: 100%;
 height: 100%;
 padding: 2%;
 display: flex;
 flex-direction: row;
 justify-content:space-between;
 align-items: center;
 gap:2%;
 font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

}

.contact-container{
    width: 80%;
 height: 400px;
 display: flex;
 flex-direction: column;
 justify-content: center;
 align-items: center;
 border-radius: 20px;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.2);

}

.phone,.email,.address{
    font-size: 25px;
    margin-top: 20px;
}

.form-container {
    width: 80%;
    height: 400px;
    padding: 20px;
    border-radius: 20px;
    background-color: #fff;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.2);
}

form {
    display: flex;
    flex-direction: column;
    gap: 20px;
}


.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
    font-size: 20px;
    
}

.labels {
    margin-bottom: 8px;
    font-weight: bold;
}

input,
textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

textarea {
    resize: vertical;
    min-height: 100px;
}

.btn-submit {
    padding: 12px;
    border: none;
    border-radius: 4px;
    background-color: #2c3e50;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
    /* transition: background-color 0.3s; */
}

.btn-submit:hover {
    background-color: rgb(34, 34, 34);
}

/* Responsive Design */
@media (max-width: 768px) {
    .row {
        flex-direction: column;
    }
}
</style>
</head>

<body>
 
    
    

    
    
 <!-- navbar starts -->
  <header class="p-1  text-white bg-black dark:bg-black-100 dark:text-gray-800 bg-black-300 relative z-1">
    <div class="container flex justify-between h-16 mx-auto">
      <a rel="noopener noreferrer" href="#" aria-label="Back to homepage" class="flex items-center p-2">
        <span class="logo-name">Burger</span>
      </a>
    <ul class="items-stretch hidden space-x-3 md:flex">
    <li class="flex"><a rel="noopener noreferrer" href="store.html" class="flex items-center px-4 ">Store</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="cart.html" class="flex items-center px-4">Menu</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="contactjsp.jsp" class="flex items-center px-4">Contact Us</a></li>
    <li class="flex justify-center">
      <div class="select">
        <div class="selected" data-default="More" data-one="Login" data-two="Contact us" data-three="About us">
        <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512" class="arrow">
         <path d="M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z"></path>
        </svg>
        </div>

    <div class="options">
      <div title="all">
        <input id="all" name="option" type="radio" checked="" />
        <label class="option" for="all" data-txt="All"></label>
      </div>
      <a href="login.jsp">
        <div>
        <!-- <input id="option-1" name="option" type="radio" /> -->
        <label class="option">Login/Signup</label>
      </div></a>
      <a href="aboutus.html">
        <div>
        <!-- <input id="option-2" name="option" type="radio" /> -->
        <label class="option">About us</label>
      </div></a>
      <a href="feedback.jsp"><div>
        <!-- <input id="option-3" name="option" type="radio" /> -->
        <label class="option">Feedback</label>
      </div></a>
    </div>
</div>
</li>

<li class="flex">
  <a  href="cart.html" class="flex items-center w-8 h-15 ml-5 fg-red"><i class="fas fa-shopping-cart" style="font-size:20px"></i></a>
</li>

<li class="flex">
  <a  href="user-profile.jsp" class="flex items-center h-15"><i class="fa fa-user" style="font-size:20px"></i></a>
</li>

</ul>
<!-- <button class="flex justify-end p-4 md:hidden">
  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" class="w-6 h-6">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
  </svg>
</button> -->

</div>
</header>
<!-- navbar ends -->

<!-- Contact Starts -->
 <div class="contact-main-container">
  
    <div class="contact-container">
        <h3 class="phone">Phone <i class="fa fa-phone" style="font-size:24px"></i></h3>
        <p class="contact-link"><a href="tel:9923950160">+91 9923950160</a></p>
        <h3 class="email">Email <i class="fas fa-envelope" style="font-size:24px"></i></h3>
        <p class="contact-link"><a href="mailto:veerajm30@gmail.com">burgermania@gmail.com </a></p>
        <h3 class="address">Address <i class="fa-solid fa-location-dot" style="font-size:24px"></i></h3>
        <p class="contact-link"><a href="https://maps.app.goo.gl/DecYJqCNhefFBGtj8">201, Sai Paradise, Jule Solapur, Maharashtra</a></p>
    </div>

        <div class="form-container">
            <form action="" method="POST">
                <input type="hidden" name="uid" id="uid">
                <div class="form-group">
                    <label for="message" class="labels">Message</label>
                    <textarea id="message" name="message" required></textarea>
                </div>
                <button type="submit" class="btn-submit">Send</button>
            </form>
        </div>


 </div>
 <!-- Contact Ends -->



</body>
</html>
<% 
        // Handle form submission
//        String uid=request.getParameter("uid");
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        
        if (firstName != null && lastName != null && email != null && message != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                // Database connection details
                String url = "jdbc:mysql://localhost:3306/burgermania"; // Replace with your DB name
                String username = "root"; // Replace with your DB username
                String password = "Veeraj_1530"; // Replace with your DB password
                
                // Load JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish connection
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to insert form data
                String sql = "INSERT INTO contact (fname, lname, email, message) VALUES (?,?, ?, ?)";

                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setString(3, email);
                pstmt.setString(4, message);
                
                // Execute update
                int rowsInserted = pstmt.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p>Form submitted successfully!</p>");
                } else {
                    out.println("<p>Failed to submit the form. Please try again.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
