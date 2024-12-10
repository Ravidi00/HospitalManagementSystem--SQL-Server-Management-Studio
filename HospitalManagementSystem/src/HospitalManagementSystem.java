
import com.sun.jdi.connect.spi.Connection;
import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */

/**
 *
 * @author Dell
 */
import java.sql.*;


public class HospitalManagementSystem {

    // JDBC URL, username, and password
    static final String DB_URL = "jdbc:sqlserver://DESKTOP-KUP1M35\\SQLEXPRESS;databaseName=HospitalManagementSystem_db;integratedSecurity=true";

    public static void main(String[] args) {
        Connection connection = null;
        CallableStatement cstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("Connecting to database...");
            connection = (Connection) DriverManager.getConnection(DB_URL);

            // Call the stored procedure GetAppointmentsForPatient
            System.out.println("Calling stored procedure GetAppointmentsForPatient...");
            cstmt = connection.prepareCall("{call GetAppointmentsForPatient(?)}");
            cstmt.setInt(1, 1); // Assuming patient ID is 1
            rs = cstmt.executeQuery();

            // Process the result set
            while (rs.next()) {
                int appointmentID = rs.getInt("Appointment_ID");
                String patientName = rs.getString("Patient_Name");
                String doctorName = rs.getString("Doctor_Name");
                Date date = rs.getDate("Date");
                Time time = rs.getTime("Time");

                // Output the appointment details
                System.out.println("Appointment ID: " + appointmentID);
                System.out.println("Patient Name: " + patientName);
                System.out.println("Doctor Name: " + doctorName);
                System.out.println("Date: " + date);
                System.out.println("Time: " + time);
            }

            // Call the function GetTotalAppointmentsForDoctor
            System.out.println("Calling function GetTotalAppointmentsForDoctor...");
            cstmt = connection.prepareCall("{? = call GetTotalAppointmentsForDoctor(?)}");
            cstmt.registerOutParameter(1, Types.INTEGER);
            cstmt.setInt(2, 1); // Assuming doctor ID is 1
            cstmt.execute();

            // Retrieve the result of the function
            int totalAppointments = cstmt.getInt(1);
            System.out.println("Total Appointments for Doctor: " + totalAppointments);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (cstmt != null) cstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

