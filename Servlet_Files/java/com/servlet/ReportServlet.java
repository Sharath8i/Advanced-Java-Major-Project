package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String reportType = request.getParameter("reportType");
            List<Patient> patients = null;

            switch (reportType) {
                case "dateRange":
                    Date startDate = Date.valueOf(request.getParameter("startDate"));
                    Date endDate = Date.valueOf(request.getParameter("endDate"));
                    patients = hospitalDAO.selectPatientsByDateRange(startDate, endDate);
                    break;
                case "ailment":
                    String ailment = request.getParameter("ailment");
                    patients = hospitalDAO.selectPatientsByAilment(ailment);
                    break;
                case "doctor":
                    String doctor = request.getParameter("doctor");
                    patients = hospitalDAO.selectPatientsByDoctor(doctor);
                    break;
            }

            request.setAttribute("patients", patients);
            request.setAttribute("reportType", reportType);
            request.getRequestDispatcher("report_result.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("reports.jsp?error=Error generating report: " + e.getMessage());
        }
    }
}
