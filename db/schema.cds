using { 
    cuid, 
    managed, 
    temporal
} from '@sap/cds/common';

namespace healthcare;

type Gender : String(15) enum {
    Male;
    Female;
    Other;
    NotSpecified;
}

type AppointmentStatus : String(20) enum {
    Pending;
    Confirmed;
    Completed;
    Cancelled;
    Rescheduled;
}

type ConsultationType : String(20) enum {
    InPerson;
    Telehealth;
    Emergency;
}

type TestStatus : String(20) enum {
    Normal;
    Abnormal;
    Pending;
    Urgent;
}


entity Patient : cuid, managed {
    firstName           : String(50);
    lastName            : String(50);
    dateOfBirth         : Date;
    gender              : Gender;
    email               : String(100);
    phone               : String(20);
    address             : String(255);
    insuranceProvider   : String(10); //Association to one InsuranceProvider;
    appointments        : Association to many Appointment on appointments.patient = $self;
    medicalRecords      : Association to many MedicalRecord on medicalRecords.patient = $self;
    prescriptions       : Association to many Prescription on prescriptions.patient = $self;
    testResults         : Association to many TestResult on testResults.patient = $self;
}

entity HealthcareProvider : cuid, managed {
    name              : String(100);
    email             : String(100);
    phone             : String(20);
    licenseNumber     : String(50);
    appointments      : Association to many Appointment on appointments.provider = $self;
    medicalRecords    : Association to many MedicalRecord on medicalRecords.provider = $self;
}

entity Appointment : cuid, managed {
    patient                 : Association to Patient;
    provider                : Association to HealthcareProvider;
    scheduledDateTime       : DateTime;
    duration                : Integer; // minutes
    status                  : AppointmentStatus;
    consultationType        : ConsultationType;
    notes                   : String(500);
}

entity MedicalRecord : cuid, managed, temporal {
    patient            : Association to Patient;
    provider           : Association to HealthcareProvider;
    recordDate         : DateTime;
    diagnosis          : String(255);
    treatmentPlan      : String(500);
    additionalNotes    : String(1000);
    prescriptions      : Association to many Prescription on prescriptions.medicalRecord = $self;
    testResults        : Association to many TestResult on testResults.medicalRecord = $self;
}

entity Prescription : cuid, managed {
    patient            : Association to Patient;
    provider           : Association to HealthcareProvider;
    medicalRecord      : Association to MedicalRecord;
    medicationName     : String(100);
    dosage             : String(50);
    frequency          : String(100);
    startDate          : Date;
    endDate            : Date;
    instructions       : String(500);
}

entity TestResult : cuid, managed {
    testType           : String(100);
    testDate           : DateTime;
    result             : String(500);
    referenceRange     : String(200);
    status             : TestStatus;
    attachmentUrl      : String(255);
    patient            : Association to Patient;
    provider           : Association to HealthcareProvider;
    medicalRecord      : Association to MedicalRecord;
}

entity InsuranceProvider : cuid, managed {
    name                : String(100);
    address             : String(200);
    contactNumber       : String(20);
    email               : String(100);
    active              : Boolean;
    //patients            : Association to many Patient on patients.insuranceProvider = $self;
}

