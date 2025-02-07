<%-- 
    Document   : updateProfile
    Created on : 2 Feb 2025, 10:54:51 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Ensure user is logged in
    HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = Integer.parseInt(session.getAttribute("id").toString()); // Logged-in User ID
    String jdbcURL = "jdbc:mysql://localhost:3306/burgermania";  // UPDATE DATABASE NAME
    String dbUser = "root";   // UPDATE USERNAME
    String dbPassword = "Veeraj_1530";  // UPDATE PASSWORD

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String fullname = "", email = "", telephone = "", address = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Fetch existing details
        String sql = "SELECT fullname, email, telephone, address FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            fullname = rs.getString("fullname");
            email = rs.getString("email");
            telephone = rs.getString("telephone");
            address = rs.getString("address");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String newFullname = request.getParameter("fullname");
        String newEmail = request.getParameter("email");
        String newTelephone = request.getParameter("telephone");
        String newAddress = request.getParameter("address");
        String newPassword = request.getParameter("password");

        try {
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            if (newPassword != null && !newPassword.trim().isEmpty()) {
                String updateSQL = "UPDATE users SET fullname=?, email=?, telephone=?, address=?, password=? WHERE id=?";
                pstmt = conn.prepareStatement(updateSQL);
                pstmt.setString(1, newFullname);
                pstmt.setString(2, newEmail);
                pstmt.setString(3, newTelephone);
                pstmt.setString(4, newAddress);
                pstmt.setString(5, newPassword); // Consider hashing
                pstmt.setInt(6, userId);
            } else {
                String updateSQL = "UPDATE users SET fullname=?, email=?, telephone=?, address=? WHERE id=?";
                pstmt = conn.prepareStatement(updateSQL);
                pstmt.setString(1, newFullname);
                pstmt.setString(2, newEmail);
                pstmt.setString(3, newTelephone);
                pstmt.setString(4, newAddress);
                pstmt.setInt(5, userId);
            }

            int updated = pstmt.executeUpdate();
            if (updated > 0) {
                out.println("<script>alert('Profile Updated Successfully!'); window.location='user-profile.jsp';</script>");
            } else {
                out.println("<script>alert('Update Failed! Try Again.');</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    <style>
        /* Resetting some default browser styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 480px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 2%;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            /*overflow: hidden;*/
        }

        h1 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 30px;
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            background: #fafafa;
            color: #555;
            transition: border 0.3s ease, background 0.3s ease;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        input:focus, textarea:focus {
    border-color: #007BFF;
    background-color: #fff;
    outline: none;
        }

        input::placeholder, textarea::placeholder {
            color: #aaa;
        }

        textarea {
            resize: vertical;
            min-height: 50px;
        }

        button {
            width: 100%;
            padding: 8px;
            background: #2c3e50;
            border: none;
            color: white;
            font-size: 18px;
            font-weight: 500;
            cursor: pointer;
            border-radius: 8px;
            margin-top: 10px;
            transition: background 0.3s ease, transform 0.3s ease;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        button:hover {
            background: rgb(34, 34, 34);
            transform: translateY(-2px);
        }

        button:active {
            transform: translateY(0);
        }

        .note {
            font-size: 14px;
            color: #777;
            margin-top: 15px;
        }

        .note a {
            color: #2c3e50;
            text-decoration: underline;
        }

/*        .note a:hover {
            text-decoration: underline;
        }*/

        /* Responsive Design */
        @media (max-width: 500px) {
            .container {
                padding: 25px;
                width: 90%;
            }

            h2 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Update Profile</h1>

        <form method="post">
            <input type="text" name="fullname" value="<%= fullname %>" required placeholder="Full Name">
            <input type="email" name="email" value="<%= email %>" required placeholder="Email">
            <input type="text" name="telephone" value="<%= telephone %>" required placeholder="Phone Number">
            <textarea name="address" required placeholder="Address"><%= address %></textarea>
            <input type="password" name="password" placeholder="New Password (Leave blank to keep current)">
            <button type="submit">Update Profile</button>
        </form>

        <p class="note">Your data is secure. <a href="#">Password updates are optional.</a></p>
    </div>

</body>
</html>





