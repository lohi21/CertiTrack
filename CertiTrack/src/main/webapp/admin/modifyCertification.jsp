<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Certification - CertiTrack</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; padding: 0; }
        .navbar { background-color: #007bff; padding: 10px 20px; }
        .navbar h2 { color: white; font-size: 24px; margin: 0; }
        .nav-links { display: flex; gap: 20px; margin-right: 40px; }
        .nav-links a { color: white; text-decoration: none; font-size: 18px; padding: 10px 15px; border-radius: 5px; transition: background 0.3s ease; }
        .nav-links a:hover { background: #0056b3; }
        .container { max-width: 800px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        h1 { text-align: center; color: #007bff; margin-bottom: 20px; }
        .footer { text-align: center; margin-top: 20px; font-size: 14px; }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <div class="navbar d-flex justify-content-between align-items-center">
        <h2>CertiTrack - Admin</h2>
        <div class="nav-links">
            <a href="adminDashboard.jsp">Dashboard</a>
            <a href="home.jsp">Logout</a>
        </div>
    </div>

    <!-- Modify Certification Form -->
    <div class="container">
        <h1>Modify Certification</h1>

        <% 
            String certificationId = request.getParameter("certificationId"); // Get the certification ID parameter from the URL
            String dbURL = "jdbc:mysql://localhost:3306/certitrack"; // Database URL
            String dbUsername = "root"; // Database username
            String dbPassword = "2003"; // Database password
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            String certificationName = "";
            String expirationDate = "";
            String status = "";

            // If the form is submitted
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String updatedCertificationName = request.getParameter("certification_name");
                String updatedExpirationDate = request.getParameter("expiration_date");
                String updatedStatus = request.getParameter("status");

                try {
                    connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                    String updateSQL = "UPDATE studentcertifications SET certification_name = ?, expiration_date = ?, status = ? " +
                                       "WHERE certification_id = ?";
                    statement = connection.prepareStatement(updateSQL);
                    statement.setString(1, updatedCertificationName);
                    statement.setDate(2, java.sql.Date.valueOf(updatedExpirationDate));
                    statement.setString(3, updatedStatus);
                    statement.setString(4, certificationId);
                    int rowsAffected = statement.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<script>alert('Certification updated successfully!'); window.location.href='adminDashboard.jsp';</script>");
                    } else {
                        out.println("<script>alert('Failed to update certification.');</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else { // Get current certification data to pre-fill the form
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                    String certQuery = "SELECT certification_name, expiration_date, status FROM studentcertifications WHERE certification_id = ?";
                    statement = connection.prepareStatement(certQuery);
                    statement.setString(1, certificationId);
                    resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        certificationName = resultSet.getString("certification_name");
                        expirationDate = resultSet.getString("expiration_date");
                        status = resultSet.getString("status");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <!-- Form to Modify Certification Details -->
        <form method="post">
            <div class="mb-3">
                <label for="certification_name" class="form-label">Certification Name</label>
                <input type="text" class="form-control" id="certification_name" name="certification_name" value="<%= certificationName %>" required>
            </div>

            <div class="mb-3">
                <label for="expiration_date" class="form-label">Expiration Date</label>
                <input type="date" class="form-control" id="expiration_date" name="expiration_date" value="<%= expirationDate %>" required>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <input type="text" class="form-control" id="status" name="status" value="<%= status %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Update Certification</button>
        </form>

        <div class="footer">
            <p>&copy; 2024 CertiTrack. All rights reserved.</p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
