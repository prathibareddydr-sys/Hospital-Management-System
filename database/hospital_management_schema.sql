-- ============================================================
-- Hospital Management System - Database Schema
-- 12 Comprehensive Tables for Complete Hospital Management
-- ============================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;

-- ============================================================
-- TABLE 1: USERS (Authentication & User Management)
-- ============================================================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    role ENUM('admin', 'doctor', 'receptionist', 'patient') DEFAULT 'patient',
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login DATETIME,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 2: DEPARTMENTS (Medical Departments)
-- ============================================================
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    head_of_department VARCHAR(100),
    contact_number VARCHAR(15),
    location VARCHAR(100),
    total_beds INT DEFAULT 0,
    available_beds INT DEFAULT 0,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_department_name (department_name),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 3: DOCTORS (Doctor Management)
-- ============================================================
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    department_id INT NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    qualification VARCHAR(200),
    license_number VARCHAR(50) UNIQUE,
    years_of_experience INT,
    consultation_fee DECIMAL(10, 2) DEFAULT 500.00,
    availability_status ENUM('available', 'busy', 'on_leave') DEFAULT 'available',
    profile_image LONGBLOB,
    bio TEXT,
    status ENUM('active', 'inactive', 'retired') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_specialization (specialization),
    INDEX idx_availability (availability_status),
    INDEX idx_department (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 4: PATIENTS (Patient Information)
-- ============================================================
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    blood_group VARCHAR(5),
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10),
    country VARCHAR(50) DEFAULT 'India',
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    emergency_contact_relation VARCHAR(50),
    allergies TEXT,
    chronic_diseases TEXT,
    insurance_provider VARCHAR(100),
    insurance_policy_number VARCHAR(50),
    patient_status ENUM('active', 'inactive', 'discharged') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_patient_name (first_name, last_name),
    INDEX idx_email (email),
    INDEX idx_phone (phone),
    INDEX idx_dob (date_of_birth)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 5: MEDICAL HISTORY (Patient Medical History)
-- ============================================================
CREATE TABLE medical_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT,
    visit_date DATE NOT NULL,
    diagnosis TEXT,
    symptoms TEXT,
    treatment_given TEXT,
    medication_prescribed TEXT,
    lab_tests_ordered TEXT,
    follow_up_date DATE,
    visit_type ENUM('consultation', 'follow_up', 'emergency', 'routine_checkup') DEFAULT 'consultation',
    visit_notes TEXT,
    vital_signs JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    INDEX idx_patient_id (patient_id),
    INDEX idx_visit_date (visit_date),
    INDEX idx_doctor_id (doctor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 6: APPOINTMENTS (Appointment Management)
-- ============================================================
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_type ENUM('consultation', 'follow_up', 'surgery', 'emergency') DEFAULT 'consultation',
    status ENUM('scheduled', 'completed', 'cancelled', 'no_show', 'rescheduled') DEFAULT 'scheduled',
    reason_for_visit VARCHAR(255),
    notes TEXT,
    consultation_fee DECIMAL(10, 2),
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_appointment_date (appointment_date),
    INDEX idx_status (status),
    INDEX idx_patient_doctor (patient_id, doctor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 7: MEDICINES (Medicine Inventory)
-- ============================================================
CREATE TABLE medicines (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(100) NOT NULL UNIQUE,
    generic_name VARCHAR(100),
    manufacturer VARCHAR(100),
    strength VARCHAR(50),
    unit_type VARCHAR(20),
    quantity_in_stock INT DEFAULT 0,
    reorder_level INT DEFAULT 50,
    unit_price DECIMAL(10, 2),
    expiry_date DATE,
    batch_number VARCHAR(50),
    storage_location VARCHAR(50),
    medicine_type ENUM('tablet', 'syrup', 'injection', 'powder', 'ointment', 'drops') DEFAULT 'tablet',
    status ENUM('available', 'out_of_stock', 'discontinued') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_medicine_name (medicine_name),
    INDEX idx_stock (quantity_in_stock),
    INDEX idx_expiry (expiry_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 8: PRESCRIPTIONS (Doctor Prescriptions)
-- ============================================================
CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT,
    medicine_id INT NOT NULL,
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    duration_days INT,
    special_instructions TEXT,
    prescription_date DATE NOT NULL,
    expiry_date DATE,
    status ENUM('active', 'completed', 'cancelled') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id),
    INDEX idx_patient_id (patient_id),
    INDEX idx_prescription_date (prescription_date),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 9: LAB TESTS (Laboratory Tests)
-- ============================================================
CREATE TABLE lab_tests (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT,
    test_name VARCHAR(100) NOT NULL,
    test_type VARCHAR(50),
    test_date DATE NOT NULL,
    sample_type VARCHAR(50),
    status ENUM('ordered', 'sample_collected', 'processing', 'completed', 'cancelled') DEFAULT 'ordered',
    test_result TEXT,
    reference_value VARCHAR(100),
    units VARCHAR(50),
    normal_range VARCHAR(100),
    test_cost DECIMAL(10, 2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    INDEX idx_patient_id (patient_id),
    INDEX idx_test_date (test_date),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 10: BILLING (Billing & Charges)
-- ============================================================
CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_id INT,
    bill_date DATE NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL DEFAULT 0,
    consultation_charges DECIMAL(10, 2) DEFAULT 0,
    medicine_charges DECIMAL(10, 2) DEFAULT 0,
    lab_test_charges DECIMAL(10, 2) DEFAULT 0,
    other_charges DECIMAL(10, 2) DEFAULT 0,
    discount_percentage DECIMAL(5, 2) DEFAULT 0,
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    net_amount DECIMAL(12, 2),
    bill_description TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    INDEX idx_patient_id (patient_id),
    INDEX idx_bill_date (bill_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 11: PAYMENTS (Payment Records)
-- ============================================================
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    patient_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_time TIME,
    amount_paid DECIMAL(12, 2) NOT NULL,
    payment_method ENUM('cash', 'credit_card', 'debit_card', 'net_banking', 'upi', 'insurance') DEFAULT 'cash',
    transaction_id VARCHAR(100),
    payment_status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    reference_number VARCHAR(100),
    payment_gateway VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES billing(bill_id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    INDEX idx_bill_id (bill_id),
    INDEX idx_payment_date (payment_date),
    INDEX idx_payment_status (payment_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLE 12: HOSPITAL_STAFF (Staff Management)
-- ============================================================
CREATE TABLE hospital_staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    staff_type ENUM('nurse', 'receptionist', 'pharmacist', 'lab_technician', 'administrative') DEFAULT 'administrative',
    department_id INT,
    designation VARCHAR(100),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2),
    shift ENUM('morning', 'afternoon', 'night', 'flexible') DEFAULT 'morning',
    address VARCHAR(255),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    status ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_staff_type (staff_type),
    INDEX idx_department_id (department_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- INSERT DEFAULT DATA
-- ============================================================

-- Insert Admin User
INSERT INTO users (username, email, password, phone, role, status) VALUES 
('admin', 'admin@hospital.com', '$2a$10$slYQmyNdGzin7olVN3p5be4DlH.PKZbv5H8KnzzVgXXbVxzy.', '9876543210', 'admin', 'active');

-- Insert Receptionist User
INSERT INTO users (username, email, password, phone, role, status) VALUES 
('receptionist', 'receptionist@hospital.com', '$2a$10$slYQmyNdGzin7olVN3p5be4DlH.PKZbv5H8KnzzVgXXbVxzy.', '9876543211', 'receptionist', 'active');

-- Insert Departments
INSERT INTO departments (department_name, description, head_of_department, contact_number, location, total_beds, available_beds) VALUES
('Cardiology', 'Heart and Cardiovascular Diseases', 'Dr. Ramesh Kumar', '9876543210', 'Building A, Floor 2', 20, 15),
('Neurology', 'Brain and Nervous System Disorders', 'Dr. Priya Sharma', '9876543211', 'Building B, Floor 3', 15, 10),
('Orthopedics', 'Bone and Joint Disorders', 'Dr. Arun Singh', '9876543212', 'Building C, Floor 1', 25, 18),
('Pediatrics', 'Children Health and Diseases', 'Dr. Sneha Patel', '9876543213', 'Building A, Floor 1', 30, 22),
('General Medicine', 'General Medical Care', 'Dr. Vikram Desai', '9876543214', 'Building D, Floor 2', 40, 30),
('Surgery', 'Surgical Procedures', 'Dr. Harish Kumar', '9876543215', 'Building B, Floor 4', 10, 7),
('Radiology', 'Imaging and Diagnostic', 'Dr. Neha Gupta', '9876543216', 'Building C, Floor 2', 0, 0),
('Psychiatry', 'Mental Health Services', 'Dr. Rajesh Verma', '9876543217', 'Building D, Floor 3', 12, 9);

-- Insert Sample Medicines
INSERT INTO medicines (medicine_name, generic_name, manufacturer, strength, unit_type, quantity_in_stock, unit_price, expiry_date, medicine_type) VALUES
('Aspirin', 'Acetylsalicylic Acid', 'Cipla Ltd', '500mg', 'tablet', 500, 15.00, '2025-12-31', 'tablet'),
('Paracetamol', 'Acetaminophen', 'GSK', '650mg', 'tablet', 800, 12.00, '2025-11-30', 'tablet'),
('Amoxicillin', 'Amoxicillin Trihydrate', 'Merck', '500mg', 'tablet', 300, 45.00, '2025-10-31', 'tablet'),
('Insulin', 'Insulin Injection', 'Novo Nordisk', '100IU/ml', 'injection', 200, 250.00, '2026-01-31', 'injection'),
('Cough Syrup', 'Dextromethorphan', 'Ayush', '10mg/5ml', 'syrup', 150, 80.00, '2025-09-30', 'syrup');

-- Create Indexes for Performance
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_departments_status ON departments(status);
CREATE INDEX idx_doctors_status ON doctors(status);
CREATE INDEX idx_patients_status ON patients(patient_status);
CREATE INDEX idx_appointments_doctor_date ON appointments(doctor_id, appointment_date);
CREATE INDEX idx_billing_status ON billing(bill_id);
CREATE INDEX idx_payments_status ON payments(payment_status);

-- ============================================================
-- END OF DATABASE SCHEMA
-- ============================================================

-- To verify the schema, run these queries:
-- SHOW TABLES;
-- DESCRIBE users;
-- DESCRIBE patients;
-- SELECT * FROM departments;
