package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdatePatientServlet")
public class UpdatePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int patientID = Integer.parseInt(request.getParameter("patientID"));
            String patientName = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            Date admissionDate = Date.valueOf(request.getParameter("admissionDate"));
            String ailment = request.getParameter("ailment");
            String assignedDoctor = request.getParameter("assignedDoctor");

            Patient patient = new Patient();
            patient.setPatientID(patientID);
            patient.setPatientName(patientName);
            patient.setAge(age);
            patient.setGender(gender);
            patient.setAdmissionDate(admissionDate);
            patient.setAilment(ailment);
            patient.setAssignedDoctor(assignedDoctor);

            hospitalDAO.updatePatient(patient);
            response.sendRedirect("patientdisplay.jsp?success=Patient updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("patientupdate.jsp?error=Error updating patient: " + e.getMessage());
        }
    }
}
