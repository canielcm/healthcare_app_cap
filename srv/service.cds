using { 
    healthcare.Patient, 
    healthcare.HealthcareProvider, 
    healthcare.Appointment,
    healthcare.MedicalRecord,
    healthcare.Prescription,
    healthcare.TestResult,
    healthcare.InsuranceProvider
} from '../db/schema';

service HealthcareService {
    entity Patients as projection on Patient;
    entity HealthcareProviders as projection on HealthcareProvider;
    entity Appointments as projection on Appointment;
    entity MedicalRecords as projection on MedicalRecord;
    entity Prescriptions as projection on Prescription;
    entity TestResults as projection on TestResult;
    entity InsuranceProviders as projection on InsuranceProvider;
}