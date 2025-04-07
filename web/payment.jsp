<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
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
            margin: 0;
            padding: 20px;
            /*background-color: #2c3e50;*/
            color: #2c3e50;
            text-align: center;
            font-size: 36px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        .container {
            width: 50%;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .amount-display {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #27ae60;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .payment-options {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .payment-option {
            width: 48%;
            display: flex;
            align-items: center;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: box-shadow 0.3s ease;
        }

        .payment-option:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .payment-option input {
            margin-right: 10px;
        }

        .button-container {
            text-align: center;
        }

        button {
            padding: 12px 30px;
            margin-top: 5%;
            font-size: 16px;
            color: white;
            background-color: #2c3e50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        button:hover {
            background: rgb(34, 34, 34);
        }

        .note {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>
    <h1>Payment</h1>
    <div class="container">
        <%
            // Retrieve the final amount from the session
            Object amountObj = session.getAttribute("finalAmount");
            double finalAmount = 0;

            if (amountObj != null) {
                finalAmount = (double) amountObj;
            } else {
                out.println("<p style='color: red; text-align: center;font-size:20px;'>Final amount not set. Please go back and complete the previous step.</p>");
                return; // Stop further processing of the page
            }
            String paymentMethod="payment";
            session.setAttribute("paymentMethod", paymentMethod);
            session.setAttribute("finalAmount",finalAmount);
        %>
        <div class="amount-display">
            Total Amount to Pay: ₹<%= finalAmount %>
        </div>
        
        <form action="paymentConfirmation.jsp" method="post">
    <!-- Ensure these hidden inputs are set properly -->
    <input type="hidden" name="finalAmount" value="<%= session.getAttribute("finalAmount") %>">
    <!-- Payment options as radio buttons -->
    <div class="payment-options">
        <input type="radio" name="paymentMethod" value="Credit Card" required> Credit Card
        <input type="radio" name="paymentMethod" value="Debit Card" required> Debit Card
        <input type="radio" name="paymentMethod" value="Net Banking" required> Net Banking
        <input type="radio" name="paymentMethod" value="UPI" required> UPI
        <input type="radio" name="paymentMethod" value="Cash on Delivery" required> Cash on Delivery
    </div>
    <button type="submit">Place Order</button>
</form>

    </div>
</body>
</html>
