<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <style>
        /* Category Title */
        .category {
            margin-top: 2%;
            margin-bottom: 2%;
            font-size: 35px;
            font-weight: bold;
            color: #2c3e50;
            text-align: center;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
        }

        /* Products Container */
        .products-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin: 10px 0 40px;
        }

        /* Product Card */
        .product-card {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 250px;
            height: 300px;
            margin-bottom: 50px;
            padding: 15px;
            text-align: center;
            border: .5rem solid white;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            font-family: Verdana, Geneva, Tahoma, sans-serif;
        }
        .product-card img {
            width: 100%;
            height: 60%;
            object-fit: cover;
            border-radius: 3%;
        }
        .product-card h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
            font-weight: 500;
        }
        .product-card p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div>
        <%
            // Database connection parameters
            String jdbcURL = "jdbc:mysql://localhost:3306/burgermania";
            String dbUser = "root";
            String dbPassword = "Veeraj_1530";

            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                // Connect to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Query to fetch products along with their categories
                String sql = "SELECT c.name AS category_name, p.name AS product_name, p.price, p.image_url " +
                             "FROM products p " +
                             "JOIN categories c ON p.category_id = c.id " +
                             "ORDER BY c.name, p.name";
                statement = connection.prepareStatement(sql);
                resultSet = statement.executeQuery();

                String currentCategory = "";
                boolean isFirstCategory = true;

                while (resultSet.next()) {
                    String categoryName = resultSet.getString("category_name");
                    String productName = resultSet.getString("product_name");
                    double price = resultSet.getDouble("price");
                    String imageUrl = resultSet.getString("image_url");

                    // Check if it's a new category
                    if (!categoryName.equals(currentCategory)) {
                        if (!isFirstCategory) {
                            // Close the previous category's grid
                            out.println("</div>");
                        }

                        // Print the new category title
                        out.println("<h2 class='category'>" + categoryName + "</h2>");
                        out.println("<div class='products-container'>");

                        currentCategory = categoryName;
                        isFirstCategory = false;
                    }

                    // Print the product card
                    out.println("<div class='product-card'>");
                    if (imageUrl != null && !imageUrl.isEmpty()) {
                        out.println("<img src='" + imageUrl + "' alt='" + productName + "'>");
                    } else {
                        out.println("<img src='default-image.jpg' alt='No Image'>");
                    }
                    out.println("<h3>" + productName + "</h3>");
                    out.println("<p>₹" + price + "</p>");
                    out.println("</div>");
                }

                // Close the last category's grid
                if (!isFirstCategory) {
                    out.println("</div>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error loading products. Please try again later.</p>");
            } finally {
                // Close resources
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        %>
    </div>
</body>
</html>
