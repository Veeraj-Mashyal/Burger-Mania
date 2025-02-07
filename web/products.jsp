<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
     <!-- navbar imports starts-->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- navbar imports end-->
    <style>
        
         /* NAVBAR CSS START */
/*  @import url('https://fonts.googleapis.com/css2?family=Matemasie&display=swap'); 
.logo-name{
  font-family: "Matemasie", sans-serif;
  font-weight: 400;
  font-style:normal;
  
}*/
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
z-index: 10000;
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

  /* NAVBAR CSS END */

        
        
        
        
        
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4ff4;
        }
        html{
    scroll-behavior: smooth;
  }
        .category {
            margin-top: 2%;
            margin-bottom: 2%;
            font-size: 35px;
            font-weight: bold;
            color: #2c3e50;
            text-align: center;
            text-transform: uppercase;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }
        .products-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin: 10px 0 40px;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }
        .product-card {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 250px;
            height: auto;
            margin-bottom: 50px;
            gap: 2%;
            padding: 15px;
            text-align: center;
            border: .5rem solid white;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
        .product-card img {
            width: 250px;
            height: 150px;
            object-fit: cover;
            border-radius: 3%;
        }
        .product-card h3 {
            margin: 10px 0;
            font-size: 20px;
            color: #333;
            font-weight: 500;
        }
        .product-card p {
            font-size: 20px;
            color: #666;
            margin: 10px 0;
        }
        .product-card button {
            background-color: #2c3e50;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            outline: none;
        }
        .cart-buttons {
    display: flex;
    justify-content: center;  /* Center the buttons horizontally */
    align-items: center;      /* Center the buttons vertically */
    gap: 10px;                /* Space between the buttons */
    margin-top: 10px;
}

        .cart-buttons button {
            background-color: #2c3e50;
            color: #fff;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        .cart-buttons span {
            font-size: 20px;
            font-weight: 500;
            color:#2c3e50;
            
        }
        .coming-soon {
            text-align: center;
            font-size: 18px;
            color: gray;
            margin: 20px 0;
        }
        
    </style>
</head>
<body>

        <div class="navclass">

  <!-- navbar starts -->
  <header class="p-1  text-white bg-black dark:bg-black-100 dark:text-gray-800 bg-black-300 relative z-1">
    <div class="container flex justify-between h-16 mx-auto">
      <a rel="noopener noreferrer" href="mainpg.html" aria-label="Back to homepage" class="flex items-center p-2">
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
  <a  href="cart.jsp" class="flex items-center w-8 h-15 ml-5 fg-red"><i class="fas fa-shopping-cart" style="font-size:20px"></i>
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
    
    

    <%
        // Database connection parameters
        String dbURL = "jdbc:mysql://localhost:3306/burgermania";
        String dbUser = "root";
        String dbPassword = "Veeraj_1530";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // Retrieve the cart from the session
        HttpSession sess = request.getSession();
        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) sess.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Query to fetch products with categories
            String sql = "SELECT c.name AS category_name, p.id AS product_id, p.name AS product_name, p.price, p.image_url " +
                         "FROM categories c " +
                         "LEFT JOIN products p ON c.id = p.category_id " +
                         "ORDER BY c.id ASC, p.name ASC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            // Current category for grouping
            String currentCategory = null;
            boolean hasProducts = false; // Tracks if the current category has products

            // Loop through the result set
            while (rs.next()) {
                String categoryName = rs.getString("category_name");
                int productId = rs.getInt("product_id");
                String productName = rs.getString("product_name");
                double price = rs.getDouble("price");
                String imageUrl = rs.getString("image_url");

                // Check if we're in a new category
                if (!categoryName.equals(currentCategory)) {
                    // Close the previous category's products-container (if any)
                    if (currentCategory != null) {
                        if (!hasProducts) {
                            %>
                            <p class="coming-soon">Coming Soon!</p>
                            <%
                        }
                        %>
                        </div>
                        <%
                    }

                    // Print the new category name
                    currentCategory = categoryName;
                    hasProducts = false; // Reset for the new category
                    %>
                    <div class="category"><%= currentCategory %></div>
                    <div class="products-container">
                    <%
                }

                // Print the product details if they exist
                if (productName != null) {
                    hasProducts = true; // Mark that this category has products
                    %>
                    <div class="product-card">
                        <img src="<%= imageUrl %>" alt="<%= productName %>">
                        <h3><%= productName %></h3>
                        <p>₹<%= price %></p>
                        <div>
                            <%
                                if (cart.containsKey(productId)) {
                                    // Product is already in the cart, show + and - buttons
                                    Map<String, Object> product = cart.get(productId);
                                    int quantity = (int) product.get("quantity");
                            %>
                            <div class="cart-buttons">
                                <form action="UpdateCartServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="productId" value="<%= productId %>">
                                    <button type="submit" name="action" value="decrease">-</button>
                                </form>
                                <span><%= quantity %></span>
                                <form action="UpdateCartServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="productId" value="<%= productId %>">
                                    <button type="submit" name="action" value="increase">+</button>
                                </form>
                            </div>
                            <%
                                } else {
                                    // Product is not in the cart, show "Add to Cart" button
                            %>
                            <form action="AddToCartServlet" method="post">
                                <input type="hidden" name="productId" value="<%= productId %>">
                                <input type="hidden" name="productName" value="<%= productName %>">
                                <input type="hidden" name="price" value="<%= price %>">
                                <button type="submit">Add to Cart</button>
                            </form>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <%
                }
            }

            // Close the last category container
            if (currentCategory != null) {
                if (!hasProducts) {
                    %>
                    <p class="coming-soon">Coming Soon !</p>
                    <%
                }
                %>
                </div>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>
