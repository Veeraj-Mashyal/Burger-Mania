<!DOCTYPE html>
<html>
  
<head>
<title>Login</title>

<!-- navbar imports starts-->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- navbar imports end-->

<style>

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
ul{
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }



.log-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
            padding: 20px;
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
  <header class="p-1  text-white bg-black dark:bg-black-100 dark:text-gray-800 bg-black-300 relative z-1">
    <div class="container flex justify-between h-16 mx-auto">
      <a rel="noopener noreferrer" href="mainpg.html" aria-label="Back to homepage" class="flex items-center p-2">
        <span class="logo-name">Burger</span>
      </a>
    <ul class="items-stretch hidden space-x-3 md:flex">
    <li class="flex"><a rel="noopener noreferrer" href="store.html" class="flex items-center px-4 ">Store</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="products.jsp" class="flex items-center px-4">Menu</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="contactjsp.jsp" class="flex items-center px-4">Contact us</a></li>
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
  <a  href="cart.html" class="flex items-center w-8 h-15 ml-5 fg-red"><i class="fas fa-shopping-cart" style="font-size:20px"></i>
  <!-- <span class="material-symbols-outlined">shopping_cart</span> -->
  </a>
</li>

<li class="flex">
  <a  href="user-profile.jsp" class="flex items-center h-15"><i class="fa fa-user" style="font-size:20px"></i>
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
                <a href="#">New user? Sign up here</a>
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