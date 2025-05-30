<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Patient, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Patients</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #e3f2fd, #fce4ec);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
            background-color: #ffffff;
        }

        h2 {
            font-weight: 700;
            color: #0d6efd;
        }

        .btn-primary {
            border-radius: 30px;
            padding: 10px 20px;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.3);
        }

        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: linear-gradient(to right, #0d6efd, #5b9dff);
            color: white;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
        }

        .table tbody td {
            vertical-align: middle;
            text-align: center;
        }

        .table-striped > tbody > tr:nth-of-type(odd) {
            background-color: #f8f9fa;
        }

        .table-hover tbody tr:hover {
            background-color: #eef2ff;
        }

        .btn-action {
            padding: 6px 12px;
            margin: 0 3px;
            border-radius: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-warning {
            background-color: #ffc107;
            border: none;
            color: #212529;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            color: #fff;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #bd2130;
        }

        .alert {
            border-radius: 12px;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row">
        <div class="col-12">
            <div class="card p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Patient Records</h2>
                    <a href="index.jsp" class="btn btn-primary">
                        <i class="fas fa-home"></i> Home
                    </a>
                </div>

                <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= request.getParameter("success") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>

                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= request.getParameter("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Admission Date</th>
                            <th>Ailment</th>
                            <th>Doctor</th>
                            <th>Actions</th>
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
                            <td>
                                <a href="patientupdate.jsp?id=<%= patient.getPatientID() %>"
                                   class="btn btn-sm btn-warning btn-action" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <form action="DeletePatientServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="patientID" value="<%= patient.getPatientID() %>">
                                    <button type="submit" class="btn btn-sm btn-danger btn-action" title="Delete"
                                            onclick="return confirm('Are you sure you want to delete this patient?');">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center">No patient records found</td>
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
