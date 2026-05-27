# Hospital Management System

A comprehensive Hospital Management System built with HTML, CSS, JavaScript, Java (Spring Boot), and MySQL.

## Features

✅ User Authentication (Login/Registration)
✅ Admin Dashboard with Analytics
✅ Patient Registration & Management
✅ Doctor Management
✅ Appointment Booking System
✅ Billing Module
✅ Patient Records Search
✅ Update/Delete Records
✅ Responsive User Interface
✅ MySQL Database Integration
✅ 12 Database Tables
✅ Real-time Data Management

## Tech Stack

- **Frontend:** HTML5, CSS3, JavaScript (ES6+)
- **Backend:** Java Spring Boot
- **Database:** MySQL
- **Architecture:** MVC (Model-View-Controller)

## System Requirements

- Java JDK 8+
- MySQL 5.7+
- Apache Tomcat 8+
- Maven 3.6+
- Modern Web Browser

## Installation & Setup

### Step 1: Database Setup

1. Open MySQL Command Line
2. Run the SQL script to create database and tables
3. Update database credentials in application.properties

### Step 2: Backend Setup

1. Extract project files
2. Open in IDE (IntelliJ IDEA, Eclipse, or VS Code)
3. Configure MySQL credentials in `application.properties`
4. Run Maven build: `mvn clean install`
5. Start Spring Boot application: `mvn spring-boot:run`

### Step 3: Frontend Setup

1. Place HTML, CSS, and JS files in `src/main/resources/static/`
2. Access application at `http://localhost:8080`

## Database Tables (12 Tables)

1. **users** - User authentication
2. **patients** - Patient information
3. **doctors** - Doctor details
4. **departments** - Medical departments
5. **appointments** - Appointment records
6. **medical_history** - Patient medical history
7. **prescriptions** - Doctor prescriptions
8. **billing** - Payment records
9. **payments** - Payment details
10. **medicines** - Medicine inventory
11. **lab_tests** - Laboratory test records
12. **hospital_staff** - Staff management

## Default Login Credentials

Username: `admin`
Password: `admin123`

## Project Structure

```
hospital-management-system/
├── src/
│   ├── main/
│   │   ├── java/com/hospital/
│   │   │   ├── controller/
│   │   │   ├── service/
│   │   │   ├── repository/
│   │   │   ├── entity/
│   │   │   └── HospitalManagementApplication.java
│   │   └── resources/
│   │       ├── static/
│   │       │   ├── css/
│   │       │   ├── js/
│   │       │   └── html/
│   │       └── application.properties
│   └── test/
├── pom.xml
└── README.md
```

## API Endpoints

- **Auth:** `/api/auth/login`, `/api/auth/register`
- **Patients:** `/api/patients/`, `/api/patients/{id}`, `/api/patients/search/{name}`
- **Doctors:** `/api/doctors/`, `/api/doctors/{id}`
- **Appointments:** `/api/appointments/`, `/api/appointments/{id}`
- **Billing:** `/api/billing/`, `/api/billing/{id}`

## Features Description

### 1. Authentication Module
- User login with role-based access
- Password hashing with BCrypt
- Session management

### 2. Admin Dashboard
- Real-time statistics
- Patient and doctor overview
- Appointment management
- Revenue tracking

### 3. Patient Module
- Register new patients
- Update patient information
- View patient history
- Search patient records

### 4. Doctor Module
- Manage doctor profiles
- Assign departments
- View availability
- Update specialization

### 5. Appointment System
- Book appointments online
- View appointment status
- Cancel appointments
- Appointment reminders

### 6. Billing Module
- Generate invoices
- Track payments
- Payment history
- Bill management

## Support

For issues or questions, please contact: support@hospital.com

## License

This project is licensed under the MIT License.
