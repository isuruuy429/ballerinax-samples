import ballerina/http;
import ballerinax/health.fhir.r4utils as utils;

# A service representing a network-accessible API for the fhirpath evaluation.
# bound to port `9090`.
service /fhir on new http:Listener(9090) {

    # API to evaluate Fhirpath expressions.
    #
    # + fhirPathRequest - Request for the API
    # + return - Result Map of Fhirpath evaluations
    resource function post fhirpath (@http:Payload FhirPathRequest fhirPathRequest) returns error|map<utils:FhirPathResult> {
        map<utils:FhirPathResult> outcome = {};
        map<json> fhirResource = fhirPathRequest.fhirResource;
        string[]|string fhirPath = fhirPathRequest.fhirPath;

        if fhirPath is string[] {
            foreach int i in 0 ..< fhirPath.length() {
                string individualFhirPath = check fhirPath[i].cloneWithType();
                outcome[individualFhirPath] = utils:getFhirPathResult(fhirResource, individualFhirPath);
            }

        } else {
            outcome[fhirPath] = utils:getFhirPathResult(fhirResource, fhirPath);
        }
        return outcome;
    }
}

# Record to hold FhirPath request parameters
#
# + fhirResource - Fhir Resource
# + fhirPath - FhirPath
public type FhirPathRequest record {|
    map<json> fhirResource;
    string[]|string fhirPath;
|};