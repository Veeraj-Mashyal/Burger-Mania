<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Check</title>
</head>
<body>
    <%
    String dbURL = "jdbc:mysql://localhost:3306/burgermania";
    String dbUser = "root";
    String dbPass = "Veeraj_1530";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        // Load and register JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Query to validate admin credentials
        String query = "SELECT id, fullname FROM admin_data WHERE email = ? AND password = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, email);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Login success
            int id = rs.getInt("id");
            String fullname = rs.getString("fullname");

            // Set session attributes
            HttpSession ss = request.getSession();
            ss.setAttribute("id", id);
            ss.setAttribute("fullname", fullname);

            // Redirect to admin profile page
            response.sendRedirect("admin-profile.jsp");
        } else {
            // Login failed
            out.println("<p>Invalid email or password!</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

</body>
</html>
