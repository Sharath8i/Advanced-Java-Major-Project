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

@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HospitalDAO hospitalDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        hospitalDAO = new HospitalDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set encoding to handle UTF-8 form data if needed
        request.setCharacterEncoding("UTF-8");

        try {
            String patientName = request.getParameter("patientName");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            Date admissionDate = Date.valueOf(request.getParameter("admissionDate"));
            String ailment = request.getParameter("ailment");
            String assignedDoctor = request.getParameter("assignedDoctor");

            Patient newPatient = new Patient();
            newPatient.setPatientName(patientName);
            newPatient.setAge(age);
            newPatient.setGender(gender);
            newPatient.setAdmissionDate(admissionDate);
            newPatient.setAilment(ailment);
            newPatient.setAssignedDoctor(assignedDoctor);

            hospitalDAO.insertPatient(newPatient);

            // Redirect after successful insert (avoid form resubmission on refresh)
            response.sendRedirect(request.getContextPath() + "/patientdisplay.jsp?success=Patient added successfully");
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to add form with error message
            response.sendRedirect(request.getContextPath() + "/patientadd.jsp?error=Error adding patient: " + e.getMessage());
        }
    }
}
