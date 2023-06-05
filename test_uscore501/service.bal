import ballerina/http;
import ballerinax/health.fhir.r4.uscore501;
import ballerinax/health.fhir.r4;

service /patients on new http:Listener(9097) {
    isolated resource function get [string id]() returns uscore501:USCorePatientProfile|r4:FHIRError? {
        return getPatient(id);
    }

    isolated resource function post .(@http:Payload json patient) returns uscore501:USCorePatientProfile|r4:FHIRError? {
        return addPatient(patient);
    }

    isolated resource function get getAll() returns r4:Bundle|r4:FHIRError?|error {
        return check getAllPatients();
    }

}
