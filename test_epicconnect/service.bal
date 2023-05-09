// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).

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

import ballerina/http;
import ballerinax/health.clients.fhir;

configurable string base = "https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4/";
configurable string tokenUrl = "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token";
configurable string clientId = "095f303e-7887-4b00-b74d-de22ba98c27c";
configurable string keyFile = "/Users/isuruuy/Desktop/RND/OH/testing/feature-testing/choreo/epic/privatekey.pem";
//configurable string customDomain = "epicconnect";

fhir:FHIRConnectorConfig epicConfig = {
    baseURL: base,
    mimeType: fhir:FHIR_JSON,
    authConfig: {
        clientId: clientId,
        tokenEndpoint: tokenUrl,
        keyFile: keyFile
    }
};

final fhir:FHIRConnector fhirConnectorObj = check new (epicConfig);

// @http:ServiceConfig{
//     interceptors: [new fhir:URLRewriteInterceptor(base, customDomain)]
// }
service http:Service / on new http:Listener(9090) {

    // Get resource by ID
    isolated resource function get fhir/r4/[string resType]/[string id]() returns http:Response {

        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->getById(resType, id);
        return fhir:handleResponse(fhirResponse);
    }

    // Create a resource
    isolated resource function post fhir/r4/[string resType](@http:Payload json|xml resPayload) returns http:Response {

        string|error rtype = fhir:extractResourceType(resPayload);
        if rtype is error {
            return fhir:handleError(string `${rtype.message()} : ${resType}`, http:STATUS_BAD_REQUEST);
        }
        if (rtype != resType) {
            return fhir:handleError("Request payload mismatch with requested resource.");
        }
        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->create(resPayload, returnPreference = fhir:REPRESENTATION);
        return fhir:handleResponse(fhirResponse);
    }

    // Patch a resource
    isolated resource function patch fhir/r4/[string resType]/[string id](http:Request request, @http:Payload json|xml resPayload) returns http:Response {

        fhir:PatchContentType patchType;
        string contentType = request.getContentType();
        if (contentType is fhir:PatchContentType) {
            patchType = <fhir:PatchContentType>contentType;
        } else {
            return fhir:handleError(string `Unsupported Patch Content Type : ${contentType}`);
        }
        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->patch(resType, id, resPayload, patchContentType = patchType, returnPreference = fhir:REPRESENTATION);
        return fhir:handleResponse(fhirResponse);
    }

    // Delete a resource
    isolated resource function delete fhir/r4/[string resType]/[string id]() returns http:Response {

        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->delete(resType, id);
        return fhir:handleResponse(fhirResponse);
    }

    // Update a resource
    isolated resource function put fhir/r4/[string resType](@http:Payload json|xml resPayload) returns http:Response {

        string|error rtype = fhir:extractResourceType(resPayload);
        if rtype is error {
            return fhir:handleError(string `${rtype.message()} : ${resType}`, http:STATUS_BAD_REQUEST);
        }
        if (rtype != resType) {
            return fhir:handleError("Request payload mismatch with requested resource.");
        }
        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->update(resPayload, returnPreference = fhir:REPRESENTATION);
        return fhir:handleResponse(fhirResponse);
    }

    // Get metadata
    isolated resource function get fhir/r4/metadata(http:Request r) returns http:Response {

        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->getConformance();
        return fhir:handleResponse(fhirResponse);
    }

    // Search through a resource type
    isolated resource function get fhir/r4/[string resType](http:Request request) returns http:Response {

        fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->search(resType, request.getQueryParams());
        return fhir:handleResponse(fhirResponse);

    }

    isolated resource function 'default [string... paths](http:Request req) returns http:Response {
        return fhir:handleError("Unsupported");
    }
}
