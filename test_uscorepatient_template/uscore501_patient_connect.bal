// // Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).

// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//
// AUTO-GENERATED FILE.
//
// This file is auto-generated by Ballerina Team for implementing source system connections.
// Developers are allowed modify this file as per the requirement.

import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.uscore501;

public isolated class Uscore501PatientSourceConnect {

    *PatientSourceConnect;
    isolated function profile() returns r4:uri {
        return "http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient";
    }

    isolated function read(string id, r4:FHIRContext ctx) returns Patient|r4:FHIRError {

        //Implement source system connection here and retreive data.
        //Create FHIR resource from retreived data.
        uscore501:USCorePatientProfile example = {
            id: "12d39",
            meta: {
                versionId: "abc12s3",
                profile: ["http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient"]
            },
            identifier: [
                {
                    system: "urn:uuid:53fefa32-fcbb-4ff8-8a92-55ee120877b7",
                    value: "123e4567-e89b-12d3-a456-426655440000"
                },
                {
                    system: "urn:uuid:53fefa32-fcbb-4ff8-8a92-55ee120877b7",
                    value: "123e4567-e89b-12d3-a456-426655440003"
                }
            ],
            implicitRules: "https://www.hl7.org/fhir",
            language: "en-US",
            gender: "unknown", 
            name: [
                {
                    use: "maiden",
                    family: "Smith",
                    given: ["Jane","Iyer"],
                    period: {
                        'start: "2010-04-05T14:30:10+05:30",
                        end: "2010-04-05T14:30:10+05:30"
                    }
                }
            ]
            
        };
        return example;
    }

    isolated function search(map<r4:RequestSearchParameter[]> searchParameters, r4:FHIRContext ctx) returns r4:Bundle|Patient[]|r4:FHIRError {

        uscore501:USCorePatientProfile[] patients = [];

        //Implement source system connection here and retreive data.
        //Create FHIR resource from retreived data.
        uscore501:USCorePatientProfile example = {
            id: "12d39",
            meta: {
                versionId: "abc12s3",
                profile: ["http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient"]
            },
            identifier: [
            ],
            implicitRules: "https://www.hl7.org/fhir",
            language: "en-US"
        ,gender: "unknown", name: []};
        uscore501:USCorePatientProfile example1 = {
            id: "12c39",
            meta: {
                versionId: "abc12s4",
                profile: ["http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient"]
            },
            identifier: [
            ],
            implicitRules: "https://www.hl7.org/fhir",
            language: "en-US"
        ,gender: "unknown", name: []};
        patients.push(example);
        patients.push(example1);
        return patients;
    }

    isolated function create(r4:FHIRResourceEntity patient, r4:FHIRContext ctx) returns string|r4:FHIRError {

        //Implement source system connection here and persist FHIR resource.
        //Must respond with ID in order to create Location header

        string resourceId = "logicalId"; //returned from the source system
        return resourceId;
    }
}

