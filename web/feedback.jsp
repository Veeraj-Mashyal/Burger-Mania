<%@ page import="java.sql.*" %>
<%
    // Check if the user is logged in
    HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userId =(String)ss.getAttribute("id");
    int uid=Integer.parseInt(userId);

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String rating = request.getParameter("rating");
        String feedback = request.getParameter("feedback");

        Connection conn = null;
        PreparedStatement pstmt = null;
        String url = "jdbc:mysql://localhost:3306/burgermania";
        String user = "root";
        String password = "Veeraj_1530";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
           
            String sql = "INSERT INTO feedback2 (sid, fullname, email, rating, msg, created_at) " +
             "SELECT s.id, s.fullname, s.email, ?, ?, NOW() FROM users s WHERE s.id = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, rating);    // Set the rating value
pstmt.setString(2, feedback); // Set the feedback message
pstmt.setInt(3, uid);         // Set the user ID for the WHERE clause
int result = pstmt.executeUpdate();

//if (result > 0) {
//    out.println("Feedback submitted successfully.");
//} else {
//    out.println("Failed to submit feedback.");
//}

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>


<!DOCTYPE html>
<html>
  
<head>
<title>FEEDBACK</title>

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
ul{
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
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




/* FEEDBACK CONTAINER START*/
.feedback-container{
            width: 100%;
            height: 90vh;
            padding: 3% 0;
            display: flex;
            justify-content: center;
            align-items: center;
            /* border: 2px solid rebeccapurple; */
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }
        form{
            width: 80%;
            height: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 10px;
            border-radius: 20px;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.2);
            /* border: 2px solid green; */
        }
        .inputs{
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            /* border: 2px solid hotpink; */
        }
        .input-field{
            width: 50%;
            height: auto;
            display: block;
            padding: 1%;
            text-align: center;
            /* border:2px solid #2a2f3b */
        }
        .titles{
            font-size: large;
            font-weight:800; 
        }
        input,textarea{
            width: 100%;
            border: 1px solid black;
        }
        .submit{
            width: 50%;
            padding: .5%;
            border-radius: 10px;
            transition: background-color 0.3s ease;
            border: none;
            font-size: large;
            font-weight: 600;
            color: white;
            background-color: #2c3e50;
           .submit:hover{
                background-color: rgb(58, 58, 58);
            }
        }
        .star {
            font-size: 40px; /* Bigger star size */
            cursor: pointer; /* Pointer cursor for clickable stars */
            color: gray; /* Default star color */
            transition: color 0.3s ease; /* Smooth color transition */
        }
        .star.filled {
            color: gold; /* Filled star color */
        }
        .star.hover {
            color: gold; /* Preview star color on hover */
        }
        /* FEEDBACK CONTAINER END*/

        /* Responsive Design */
        @media (max-width: 600px) {
            form {
                padding: 1.5rem;
                width: 90%;
            }

            .star {
                font-size: 40px;
            }
        }


</style>
</head>

<body>
 
 <!-- navbar starts -->
  <header class="p-1  text-white bg-black dark:bg-black-100 dark:text-gray-800 bg-black-300 relative z-1">
    <div class="container flex justify-between h-16 mx-auto">
      <a rel="noopener noreferrer" href="index.html" aria-label="Back to homepage" class="flex items-center p-2">
        <span class="logo-name">Burger</span>
      </a>
    <ul class="items-stretch hidden space-x-3 md:flex">
    <li class="flex"><a rel="noopener noreferrer" href="store.html" class="flex items-center px-4 ">Store</a></li>
    <li class="flex"><a rel="noopener noreferrer" href="cart.html" class="flex items-center px-4">Menu</a></li>
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


<!-- Feedback Content  -->
<div class="feedback-container">
    <!-- <h1>Rate Us</h1> -->
    <form action="feedback.jsp" method="post">
        <!-- Star Rating -->
        <label class="titles" for="rating">How would you rate us?</label><br>
        <div id="stars">
            <span class="star" data-value="1">&#9733;</span>
            <span class="star" data-value="2">&#9733;</span>
            <span class="star" data-value="3">&#9733;</span>
            <span class="star" data-value="4">&#9733;</span>
            <span class="star" data-value="5">&#9733;</span>
        </div>
        <input type="hidden" id="rating" name="rating" value="" required>
        <br><br>

        <div class="inputs">
        <!-- Feedback -->
        <div class="input-field">
        <label class="titles" for="feedback">Tell us more:</label><br>
        <textarea id="feedback" name="feedback" rows="5" cols="30" required></textarea><br><br>
        </div>

        </div>

        <!-- Submit Button -->
        <button type="submit" class="submit">Submit</button>
    </form>
</div>

    <script>
        
        const stars = document.querySelectorAll('.star');
        const ratingInput = document.getElementById('rating');

        let selectedRating = 0; // Tracks the current selected rating

        stars.forEach((star, index) => {
            // Handle click event
            star.addEventListener('click', () => {
                const newRating = index + 1;

                if (newRating === selectedRating) {
                    // If clicking the same star, deselect the rating
                    selectedRating = 0;
                    ratingInput.value = '';
                    stars.forEach(s => s.classList.remove('filled'));
                } else {
                    // Update the rating
                    selectedRating = newRating;
                    ratingInput.value = selectedRating;

                    // Update star appearance based on the selected rating
                    stars.forEach((s, i) => {
                        if (i < selectedRating) {
                            s.classList.add('filled'); // Fill stars up to the selected one
                        } else {
                            s.classList.remove('filled'); // Unfill the rest
                        }
                    });
                }
            });

            // Handle hover effect
            star.addEventListener('mouseover', () => {
                // Preview hover state for stars up to the hovered one
                stars.forEach((s, i) => {
                    if (i <= index) {
                        s.classList.add('hover');
                    } else {
                        s.classList.remove('hover');
                    }
                });
            });

            // Handle mouse leave
            star.addEventListener('mouseleave', () => {
                // Clear hover effect when the mouse leaves
                stars.forEach(s => s.classList.remove('hover'));
            });
        });
    </script>
    <!-- Feedback Content -->


</body>
</html>