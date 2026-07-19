<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("../index.jsp");
        return; 
    }

    HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<Integer, Integer>();
    }

    String action = request.getParameter("action");
    String idParam = request.getParameter("id");
    
    String redirectTarget = "cart.jsp"; 

    if (idParam != null) {
        int productId = Integer.parseInt(idParam);
        
        if ("add".equals(action)) {
            cart.put(productId, cart.getOrDefault(productId, 0) + 1);
            redirectTarget = "shop.jsp?added=true";
        } 
        else if ("remove".equals(action)) {
            cart.remove(productId);
        }
    } 
    else if ("clear".equals(action)) {
        cart.clear();
    }

    session.setAttribute("cart", cart);

    response.sendRedirect(redirectTarget);
%>