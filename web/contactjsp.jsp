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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Matemasie&display=swap" rel="stylesheet">
<!-- navbar imports end-->

<style>

/* NAVBAR STARTS */
* {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        nav {
            background: black;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 10px 10px 20px;
        }
        .logo {
            font-size: 15px;
            font-weight: 400;
            font-family: "Matemasie", serif;
            padding: 10px;
        }
        .nav-links {
            list-style: none;
            display: flex;
            gap: 20px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }
        .nav-links li {
            position: relative;
        }
        .nav-links a {
            text-decoration: none;
            color: white;
            padding: 10px;
            display: block;
        }
        .nav-links a:hover {
            background-color: rgb(66, 66, 66);
            border-radius: 10px;
        }
 
        .dropdown {
            display: none;
        }
        .icons {
            display: flex;
            gap: 5px;
            font-size: 20px;
            padding: 2px;
        }
        .icons a{
            padding: 10px;
            color: white;
        }
        .icons a:hover{
            background-color: rgb(66, 66, 66);
            border-radius: 10px; 
        }
        .menu-toggle {
            display: none;
            font-size: 24px;
            cursor: pointer;
        }
        .highlight{
            background-color: rgb(66, 66, 66);
            border-radius: 10px;
        }
        @media (max-width: 768px) {
            .nav-links {
                display: none;
                flex-direction: column;
                width: 100%;
                position: absolute;
                top: 60px;
                left: 0;
                background: black;
            }
            .nav-links.show {
                display: flex;
            }
            .menu-toggle {
                display: block;
            }
            .nav-links li {
                display: block;
                text-align: center;
            }
        }
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
.contact-link a{
    text-decoration: none;
    color: black;
}
.contact-link a:hover{
    text-decoration: underline;
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
   <nav>
        <div class="logo">Burger</div>
        <ul class="nav-links">
            <li><a href="franchise.jsp">Get Franchise</a></li>
            <li><a href="products.jsp">Menu</a></li>
            <li class="highlight"><a href="contactjsp.jsp">Contact us</a></li>
            <li><a href="login.jsp">Login/Signup</a></li>
            <li><a href="aboutus.html">About us</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
        </ul>
        <div class="icons">
            <a href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
            <a href="user-profile.jsp"><i class="fas fa-user"></i></a>
            <span class="menu-toggle">☰</span>
        </div>
    </nav>
    <script>
        document.querySelector(".menu-toggle").addEventListener("click", function() {
            document.querySelector(".nav-links").classList.toggle("show");
        });
    </script>
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
    HttpSession ss = request.getSession(false);
      if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
      }

      int uid = 0;
      try {
        String s = (String) ss.getAttribute("id");
        uid = Integer.parseInt(s);
      } catch (NumberFormatException e) {
        response.sendRedirect("login.jsp");
        return;
      }
      
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
