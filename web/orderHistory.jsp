<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check if the user is logged in
    HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = Integer.parseInt(ss.getAttribute("id").toString()); // Get logged-in user's ID

    // Database Connection
    String jdbcURL = "jdbc:mysql://localhost:3306/burgermania";
    String dbUser = "root";
    String dbPassword = "Veeraj_1530";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <style>
        body {
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            margin: 20px;
            text-align: center;
        }
        h1{
            text-align: center;
      color: #2c3e50;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>

    <h1>Order History</h1>

    <table>
        <thead>
            <tr>
                <th>Order Date</th>
                <th>Total Amount</th>
                <th>Order Details</th>
                <th>Quantity</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Fetch only delivered or canceled orders for the logged-in user
                String sql = "SELECT order_date, total_amount, order_details, quantity, status FROM orders WHERE uid = ? AND status IN ('Delivered', 'Canceled') ORDER BY order_date DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();

                boolean hasOrders = false;
                while (rs.next()) {
                    hasOrders = true;
        %>
                    <tr>
                        <td><%= rs.getString("order_date") %></td>
                        <td>₹<%= rs.getDouble("total_amount") %></td>
                        <td><%= rs.getString("order_details") %></td>
                        <td><%= rs.getString("quantity") %></td>
                        <td><%= rs.getString("status") %></td>
                    </tr>
        <%
                }
                if (!hasOrders) {
        %>
                    <tr><td colspan="5">No past orders found.</td></tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <tr><td colspan="5">Error fetching orders!</td></tr>
        <%
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>

        </tbody>
    </table>

</body>
</html>
