
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Profile</title>
  <style>
    body {
      font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
      background-color: #f4f4f9;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .profile-container {
      width: 90%;
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    h1, h2 {
      text-align: center;
      color: #2c3e50;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }
    th {
      background-color: #f2f2f2;
    }
    .ac-btn{
        display:flex;
        justify-content: center;
        gap: 2%;
    }
    
    .action-btn {
      padding: 1px 10px;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      font-size: 16px;
    }
    .track-btn {
      background-color: #2c3e50;
    }
    .cancel-btn {
      background-color: #2c3e50;
    }

    

    .no-data {
      text-align: center;
      font-size: 18px;
      color: #666;
      margin-top: 20px;
    }

    .additional-links {
      margin-top: 20px;
      text-align: center;
    }

    .additional-links a {
      display: inline-block;
      padding: 10px 15px;
      background-color: #2c3e50;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      margin: 5px;
    }

    .additional-links a:hover {
      background-color: black;
    }
  </style>
</head>
<body>
  <div class="profile-container">
    <h1>User Profile</h1>

    <%
      String dbURL = "jdbc:mysql://localhost:3306/burgermania";
      String dbUser = "root";
      String dbPass = "Veeraj_1530";
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

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

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Fetch user details
        String userQuery = "SELECT fullname, email, address, telephone FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(userQuery);
        pstmt.setInt(1, uid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
    %>
          <div>
            <p><strong>Name:</strong> <%= rs.getString("fullname") %></p>
            <p><strong>Email:</strong> <%= rs.getString("email") %></p>
            <p><strong>Address:</strong> <%= rs.getString("address") %></p>
            <p><strong>Telephone:</strong> <%= rs.getString("telephone") %></p>
          </div>
          
          <!-- Additional Links -->
    <div class="additional-links">
      <a href="updateProfile.jsp">Update Profile</a>
      <a href="orderHistory.jsp">Order History</a>
      <a href="ratingFeedback.jsp">Rating & Feedback</a>
      <a href="logout.jsp">Logout</a>
    </div>
    <%
        } else {
    %>
          <p class="no-data">No user details found!</p>
    <%
        }

        rs.close();
        pstmt.close();

        // Fetch current orders
        String orderQuery = "SELECT order_id, order_date, order_details, quantity, total_amount, status FROM orders WHERE uid = ? AND status NOT IN ('Delivered', 'Canceled')";
        pstmt = conn.prepareStatement(orderQuery);
        pstmt.setInt(1, uid);
        rs = pstmt.executeQuery();
    %>

    <h2>Current Orders</h2>
    <%
      boolean hasOrders = false;
    %>

    <table>
      <thead>
        <tr>
          <th>Order Date</th>
          <th>Total Amount</th>
          <th>Order Details</th>
          <th>Quantity</th>
          <th>Actions</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
    <%
      while (rs.next()) {
        hasOrders = true;
    %>
        <tr>
          <td><%= rs.getTimestamp("order_date") %></td>
          <td>₹<%= rs.getBigDecimal("total_amount") %></td>
          <td><%= rs.getString("order_details") %></td>
          <td><%= rs.getString("quantity") %></td>
          <td>
              <div class="ac-btn">
            <!--<a href="trackOrder.jsp?order_id=<%= rs.getInt("order_id") %>" class="action-btn track-btn">Track</a>-->
            <a href="cancelOrder.jsp?order_id=<%= rs.getInt("order_id") %>" class="action-btn cancel-btn">Cancel</a>
            </div>
              </td>
          <td><%= rs.getString("status") %></td>
        </tr>
    <%
      }

      if (!hasOrders) {
    %>
        <tr>
          <td colspan="6" class="no-data">No active orders found!</td>
        </tr>
    <%
      }
    %>
      </tbody>
    </table>

    

    <%
      } catch (Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error fetching user data: " + e.getMessage() + "</p>");
        e.printStackTrace();
      } finally {
        try {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        } catch (SQLException e) {
          out.println("<p style='color:red; text-align:center;'>Error closing database connection.</p>");
        }
      }
    %>
  </div>
</body>
</html>

