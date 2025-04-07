<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Confirmation</title>
    <style>
        body {
            text-align: center;
            margin-top: 50px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }
        .message {
            font-size: 20px;
            color: green;
            margin-top: 20px;
        }
        .payment-details {
            margin-top: 30px;
            font-size: 18px;
            color: #555;
        }
        .checkmark {
            width: 100px;
            height: 100px;
            margin: 20px auto;
        }
        .checkmark-circle {
            stroke-dasharray: 314;
            stroke-dashoffset: 314;
            animation: circle-animation 0.9s ease-out forwards;
            stroke: #4caf50;
            stroke-width: 4;
            fill: none;
        }
        .checkmark-check {
            stroke-dasharray: 50;
            stroke-dashoffset: 50;
            animation: check-animation 0.7s ease-out 0.6s forwards;
            stroke: #4caf50;
            stroke-width: 6;
            stroke-linecap: round;
            fill: none;
        }
        a{
            display: inline-block;
            margin: 10px 5px;
            padding: 10px 15px;
            background-color: #2c3e50;
            color: #fff;
            text-decoration:none;
            border-radius: 5px;
        }
        a:hover{
            background: rgb(34, 34, 34);
        }
        
        @keyframes circle-animation {
            to {
                stroke-dashoffset: 0;
            }
        }
        @keyframes check-animation {
            to {
                stroke-dashoffset: 0;
            }
        }
    </style>
</head>
<body>

<%
    // Step 1: Validate user session
    HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userId = (String) ss.getAttribute("id");
    int uid = Integer.parseInt(userId);

    // Step 2: Retrieve total amount & payment method
    double finalAmount = Double.parseDouble(request.getParameter("finalAmount"));
    String paymentMethod = request.getParameter("paymentMethod");

    // Step 3: Get cart items from session
    Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) ss.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    // Step 4: Extract and format cart details
    StringBuilder orderDetails = new StringBuilder();
    StringBuilder quantityDetails = new StringBuilder();

    for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
        int productId = entry.getKey();
        Map<String, Object> product = entry.getValue();
        String productName = (String) product.get("name");
        int quantity = (int) product.get("quantity");

        if (orderDetails.length() > 0) orderDetails.append(", ");
        if (quantityDetails.length() > 0) quantityDetails.append(",");

        orderDetails.append(productName); // Store product names as CSV
        quantityDetails.append(quantity); // Store quantities as CSV
    }

    Connection con = null;
    PreparedStatement psOrder = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/burgermania", "root", "Veeraj_1530");

        // Step 5: Insert order into database
        String orderQuery = "INSERT INTO orders (uid, total_amount, order_details, quantity, status, payment_mode) VALUES (?, ?, ?, ?, 'Pending', ?)";
        psOrder = con.prepareStatement(orderQuery);
        psOrder.setInt(1, uid);
        psOrder.setDouble(2, finalAmount);
        psOrder.setString(3, orderDetails.toString());
        psOrder.setString(4, quantityDetails.toString());
        psOrder.setString(5, paymentMethod);
        psOrder.executeUpdate();

        // Step 6: Clear cart session after order placement
        ss.removeAttribute("cart");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (psOrder != null) psOrder.close();
        if (con != null) con.close();
    }
%>

<!-- Order Success Animation -->
<h1>Order Successful !!</h1>
<div class="checkmark">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
        <circle class="checkmark-circle" cx="26" cy="26" r="25"></circle>
        <path class="checkmark-check" fill="none" d="M14 27l7 7 17-17"></path>
    </svg>
</div>
<p class="message">Your order has been confirmed!</p>
<p><strong>Payment Mode:</strong> <%= paymentMethod %></p>
<p><strong>Total Amount:</strong> ₹<%= finalAmount %></p>
<a href="user-profile.jsp">Back to User Profile</a>
<a href="viewbill.jsp">View Bill</a>

</body>
</html>
