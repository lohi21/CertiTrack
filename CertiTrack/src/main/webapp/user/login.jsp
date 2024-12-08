<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Initialize login status
    String loginStatus = "";
    
    // Check if the form has been submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/certitrack"; // Replace with your database name
        String dbUser = "root"; // Replace with your database username
        String dbPassword = "2003"; // Your database password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            
            String sql = "SELECT * FROM student_profiles WHERE email = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                // Redirect to the student dashboard on successful login
                response.sendRedirect("studentDashboard.jsp?email=" + email);
            } else {
                loginStatus = "Invalid email or password!";
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            loginStatus = "Database error occurred!";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Login - CertiTrack</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .navbar {
            width: 100%;
            background-color: #007bff;
            overflow: auto;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h2 {
            margin: 0;
            color: white;
            font-size: 24px;
        }
        .nav-links {
            display: flex;
            gap: 20px;
            margin-right: 40px;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }
        .nav-links a:hover {
            background: #0056b3;
        }
        .container {
            width: 400px;
            margin: 100px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #007bff;
        }
        label {
            display: block;
            margin-top: 10px;
            font-size: 16px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 5px;
            background: #007bff;
            color: #fff;
            font-size: 18px;
            cursor: pointer;
        }
        .button:hover {
            background: #0056b3;
        }
        .signup-link {
            text-align: center;
            margin-top: 20px;
        }
        .error {
            text-align: center;
            color: #d9534f;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <h2>CertiTrack</h2>
        <div class="nav-links">
            <a href="/springmvc/index.jsp">Home</a>
            <a href="/springmvc/about.html">About</a>
            <a href="signup.jsp">Signup</a>
        </div>
    </div>

    <!-- Login Container -->
    <div class="container">
        <h1>Login</h1>
        <form action="" method="post">
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit" class="button">Login</button>
        </form>
        <% if (!loginStatus.isEmpty()) { %>
            <div class="error"><%= loginStatus %></div>
        <% } %>
        <div class="signup-link">
            <p>Don't have an account? <a href="signup.jsp" style="color: #007bff;">Sign up here</a></p>
        </div>
    </div>
</body>
</html>
