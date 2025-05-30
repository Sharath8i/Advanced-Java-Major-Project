<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Hospital Management System</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #ffffff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .hero-section {
            background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
            color: white;
            padding: 5rem 0;
            border-radius: 0 0 30px 30px;
            margin-bottom: 3rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }
        .card {
            border: none;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 18px 35px rgba(0, 0, 0, 0.12);
        }
        .card-icon {
            font-size: 2.8rem;
            margin-bottom: 1rem;
            color: #007bff;
        }
        .btn-custom {
            background: linear-gradient(to right, #007bff, #00bfff);
            color: white;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 1rem;
            transition: background 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
            text-decoration: none;
        }
        .btn-custom:hover {
            background: linear-gradient(to right, #0056b3, #0091ea);
            transform: scale(1.05);
            color: white;
            box-shadow: 0 6px 16px rgba(0, 123, 255, 0.4);
        }
    </style>
</head>
<body>
    <div class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">Hospital Management System</h1>
            <p class="lead mb-5">Efficient patient record management with advanced features</p>
        </div>
    </div>

    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <h3>Add Patient</h3>
                    <p>Register new patients to the system</p>
                    <a href="patientadd.jsp" class="btn btn-custom">Go to Add</a>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-edit"></i>
                    </div>
                    <h3>Update Patient</h3>
                    <p>Modify existing patient records</p>
                    <a href="patientupdate.jsp" class="btn btn-custom">Go to Update</a>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-trash-alt"></i>
                    </div>
                    <h3>Delete Patient</h3>
                    <p>Remove patient records from system</p>
                    <a href="patientdelete.jsp" class="btn btn-custom">Go to Delete</a>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card h-100 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>View Patients</h3>
                    <p>View all patient records in the system</p>
                    <a href="DisplayPatientsServlet" class="btn btn-custom">View All</a>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card h-100 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <h3>Reports</h3>
                    <p>Generate various patient reports</p>
                    <a href="reports.jsp" class="btn btn-custom">Generate Reports</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
