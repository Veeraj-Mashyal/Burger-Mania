<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products Page</title>
    <style>
        /* Add your CSS here */
        body {
            font-family: Arial, sans-serif;
        }
        .category {
            margin: 20px 0;
        }
        .category h2 {
            text-align: center;
            color: #333;
        }
        .product-card {
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 10px;
            margin: 10px;
            width: 200px;
            height: auto;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .product-card img {
            max-width: 200px;
            height: 150px;
            border-radius: 8px;
            object-fit: cover;
        }
        .product-card button {
            padding: 8px 12px;
            margin-top: 10px;
            border: none;
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
        .product-card button:hover {
            background-color: rgb(34, 34, 34);
        }
        .quantity-controls {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
        }
        .quantity-controls button {
            padding: 5px;
            font-size: 14px;
            width: 30px;
            height: 30px;
            border: none;
            border-radius: 50%;
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
        }
        .quantity-controls button:hover {
            background-color: rgb(34, 34, 34);
        }
        .quantity-controls span {
            padding: 0 10px;
            font-size: 16px;
        }
    </style>
    <script>
        // Function to handle adding to cart
        function addToCart(button, productId, productName, productPrice) {
            console.log("addToCart invoked for productId:", productId); // Debugging

            const parent = button.parentNode;
            const controls = document.createElement('div');
            controls.className = 'quantity-controls';
            controls.innerHTML = `
                <button onclick="updateCart(${productId}, '${productName}', ${productPrice}, -1)">-</button>
                <span id="quantity-${productId}">1</span>
                <button onclick="updateCart(${productId}, '${productName}', ${productPrice}, 1)">+</button>
            `;
            parent.replaceChild(controls, button);

            // Send cart data to the server
            sendCartData(productId, productName, productPrice, 1);
        }

        // Function to update the quantity of the product in the cart
        function updateCart(productId, productName, productPrice, change) {
            const quantityElement = document.getElementById(`quantity-${productId}`);
            let quantity = parseInt(quantityElement.innerText);
            quantity += change;

            if (quantity <= 0) {
                quantityElement.closest('.quantity-controls').innerHTML = `<button onclick="addToCart(this, ${productId}, '${productName}', ${productPrice})">Add to Cart</button>`;
                quantity = 0;
            }

            quantityElement.innerText = quantity;

            // Send updated cart data to the server
            sendCartData(productId, productName, productPrice, quantity);
        }

        function sendCartData(productId, productName, productPrice, quantity) {
    // Check if any parameter is undefined or null
    if (productId === undefined || productName === undefined || productPrice === undefined || quantity === undefined) {
        console.error("Missing or undefined parameter:", { productId, productName, productPrice, quantity });
        return;
    }

    // Debugging: Log the values to see if they are correct
    console.log("Sending data to server:", {
        productId: productId,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity
    });

    // Ensure that productPrice and quantity are numbers
    if (isNaN(productPrice) || isNaN(quantity)) {
        console.error("Invalid data: productPrice and quantity should be numbers.");
        return;
    }

    // Create the URLSearchParams object
    const params = new URLSearchParams();
    params.append('id', productId);
    params.append('name', productName);
    params.append('price', productPrice);
    params.append('quantity', quantity);

    // Debugging: Log the formed parameters to make sure everything is encoded correctly
    console.log("Formed parameters:", params.toString());

    // Send the request to the server
    fetch('cart1.jsp', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params.toString()
    })
    .then(response => response.text())
    .then(data => {
        console.log("Cart updated:", data);
        // Optional: Update the UI or do something else after the cart is updated
    })
    .catch(error => {
        console.error("Error updating cart:", error);
    });
}



    </script>
</head>
<body>
    <%
        String dbURL = "jdbc:mysql://localhost:3306/burgermania";
        String dbUser = "root";
        String dbPassword = "Veeraj_1530";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            String queryCategories = "SELECT * FROM categories";
            Statement stmtCategories = connection.createStatement();
            ResultSet rsCategories = stmtCategories.executeQuery(queryCategories);

            while (rsCategories.next()) {
                int categoryId = rsCategories.getInt("id");
                String categoryName = rsCategories.getString("name");

                out.println("<div class='category'>");
                out.println("<h2>" + categoryName + "</h2>");

                String queryProducts = "SELECT * FROM products WHERE category_id = ?";
                try (PreparedStatement stmtProducts = connection.prepareStatement(queryProducts)) {
                    stmtProducts.setInt(1, categoryId);
                    ResultSet rsProducts = stmtProducts.executeQuery();

                    while (rsProducts.next()) {
                        int productId = rsProducts.getInt("id");
                        String productName = rsProducts.getString("name");
                        double productPrice = rsProducts.getDouble("price");
                        String imageUrl = rsProducts.getString("image_url");

                        out.println("<div class='product-card'>");
                        out.println("<img src='" + imageUrl + "' alt='" + productName + "'>");
                        out.println("<h3>" + productName + "</h3>");
                        out.println("<p>₹" + productPrice + "</p>");
                        out.println("<button onclick='addToCart(this, " + productId + ", \"" + productName + "\", " + productPrice + ")'>Add to Cart</button>");
                        out.println("</div>");
                    }
                }
                out.println("</div>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error fetching data from the database.</p>");
        }
    %>
</body>
</html>
