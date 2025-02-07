<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isErrorPage="true" %>
<%@ page import="java.sql.*" %>
<%
    try {
        System.out.println("updateOrderStatus.jsp Loaded...");
        
        // Fetch parameters
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");

        // Debug prints
        System.out.println("Received orderId: " + orderId);
        System.out.println("Received status: " + status);

        // Validate input
        if (orderId == null || status == null || orderId.trim().isEmpty() || status.trim().isEmpty()) {
            System.out.println("Error: Missing orderId or status.");
            out.println("<h3>Error: Missing orderId or status.</h3>");
            return;
        }

        // Trim status value
        status = status.trim();
        System.out.println("Trimmed status: " + status);

        // Valid status options
        String[] validStatuses = {"Pending", "Processing", "Out for Delivery", "Delivered", "Canceled"};
        boolean isValid = false;
        for (String s : validStatuses) {
            System.out.println("Checking status: " + s);
            if (s.equals(status)) {
                isValid = true;
                break;
            }
        }

        if (!isValid) {
            System.out.println("Error: Invalid status value.");
            out.println("<h3>Error: Invalid status value.</h3>");
            return;
        }

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/burgermania";
        String dbUser = "root";
        String dbPass = "Veeraj_1530";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            System.out.println("Database connected successfully.");

            // Update query
            String updateQuery = "UPDATE orders SET status = ? WHERE order_id = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, status);
            pstmt.setInt(2, Integer.parseInt(orderId));

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Order status updated successfully.");
                out.println("<h3>Order status updated successfully.</h3>");
            } else {
                System.out.println("Error: No order found with ID: " + orderId);
                out.println("<h3>Error: No order found with ID: " + orderId + "</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Database error: " + e.getMessage());
            out.println("<h3>Database error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Unexpected error: " + e.getMessage());
        out.println("<h3>Unexpected error: " + e.getMessage() + "</h3>");
    }
%>


