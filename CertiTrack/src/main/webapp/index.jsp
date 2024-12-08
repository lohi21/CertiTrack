<!DOCTYPE html>
<html>
<head>
    <title>CertiTrack - Certification Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e0f7fa; /* Light blue background */
            margin: 0;
            padding: 0;
            text-align: center;
        }

        h1 {
            margin-top: 50px;
            font-size: 36px;
            color: #00008B; /* Dark blue for heading */
        }

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

        .main-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 50px;
        }

        .content-text {
            width: 45%;
            padding: 20px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }

        .content-text h1 {
            font-size: 48px;
            color: #3a3a62;
            margin-bottom: 20px;
        }

        .content-text h2 {
            font-size: 24px;
            color: #3a3a62;
            margin-bottom: 15px;
        }

        .content-text p {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
        }

        .dashboard-btn {
            display: inline-block;
            margin-top: 30px;
            padding: 15px 30px;
            font-size: 20px;
            color: #ffffff;
            background: #3a3a62;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: 0.3s;
        }

        .dashboard-btn:hover {
            background: #2ecc71;
            transform: scale(1.05);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        }

        .content-image {
            width: 45%;
        }

        .content-image img {
            width: 100%;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideDown {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <h2>CertiTrack</h2>
        <div class="nav-links">
            <a href="about.html">About Us</a>
            <a href="contact.html">Contact</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Left Text Content -->
        <div class="content-text">
            <h1>CertiTrack</h1>
            <h2>Streamline Your Certification Management</h2>
            <p>
                CertiTrack is a comprehensive platform that helps organizations and professionals 
                track, manage, and renew certifications effortlessly. With our intuitive interface, 
                users can ensure they are always up to date with their certification requirements.
            </p>
            <a href="dashboard.jsp" class="dashboard-btn">DASHBOARD</a>
        </div>

        <!-- Right Image Content with External Link -->
        <div class="content-image">
            <img src="https://static.vecteezy.com/system/resources/previews/000/664/649/original/group-of-young-business-people-working-together-vector.jpg" alt="Certification Management Image">
        </div>
    </div>
</body>
</html>
