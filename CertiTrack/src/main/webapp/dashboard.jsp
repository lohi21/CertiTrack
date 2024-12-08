<!DOCTYPE html>
<html>
<head>
    <title>CertiTrack Dashboard</title>
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

        .description {
            font-size: 20px;
            color: #555;
            margin: 20px 0;
            padding: 0 20px;
        }

        .features, .benefits {
            margin: 30px 0;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .feature, .benefit {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 10px;
            width: 30%; /* Adjust as needed */
            text-align: left;
        }

        .feature img, .benefit img {
            max-width: 50px;
            margin-bottom: 10px;
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

        img {
            max-width: 100px; /* Adjust size as needed */
        }

        .footer {
            margin: 40px 0;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <h2>CertiTrack</h2>
        <div class="nav-links">
                    <a href="index.jsp">Home</a>
        
            <a href="user/login.jsp">Login</a>
            <a href="user/signup.jsp">Register</a>
            <a href="Certifications.jsp">Certifications</a>
            <a href="admin/adminLogin.jsp">Admin</a>
            
            
        </div>
    </div>

    <h1>Welcome to CertiTrack</h1>
    <div class="description">
        CertiTrack is an innovative Certification Management System designed to streamline the process of tracking, managing, and renewing professional certifications. Whether you are an individual seeking to monitor your own certifications or an organization managing multiple employees, CertiTrack provides an efficient solution for certification tracking.
    </div>

    <h2>Key Features</h2>
    <div class="features">
        <div class="feature">
            <img src="https://media.istockphoto.com/vectors/use-by-icon-on-transparent-background-vector-id1284145502?k=20&m=1284145502&s=612x612&w=0&h=c3JCN9B0Wk_-1Eb96vvhJWObGNeBT33MsXfq54E23mA=" alt="Feature 1">
            <h3>Track Expiration Dates</h3>
            <p>Easily monitor the expiration dates of your certifications and receive reminders for renewals.</p>
        </div>
        <div class="feature">
            <img src="https://tse4.mm.bing.net/th?id=OIP.uwtWxrFGJARyc4PA6zAMLwHaHa&pid=Api&P=0&h=180" alt="Feature 2">
            <h3>User-Friendly Interface</h3>
            <p>Intuitive design that makes navigating your certifications simple and efficient.</p>
        </div>
        <div class="feature">
            <img src="https://media.istockphoto.com/vectors/secure-storage-icon-flat-design-vector-id536664112?k=20&m=536664112&s=170667a&w=0&h=q0OaeNeGd0cUAlavFzlxRBo_KPlut6_AiziixHWCd0g=" alt="Feature 3">
            <h3>Secure Storage</h3>
            <p>Store your certification documents securely and access them anytime, anywhere.</p>
        </div>
    </div>

    <h2>Benefits of Using CertiTrack</h2>
    <div class="benefits">
        <div class="benefit">
            <img src="https://www.creativefabrica.com/wp-content/uploads/2020/09/16/1600258740/Stay-Organized.jpg" alt="Benefit 1">
            <h3>Stay Organized</h3>
            <p>Keep all your certifications in one place, easily accessible and well-organized.</p>
        </div>
        <div class="benefit">
            <img src="https://tse3.mm.bing.net/th?id=OIP.ZSskdzUMs7UQ2bO8eKG9uwHaHa&pid=Api&P=0&h=180" alt="Benefit 2">
            <h3>Save Time</h3>
            <p>Automated reminders for renewals save you time and ensure you never miss a deadline.</p>
        </div>
        <div class="benefit">
            <img src="https://png.pngtree.com/png-clipart/20230924/original/pngtree-identify-career-opportunities-blue-gradient-concept-icon-infographic-logo-vector-vector-png-image_12848307.png" alt="Benefit 3">
            <h3>Enhance Career Opportunities</h3>
            <p>Keep your certifications up to date, which enhances your professional profile and opportunities.</p>
        </div>
    </div>

    <div class="footer">
        <h2>Get Started Today!</h2>
        <p>Sign up or log in to begin tracking your certifications efficiently.</p>
    </div>
</body>
</html>
