<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  
<head>
<title>Login</title>

<!-- navbar imports starts-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Matemasie&display=swap" rel="stylesheet">
<!-- navbar imports end-->

<style>
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



.log-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 80vh;
            background-color: #fffdfd;
/*            backdrop-filter: 1;*/
            
        }

        .login-box {
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            max-width: 400px;
            width: 100%;
            padding: 20px;
        }

        .toggle-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .toggle-buttons button {
            width: 48%;
            padding: 10px;
            background: #4CAF50;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            /* font-family: 'Roboto', sans-serif; */
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            font-weight: 500;
        }

        .toggle-buttons button:hover {
            background: #45a049;
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 20px;
            color: black;
            font-size: 30px;
            font-weight: 600;
            /* font-family: 'Roboto', sans-serif; */
    font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        .login-box form {
            display: flex;
            flex-direction: column;
        }

        .login-box label {
            margin-bottom: 5px;
            font-weight: bold;
            font-family: 'Roboto', sans-serif;
            color: black;
        }

        .login-box input {
            padding: 10px;
            border: 1px solid #dddddd;
            border-radius: 4px;
            background: #f3f3f3;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .login-box button {
            padding: 10px;
            background: #2c3e50;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            font-weight: 500;
        }

        .login-box button:hover {
            background: rgb(34, 34, 34);
        }

        .signup-link {
            text-align: center;
            margin-top: 10px;
        }

        .signup-link a {
            text-decoration: none;
            color: rgb(47, 46, 46);
            font-family: 'Roboto', sans-serif;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .toggle-buttons button {
                font-size: 14px;
            }

            .login-box input {
                font-size: 14px;
            }

            .login-box button {
                font-size: 14px;
            }
        }z
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


<div class="log-container">
    <div class="login-box">
        <div class="toggle-buttons">
            <button onclick="showLogin('admin')">Admin</button>
            <button onclick="showLogin('user')">User</button>
        </div>

        <div id="admin-login" class="login-content">
            <h2>Admin Login</h2>
            <form action="admin_log_check.jsp" method="POST">
                <label for="admin-username">Email</label>
                <input type="email" id="admin-email" name="email" placeholder="Enter your Email" required>

                <label for="admin-password">Password</label>
                <input type="password" id="admin-password" name="password" placeholder="Enter your password" required>

                <button type="submit">Login</button>
            </form>

            <!-- <div class="signup-link">
                <a href="#">New user? Sign up here</a>
            </div> -->
        </div>

        <div id="user-login" class="login-content" style="display: none;">
            <h2>User Login</h2>
            <form action="Login_check.jsp" method="POST">
                <label for="user-username">Email</label>
                <input type="email" id="user-email" name="email" placeholder="Enter your Email" required>

                <label for="user-password">Password</label>
                <input type="password" id="user-password" name="password" placeholder="Enter your password" required>

                <button type="submit">Login</button>
            </form>

            <div class="signup-link">
                <a href="signin.jsp">New user? Sign up here</a>
            </div>
        </div>
    </div>
</div>

<script>
    function showLogin(type) {
        const adminBox = document.getElementById('admin-login');
        const userBox = document.getElementById('user-login');

        if (type === 'admin') {
            adminBox.style.display = 'block';
            userBox.style.display = 'none';
        } else {
            userBox.style.display = 'block';
            adminBox.style.display = 'none';
        }
    }

    // Default view
    showLogin('user');
</script>
</body>
</html>