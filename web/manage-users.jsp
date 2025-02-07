<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customers List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 90%;
            margin: 50px auto;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
                font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;

        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        table th {
            background-color: #2c3e50;
            color: white;
            text-transform: uppercase;
        }
        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        table tr:hover {
            background-color: #f1f1f1;
        }
        .no-data {
            text-align: center;
            color: #999;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Customers List</h1>
    <%
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/burgermania";
        String dbUser = "root";
        String dbPassword = "Veeraj_1530";

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Load the database driver (MySQL example)
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish the connection
            connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Query to fetch all users
            String query = "SELECT * FROM users";

            // Create a statement
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);

            // Check if there is data to display
            if (!resultSet.isBeforeFirst()) {
    %>
        <p class="no-data">No users found in the database.</p>
    <%
            } else {
    %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Telephone</th>
            <th>Address</th>
        </tr>
        </thead>
        <tbody>
        <%
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String fullname = resultSet.getString("fullname");
                String email = resultSet.getString("email");
                String telephone = resultSet.getString("telephone");
                String address = resultSet.getString("address");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= fullname %></td>
            <td><%= email %></td>
            <td><%= telephone %></td>
            <td><%= address %></td>
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
    %>
    <p class="no-data">An error occurred while fetching users.</p>
    <%
        } finally {
            // Close resources
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignored) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignored) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
        }
    %>
</div>
</body>
</html>
