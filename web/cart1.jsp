<%@ page import="java.util.*, java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .total {
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
        }
        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            text-align: center;
            display: inline-block;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    // Get or initialize the cart (session scope)
    HttpSession sessio = request.getSession();
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) sessio.getAttribute("cart");

    // If cart is null, initialize it as a new HashMap
    if (cart == null) {
        cart = new HashMap<>();
        sessio.setAttribute("cart", cart); // Save the empty cart back to the session
    }

    // Get data from the request (POST data sent from products1.jsp)
    String productIdStr = request.getParameter("id");
    String productName = request.getParameter("name");
    String productPriceStr = request.getParameter("price");
    String quantityStr = request.getParameter("quantity");

    if (productIdStr != null && productName != null && productPriceStr != null && quantityStr != null) {
        int productId = Integer.parseInt(productIdStr);
        double productPrice = Double.parseDouble(productPriceStr);
        int quantity = Integer.parseInt(quantityStr);

        // Add to the cart
        if (cart.containsKey(productId)) {
            CartItem item = cart.get(productId);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            CartItem item = new CartItem(productId, productName, productPrice, quantity);
            cart.put(productId, item);
        }

        // Save updated cart to the session
        sessio.setAttribute("cart", cart);
    }

    // Calculate the total price
    double total = 0;
    DecimalFormat df = new DecimalFormat("0.00");

    // Debugging: Check if the cart is null
    if (cart == null) {
        out.println("Cart is null!");
    } else {
        // Debugging: Check the cart contents
        for (Map.Entry<Integer, CartItem> entry : cart.entrySet()) {
            CartItem item = entry.getValue();
            System.out.println("Item ID: " + item.getProductId() + ", Name: " + item.getProductName() + ", Price: " + item.getProductPrice() + ", Quantity: " + item.getQuantity());
        }

        // Calculate total price
        for (CartItem item : cart.values()) {
            total += item.getTotalPrice();
        }
    }

%>

<!-- Now you can display the cart data or total price -->
<p>Total: ₹<%= df.format(total) %></p>

<!-- Now you can display the cart data or total price -->
<p>Total: ₹<%= df.format(total) %></p>


<h2>Your Cart</h2>

<% if (cart.isEmpty()) { %>
    <p>Your cart is empty. Add some products to the cart!</p>
<% } else { %>

<table>
    <thead>
        <tr>
            <th>Item</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
        </tr>
    </thead>
    <tbody>
        <% for (CartItem item : cart.values()) { %>
            <tr>
                <td><%= item.getProductName() %></td>
                <td>₹<%= df.format(item.getProductPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>₹<%= df.format(item.getTotalPrice()) %></td>
            </tr>
        <% } %>
    </tbody>
</table>

<div class="total">
    Total: ₹<%= df.format(total) %>
</div>

<a href="products1.jsp" class="btn">Continue Shopping</a>

<% } %>

</body>
</html>

<%! 
    // CartItem class to hold product details in the cart
    public static class CartItem {
        private int productId;
        private String productName;
        private double productPrice;
        private int quantity;

        public CartItem(int productId, String productName, double productPrice, int quantity) {
            this.productId = productId;
            this.productName = productName;
            this.productPrice = productPrice;
            this.quantity = quantity;
        }

        public int getProductId() {
            return productId;
        }

        public String getProductName() {
            return productName;
        }

        public double getProductPrice() {
            return productPrice;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public double getTotalPrice() {
            return productPrice * quantity;
        }
    }
%>
