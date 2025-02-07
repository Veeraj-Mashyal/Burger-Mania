<%-- 
    Document   : cancelOrder
    Created on : 2 Feb 2025, 10:36:23 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    // Get order_id from request parameter
    String orderIdStr = request.getParameter("order_id");

    if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
        response.sendRedirect("user-profile.jsp"); // Redirect if no order ID is provided
        return;
    }

    int orderId = Integer.parseInt(orderIdStr);

    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/burgermania";
    String dbUser = "root";
    String dbPassword = "Veeraj_1530";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL query to update order status to "Canceled"
        String sql = "UPDATE orders SET status = 'Canceled' WHERE order_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, orderId);

        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
%>
            <script>
                var confirmCancel = confirm("Are you sure you want to cancel this order?");
                if (confirmCancel) {
                    alert("Order has been canceled successfully!");
                    window.location.href = "orderHistory.jsp"; // Redirect back to order history page
                } else {
                    window.history.back(); // Go back if the user cancels
                }
            </script>
<%
        } else {
%>
            <script>
                alert("Error: Unable to cancel the order!");
                window.location.href = "orderHistory.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("Database Error: Unable to cancel the order!");
            window.location.href = "orderHistory.jsp";
        </script>
<%
    } finally {
        // Close resources
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
