<%@ page import="java.sql.*, java.math.BigDecimal" %>
<html>
<head>
    <title>CRUD Operations</title>
    <style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f8f9fa;
    color: #333;
    margin: 0;
    padding: 0;
    line-height: 1.6;
}

h3 {
    color: #2c3e50;
    border-bottom: 3px solid #2c3e50;
    padding-bottom: 10px;
    margin-bottom: 20px;
    margin-top: 10%;
    font-size: 1.5em;
    text-align: center;
}

.container {
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.crud-section {
    margin-bottom: 30px;
    padding: 20px;
    border: 1px solid #eaeaea;
    border-radius: 8px;
    background-color: #fdfdfd;
    transition: all 0.3s ease-in-out;
}

.crud-section:hover {
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.category-section {
    border-left: 5px solid #2c3e50; /* Green */
    margin-top: 20px;
}

.product-section {
    border-left: 5px solid #2c3e50; /* Blue */
    margin-top: 20px;
}

.form-container {
    width: 100%;
    margin-top: 20px;
}

label {
    font-weight: bold;
    font-size: 1rem;
    margin-bottom: 8px;
    display: inline-block;
    color: #555;
}

input[type="text"],
select {
    width: 100%;
    padding: 12px;
    margin: 8px 0;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 1rem;
    color: #333;
    background-color: #f9f9f9;
    transition: border-color 0.3s ease;
}

input[type="text"]:focus,
select:focus {
    border-color: #007BFF;
    background-color: #fff;
    outline: none;
}

input[type="submit"] {
    background-color: #2c3e50;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.8rem;
    font-weight: bold;
/*    text-transform: uppercase;*/
    transition: background-color 0.3s ease;
    margin-top: 10px;
}

input[type="submit"]:hover {
    background: rgb(34, 34, 34);
}

.alert {
    padding: 20px;
    margin: 20px 0;
    border-radius: 8px;
    text-align: center;
    font-weight: bold;
    font-size: 1.1rem;
}

.alert.success {
    background-color: #28a745;
    color: white;
}

.alert.error {
    background-color: #dc3545;
    color: white;
}

.operation {
    margin-bottom: 25px;
    padding: 15px;
    background-color: #f1f1f1;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.operation:hover {
    background-color: #f9f9f9;
}

select {
    appearance: none;
    background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="gray" d="M2 0L0 2h4z"/></svg>');
    background-repeat: no-repeat;
    background-position: right 10px top 50%;
    background-size: 10px 10px;
}

footer {
    text-align: center;
    margin-top: 50px;
    font-size: 0.9rem;
    color: #777;
}

    </style>
</head>
<body>

<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/burgermania";  // Adjust the DB name as needed
    String user = "root";  // Adjust the DB user
    String password = "Veeraj_1530";  // Adjust the DB password

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Establish a connection to the database
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();

        // Handle CRUD operations for categories and products
        String action = request.getParameter("action");

        // CREATE or UPDATE category
        if ("createCategory".equals(action)) {
            String categoryName = request.getParameter("categoryName");
            if (categoryName != null && !categoryName.isEmpty()) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO categories (name) VALUES (?)");
                ps.setString(1, categoryName);
                ps.executeUpdate();
                out.println("<script>alert('Category \"" + categoryName + "\" added successfully.');</script>");
            } else {
                out.println("<script>alert('Error: Category name cannot be empty.');</script>");
            }
        } else if ("updateCategory".equals(action)) {
            String categoryId = request.getParameter("categoryId");
            String categoryName = request.getParameter("categoryName");
            if (categoryId != null && categoryName != null) {
                PreparedStatement ps = conn.prepareStatement("UPDATE categories SET name = ? WHERE id = ?");
                ps.setString(1, categoryName);
                ps.setInt(2, Integer.parseInt(categoryId));
                ps.executeUpdate();
                out.println("<script>alert('Category updated successfully.');</script>");
            }
        } else if ("deleteCategory".equals(action)) {
            String categoryId = request.getParameter("categoryId");
            if (categoryId != null) {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM categories WHERE id = ?");
                ps.setInt(1, Integer.parseInt(categoryId));
                ps.executeUpdate();
                out.println("<script>alert('Category deleted successfully.');</script>");
            }
        }

        // CREATE or UPDATE product
        if ("createProduct".equals(action)) {
            String productName = request.getParameter("productName");
            String price = request.getParameter("price");
            String imageUrl = request.getParameter("imageUrl");
            String categoryId = request.getParameter("categoryId");

            if (productName != null && !productName.isEmpty() && price != null && !price.isEmpty() && categoryId != null) {
                try {
                    BigDecimal productPrice = BigDecimal.valueOf(Double.parseDouble(price));

                    PreparedStatement ps = conn.prepareStatement("INSERT INTO products (name, price, image_url, category_id) VALUES (?, ?, ?, ?)");
                    ps.setString(1, productName);
                    ps.setBigDecimal(2, productPrice);  // Use BigDecimal properly here
                    ps.setString(3, imageUrl);
                    ps.setInt(4, Integer.parseInt(categoryId));
                    ps.executeUpdate();
                    out.println("<script>alert('Product \"" + productName + "\" added successfully.');</script>");
                } catch (NumberFormatException e) {
                    out.println("<script>alert('Error: Invalid price format. Please enter a valid number.');</script>");
                }
            } else {
                out.println("<script>alert('Error: All product fields must be filled.');</script>");
            }
        } else if ("updateProduct".equals(action)) {
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String price = request.getParameter("price");
            String imageUrl = request.getParameter("imageUrl");
            String categoryId = request.getParameter("categoryId");

            if (productId != null && productName != null && price != null) {
                try {
                    BigDecimal productPrice = BigDecimal.valueOf(Double.parseDouble(price));

                    PreparedStatement ps = conn.prepareStatement("UPDATE products SET name = ?, price = ?, image_url = ?, category_id = ? WHERE id = ?");
                    ps.setString(1, productName);
                    ps.setBigDecimal(2, productPrice);  // Use BigDecimal properly here
                    ps.setString(3, imageUrl);
                    ps.setInt(4, Integer.parseInt(categoryId));
                    ps.setInt(5, Integer.parseInt(productId));
                    ps.executeUpdate();
                    out.println("<script>alert('Product updated successfully.');</script>");
                } catch (NumberFormatException e) {
                    out.println("<script>alert('Error: Invalid price format. Please enter a valid number.');</script>");
                }
            }
            else {
                out.println("<script>alert('Error: All product fields must be filled.');</script>");
            }
            
        } else if ("deleteProduct".equals(action)) {
            String productId = request.getParameter("productId");
            if (productId != null) {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE id = ?");
                ps.setInt(1, Integer.parseInt(productId));
                ps.executeUpdate();
                out.println("<script>alert('Product deleted successfully.');</script>");
            }
        }

        // Display sections for categories and products CRUD operations
        out.println("<div class='container'>");

        // Category CRUD Section
        out.println("<div class='crud-section category-section'>");
        out.println("<h3>Add a New Category:</h3>");
        out.println("<div class='operation'>");
        out.println("<form action='crud.jsp' method='POST'>");
        out.println("<input type='hidden' name='action' value='createCategory'/>");
        out.println("Category Name: <input type='text' name='categoryName'/>");
        out.println("<input type='submit' value='Add Category'/>");
        out.println("</form>");
        out.println("</div>");

        out.println("<h3>Update Existing Category:</h3>");
        out.println("<div class='operation'>");
        out.println("<form action='crud.jsp' method='POST'>");
        out.println("<input type='hidden' name='action' value='updateCategory'/>");
        out.println("Category: <select name='categoryId'>");

        // Fetch categories to populate the dropdown for update category
        rs = stmt.executeQuery("SELECT * FROM categories");
        while (rs.next()) {
            int categoryId = rs.getInt("id");
            String categoryName = rs.getString("name");
            out.println("<option value='" + categoryId + "'>" + categoryName + "</option>");
        }

        out.println("</select>");
        out.println("New Category Name: <input type='text' name='categoryName' required/>");
        out.println("<input type='submit' value='Update Category'/>");
        out.println("</form>");
        out.println("</div>");

        out.println("<h3>Delete Category:</h3>");
        out.println("<div class='operation'>");
        out.println("<form action='crud.jsp' method='POST'>");
        out.println("<input type='hidden' name='action' value='deleteCategory'/>");
        out.println("Category: <select name='categoryId'>");

        // Fetch categories for delete dropdown
        rs = stmt.executeQuery("SELECT * FROM categories");
        while (rs.next()) {
            int categoryId = rs.getInt("id");
            String categoryName = rs.getString("name");
            out.println("<option value='" + categoryId + "'>" + categoryName + "</option>");
        }

        out.println("</select>");
        out.println("<input type='submit' value='Delete Category'/>");
        out.println("</form>");
        out.println("</div>");  // Close operation for category

        out.println("</div>");  // Close category-section

        // Product CRUD Section
        out.println("<div class='crud-section product-section'>");
        out.println("<h3>Add a New Product:</h3>");
        out.println("<div class='operation'>");
        out.println("<form action='crud.jsp' method='POST'>");
        out.println("<input type='hidden' name='action' value='createProduct'/>");
        out.println("Product Name: <input type='text' name='productName'/>");
        out.println("Price: <input type='text' name='price'/>");
        out.println("Image URL: <input type='text' name='imageUrl'/>");
        out.println("Category: <select name='categoryId'>");

        // Fetch categories for product form
        rs = stmt.executeQuery("SELECT * FROM categories");
        while (rs.next()) {
            int categoryId = rs.getInt("id");
            String categoryName = rs.getString("name");
            out.println("<option value='" + categoryId + "'>" + categoryName + "</option>");
        }

        out.println("</select>");
        out.println("<input type='submit' value='Add Product'/>");
        out.println("</form>");
        out.println("</div>");

        // Update Product Form
        out.println("<h3>Update Existing Product:</h3>");
        out.println("<div class='operation'>");
        out.println("<form action='crud.jsp' method='POST'>");
        out.println("<input type='hidden' name='action' value='updateProduct'/>");
        out.println("Product: <select name='productId'>");

        // Fetch products for update form
        rs = stmt.executeQuery("SELECT * FROM products");
        while (rs.next()) {
            int productId = rs.getInt("id");
            String productName = rs.getString("name");
            out.println("<option value='" + productId + "'>" + productName + "</option>");
        }

        out.println("</select>");
        out.println("New Product Name: <input type='text' name='productName'/>");
        out.println("New Price: <input type='text' name='price'/>");
        out.println("New Image URL: <input type='text' name='imageUrl'/>");
        out.println("Category: <select name='categoryId'>");

        // Fetch categories for category dropdown
        rs = stmt.executeQuery("SELECT * FROM categories");
        while (rs.next()) {
            int categoryId = rs.getInt("id");
            String categoryName = rs.getString("name");
            out.println("<option value='" + categoryId + "'>" + categoryName + "</option>");
        }

        out.println("</select>");
        out.println("<input type='submit' value='Update Product'/>");
        out.println("</form>");
        out.println("</div>");

        // Delete Product Form
        out.println("<h3>Delete Product:</h3>");
        out.println("<div class='operation'>");
        out.println("<form action='crud.jsp' method='POST'>");
        out.println("<input type='hidden' name='action' value='deleteProduct'/>");
        out.println("Product: <select name='productId'>");

        // Fetch products for delete form
        rs = stmt.executeQuery("SELECT * FROM products");
        while (rs.next()) {
            int productId = rs.getInt("id");
            String productName = rs.getString("name");
            out.println("<option value='" + productId + "'>" + productName + "</option>");
        }

        out.println("</select>");
        out.println("<input type='submit' value='Delete Product'/>");
        out.println("</form>");
        out.println("</div>");
        out.println("</div>"); // Close product-section
        out.println("</div>"); // Close container
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
