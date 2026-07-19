<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="../includes/db_connect.jsp" %>
<%
    // Security check
    String role = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("currentUser");
    
    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
    
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("shop.jsp");
        return;
    }

    if (conn != null) {
        try {
            double grandTotal = 0.0;
            String priceSql = "SELECT price FROM products WHERE id = ?";
            PreparedStatement priceStmt = conn.prepareStatement(priceSql);
            
            HashMap<Integer, Double> itemPrices = new HashMap<>();
            
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                priceStmt.setInt(1, entry.getKey());
                ResultSet rs = priceStmt.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("price");
                    itemPrices.put(entry.getKey(), price);
                    grandTotal += (price * entry.getValue());
                }
                rs.close();
            }
            priceStmt.close();

            String orderSql = "INSERT INTO orders (username, total_amount) VALUES (?, ?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setString(1, username);
            orderStmt.setDouble(2, grandTotal);
            orderStmt.executeUpdate();

            ResultSet generatedKeys = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }
            generatedKeys.close();
            orderStmt.close();

            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(itemSql);
            
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, entry.getKey());
                itemStmt.setInt(3, entry.getValue());
                itemStmt.setDouble(4, itemPrices.get(entry.getKey()));
                
                itemStmt.addBatch(); 
            }
            itemStmt.executeBatch();
            itemStmt.close();

            session.removeAttribute("cart");
            response.sendRedirect("orderSuccess.jsp?orderId=" + orderId);

        } catch (Exception e) {
            out.println("<div class='error'>Checkout failed: " + e.getMessage() + "</div>");
        } finally {
            conn.close();
        }
    }
%>