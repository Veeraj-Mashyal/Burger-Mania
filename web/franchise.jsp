<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Franchise Registration</title>
    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Matemasie&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        
        /* Navbar css Starts */
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
        /* Navbar css ends */
        
        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 90%;
            margin: auto;
            margin-top: 50px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }
        h2 {
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }
        .form-control {
            background: #f8f9fa;
            border: 1px solid #ced4da;
            padding: 12px;
            transition: 0.3s;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }
        .btn-submit {
            background: #2c3e50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
            width: 100%;
        }
        .btn-submit:hover {
            background: rgb(34, 34, 34);
        }
        .alert {
            font-size: 14px;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    
        <!-- navbody starts -->
<nav>
        <div class="logo">Burger</div>
        <ul class="nav-links">
            <li class="highlight"><a href="franchise.jsp">Get Franchise</a></li>
            <li><a href="products.jsp">Menu</a></li>
            <li><a href="contactjsp.jsp">Contact us</a></li>
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
    <!-- navbody ends -->

<div class="container">
    <h2>Franchise Registration</h2>

    <% 
        String message = "";
        if(request.getMethod().equals("POST")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String location = request.getParameter("location");
            String franchiseMessage = request.getParameter("message");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/burgermania", "root", "Veeraj_1530");
                
                String query = "INSERT INTO franchises (name, email, phone, location, message) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setString(3, phone);
                pst.setString(4, location);
                pst.setString(5, franchiseMessage);

                int rowCount = pst.executeUpdate();
                if(rowCount > 0) {
                    message = "<div class='alert alert-success'>Thank you! We will contact you soon.</div>";
                } else {
                    message = "<div class='alert alert-danger'>Error submitting form. Try again.</div>";
                }
                con.close();
            } catch (Exception e) {
                message = "<div class='alert alert-danger'>Database error: " + e.getMessage() + "</div>";
            }
        }
    %>

    <%= message %>

    <form method="POST" onsubmit="return validateForm()">
        <div class="mb-3">
            <input type="text" name="name" id="name" class="form-control" placeholder="Full Name" required>
        </div>
        
        <div class="mb-3">
            <input type="email" name="email" id="email" class="form-control" placeholder="Email" required>
        </div>
        
        <div class="mb-3">
            <input type="text" name="phone" id="phone" class="form-control" placeholder="Phone Number" required>
        </div>

        <div class="mb-3">
            <input type="text" name="location" id="location" class="form-control" placeholder="Preferred Location" required>
        </div>

        <div class="mb-3">
            <textarea name="message" id="message" class="form-control" placeholder="Why do you want a franchise?" rows="4" required></textarea>
        </div>

        <button type="submit" class="btn-submit">Submit</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function validateForm() {
        let phone = document.getElementById("phone").value;
        let email = document.getElementById("email").value;
        let name = document.getElementById("name").value;
        let location = document.getElementById("location").value;
        
        let phoneRegex = /^[0-9]{10}$/;
        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!phoneRegex.test(phone)) {
            alert("Enter a valid 10-digit phone number.");
            return false;
        }
        if (!emailRegex.test(email)) {
            alert("Enter a valid email address.");
            return false;
        }
        if (name.trim() === "" || location.trim() === "") {
            alert("All fields are required.");
            return false;
        }
        return true;
    }
</script>

</body>
</html>