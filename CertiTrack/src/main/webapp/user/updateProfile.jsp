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
            fullName = userResultSet.getString("first_name") + " " + userResultSet.getString("last_name");
            username = userResultSet.getString("first_name");
            phoneNumber = userResultSet.getString("phone_number");
            dob = userResultSet.getString("date_of_birth");
            address = userResultSet.getString("address");
        }

        userResultSet.close();
        userStatement.close();

        // If the form is submitted, update the user's profile
        String updatedPhoneNumber = request.getParameter("phone_number");
        String updatedDob = request.getParameter("dob");
        String updatedAddress = request.getParameter("address");

        if (updatedPhoneNumber != null && updatedDob != null && updatedAddress != null) {
            String updateQuery = "UPDATE student_profiles SET phone_number = ?, date_of_birth = ?, address = ? WHERE email = ?";
            PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
            updateStatement.setString(1, updatedPhoneNumber);
            updateStatement.setString(2, updatedDob);
            updateStatement.setString(3, updatedAddress);
            updateStatement.setString(4, email);

            int rowsUpdated = updateStatement.executeUpdate();

            if (rowsUpdated > 0) {
                // Profile updated successfully
                response.sendRedirect("studentDashboard.jsp?email=" + email); // Redirect back to dashboard
            } else {
                // Handle the error
                out.println("<p>Failed to update profile. Please try again.</p>");
            }

            updateStatement.close();
        }

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
    <title>Update Profile - CertiTrack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
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
    margin-bottom: 10px;
}

.certifications table {
    width: 100%;
    margin-top: 20px;
    border-collapse: collapse;
}

.certifications th, .certifications td {
    text-align: center;
    padding: 12px;
    border: 1px solid #ccc;
}

.certifications th {
    background-color: #f8f9fa;
}

.certifications td a {
    color: white;
    font-weight: bold;
}

.certifications td a:hover {
    background-color: #c82333;
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
    color: #6c757d;
}

    </style>
</head>

<body>
    <div class="container">
        <h2>Update Your Profile</h2>

        <form action="updateProfile.jsp?email=<%= email %>" method="POST">
            <!-- Displaying User Details -->
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" class="form-control" id="email" name="email" value="<%= email %>" disabled>
            </div>

            <div class="form-group">
                <label for="phone_number">Phone Number:</label>
                <input type="text" class="form-control" id="phone_number" name="phone_number" value="<%= phoneNumber %>" required>
            </div>

            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" class="form-control" id="dob" name="dob" value="<%= dob %>" required>
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="address" value="<%= address %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Update Profile</button>
            <a href="studentDashboard.jsp?email=<%= email %>" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
