import ballerinax/health.fhir.r4.aubase410;
import ballerinax/health.fhir.r4;
import ballerina/http;
import ballerina/log;

isolated function getPatient(string id) returns aubase410:AUBasePatient|r4:FHIRError? {
    do {
        aubase410:AUBasePatient auPatient = {
            birthDate: "1989-04-29",
            extension: [
                {
                    url: "http://hl7.org.au/fhir/StructureDefinition/indigenous-status",
                    valueCoding: {
                        code: "4",
                        display: "Neither Aboriginal nor Torres Strait Islander origin",
                        system: "https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1"
                    }
                },
                {
                    url: "http://hl7.org.au/fhir/StructureDefinition/closing-the-gap-registration",
                    valueBoolean: true
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName",
                    valueString: "Jane"
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-birthPlace",
                    valueAddress: {
                        city: "Melbourne",
                        country: "Australia",
                        district: "Melbourne",
                        line: [
                            "123 Fake Street"
                        ],
                        postalCode: "3000",
                        state: "VIC",
                        text: "123 Fake Street, Melbourne, VIC 3000",
                        'type: "both"
                    }
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired",
                    valueBoolean: true
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-genderIdentity",
                    valueCodeableConcept: {
                        coding: [
                            {
                                "system": " https://healthterminologies.gov.au/fhir/ValueSet/gender-identity-response-1",
                                "code": "446151000124109",
                                "display": "male"
                            }
                        ]
                    }
                }
            ],
            address: [
                {
                    city: "Melbourne",
                    country: "Australia",
                    district: "Melbourne",
                    line: [
                        "123 Fake Street"
                    ],
                    postalCode: "3000",
                    state: "VIC",
                    text: "123 Fake Street, Melbourne, VIC 3000",
                    'type: "both"
                }
            ],
            identifier: [
                {
                    system: "http://ns.electronichealth.net.au/id/medicare-number",
                    value: "32788511952",
                    'type: {
                        coding: [
                            {
                                system: "http://terminology.hl7.org/CodeSystem/v2-0203",
                                code: "MC",
                                display: "Patient's Medicare Number"
                            }
                        ]
                    }
                }
            ]

        };
        return auPatient;

    } on fail var e {
        r4:FHIRError fhirError = r4:createFHIRError(e.toString(), r4:CODE_SEVERITY_FATAL, r4:CODE_TYPE_INFORMATIONAL,
        httpStatusCode = http:STATUS_NOT_FOUND);
        return fhirError;
    }
}

isolated function getAllPatients() returns r4:Bundle|r4:FHIRError?|error {
    do {
        r4:BundleEntry[] entries = [];

        aubase410:AUBasePatient auPatient1 = {
            birthDate: "1989-04-29",
            extension: [
                {
                    url: "http://hl7.org.au/fhir/StructureDefinition/indigenous-status",
                    valueCoding: {
                        code: "4",
                        display: "Neither Aboriginal nor Torres Strait Islander origin",
                        system: "https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1"
                    }
                },
                {
                    url: "http://hl7.org.au/fhir/StructureDefinition/closing-the-gap-registration",
                    valueBoolean: true
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName",
                    valueString: "Jane"
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-birthPlace",
                    valueAddress: {
                        city: "Melbourne",
                        country: "Australia",
                        district: "Melbourne",
                        line: [
                            "123 Fake Street"
                        ],
                        postalCode: "3000",
                        state: "VIC",
                        text: "123 Fake Street, Melbourne, VIC 3000",
                        'type: "both"
                    }
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired",
                    valueBoolean: true
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-genderIdentity",
                    valueCodeableConcept: {
                        coding: [
                            {
                                "system": " https://healthterminologies.gov.au/fhir/ValueSet/gender-identity-response-1",
                                "code": "446151000124109",
                                "display": "male"
                            }
                        ]
                    }
                }
            ]

        };

        aubase410:AUBasePatient auPatient2 = {
            birthDate: "1989-05-29",
            extension: [
                {
                    url: "http://hl7.org.au/fhir/StructureDefinition/indigenous-status",
                    valueCoding: {
                        code: "4",
                        display: "Neither Aboriginal nor Torres Strait Islander origin",
                        system: "https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1"
                    }
                },
                {
                    url: "http://hl7.org.au/fhir/StructureDefinition/closing-the-gap-registration",
                    valueBoolean: true
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName",
                    valueString: "Heaven"
                },
                {
                    url: "http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired",
                    valueBoolean: false
                }
            ]

        };

        entries.push({
            'resource: auPatient1
        });
        entries.push({
            'resource: auPatient2
        });

        r4:Bundle bundle = {
            'type: r4:BUNDLE_TYPE_SEARCHSET,
            entry: entries
        };

        log:printInfo(bundle.toString());
        return bundle;

    } on fail error parseError {
        log:printError(string `Error occurred while parsing : ${parseError.message()}`, parseError);
    }

    return;
}
