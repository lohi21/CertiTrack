<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    int studentId = -1;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String certificationName = request.getParameter("certification_name");
        String issuedTo = request.getParameter("issued_to");
        String expirationDate = request.getParameter("expiration_date");
        String status = request.getParameter("status");

        String jdbcURL = "jdbc:mysql://localhost:3306/certitrack"; // Updated to match your database name
        String dbUser = "root"; // Your database username
        String dbPassword = "2003"; // Your database password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Insert certification into the certitrack.certifications table
            String insertSQL = "INSERT INTO certitrack.studentcertifications (certification_name, issued_to, expiration_date, status) VALUES (?, ?, ?, ?)";
            PreparedStatement insertStmt = connection.prepareStatement(insertSQL);
            insertStmt.setString(1, certificationName);
            insertStmt.setString(2, issuedTo);
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
                <label for="issued_to" class="form-label">Issued To</label>
                <input type="text" class="form-control" name="issued_to" required>
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
        <a href="adminDashboard.jsp?username=<%= username %>" class="btn btn-secondary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>
