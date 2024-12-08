<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Fetch the email from the request
    String email = request.getParameter("email");

    // Initialize variables for user details
    String fullName = "N/A";
    String username = "N/A";
    String phoneNumber = "N/A";
    String dob = "N/A";
    String address = "N/A";

    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/certitrack";
    String dbUser = "root";
    String dbPassword = "2003";

    // Initialize certifications flag and HTML builder
    boolean hasCertifications = false;
    StringBuilder certificationsHtml = new StringBuilder();

    Connection connection = null;
    try {
        // Load MySQL JDBC driver and establish a connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL Query to fetch user details from student_profiles
        String userQuery = "SELECT first_name, last_name, phone_number, date_of_birth, address FROM student_profiles WHERE email = ?";
        PreparedStatement userStatement = connection.prepareStatement(userQuery);
        userStatement.setString(1, email);
        ResultSet userResultSet = userStatement.executeQuery();

        if (userResultSet.next()) {
            username = userResultSet.getString("first_name");
            fullName = userResultSet.getString("first_name") + " " + userResultSet.getString("last_name");
            phoneNumber = userResultSet.getString("phone_number");
            dob = userResultSet.getString("date_of_birth");
            address = userResultSet.getString("address");
        }

        userResultSet.close();
        userStatement.close();

        // SQL Query to fetch certifications by joining student_profiles and studentcertifications
        String certQuery = "SELECT sc.certification_id, sc.certification_name, sc.created_at, sc.expiration_date FROM studentcertifications sc " +
                           "JOIN student_profiles sp ON sc.email = sp.email WHERE sp.email = ?";
        PreparedStatement certStatement = connection.prepareStatement(certQuery);
        certStatement.setString(1, email);
        ResultSet certResultSet = certStatement.executeQuery();

        // Fetching certifications and building the HTML
        while (certResultSet.next()) {
            hasCertifications = true;
            certificationsHtml.append("<tr>")
                .append("<td>").append(certResultSet.getString("certification_name")).append("</td>")
                .append("<td>").append(certResultSet.getString("created_at")).append("</td>")
                .append("<td>").append(certResultSet.getString("expiration_date")).append("</td>")
                .append("<td><a href=\"deleteCertification.jsp?email=").append(email)
                .append("&certification_id=").append(certResultSet.getInt("certification_id"))
                .append("\" class=\"btn btn-danger\">Delete</a></td>")
                .append("</tr>");
        }

        certResultSet.close();
        certStatement.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - CertiTrack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #007bff;
            padding: 10px 20px;
        }

        .navbar h2 {
            color: white;
            font-size: 24px;
            margin: 0;
        }

        .navbar .nav-links {
            display: flex;
            gap: 20px;
        }

        .navbar .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .navbar .nav-links a:hover {
            background: #0056b3;
        }

        .container {
            max-width: 800px;
            background: #fff;
            margin: 50px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2, h3 {
            text-align: center;
            color: #007bff;
        }

        .profile-details p {
            font-size: 18px;
        }

        .certifications table {
            width: 100%;
            margin-top: 20px;
        }

        .certifications th, .certifications td {
            text-align: center;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .btn {
            width: 100%;
            margin-top: 15px;
            border-radius: 5px;
            font-weight: bold;
        }

        .btn-primary {
            background-color: #007bff;
            color: #ffffff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .footer p {
            margin: 0;
        }

    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <div class="navbar d-flex justify-content-between align-items-center">
        <h2>CertiTrack</h2>
        <div class="nav-links">
            <a href="/springmvc/index.jsp">Home</a>
            <a href="login.jsp">Logout</a>
        </div>
    </div>

    <!-- Student Dashboard -->
    <div class="container">
        <h2>Welcome, <%= fullName %>!</h2>

        <!-- Displaying User Details -->
        <div class="profile-details">
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Username:</strong> <%= username %></p>
            <p><strong>Phone Number:</strong> <%= phoneNumber %></p>
            <p><strong>Date of Birth:</strong> <%= dob %></p>
            <p><strong>Address:</strong> <%= address %></p>
        </div>

        <!-- Displaying Certifications -->
        <div class="certifications">
            <h3>Your Certifications</h3>
            <table>
                <thead>
                    <tr>
                        <th>Certification Name</th>
                        <th>Created Date</th>
                        <th>Expiry Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%= certificationsHtml.toString() %>
                </tbody>
            </table>
            <% if (!hasCertifications) { %>
                <p>No certifications found.</p>
            <% } %>
        </div>

        <!-- Action Buttons -->
        <a href="updateProfile.jsp?email=<%= email %>" class="btn btn-primary">Update Profile</a>
        <a href="userCertificate.jsp?email=<%= email %>" class="btn btn-primary">Add Certifications</a>
    </div>

    <div class="footer">
        <p>&copy; 2024 CertiTrack. All rights reserved.</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
