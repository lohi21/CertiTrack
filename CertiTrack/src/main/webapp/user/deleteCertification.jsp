<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String email = request.getParameter("email");
    int certificationId = Integer.parseInt(request.getParameter("certification_id"));
    
    String jdbcURL = "jdbc:mysql://localhost:3306/certitrack"; // Updated to match your database name
    String dbUser = "root"; // Your database username
    String dbPassword = "2003"; // Your database password

    Connection connection = null;
    try {
        // Load MySQL JDBC driver and establish a connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL Query to delete a certification
        String deleteSQL = "DELETE FROM studentcertifications WHERE certification_id = ? AND email = ?";
        PreparedStatement deleteStmt = connection.prepareStatement(deleteSQL);
        deleteStmt.setInt(1, certificationId);
        deleteStmt.setString(2, email);

        int rowsAffected = deleteStmt.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<script>alert('Certification deleted successfully!'); window.location='studentDashboard.jsp?email=" + email + "';</script>");
        } else {
            out.println("<script>alert('Failed to delete certification.'); window.location='studentDashboard.jsp?email=" + email + "';</script>");
        }

        deleteStmt.close();
        connection.close();
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
