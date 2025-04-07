<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
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

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/burgermania";
    String user = "root";
    String password = "Veeraj_1530";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    ResultSet userRs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bill</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #333;
            padding: 8px 12px;
            border: 1px solid #333;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #333;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Order Bill</h2>
        <h3>User Details</h3>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);
                String userQuery = "SELECT fullname, email, telephone, address FROM users WHERE id = ?";
                pst = con.prepareStatement(userQuery);
                pst.setInt(1, uid);
                userRs = pst.executeQuery();
                if (userRs.next()) {
        %>
        <p><strong>Full Name:</strong> <%= userRs.getString("fullname") %></p>
        <p><strong>Email:</strong> <%= userRs.getString("email") %></p>
        <p><strong>Phone:</strong> <%= userRs.getString("telephone") %></p>
        <p><strong>Address:</strong> <%= userRs.getString("address") %></p>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        
        <h3>Order Details</h3>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Order Details</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Payment Mode</th>
                <th>Status</th>
            </tr>
            <%
                try {
                    String query = "SELECT order_id, order_date, order_details, quantity, total_amount, payment_mode, status FROM orders WHERE uid = ? ORDER BY order_id DESC LIMIT 1";
                    pst = con.prepareStatement(query);
                    pst.setInt(1, uid);
                    rs = pst.executeQuery();
                    if (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("order_id") %></td>
                <td><%= rs.getTimestamp("order_date") %></td>
                <td><%= rs.getString("order_details") %></td>
                <td><%= rs.getString("quantity") %></td>
                <td>₹<%= rs.getBigDecimal("total_amount") %></td>
                <td><%= rs.getString("payment_mode") %></td>
                <td><%= rs.getString("status") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (userRs != null) userRs.close();
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                }
            %>
        </table>
        <a href="user-profile.jsp" class="back-link">Back to User Profile</a>
    </div>
</body>
</html>
