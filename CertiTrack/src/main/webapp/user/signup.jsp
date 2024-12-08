<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - CertiTrack</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
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
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
        }

        .form-control {
            border-radius: 10px;
            padding: 10px;
        }

        .btn-success {
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            padding: 12px 30px;
            width: 100%;
            font-size: 16px;
        }

        .btn-success:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .error-message {
            color: #dc3545;
            text-align: center;
            margin-top: 20px;
        }

        /* Responsive design adjustments */
        @media (max-width: 768px) {
            .navbar .nav-links {
                flex-direction: column;
                margin-right: 0;
            }

            .container {
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 15px;
            }

            .btn-success {
                font-size: 14px;
                padding: 12px;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <div class="navbar d-flex justify-content-between align-items-center">
        <h2>CertiTrack</h2>
        <div class="nav-links">
            <a href="/springmvc/index.jsp">Home</a>
            <a href="login.jsp">Login</a>
        </div>
    </div>

    <!-- Sign-Up Form -->
    <div class="container">
        <h1>Sign Up</h1>
        <form action="" method="post">
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" required>
            </div>
            <div class="mb-3">
                <label for="lastName" class="form-label">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber">
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Date of Birth</label>
                <input type="date" class="form-control" id="dob" name="dob">
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" name="address"></textarea>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-success">Sign Up</button>
            </div>
        </form>

        <% 
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                String dob = request.getParameter("dob");
                String address = request.getParameter("address");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");

                // Check if passwords match
                if (!password.equals(confirmPassword)) {
        %>
                    <div class="error-message">Passwords do not match. Please try again.</div>
        <%
                } else {
                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        // Load MySQL JDBC Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish connection to the database
                        conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/certitrack", "root", "2003");

                        // Insert user data into the database
                        String sql = "INSERT INTO student_profiles (email, first_name, last_name, phone_number, date_of_birth, address, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, email);
                        pstmt.setString(2, firstName);
                        pstmt.setString(3, lastName);
                        pstmt.setString(4, phoneNumber);
                        pstmt.setString(5, dob);
                        pstmt.setString(6, address);
                        pstmt.setString(7, password);

                        int rowsAffected = pstmt.executeUpdate();
                        if (rowsAffected > 0) {
                            // Show registration success message and redirect
                            out.println("<script>alert('Registration Successful!'); window.location.href='login.jsp';</script>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            }
        %>

        <p class="text-center mt-3">Already have an account? <a href="login.jsp">Login</a></p>
    </div>

    <div class="footer">
        <p>&copy; 2024 CertiTrack. All rights reserved.</p>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
