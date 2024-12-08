<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Certification - CertiTrack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
   

    <div class="container mt-5">

        <%
            String certificationId = request.getParameter("certificationId");
            if (certificationId == null) {
                out.println("<p>Invalid certification ID.</p>");
                return;
            }

            String dbURL = "jdbc:mysql://localhost:3306/certitrack"; // DB URL
            String dbUsername = "root"; // DB username
            String dbPassword = "2003"; // DB password
            Connection connection = null;
            PreparedStatement statement = null;

            try {
                // Establish connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                // Prepare delete query
                String deleteQuery = "DELETE FROM studentcertifications WHERE certification_id = ?";
                statement = connection.prepareStatement(deleteQuery);
                statement.setString(1, certificationId);
                
                // Execute delete
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<div class='alert alert-success text-center'>");
                    out.println("<strong>Success!</strong> Certification has been deleted.");
                    out.println("<a href='adminDashboard.jsp' class='btn btn-primary mt-3'>Go back to Dashboard</a>");
                    out.println("</div>");
                } else {
                    out.println("<div class='alert alert-danger text-center'>");
                    out.println("<strong>Error!</strong> Unable to delete certification.");
                    out.println("<a href='adminDashboard.jsp' class='btn btn-primary mt-3'>Go back to Dashboard</a>");
                    out.println("</div>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger text-center'>");
                out.println("<strong>Error!</strong> Something went wrong. Please try again.");
                out.println("<a href='adminDashboard.jsp' class='btn btn-primary mt-3'>Go back to Dashboard</a>");
                out.println("</div>");
            } finally {
                try {
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
