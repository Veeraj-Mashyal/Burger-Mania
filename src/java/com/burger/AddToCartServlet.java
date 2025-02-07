/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.burger;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve product details from the form
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));

        // Get the cart from the session or create a new one
        HttpSession session = request.getSession();
        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // Add product to cart or update its quantity
        if (cart.containsKey(productId)) {
            Map<String, Object> product = cart.get(productId);
            int quantity = (int) product.get("quantity");
            product.put("quantity", quantity + 1);
        } else {
            Map<String, Object> product = new HashMap<>();
            product.put("name", productName);
            product.put("price", price);
            product.put("quantity", 1);
            cart.put(productId, product);
        }

        // Save the cart back to the session
        session.setAttribute("cart", cart);

        // Redirect to the products page
        response.sendRedirect("products.jsp");
    }
}
