<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Franchise Requests - Admin</title>
    <style>
        body {             
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;           
            margin: 20px; 
            background-color: #f8f9fa; 
        }
        .container {
            max-width: 900px; 
            margin: auto; 
            padding: 20px; }
        .card { 
            background: #fff; 
            padding: 15px; 
            margin: 15px 0; 
            border-radius: 10px; 
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        .card h3 {
            margin: 0 0 10px; 
            color: #333; }
        .card p { 
            margin: 5px 0; 
            color: #555; }
        .date { 
            font-size: 0.9em; 
            color: #777; }
        .actions { margin-top: 10px; }
        .btn { 
            padding: 8px 12px; 
            border: none;
            border-radius: 5px; 
            cursor: pointer; 
            text-decoration: none; 
            color: white; 
            display: inline-block;
        }
        .btn-delete { background: #dc3545; }
        .btn-delete:hover { background: #c82333; }
        
        .filter-form { 
            margin-bottom: 20px; 
            padding: 10px; 
            background: #fff; 
            border-radius: 10px; 
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); }
        input, select 
        { padding: 8px; 
          margin: 5px; 
          border: 1px solid #ccc; 
          border-radius: 5px; }
        button { 
            cursor: pointer; 
            background: #2c3e50; 
            color: white; 
            border: none;
        padding: 10px; 
          margin: 5px; 
          /*border: 1px solid #ccc;*/ 
          border-radius: 5px;
          font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;           
}
        button:hover { background: rgb(34, 34, 34); }
        .adminbtn{cursor: pointer;
                 background: #2c3e50;
                 color: white; 
                 border: none;
                 padding: 8px; 
                 margin: 5px; 
                 text-decoration: none;
                 border-radius: 5px;}
        .adminbtn:hover{
            background: rgb(34, 34, 34);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Franchise Requests</h2>

        <!-- Search & Filter Form -->
        <form class="filter-form" method="GET" action="franchiseRequests.jsp">
            <input type="text" name="search" placeholder="Search by name, email, or phone" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <select name="location">
                <option value="">All Locations</option>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/burgermania", "root", "Veeraj_1530");
                        String locQuery = "SELECT DISTINCT location FROM franchises ORDER BY location ASC";
                        pstmt = conn.prepareStatement(locQuery);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                            String loc = rs.getString("location");
                            String selected = request.getParameter("location") != null && request.getParameter("location").equals(loc) ? "selected" : "";
                %>
                            <option value="<%= loc %>" <%= selected %>><%= loc %></option>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                    }
                %>
            </select>
            <input type="date" name="start_date" value="<%= request.getParameter("start_date") != null ? request.getParameter("start_date") : "" %>">
            <input type="date" name="end_date" value="<%= request.getParameter("end_date") != null ? request.getParameter("end_date") : "" %>">
            <button type="submit">Apply Filters</button>
            <a href="admin-profile.jsp" class="adminbtn">Back to Admin</a>
        </form>
        <%
            PreparedStatement pstmt2 = null;
            ResultSet rs2 = null;
            try {
                String query = "SELECT * FROM franchises WHERE 1=1";
                String search = request.getParameter("search");
                String location = request.getParameter("location");
                String startDate = request.getParameter("start_date");
                String endDate = request.getParameter("end_date");

                if (search != null && !search.trim().isEmpty()) {
                    query += " AND (name LIKE ? OR email LIKE ? OR phone LIKE ?)";
                }
                if (location != null && !location.isEmpty()) {
                    query += " AND location = ?";
                }
                if (startDate != null && !startDate.isEmpty()) {
                    query += " AND submitted_at >= ?";
                }
                if (endDate != null && !endDate.isEmpty()) {
                    query += " AND submitted_at <= ?";
                }

                query += " ORDER BY submitted_at DESC";
                pstmt2 = conn.prepareStatement(query);

                int paramIndex = 1;
                if (search != null && !search.trim().isEmpty()) {
                    pstmt2.setString(paramIndex++, "%" + search + "%");
                    pstmt2.setString(paramIndex++, "%" + search + "%");
                    pstmt2.setString(paramIndex++, "%" + search + "%");
                }
                if (location != null && !location.isEmpty()) {
                    pstmt2.setString(paramIndex++, location);
                }
                if (startDate != null && !startDate.isEmpty()) {
                    pstmt2.setString(paramIndex++, startDate);
                }
                if (endDate != null && !endDate.isEmpty()) {
                    pstmt2.setString(paramIndex++, endDate);
                }

                rs2 = pstmt2.executeQuery();

                while (rs2.next()) {
        %>
                    <div class="card">
                        <h3><%= rs2.getString("name") %></h3>
                        <p><strong>Email:</strong> <%= rs2.getString("email") %></p>
                        <p><strong>Phone:</strong> <%= rs2.getString("phone") %></p>
                        <p><strong>Location:</strong> <%= rs2.getString("location") %></p>
                        <p><strong>Message:</strong> <%= rs2.getString("message") %></p>
                        <p class="date"><strong>Submitted At:</strong> <%= rs2.getTimestamp("submitted_at") %></p>
                        <div class="actions">
                            <a href="deleteFranchiseRequest.jsp?id=<%= rs2.getInt("id") %>" class="btn btn-delete">Delete</a>
                        </div>
                    </div>
        <%
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs2 != null) rs2.close();
                if (pstmt2 != null) pstmt2.close();
                if (conn != null) conn.close();
            }
        %>

    </div>
</body>
</html>
