<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <style>
    body {
      /*font-family: Arial, sans-serif;*/
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
      font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

    }
    h1, h2 {
      text-align: center;
      color: #2c3e50;
    }
    .profile-card {
      padding: 5px;
      padding-left: 10px;
      background-color: #f9f9f9;
      border-radius: 10px;
      margin-bottom: 20px;
    }
    .btn-container {
      text-align: center;
      margin-bottom: 20px;
    }
    .btn-container a {
      display: inline-block;
      margin: 10px 5px;
      padding: 10px 15px;
      background-color: #2c3e50;
      color: #fff;
      text-decoration:none;
      border-radius: 5px;
    }
    .btn-container a:hover {
      background-color: rgb(34, 34, 34);
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
    .status-select {
      padding: 5px;
      border-radius: 5px;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

    }
    .update-btn{
     font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
     margin-top: 1%;
     background-color: #2c3e50;
     color: white;
     padding: 4%;
     border-radius: 5%;
    }
    .update-btn:hover{
    background-color: rgb(34, 34, 34);
    }
    .view-det{
     font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
     margin-top: 2%;
     background-color: #2c3e50;
     color: white;
     padding: 10%;
     border-radius: 5%;
    }
    .view-det:hover{
        background-color: rgb(34, 34, 34);
    }
    
  </style>

  <script>
function updateOrderStatus(orderId, newStatus) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "updateOrderStatus.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("statusMessage").innerHTML = xhr.responseText;
        }
    };

    xhr.send("orderId=" + orderId + "&status=" + encodeURIComponent(newStatus));
}
</script>
</head>
<body>
  <div class="profile-container">
    <h1>Admin Dashboard</h1>

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

      String adminName = (String) ss.getAttribute("fullname");
    %>
    <div class="profile-card">
      <p><b>Admin Name:</b> <%= adminName %></p>
    </div>
    <div id="statusMessage" style="text-align: center; font-weight: bold; color: green; margin-bottom: 10px;"></div>
    <div class="btn-container">
      <a href="crud.jsp">Manage Products</a>
      <a href="previousOrders.jsp">Previous Orders</a>
      <a href="salesReport.jsp">Sales Report</a>
      <a href="manage-users.jsp">View Customers</a>
      <a href="viewProducts.jsp">View Products</a>
      <a href="adminFeedback.jsp">View Feedback</a>
      <a href="logout.jsp">Logout</a>
    </div>

    <h2>Current Orders</h2>
    
    <%
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        String query = "SELECT order_id, uid, order_date, total_amount, order_details, quantity, status FROM orders WHERE status NOT IN ('Delivered', 'Canceled') ORDER BY order_date DESC";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) {
    %>
          <p>No current orders found!</p>
    <%
        } else {
    %>
          <table>
            <thead>
              <tr>
                <th>User ID</th>
                <th>Order ID</th>
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
            int orderId = rs.getInt("order_id");
            int userId = rs.getInt("uid");
            String orderDate = rs.getString("order_date");
            double totalAmount = rs.getDouble("total_amount");
            String orderDetails = rs.getString("order_details");
            String quantity = rs.getString("quantity");
            String status = rs.getString("status");
            String updateQuery = "UPDATE orders SET status = 'Canceled' WHERE status = 'Pending' AND TIMESTAMPDIFF(MINUTE, order_date, NOW()) > 120";
        pstmt = conn.prepareStatement(updateQuery);
        int updatedRows = pstmt.executeUpdate();

        if (updatedRows > 0) {
            System.out.println(updatedRows + " orders were automatically canceled due to delay.");
        }
    %>
              <tr>
                <td><%= userId %><a href="user-det.jsp?userId=<%= userId %>"><button class="view-det">Details</button></a></td>
                <td><%= orderId %></td>
                <td><%= orderDate %></td>
                <td>₹<%= totalAmount %></td>
                <td><%= orderDetails %></td>
                <td><%= quantity %></td>
                <td>
                  <form onsubmit="event.preventDefault(); updateOrderStatus(<%= orderId %>, this.status.value);">
    <input type="hidden" name="orderId" value="<%= orderId %>">
    <select name="status" class="status-select">
        <option value="Pending">Pending</option>
        <option value="Processing">Processing</option>
        <option value="Out for Delivery">Out for Delivery</option>
        <option value="Delivered">Delivered</option>
        <option value="Canceled">Canceled</option>
    </select>
    <button type="submit" class="update-btn">Update</button>
    

</form>
                </td>
                <td><%= status %></td>
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
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
      }

    %>
  </div>
</body>
</html>
