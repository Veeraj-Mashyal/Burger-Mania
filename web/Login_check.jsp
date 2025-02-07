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
        response.setContentType("text/html;charset=UTF-8");
        // Retrieve username and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userId = "";

        if (email != null && password != null) {
            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a connection to the database
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/burgermania", "root", "Veeraj_1530");

                // Create a SQL query to check if the user exists
                String query = "SELECT id FROM users WHERE email = ? AND password = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, email);
                pstmt.setString(2, password);

                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Login successful
                    userId = rs.getString("id");

                    // Store user ID in the session
                    HttpSession ss = request.getSession(true);
                    ss.setAttribute("id", userId);

                    // Redirect to the home page
                    response.sendRedirect("index.html");
                } else {
                    // Login failed, show an error message
                    out.println("<p style='color:red;'>Invalid email or password.</p>");
                    request.getRequestDispatcher("login.jsp").include(request, response);
                }

                // Close the connections
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p style='color:red;'>Email and Password cannot be null.</p>");
            request.getRequestDispatcher("login.jsp").include(request, response);
        }
    %>
</body>
</html>
