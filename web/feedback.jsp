<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check if the user is logged in
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
 <nav>
        <div class="logo">Burger</div>
        <ul class="nav-links">
            <li><a href="franchise.jsp">Get Franchise</a></li>
            <li><a href="products.jsp">Menu</a></li>
            <li><a href="contactjsp.jsp">Contact us</a></li>
            <li><a href="login.jsp">Login/Signup</a></li>
            <li><a href="aboutus.html">About us</a></li>
            <li class="highlight"><a href="feedback.jsp">Feedback</a></li>
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