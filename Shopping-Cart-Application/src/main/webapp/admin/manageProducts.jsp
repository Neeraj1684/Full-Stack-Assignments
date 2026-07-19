<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/db_connect.jsp" %>

<%
    String role = (String) session.getAttribute("userRole");

    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>
    <title>Manage Products - Admin Dashboard</title>

    <link rel="stylesheet" href="../assets/css/style.css">

    <style>
        .container {
            max-width: 900px;
            margin: 0 auto; /* Centers the container in the content area */
        }

        .add-form-container {
            background: #f8f9fa;
            border: 1px solid #e2e2e2;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
        }

        .add-form-container h3 {
            margin-bottom: 18px;
            margin-top: 0;
        }

        .product-form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
        }

        .form-group {
            flex: 1;
        }

        .form-group:first-child {
            flex: 2;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
        }

        .form-group input {
            margin: 0;
        }

        .submit-group {
            flex: 0;
        }

        .submit-group input {
            width: auto;
            padding: 12px 18px;
            margin: 0;
        }

        .badge-active,
        .badge-inactive {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-active {
            background: #2ecc71;
            color: white;
        }

        .badge-inactive {
            background: #e74c3c;
            color: white;
        }

        .action-btn {
            width: auto;
            padding: 8px 14px;
            margin: 0;
            font-size: 13px;
        }

        table {
            margin-top: 0;
        }

        td:last-child {
            width: 140px;
        }
    </style>
</head>

<body>

    <div class="dashboard-layout">
        
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="home.jsp">Home</a>
            <a href="manageProducts.jsp" class="active">Products</a>
            <a href="viewCustomers.jsp">Customers</a>
            <a href="viewOrders.jsp">Orders</a>
        </div>

        <div class="main-content">
            
            <div class="topbar">
                <div class="profile-menu">
                    <span class="username">Admin</span>
                    <div class="profile-icon">👤</div>
                    
                    <div class="dropdown-content">
                        <a href="../logout.jsp">Logout</a>
                    </div>
                </div>
            </div>

            <!-- PAGE SPECIFIC CONTENT -->
            <div class="content-area">
                <div class="container">

                    <h2 style="margin-bottom: 25px; margin-top: 0; color: #2c3e50;">Manage Products</h2>

                    <!-- ADD PRODUCT FORM -->
                    <div class="add-form-container">
                        <h3>Add New Product</h3>
                        <form action="productAction.jsp" method="post" class="product-form">
                            <input type="hidden" name="action" value="add">
                            <div class="form-group">
                                <label>Product Name</label>
                                <input type="text" name="name" required>
                            </div>
                            <div class="form-group">
                                <label>Price (₹)</label>
                                <input type="number" name="price" step="0.01" min="0" required>
                            </div>
                            <div class="submit-group">
                                <input type="submit" value="+ Add Product">
                            </div>
                        </form>
                    </div>

                    <!-- PRODUCTS TABLE -->
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        <%
                            if (conn != null) {
                                try {
                                    String sql = "SELECT * FROM products ORDER BY id DESC";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);

                                    while (rs.next()) {
                                        int id = rs.getInt("id");
                                        String name = rs.getString("name");
                                        double price = rs.getDouble("price");
                                        boolean isActive = rs.getBoolean("is_active");

                                        String badgeClass = isActive ? "badge-active" : "badge-inactive";
                                        String statusText = isActive ? "Active" : "Hidden";
                                        String toggleAction = isActive ? "Disable" : "Enable";
                                        String btnColor = isActive ? "#e67e22" : "#2ecc71";
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td>₹<%= String.format("%.2f", price) %></td>
                            <td>
                                <span class="<%= badgeClass %>"><%= statusText %></span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 5px;">
                                    <a href="editProduct.jsp?id=<%= id %>" class="btn action-btn" style="background-color: #3498db;">Edit</a>
                                    <form action="productAction.jsp" method="post" style="margin: 0;">
                                        <input type="hidden" name="action" value="toggle">
                                        <input type="hidden" name="id" value="<%= id %>">
                                        <input type="hidden" name="currentState" value="<%= isActive %>">
                                        <input type="submit" class="btn action-btn" value="<%= toggleAction %>" style="background-color: <%= btnColor %>;">
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='5' class='error'>Database Error: " + e.getMessage() + "</td></tr>");
                                }
                            }
                        %>
                    </table>

                </div>
            </div>
            
        </div>
    </div>

</body>
</html>