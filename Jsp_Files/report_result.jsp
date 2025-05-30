<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Patient, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Report Results</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: box-shadow 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: box-shadow 0.3s ease;
        }
        .table-responsive:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .table thead th {
            background-color: #0d6efd;
            color: white;
            user-select: none;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        /* Smooth transition on table rows */
        .table tbody tr {
            transition: background-color 0.25s ease, transform 0.2s ease;
            cursor: default;
        }
        /* Hover highlight on rows */
        .table tbody tr:hover {
            background-color: #e9f0ff;
            transform: scale(1.02);
            cursor: pointer;
        }
        /* Alternate row shading */
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9fbff;
        }

        .report-header {
            background-color: #f1f8ff;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: inset 0 0 10px #d6e4ff;
            transition: background-color 0.3s ease;
        }
        .report-header:hover {
            background-color: #d9e8ff;
        }

        h2 {
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 0;
        }

        a.btn-primary {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        a.btn-primary:hover {
            background-color: #0b5ed7;
            text-decoration: none;
        }

        /* Responsive tweaks for smaller devices */
        @media (max-width: 576px) {
            .card {
                padding: 1rem;
            }
            .report-header {
                padding: 15px;
            }
            .table-responsive {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2>Report Results</h2>
                        <a href="reports.jsp" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i> Back to Reports
                        </a>
                    </div>

                    <div class="report-header">
                        <% 
                        String reportType = (String) request.getAttribute("reportType");
                        if (reportType != null) {
                            switch(reportType) {
                                case "dateRange":
                        %>
                            <h4><i class="fas fa-calendar-alt me-2"></i>Date Range Report</h4>
                            <p class="mb-0">Showing patients admitted between the selected dates</p>
                        <%
                                    break;
                                case "ailment":
                        %>
                            <h4><i class="fas fa-heartbeat me-2"></i>Ailment Report</h4>
                            <p class="mb-0">Showing patients with the specified ailment/condition</p>
                        <%
                                    break;
                                case "doctor":
                        %>
                            <h4><i class="fas fa-user-md me-2"></i>Doctor Report</h4>
                            <p class="mb-0">Showing patients assigned to the specified doctor</p>
                        <%
                                    break;
                            }
                        }
                        %>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Age</th>
                                    <th>Gender</th>
                                    <th>Admission Date</th>
                                    <th>Ailment</th>
                                    <th>Doctor</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                                if (patients != null && !patients.isEmpty()) {
                                    for (Patient patient : patients) { 
                                %>
                                    <tr>
                                        <td><%= patient.getPatientID() %></td>
                                        <td><%= patient.getPatientName() %></td>
                                        <td><%= patient.getAge() %></td>
                                        <td><%= patient.getGender() %></td>
                                        <td><%= patient.getAdmissionDate() %></td>
                                        <td><%= patient.getAilment() %></td>
                                        <td><%= patient.getAssignedDoctor() %></td>
                                    </tr>
                                <% 
                                    }
                                } else { 
                                %>
                                    <tr>
                                        <td colspan="7" class="text-center fw-semibold text-muted">No patient records found matching the criteria</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
