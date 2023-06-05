import ballerinax/health.fhir.r4;
import ballerinax/health.fhirr4;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new fhirr4:Listener(9092, apiConfig) {

    // Read the current state of the resource
    resource function get fhir/r4/Patient/[string id](r4:FHIRContext fhirContext) returns r4:Patient|r4:FHIRError? {

        r4:Patient fhirPatient = {
            birthDate: "1989-04-29",
            id: "321444",
            active: false,
            gender: "male"
        };
        return fhirPatient;
    }
}
