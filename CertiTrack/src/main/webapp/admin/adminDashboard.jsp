<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CertiTrack</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Styling remains the same as before */
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; padding: 0; }
        .navbar { background-color: #007bff; padding: 10px 20px; }
        .navbar h2 { color: white; font-size: 24px; margin: 0; }
        .nav-links { display: flex; gap: 20px; margin-right: 40px; }
        .nav-links a { color: white; text-decoration: none; font-size: 18px; padding: 10px 15px; border-radius: 5px; transition: background 0.3s ease; }
        .nav-links a:hover { background: #0056b3; }
        .container { max-width: 1200px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        h1 { text-align: center; color: #007bff; margin-bottom: 20px; }
        .action-buttons { display: flex; justify-content: space-between; margin-bottom: 20px; flex-wrap: wrap; }
        .action-buttons button { flex: 1; margin: 0 10px; padding: 15px; border: none; border-radius: 5px; background: #007bff; color: #fff; font-size: 16px; cursor: pointer; transition: background 0.3s ease; width: 100%; max-width: 200px; }
        .action-buttons button:hover { background: #0056b3; }
        .participant-list { margin-top: 20px; }
        .participant-item { display: flex; justify-content: space-between; padding: 15px; background: #f9f9f9; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 10px; }
        .participant-item:nth-child(even) { background: #f1f1f1; }
        .footer { text-align: center; margin-top: 20px; font-size: 14px; }
        /* Responsive design adjustments */
        @media (max-width: 768px) {
            .navbar { flex-direction: column; align-items: flex-start; }
            .nav-links { flex-direction: column; margin-right: 0; }
            .action-buttons { flex-direction: column; align-items: stretch; }
            .action-buttons button { width: 100%; margin-bottom: 10px; }
            .container { padding: 20px; }
            .participant-item { flex-direction: column; text-align: left; }
            .participant-item span { margin-bottom: 5px; }
        }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <div class="navbar d-flex justify-content-between align-items-center">
        <h2>CertiTrack - Admin</h2>
        <div class="nav-links">
            <a href="/springmvc/dashboard.jsp">Dashboard</a>
            <a href="adminLogin.jsp">Logout</a>
        </div>
    </div>

    <!-- Admin Dashboard -->
    <div class="container">
        <h1>Admin Dashboard</h1>

        <div class="action-buttons">
            <button onclick="window.location.href='addcertification.jsp'">Add Certification</button>
        </div>

        <h2>Certification List</h2>
        <div class="participant-list">
            <% 
                // JDBC Connection Setup
                String dbURL = "jdbc:mysql://localhost:3306/certitrack"; // Replace with your DB URL
                String dbUsername = "root"; // Replace with your DB username
                String dbPassword = "2003"; // Replace with your DB password
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;

                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection
                    connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                    // SQL query to get certifications and user information
                    String certQuery = "SELECT sp.id, sp.first_name, sp.last_name, sp.email, sp.phone_number, sp.date_of_birth, sp.address, " +
                                       "sc.certification_id, sc.certification_name, sc.created_at, sc.expiration_date, sc.status " +
                                       "FROM student_profiles sp " +
                                       "JOIN studentcertifications sc ON sp.email = sc.email";  // Join on email
                    
                    preparedStatement = connection.prepareStatement(certQuery);

                    // Execute query
                    resultSet = preparedStatement.executeQuery();

                    // Display certifications dynamically
                    while (resultSet.next()) {
                        String id = resultSet.getString("id");
                        String firstName = resultSet.getString("first_name");
                        String lastName = resultSet.getString("last_name");
                        String email = resultSet.getString("email");
                        String phoneNumber = resultSet.getString("phone_number");
                        String dateOfBirth = resultSet.getString("date_of_birth");
                        String address = resultSet.getString("address");
                        String certificationId = resultSet.getString("certification_id");
                        String certificationName = resultSet.getString("certification_name");
                        String createdAt = resultSet.getString("created_at");
                        String expirationDate = resultSet.getString("expiration_date");
                        String status = resultSet.getString("status");

            %>
            <div class="participant-item">
                <div>
                    <strong><%= firstName %> <%= lastName %></strong><br>
                    <span>Email: <%= email %></span><br>
                    <span>Phone: <%= phoneNumber %></span><br>
                    <span>Date of Birth: <%= dateOfBirth %></span><br>
                    <span>Address: <%= address %></span>
                </div>
                <div>
                    <strong>Certification: <%= certificationName %></strong><br>
                    <span>Certification ID: <%= certificationId %></span><br>
                    <span>Created At: <%= createdAt %></span><br>
                    <span>Expiration Date: <%= expirationDate %></span><br>
                    <span>Status: <%= status %></span><br>
                    <button class="btn btn-warning" onclick="modifyCertification('<%= certificationId %>')">Update</button>
                    <button class="btn btn-danger" onclick="deleteCertification('<%= certificationId %>')">Delete</button>
                    <button class="btn btn-danger" onclick="notifyCertification('<%= certificationId %>')">Notify</button>
                </div>
            </div>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (resultSet != null) resultSet.close();
                        if (preparedStatement != null) preparedStatement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <div class="footer">
            <p>&copy; 2024 CertiTrack. All rights reserved.</p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Function to handle modify action for a certification
        function modifyCertification(certificationId) {
            window.location.href = 'modifyCertification.jsp?certificationId=' + certificationId;
        }

        // Function to handle delete action for a certification
        function deleteCertification(certificationId) {
            if (confirm("Are you sure you want to delete this certification?")) {
                window.location.href = 'deleteCertification.jsp?certificationId=' + certificationId;
            }
        }

        // Function to handle notify action for a certification
        function notifyCertification(certificationId) {
            // Redirect to the renew email page with the certificationId
            window.location.href = 'renewEmail.jsp?certificationId=' + certificationId;
        }
    </script>
</body>

</html>