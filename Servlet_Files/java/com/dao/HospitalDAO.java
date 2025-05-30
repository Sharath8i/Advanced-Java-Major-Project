package com.dao;

import com.model.Patient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class HospitalDAO {
    private static final Logger logger = Logger.getLogger(HospitalDAO.class.getName());
    
    // Use DataSource/JNDI for production (recommended)
    private DataSource dataSource;
    
    // Fallback to DriverManager (for development/testing only)
    private String jdbcURL = "jdbc:mysql://localhost:3306/HospitalDB?useSSL=false&serverTimezone=UTC";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // SQL Queries
    private static final String INSERT_PATIENT_SQL = "INSERT INTO Patients (PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_PATIENT_BY_ID = "SELECT * FROM Patients WHERE PatientID=?";
    private static final String SELECT_ALL_PATIENTS = "SELECT * FROM Patients";
    private static final String DELETE_PATIENT_SQL = "DELETE FROM Patients WHERE PatientID=?";
    private static final String UPDATE_PATIENT_SQL = "UPDATE Patients SET PatientName=?, Age=?, Gender=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?";
    private static final String SELECT_PATIENTS_BY_DATE_RANGE = "SELECT * FROM Patients WHERE AdmissionDate BETWEEN ? AND ?";
    private static final String SELECT_PATIENTS_BY_AILMENT = "SELECT * FROM Patients WHERE Ailment LIKE ?";
    private static final String SELECT_PATIENTS_BY_DOCTOR = "SELECT * FROM Patients WHERE AssignedDoctor=?";

    public HospitalDAO() {
        try {
            // Try to get DataSource via JNDI first
            Context ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/hospitalDB");
        } catch (NamingException e) {
            logger.log(Level.WARNING, "JNDI lookup failed, falling back to DriverManager", e);
        }
    }

    protected Connection getConnection() throws SQLException {
        // Try DataSource first
        if (dataSource != null) {
            return dataSource.getConnection();
        }
        
        // Fallback to DriverManager
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    // CRUD Operations
    public void insertPatient(Patient patient) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PATIENT_SQL, Statement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setString(1, patient.getPatientName());
            preparedStatement.setInt(2, patient.getAge());
            preparedStatement.setString(3, patient.getGender());
            preparedStatement.setDate(4, new java.sql.Date(patient.getAdmissionDate().getTime()));
            preparedStatement.setString(5, patient.getAilment());
            preparedStatement.setString(6, patient.getAssignedDoctor());
            
            int affectedRows = preparedStatement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating patient failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    patient.setPatientID(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating patient failed, no ID obtained.");
                }
            }
        }
    }

    public Patient selectPatient(int id) throws SQLException {
        Patient patient = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PATIENT_BY_ID)) {
            
            preparedStatement.setInt(1, id);
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    patient = mapPatientFromResultSet(rs);
                }
            }
        }
        return patient;
    }

    public List<Patient> selectAllPatients() throws SQLException {
        List<Patient> patients = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PATIENTS);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                patients.add(mapPatientFromResultSet(rs));
            }
        }
        return patients;
    }

    public boolean deletePatient(int id) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_PATIENT_SQL)) {
            
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    public boolean updatePatient(Patient patient) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_PATIENT_SQL)) {
            
            statement.setString(1, patient.getPatientName());
            statement.setInt(2, patient.getAge());
            statement.setString(3, patient.getGender());
            statement.setDate(4, new java.sql.Date(patient.getAdmissionDate().getTime()));
            statement.setString(5, patient.getAilment());
            statement.setString(6, patient.getAssignedDoctor());
            statement.setInt(7, patient.getPatientID());
            
            return statement.executeUpdate() > 0;
        }
    }

    // Report Methods
    public List<Patient> selectPatientsByDateRange(Date startDate, Date endDate) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PATIENTS_BY_DATE_RANGE)) {
            
            preparedStatement.setDate(1, new java.sql.Date(startDate.getTime()));
            preparedStatement.setDate(2, new java.sql.Date(endDate.getTime()));
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    patients.add(mapPatientFromResultSet(rs));
                }
            }
        }
        return patients;
    }

    public List<Patient> selectPatientsByAilment(String ailment) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PATIENTS_BY_AILMENT)) {
            
            preparedStatement.setString(1, "%" + ailment + "%");
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    patients.add(mapPatientFromResultSet(rs));
                }
            }
        }
        return patients;
    }

    public List<Patient> selectPatientsByDoctor(String doctorName) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PATIENTS_BY_DOCTOR)) {
            
            preparedStatement.setString(1, doctorName);
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    patients.add(mapPatientFromResultSet(rs));
                }
            }
        }
        return patients;
    }

    // Helper method to map ResultSet to Patient object
    private Patient mapPatientFromResultSet(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setPatientID(rs.getInt("PatientID"));
        patient.setPatientName(rs.getString("PatientName"));
        patient.setAge(rs.getInt("Age"));
        patient.setGender(rs.getString("Gender"));
        patient.setAdmissionDate(rs.getDate("AdmissionDate"));
        patient.setAilment(rs.getString("Ailment"));
        patient.setAssignedDoctor(rs.getString("AssignedDoctor"));
        return patient;
    }
}
