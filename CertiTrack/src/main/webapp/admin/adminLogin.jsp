<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    /* Global Styles */
body {
    font-family: Arial, sans-serif;
    background-color: #e0f7fa; /* Light blue background */
    margin: 0;
    padding: 0;
    text-align: center;
}

h2 {
    font-size: 30px;
    color: #00008B; /* Dark blue for heading */
    margin-bottom: 30px;
}

.container {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 30px;
    max-width: 400px;
    margin-top: 50px;
}

.form-label {
    font-size: 16px;
    font-weight: bold;
    color: #555;
}

.form-control {
    border-radius: 8px;
    border: 2px solid #ccc;
    padding: 10px;
    margin-bottom: 20px;
    font-size: 1rem;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #3a3a62;
    box-shadow: 0 0 8px rgba(58, 58, 98, 0.5);
}

.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
    border-radius: 8px;
    font-size: 16px;
    padding: 10px 20px;
    transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.btn-primary:hover {
    background-color: #0056b3;
    border-color: #0056b3;
    transform: scale(1.05);
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
}

.alert {
    border-radius: 8px;
    padding: 10px;
    font-size: 14px;
}

.alert-danger {
    background-color: #f44336;
    color: white;
}

/* Navbar */
.navbar {
    width: 100%;
    background-color: #007bff; /* Dark blue navbar color */
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
    margin-right: 40px; /* Space between the links and the right edge */
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
    background: #000066; /* Slightly darker blue for hover effect */
}

/* Footer */
.footer {
    margin: 40px 0;
    font-size: 16px;
    color: #555;
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        margin-top: 50px;
        padding: 20px;
    }

    h2 {
        font-size: 24px;
    }
}

    </style>
</head>
<body>
<!-- Navigation Bar -->
    <div class="navbar">
        <h2>Welcome Admin</h2>
        <div class="nav-links">
             <a href="index.jsp">Home</a>
        </div>
    </div>
    <div class="container">
        <h2 class="text-center">Admin Login</h2>
        
        <!-- Display error message if exists -->
        <%
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
                out.println("<div class='alert alert-danger'>" + errorMessage + "</div>");
                session.removeAttribute("errorMessage"); // Clear the message after displaying
            }
        %>
        
        <form action="adminLoginAction.jsp" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Login</button>
            </div>
        </form>
    </div>
</body>
</html>
