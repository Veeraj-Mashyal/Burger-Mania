<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Previous Orders</title>
  <style>
   body {
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
      background-color: #f4f4f9;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
    }
    .profile-container {
      width: 90%;
      max-width: 900px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      padding: 20px;
    }
    h1 {
      text-align: center;
      color: #2c3e50;
    }
    .btn-container {
      text-align: center;
      margin-bottom: 20px;
    }
    .filter-btn {
      padding: 5px 10px;
      background-color: #007bff;
      color: #fff;
      border: none;
      cursor: pointer;
    }
    .filter-btn:hover {
      background-color: #0056b3;
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
    p {
      text-align: center;
      font-size: 20px;
    }
    .btn-container {
      text-align: center;
      margin-bottom: 20px;
    }
    .btn-container button {
      display: inline-block;
      margin: 10px 5px;
      padding: 10px 15px;
      background-color: #2c3e50;
      color: #fff;
      font-size: 15px;
      text-decoration:none;
      border-radius: 5px;
      font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
    }
    .btn-container button:hover {
      background-color: rgb(34, 34, 34);
    }
  </style>
</head>
<body>
  <div class="profile-container">
    <h1>Previous Orders</h1>

    <div class="btn-container">
      <form action="previousOrders.jsp" method="GET">
        <label for="filterDate">Select Date:</label>
        <input type="date" id="filterDate" name="filterDate" class="styled-date-input" value="<%= request.getParameter("filterDate") != null ? request.getParameter("filterDate") : "" %>">
        <button type="submit" class="filter-btn" name="status" value="Delivered">Show Delivered Orders</button>
        <button type="submit" class="filter-btn" name="status" value="Canceled">Show Canceled Orders</button>
        <button type="button" class="filter-btn" onclick="window.location.href='admin-profile.jsp';">Back to Admin Page</button>
      </form>
    </div>

    <% 
      String dbURL = "jdbc:mysql://localhost:3306/burgermania";
      String dbUser = "root";
      String dbPass = "Veeraj_1530";
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String filterDate = request.getParameter("filterDate");
      String filterStatus = request.getParameter("status");
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      if (filterDate == null || filterDate.isEmpty()) {
        filterDate = sdf.format(new java.util.Date());
      }
      if (filterStatus == null) {
        filterStatus = "Delivered"; 
      }

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String query = "SELECT order_id, uid, order_date, total_amount, order_details, quantity, status FROM orders WHERE status = ? AND DATE(order_date) = ? ORDER BY order_date DESC";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, filterStatus);
        pstmt.setString(2, filterDate);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
    %>
          <p>No orders found for the selected filter!</p>
    <%
        } else {
    %>
          <table>
            <thead>
              <tr>
                <th>Order ID</th>
                <th>User ID</th>
                <th>Order Date</th>
                <th>Total Amount</th>
                <th>Order Details</th>
                <th>Quantity</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
    <%
          while (rs.next()) {
    %>
              <tr>
                <td><%= rs.getInt("order_id") %></td>
                <td><%= rs.getInt("uid") %></td>
                <td><%= rs.getString("order_date") %></td>
                <td>₹<%= rs.getDouble("total_amount") %></td>
                <td><%= rs.getString("order_details") %></td>
                <td><%= rs.getString("quantity") %></td>
                <td><%= rs.getString("status") %></td>
              </tr>
    <%
          }
    %>
            </tbody>
          </table>
    <%
        }
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error fetching orders: " + e.getMessage() + "</p>");
      } finally {
        try {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        } catch (SQLException e) {
          e.printStackTrace();
        }
      }
    %>
  </div>
</body>
</html>
