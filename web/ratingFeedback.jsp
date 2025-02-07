<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        .star {
            font-size: 24px;
            color: gray;
        }
        .star.filled {
            color: gold;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #2c3e50;
            font-size: 2rem;
            text-transform: uppercase;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        thead {
            background-color: #2c3e50;
            color: white;
        }

        thead tr {
            text-align: left;
        }

        th, td {
            padding: 15px;
            text-align: center;
            font-size: 0.9rem;
        }

        tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        tbody tr:hover {
            background-color: #e0f7fa;
        }

        th {
            font-weight: bold;
            text-transform: uppercase;
        }

        td {
            color: #555;
        }

        .star {
            font-size: 30px;
            color: gray;
            
        }

        .star.filled {
            color: gold;
        }

        @media (max-width: 768px) {
            table {
                width: 95%;
            }

            th, td {
                padding: 10px;
                font-size: 0.8rem;
            }

            h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <h1>Feedback</h1>
    <table border="1" cellpadding="10" cellspacing="0">
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Feedback</th>
                <th>Rating</th>
                <th>Date</th>
                
            </tr>
        </thead>
        <tbody>
            <%
                // Database connection details
                String url = "jdbc:mysql://localhost:3306/burgermania";
                String user = "root";
                String password = "Veeraj_1530";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userId =(String)ss.getAttribute("id");
    int uid=Integer.parseInt(userId);
    
                try {
                    // Establish connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    // Execute query to fetch feedback
                    String sql = "SELECT * FROM feedback2 where sid=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, uid);
                    rs = pstmt.executeQuery();
                    
                   
        

                    // Display results
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("fullname");
                        String email = rs.getString("email");
                        String feedback = rs.getString("msg");
                        int rating = rs.getInt("rating");
                        String datetime=rs.getString("posted_at");
            %>
            <tr>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= feedback %></td>
                <td>
                    <%-- Render stars dynamically based on rating --%>
                    <% for (int i = 1; i <= 5; i++) { %>
                        <i class="star <%= (i <= rating) ? "filled" : "" %>">&#9733;</i>
                    <% } %>
                </td>
                <td><%= datetime %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
