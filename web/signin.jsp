<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fullname = request.getParameter("fullname");
    String email = request.getParameter("email");
    String telephone = request.getParameter("telephone");
    String address = request.getParameter("address");
    String password = request.getParameter("password");
    String cfpassword = request.getParameter("cfpassword");

    if (fullname == null || email == null || telephone == null || address == null || password == null) {
        out.println("<script>alert('All fields are required. Please fill out the form correctly.');</script>");
    } else if (!password.equals(cfpassword)) {
        out.println("<script>alert('Passwords do not match. Please try again.');</script>");
    } else {
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/burgermania", "root", "Veeraj_1530");

            // Insert data into the database
            String query = "INSERT INTO users (fullname, email, telephone, address, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, fullname);
            pst.setString(2, email);
            pst.setString(3, telephone);
            pst.setString(4, address);
            pst.setString(5, password); // Consider hashing the password

            int rowCount = pst.executeUpdate();

            pst.close();
            con.close();

            if (rowCount > 0) {
                // Redirect to login page
                response.sendRedirect("login.jsp");
            } else {
                out.println("<script>alert('Signup failed. Please try again.');</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Database error: " + e.getMessage() + "');</script>");
        }
    }
%>


<!DOCTYPE html>
<html>
  
<head>
<title>NAVBARmain</title>

<!-- navbar imports starts-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Matemasie&display=swap" rel="stylesheet">
<!-- navbar imports end-->

<style>
    .error { color: red; }
        .form-group { margin-bottom: 10px; }
        .labels { display: block; font-weight: bold; }

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
.form-container {
    width: 100%;
    height: auto;
    padding: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

    /* border: 2px solid green; */
}

form {
    width:40%;
    display: flex;
    flex-direction: column;
    padding: 1%;
    gap: 20px;
    border-radius: 20px;
    background-color: #fff;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.2);
    /* border: 2px solid peru; */
}
.title{
    /* width: 100%; */
    text-align: center;
    font-size: 30px;
    font-weight: 700;
    padding: 2% 0% ;
    margin-bottom: 2%;
    font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
    /* border-radius: 10px;
    background-color: rgb(255, 255, 255);
    box-shadow: 0 0.1rem 0.5rem rgba(0, 0, 0, 0.2); */
}

/*.row {
    display: flex;
    gap: 20px;
}*/

.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
    
}

.labels {
    margin-bottom: 8px;
    font-weight: bold;
}

input{
    width: 100%;
    padding: 10px;
    border: 1.5px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}
button[type="button"]{
  padding: 12px;
    border: none;
    border-radius: 4px;
    background-color: black;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
    /* transition: background-color 0.3s; */
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
    background-color: rgb(46, 45, 45);
}

/* Responsive Design */
@media (max-width: 768px) {
    .row {
        flex-direction: column;
    }
}

.contact-notif {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

 /* Notification Container */
 #notification {
            position: fixed;
            top: 20px;
            right: 50px;
            background-color: #ee3c2f; /* Default: Red for errors */
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            font-family: Arial, sans-serif;
            font-size: 14px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: none;
            z-index: 1000;
            animation: fadeInOut 3s forwards;
        }

        /* Fade-in and fade-out animation */
        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateY(-100%); }
            10% { opacity: 1; transform: translateY(0); }
            80% { opacity: 1; transform: translateY(0);}
            100% { opacity: 0; transform: translateY(-100%); }
        }

        /* Buttons */
        .btn {
            margin: 10px;
            padding: 10px 20px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0056b3;
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
            <li><a href="contactjsp.jsp">Contact us</a></li>
            <li class="highlight"><a href="login.jsp">Login/Signup</a></li>
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


<div class="form-container">
        <form>
        <h3 class="title">Signup</h3>
   
        <div class="form-group">
            <label for="fullname" class="labels">Full Name </label>
            <input type="text" id="fullname" name="fullname" required>
        </div>
        
        <div class="form-group">
            <label for="email" class="labels">Email </label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="telephone" class="labels">Contact </label>
            <input type="tel" id="tel" name="telephone" pattern="[0-9]{10}" required>
            <div class="contact-notif" id="contact-notif"></div>
        </div>

        <div class="form-group">
            <label for="address" class="labels">Address </label>
            <input type="text" id="address" name="address" required pattern="^\d{1,5}\s?[a-zA-Z0-9\s,]+\s[a-zA-Z\s,]+,\s?[a-zA-Z\s]+$" placeholder="House no , House name , Area name , City name">
        </div>

        <div class="form-group">
            <label for="password" class="labels">Password </label>
            <input type="password" id="password" name="password">
        </div>

        <div class="form-group">
            <label for="cfpassword" class="labels">Confirm Password </label>
            <input type="password" id="cfpassword" name="cfpassword" >
        </div>
        
        <button type="submit" class="btn-submit" onclick="return validateForm()">Submit</button>
    </form>
</div>
<script>

function validateForm() {
    const fullname = document.getElementById("fullname").value.trim();
    const email = document.getElementById("email").value.trim();
    const telephone = document.getElementById("tel").value.trim();
    const address = document.getElementById("address").value.trim();
    const password = document.getElementById("password").value;
    const cfpassword = document.getElementById("cfpassword").value;

    // Fullname Validation
    if (fullname === "") {
        alert("Full Name cannot be empty.");
        return false;
    }

    // Email Validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("Please enter a valid email address.");
        return false;
    }

    // Telephone Validation
    const telRegex = /^[0-9]{10}$/;
    if (!telRegex.test(telephone)) {
        alert("Please enter a valid 10-digit contact number.");
        return false;
    }

    // Address Validation
    const addressRegex = /^\d{1,5}\s?[a-zA-Z0-9\s,]+\s[a-zA-Z\s,]+,\s?[a-zA-Z\s]+$/;
    if (!addressRegex.test(address)) {
        alert("Please enter a valid address in the format: House no, House name, Area name, City name.");
        return false;
    }

    // Password Validation
    if (password === "") {
        alert("Password cannot be empty.");
        return false;
    }

    // Confirm Password Validation
    if (password !== cfpassword) {
        alert("Passwords do not match. Please try again.");
        return false;
    }

    // If all validations pass, submit the form
    return true;
}


</script>



</body>
</html>