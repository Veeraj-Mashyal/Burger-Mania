<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Details</title>
  <style>
    body {
          font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
      margin: 20px;
      padding: 20px;
    }
    .user-details {
      border: 1px solid #ddd;
      padding: 20px;
      border-radius: 10px;
      background-color: #f9f9f9;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      width: 50%;
      margin: 0 auto;
    }
    .user-details h1{
        color: #2c3e50;
    }
    .user-details p {
      font-size: 16px;
    }
    .user-details b {
      color: #2c3e50;
    }
    .btn {
      padding: 10px 20px;
      background-color: #2c3e50;
      color: #fff;
      border: none;
      border-radius: 5px;
      text-decoration: none;
    }
    .btn:hover {
      background-color: rgb(34, 34, 34);
    }
  </style>
</head>
<body>
  
  <%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/burgermania";
    String dbUser = "root";
    String dbPass = "Veeraj_1530";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Get the userId from the query parameter
    String userId = request.getParameter("userId");

    if (userId != null) {
      try {
        // Load JDBC Driver & Connect
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Query to fetch user details
        String query = "SELECT * FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(userId));  // Set the userId in the query
        rs = pstmt.executeQuery();

        if (rs.next()) {
          // Display user details
          String fullname = rs.getString("fullname");
          String email = rs.getString("email");
          String telephone = rs.getString("telephone");
          String address = rs.getString("address");
  %>
          <div class="user-details">
              <h1>User Details</h1>
            <p><b>Full Name:</b> <%= fullname %></p>
            <p><b>Email:</b> <%= email %></p>
            <p><b>Telephone:</b> <%= telephone %></p>
            <p><b>Address:</b> <%= address %></p>
            <br>
  <a href="admin-profile.jsp" class="btn">Back to Admin Page</a>
          </div>
  <%
        } else {
          out.println("<p>No user found with ID: " + userId + "</p>");
        }
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error fetching user details: " + e.getMessage() + "</p>");
      } finally {
        try {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        } catch (SQLException e) {
          e.printStackTrace();
        }
      }
    } else {
      out.println("<p>No user ID provided!</p>");
    }
  %>

  
</body>
</html>
