<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
        }
        .container {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            color: #2c3e50;;
        }
        .filters {
            margin-bottom: 20px;
        }
        .filters form {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .filters input, .filters select, .filters button {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .filters button {
            font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
            font-size: 15px;
        }
        .filters button:hover {
            background-color: rgb(34, 34, 34);
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        .chart-container {
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
        }
        p {
            font-size: 18px;
            font-weight: bold;
            
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Sales Report</h1>

    <!-- Filters -->
    <div class="filters">
        <form action="salesReport.jsp" method="GET">
            <label>Filter by:</label>
            <select name="filter">
                <option value="daily">Daily</option>
                <option value="weekly">Weekly</option>
                <option value="monthly">Monthly</option>
                <option value="yearly">Yearly</option>
            </select>
            <input type="date" name="selectedDate">
            <input type="month" name="selectedMonth">
            <input type="number" name="selectedYear" placeholder="Enter Year (e.g., 2025)">
            <button type="submit">Generate Report</button>
        </form>
        <button onclick="window.location.href='admin-profile.jsp'">Back to Admin</button>
    </div>

    <%
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/burgermania";
        String dbUser = "root";
        String dbPass = "Veeraj_1530";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Fetch filter type
        String filterType = request.getParameter("filter");
        String selectedDate = request.getParameter("selectedDate");
        String selectedMonth = request.getParameter("selectedMonth");
        String selectedYear = request.getParameter("selectedYear");

        if (filterType == null) {
            filterType = "daily"; // Default filter
        }

        // Define SQL query
        String query = "";
        switch (filterType) {
            case "daily":
                if (selectedDate != null && !selectedDate.isEmpty()) {
                    query = "SELECT DATE(order_date) AS period, SUM(total_amount) AS total_sales FROM orders WHERE status='Delivered' AND DATE(order_date) = ? GROUP BY DATE(order_date)";
                }
                break;
            case "weekly":
                if (selectedDate != null && !selectedDate.isEmpty()) {
                    query = "SELECT YEARWEEK(order_date) AS period, SUM(total_amount) AS total_sales FROM orders WHERE status='Delivered' AND YEARWEEK(order_date) = YEARWEEK(?) GROUP BY YEARWEEK(order_date)";
                }
                break;
            case "monthly":
                if (selectedMonth != null && !selectedMonth.isEmpty()) {
                    query = "SELECT DATE_FORMAT(order_date, '%Y-%m') AS period, SUM(total_amount) AS total_sales FROM orders WHERE status='Delivered' AND DATE_FORMAT(order_date, '%Y-%m') = ? GROUP BY DATE_FORMAT(order_date, '%Y-%m')";
                }
                break;
            case "yearly":
                if (selectedYear != null && !selectedYear.isEmpty()) {
                    query = "SELECT YEAR(order_date) AS period, SUM(total_amount) AS total_sales FROM orders WHERE status='Delivered' AND YEAR(order_date) = ? GROUP BY YEAR(order_date)";
                }
                break;
        }

        // Lists for storing fetched data
        List<String> labels = new ArrayList<>();
        List<Double> salesData = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            if (!query.isEmpty()) {
                pstmt = conn.prepareStatement(query);

                // Set parameter value dynamically
                if (filterType.equals("daily") && selectedDate != null) {
                    pstmt.setString(1, selectedDate);
                } else if (filterType.equals("weekly") && selectedDate != null) {
                    pstmt.setString(1, selectedDate);
                } else if (filterType.equals("monthly") && selectedMonth != null) {
                    pstmt.setString(1, selectedMonth);
                } else if (filterType.equals("yearly") && selectedYear != null) {
                    pstmt.setString(1, selectedYear);
                }

                rs = pstmt.executeQuery();

                while (rs.next()) {
                    labels.add(rs.getString("period"));
                    salesData.add(rs.getDouble("total_sales"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Error fetching data: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>

    <!-- Display Sales Data in Table -->
    <table>
        <thead>
            <tr>
                <th>Period</th>
                <th>Total Sales (₹)</th>
            </tr>
        </thead>
        <tbody>
            <% for (int i = 0; i < labels.size(); i++) { %>
                <tr>
                    <td><%= labels.get(i) %></td>
                    <td>₹<%= salesData.get(i) %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Display Graph -->
    <div class="chart-container">
        <canvas id="salesChart"></canvas>
    </div>

    <script>
        let ctx = document.getElementById('salesChart').getContext('2d');
        let salesChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: <%= labels.toString() %>, 
                datasets: [{
                    label: 'Total Sales (₹)',
                    data: <%= salesData.toString() %>, 
                    backgroundColor: 'rgba(44, 62, 80, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: { responsive: true }
        });
    </script>
</div>
</body>
</html>
