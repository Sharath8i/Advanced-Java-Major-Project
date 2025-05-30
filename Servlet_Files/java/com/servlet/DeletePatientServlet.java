package com.servlet;

import com.dao.HospitalDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
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
        try {
            // Get patient ID from form
            int patientId = Integer.parseInt(request.getParameter("id"));
            
            // Delete patient using DAO
            boolean isDeleted = hospitalDAO.deletePatient(patientId);
            
            if (isDeleted) {
                // Redirect with success message
                response.sendRedirect("patientdelete.jsp?success=" + 
                    URLEncoder.encode("Patient deleted successfully", "UTF-8"));
            } else {
                // Redirect with error message if patient not found
                response.sendRedirect("patientdelete.jsp?error=" + 
                    URLEncoder.encode("Patient not found with ID: " + patientId, "UTF-8"));
            }
        } catch (NumberFormatException e) {
            // Handle invalid ID format
            response.sendRedirect("patientdelete.jsp?error=" + 
                URLEncoder.encode("Invalid Patient ID format", "UTF-8"));
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            response.sendRedirect("patientdelete.jsp?error=" + 
                URLEncoder.encode("Error deleting patient: " + e.getMessage(), "UTF-8"));
        }
    }
}
