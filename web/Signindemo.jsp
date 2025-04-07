<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

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
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- navbar imports end-->

<style>
    .error { color: red; }
        .form-group { margin-bottom: 10px; }
        .labels { display: block; font-weight: bold; }

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
}
.select:has(.options input[type="radio"]#option-2:checked) .selected::before {
content: attr(data-two);
}
.select:has(.options input[type="radio"]#option-3:checked) .selected::before {
content: attr(data-three);
} */

.form-container {
    width: 100%;
    height: auto;
    padding: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
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
    background-color: black;
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
  <header class="p-1  text-white bg-black dark:bg-black-100 dark:text-gray-800 bg-black-300 relative z-1">
    <div class="container flex justify-between h-16 mx-auto">
      <a rel="noopener noreferrer" href="mainpg.html" aria-label="Back to homepage" class="flex items-center p-2">
        <span class="logo-name">Burger</span>
      </a>
    <ul class="items-stretch hidden space-x-3 md:flex">
    <li class="flex"><a rel="noopener noreferrer" href="" class="flex items-center px-4 ">Store</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="index.html" class="flex items-center px-4">Menu</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="#" class="flex items-center px-4">Contact</a></li>
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
      <a href="Login.html">
        <div>
        <!-- <input id="option-1" name="option" type="radio" /> -->
        <label class="option">Login</label>
      </div></a>
      <a href="#contact">
        <div>
        <!-- <input id="option-2" name="option" type="radio" /> -->
        <label class="option">Contact us</label>
      </div></a>
      <a href="about1.html"><div>
        <!-- <input id="option-3" name="option" type="radio" /> -->
        <label class="option">About us</label>
      </div></a>
    </div>
</div>
</li>

<li class="flex">
  <a  href="index.html" class="flex items-center w-8 h-15 ml-5 fg-red"><i class="fas fa-shopping-cart"></i>
  <!-- <span class="material-symbols-outlined">shopping_cart</span> -->
  </a>
</li>

<li class="flex">
  <a  href="user1.html" class="flex items-center h-15"><i class="fa fa-user"></i>
  <!-- <span class="material-symbols-outlined">shopping_cart</span> -->
  </a>
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