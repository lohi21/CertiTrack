<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String email = request.getParameter("email"); // Fetch email parameter from the request
    int studentId = -1;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String certificationName = request.getParameter("certification_name");
        String expirationDate = request.getParameter("expiration_date");
        String status = request.getParameter("status");

        String jdbcURL = "jdbc:mysql://localhost:3306/certitrack"; // Updated to match your database name
        String dbUser = "root"; // Your database username
        String dbPassword = "2003"; // Your database password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Insert certification into the studentcertifications table
            String insertSQL = "INSERT INTO studentcertifications (email, certification_name, expiration_date, status) VALUES (?, ?, ?, ?)";
            PreparedStatement insertStmt = connection.prepareStatement(insertSQL);
            insertStmt.setString(1, email); // Set the email of the student (this comes from the request)
            insertStmt.setString(2, certificationName);
            insertStmt.setDate(3, Date.valueOf(expirationDate)); // Assuming expiration_date is in 'YYYY-MM-DD' format
            insertStmt.setString(4, status);

            int rowsAffected = insertStmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<script>alert('Certification submitted successfully!');</script>");
            } else {
                out.println("<script>alert('Failed to submit certification.');</script>");
            }

            // Closing resources
            insertStmt.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Certification</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style >
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

.btn-secondary {
    background-color: #6c757d;
    color: white;
    text-decoration: none;
    padding: 10px;
    display: inline-block;
    border-radius: 5px;
}

.btn-secondary:hover {
    background-color: #5a6268;
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
        <h2>Submit Certification</h2>
        <form method="post">
            <div class="mb-3">
                <label for="certification_name" class="form-label">Certification Name</label>
                <input type="text" class="form-control" name="certification_name" required>
            </div>
            <div class="mb-3">
                <label for="expiration_date" class="form-label">Expiration Date</label>
                <input type="date" class="form-control" name="expiration_date" required>
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select class="form-control" name="status">
                    <option value="Active">Active</option>
                    <option value="Expired">Expired</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit Certification</button>
        </form>
        <a href="studentDashboard.jsp?email=<%= email %>" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>
