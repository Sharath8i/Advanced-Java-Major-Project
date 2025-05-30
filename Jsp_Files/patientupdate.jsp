<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.HospitalDAO, com.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Update Patient</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        /* Reset and base */
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .card {
            max-width: 720px;
            width: 100%;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
            padding: 2rem;
            background: #fff;
            transition: box-shadow 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.18);
        }

        h2 {
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: #0d6efd;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
            color: #212529;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 1.5px solid #ced4da;
            padding: 0.75rem 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px rgba(13, 110, 253, 0.3);
            outline: none;
        }

        .input-group > .form-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .input-group > .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            padding: 0.75rem 1.5rem;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }

        .btn-secondary {
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #6c757d;
            color: #fff;
        }

        .alert {
            font-weight: 600;
        }

        /* Responsive tweaks */
        @media (max-width: 576px) {
            .card {
                padding: 1.5rem 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Update Patient Information</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% 
        String id = request.getParameter("id");
        if (id == null) { 
        %>
            <form method="get" action="" class="mb-4">
                <div class="input-group">
                    <input type="number" class="form-control" name="id" placeholder="Enter Patient ID" required />
                    <button class="btn btn-primary" type="submit">Search</button>
                </div>
            </form>
        <% 
        } else {
            HospitalDAO hospitalDAO = new HospitalDAO();
            Patient patient = hospitalDAO.selectPatient(Integer.parseInt(id));
            if (patient != null) { 
        %>
                <form action="UpdatePatientServlet" method="post" novalidate>
                    <input type="hidden" name="patientID" value="<%= patient.getPatientID() %>" />
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="patientName" class="form-label">Patient Name</label>
                            <input type="text" class="form-control" id="patientName" name="patientName" 
                                   value="<%= patient.getPatientName() %>" required />
                        </div>
                        <div class="col-md-6">
                            <label for="age" class="form-label">Age</label>
                            <input type="number" class="form-control" id="age" name="age" 
                                   value="<%= patient.getAge() %>" min="0" max="120" required />
                        </div>
                        <div class="col-md-6">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="Male" <%= patient.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= patient.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= patient.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="admissionDate" class="form-label">Admission Date</label>
                            <input type="date" class="form-control" id="admissionDate" name="admissionDate" 
                                   value="<%= new java.sql.Date(patient.getAdmissionDate().getTime()) %>" required />
                        </div>
                        <div class="col-12">
                            <label for="ailment" class="form-label">Ailment/Condition</label>
                            <input type="text" class="form-control" id="ailment" name="ailment" 
                                   value="<%= patient.getAilment() %>" required />
                        </div>
                        <div class="col-12">
                            <label for="assignedDoctor" class="form-label">Assigned Doctor</label>
                            <input type="text" class="form-control" id="assignedDoctor" name="assignedDoctor" 
                                   value="<%= patient.getAssignedDoctor() %>" required />
                        </div>
                        <div class="col-12 mt-4 d-flex justify-content-end gap-2">
                            <a href="patientupdate.jsp" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update Patient</button>
                        </div>
                    </div>
                </form>
        <% 
            } else { 
        %>
                <div class="alert alert-warning">No patient found with ID: <%= id %></div>
                <a href="patientupdate.jsp" class="btn btn-primary">Try Again</a>
        <% 
            } 
        } 
        %>
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
