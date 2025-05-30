## This project is a Hospital Patient Management System developed using Advanced Java (JSP, JDBC) and MySQL. It enables the management of patient records, including adding, updating, deleting, viewing, and generating detailed reports based on specific filters.
___
📋 Prerequisites                                                
Before running this application, make sure you have the following installed:                                                
Java Development Kit (JDK) 8 or higher                                                
Apache Tomcat 9.0 or higher                                                
MySQL Server 5.7 or XAMP Server                                                
MySQL JDBC Driver (mysql-connector-java)                                                
IDE: Eclipse (J2EE), IntelliJ IDEA, or any Java IDE                                                
Web Browser: Chrome, Firefox, or Edge                                                
___
🗄️ Database Setup                                                
1. Create Database                                                
CREATE DATABASE IF NOT EXISTS hospitaldb;                                                
USE hospitaldb;                                                
2. Create Table                                                
CREATE TABLE Patients (                                  
PatientID INT PRIMARY KEY,                                  
PatientName VARCHAR(100),                                  
Age INT,                                  
Gender VARCHAR(10),                                  
AdmissionDate DATE,                                  
Ailment VARCHAR(255),                                  
AssignedDoctor VARCHAR(100)                                  
);                                  
___

🖼️ Screenshots                                                      

🏠 Home Page                                         

![Output](https://github.com/Sharath8i/Advanced-Java-Major-Project/blob/main/Outputs/Home.png)

➕ Add Patient Page                                                           

![Output](https://github.com/Sharath8i/Advanced-Java-Major-Project/blob/main/Outputs/AddPatient.png)

🪟 View Patients                       
![Output](https://github.com/Sharath8i/Advanced-Java-Major-Project/blob/main/Outputs/AddPatient.png)                       

❌ Delete p+Patient                                  
![Output](https://github.com/Sharath8i/Advanced-Java-Major-Project/blob/main/Outputs/DeletePatient.png)


🆕 Update Patient                           
![Output](https://github.com/Sharath8i/Advanced-Java-Major-Project/blob/main/Outputs/UpdatePatient.png)

📋 Reports                                      
![Output](https://github.com/Sharath8i/Advanced-Java-Major-Project/blob/main/Outputs/ReportResult.png)



MVC Architecture: Clear separation between Model, View, and Controller  

Database Integration: CRUD operations with MySQL                      

Web Development: JSP, Servlets, HTML, CSS, JavaScript                

Input Validation: Both client-side and server-side                                     

Report Generation: Dynamic data analysis and presentation         

Professional UI: Responsive design with Bootstrap              

