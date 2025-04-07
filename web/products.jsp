<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Products Page</title>
     <!-- navbar imports starts-->
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Matemasie&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- navbar imports end-->
    <style>
        
        /*navbar css starts*/
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
  /* NAVBAR CSS END */

        
        
        
        
        
/*        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4ff4;
        }*/
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
            width: 300px;
            height: 350px;
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
        .product-card button:hover{
            background: rgb(34, 34, 34);
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
        .search-container {
    width: 100%;
    max-width: 400px;
    margin: 20px auto;
    position: relative;
}

.search-container input {
    width: 100%;
    padding: 10px 40px 10px 15px;
    border: 2px solid #ff9800;
    border-radius: 25px;
    font-size: 16px;
    outline: none;
    transition: 0.3s;
}

.search-container input:focus {
    border-color: #e65100;
    box-shadow: 0 0 10px rgba(255, 152, 0, 0.5);
}

.search-container i {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: #ff9800;
    font-size: 18px;
}

    </style>
</head>
<body>
    
    <nav>
        <div class="logo">Burger</div>
        <ul class="nav-links">
            <li><a href="franchise.jsp">Get Franchise</a></li>
            <li class="highlight"><a href="products.jsp">Menu</a></li>
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

<div class="search-container">
    <input type="text" id="searchBox" placeholder="Search for products..." onkeyup="filterProducts()">
    <i class="fas fa-search"></i>
</div>  
    

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
    
    <script>
function filterProducts() {
    let input = document.getElementById("searchBox").value.toLowerCase();
    let products = document.querySelectorAll(".product-card");

    let hasResults = false;

    products.forEach(product => {
        let name = product.querySelector("h3").innerText.toLowerCase();
        if (name.includes(input)) {
            product.style.display = "block";
            hasResults = true;
        } else {
            product.style.display = "none";
        }
    });

    let noResultsMessage = document.getElementById("noResults");
    if (!hasResults) {
        if (!noResultsMessage) {
            noResultsMessage = document.createElement("p");
            noResultsMessage.id = "noResults";
            noResultsMessage.innerText = "No products found.";
            document.querySelector(".products-container").appendChild(noResultsMessage);
        }
    } else {
        if (noResultsMessage) noResultsMessage.remove();
    }
}
</script>

</body>
</html>
