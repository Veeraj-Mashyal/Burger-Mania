/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.burger;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the cart from the session
        HttpSession session = request.getSession();
        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");

        if (cart != null) {
            // Get the product ID and action (increase or decrease)
            int productId = Integer.parseInt(request.getParameter("productId"));
            String action = request.getParameter("action");

            if (cart.containsKey(productId)) {
                Map<String, Object> product = cart.get(productId);
                int quantity = (int) product.get("quantity");

                if ("increase".equals(action)) {
                    // Increase the quantity
                    product.put("quantity", quantity + 1);
                } else if ("decrease".equals(action)) {
                    // Decrease the quantity (but not below 1)
                    if (quantity > 1) {
                        product.put("quantity", quantity - 1);
                    } else {
                        // Remove the product if the quantity reaches 0
                        cart.remove(productId);
                    }
                }
            }
        }

        // Redirect back to the products page
        response.sendRedirect("products.jsp");
    }
}
