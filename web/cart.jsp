<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

        h1 {
            font-size:35px;
   text-align: center; 
    /*padding: 1% 0 0% 0;*/
    color:#2c3e50;
   font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
  
        }
        ul{
        font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }

        p {
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
        }

        /* Table Styles */
        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #34495e;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            font-size: 16px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

/*        tr:hover {
            background-color: #f1c40f;
            color: white;
        }*/

        /* Action Link */
        a {
            text-decoration: none;
            color: #e74c3c;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Footer Note */
        

        /* Button Styles */
        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #2c3e50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
                        font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <h1>Shopping Cart</h1>
    <%
        // Retrieve the cart from the session
        HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) ss.getAttribute("cart");

        // Check if the cart is empty
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Your cart is empty!</p>
        <div class="button-container">
    <button onclick="location.href='products.jsp';">Back to products</button>
</div>
    <%
        } else {
    %>
    <table>
    <tr>
        <th>Product Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
        <th>Action</th>
    </tr>
    <%
        double grandTotal = 0;
        for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
            int productId = entry.getKey();
            Map<String, Object> product = entry.getValue();
            String productName = (String) product.get("name");
            double price = (double) product.get("price");
            int quantity = (int) product.get("quantity");

            // Calculate total for the product
            double total = price * quantity;

            // Add to grand total
            grandTotal += total;
    %>
    <tr>
        <td><%= productName %></td>
        <td>₹<%= price %></td>
        <td><%= quantity %></td> <!-- Quantity (read-only) -->
        <td>₹<%= total %></td>
        <td>
            <a href="RemoveFromCartServlet?productId=<%= productId %>">Remove</a>
        </td>
    </tr>
    <% } %>

    <!-- Calculate SGST, CGST, Discount, and Final Amount -->
    <%
        // Discount logic
        double discountRate = (grandTotal > 600) ? 0.20 : 0.10;
        double discount = grandTotal * discountRate;

        // Tax amounts
        double sgst = 8;
        double cgst = 8;
        double delivery = 40;

        // Final amount calculation
        double amountAfterDiscount = grandTotal - discount;
        double finalAmount = amountAfterDiscount + sgst + cgst + delivery;
        session.setAttribute("finalAmount", finalAmount);

    %>
    <tr>
        <td colspan="3" style="text-align:right;"><strong>Grand Total:</strong></td>
        <td colspan="2">₹<%= grandTotal %></td>
    </tr>
    <tr>
        <td colspan="3" style="text-align:right;"><strong>Discount (<%= (int)(discountRate * 100) %>% Applied):</strong></td>
        <td colspan="2">-₹<%= discount %></td>
    </tr>
    <tr>
        <td colspan="3" style="text-align:right;"><strong>SGST (₹8) + CGST (₹8):</strong></td>
        <td colspan="2">₹<%= sgst %> +  ₹<%= cgst %></td>
    </tr>
    <tr>
        <td colspan="3" style="text-align:right;"><strong>Delivery Charges :</strong></td>
        <td colspan="2">₹<%= delivery %></td>
    </tr>
    <tr>
        <td colspan="3" style="text-align:right;"><strong>Final Amount:</strong></td>
        <td colspan="2">₹<%= finalAmount %></td>
    </tr>
</table>



<div class="button-container">
    <button onclick="location.href='payment.jsp';">Proceed to Payment</button>
</div>

    <% } %>
</body>
</html>
