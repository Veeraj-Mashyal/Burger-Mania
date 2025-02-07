<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/burgermania";
    String dbUser = "root";
    String dbPassword = "Veeraj_1530";

    // Retrieve session

    // Retrieve session
    HttpSession ss = request.getSession(false);
    if (ss == null || ss.getAttribute("id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve user ID safely
    Object uidObj = ss.getAttribute("id");

    if (uidObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer uid;
    if (uidObj instanceof Integer) {
        uid = (Integer) uidObj;
    } else {
        uid = Integer.parseInt(uidObj.toString());
    }



    // Retrieve user ID
//    Integer uid = (Integer) ss.getAttribute("id");

    // Retrieve cart from session
    Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) ss.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    // Initialize variables
    double grandTotal = 0;
    StringBuilder orderDetails = new StringBuilder();
    StringBuilder quantityDetails = new StringBuilder();

    for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
        Map<String, Object> product = entry.getValue();
        String productName = (String) product.get("name");
        double price = (double) product.get("price");
        int quantity = (int) product.get("quantity");
        double total = price * quantity;

        // Add to grand total
        grandTotal += total;

        // Append product name and quantity (comma-separated)
        if (orderDetails.length() > 0) {
            orderDetails.append(", ");
            quantityDetails.append(",");
        }
        orderDetails.append(productName);
        quantityDetails.append(quantity);
    }

    // Apply discounts, tax, and delivery charges
    double discountRate = (grandTotal > 600) ? 0.20 : 0.10;
    double discount = grandTotal * discountRate;
    double sgst = 8, cgst = 8, delivery = 40;
    double amountAfterDiscount = grandTotal - discount;
    double finalAmount = amountAfterDiscount + sgst + cgst + delivery;

    // Store final amount in session
    session.setAttribute("finalAmount", finalAmount);

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Insert order into database
        String sql = "INSERT INTO orders (uid, total_amount, order_details, quantity, status) VALUES (?, ?, ?, ?, 'Pending')";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, uid);
        stmt.setDouble(2, finalAmount);
        stmt.setString(3, orderDetails.toString()); // Product names as CSV
        stmt.setString(4, quantityDetails.toString()); // Quantities as CSV

        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            // Clear the cart after successful order placement
            session.removeAttribute("cart");

            // Redirect to payment confirmation page
            response.sendRedirect("paymentConfirmation.jsp?finalAmount=" + finalAmount);
        } else {
            out.println("<p style='color: red;'>Order could not be placed. Please try again.</p>");
        }

    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>