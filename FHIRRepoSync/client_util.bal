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
//
// AUTO-GENERATED FILE.
//
// This file is auto-generated by Ballerina Team for implementing client utility functions.
// Developers are allowed to modify this file as per the requirement.

import ballerina/time;

import ballerinax/health.fhir.r4;

# Fetch the last invocation time of the scheduler
#
# + return - Last invocation time in Utc if successful else error
function fetchLastInvocationTime() returns time:Utc|error {
    // Integration developer logic to access scheduler last invocation time from the client persistence layer.
    // Remove the default error return with your implementation.
    return error("Unimplemented method fetchLastInvocationTime() in client_util.bal");
}

# Push the current invocation time of the scheduler
#
# + now - Current time in Utc
# + return - error if unsuccessful
function pushCurrentInvocationTime(time:Utc now) returns error? {
    // Integration developer logic to save scheduler current invocation time to the client persistence layer.
    // Remove the default error return with your implementation.
    return error("Unimplemented method pushCurrentInvocationTime(time:Utc now) in client_util.bal");
}

# Process r4:BundleEntry[] into multiple r4:BundleEntry[]s
#
# + bundleEntry - r4:BundleEntry[] to process
# + return - map<r4:BundleEntry[]> of processed r4:BundleEntry[]s
function processAndReturnBundleEntries(r4:BundleEntry[] bundleEntry) returns map<r4:BundleEntry[]>|error {
    // Integration developer logic to process r4:BundleEntry[] into multiple r4:BundleEntry[]s.
    // It is not recommended to exceed the maximum limit of entries per bundle configured in your fhir repository provider.
    // Push all processed r4:BundleEntry[]s to a map<r4:BundleEntry[]> and return it.

    // Here is an example of splitting the r4:BundleEntry[] into r4:BundleEntry[]s of length 10
    // map<r4:BundleEntry[]> processedBundleEntries = {};

    // int startIndex = 0;
    // int length = bundleEntry.length();
    // int splitSize = 10;
    // while startIndex + splitSize < length {
        // r4:BundleEntry[] splittedBundleEntry = bundleEntry.slice(startIndex, startIndex + splitSize);
        // processedBundleEntries[startIndex.toString()] = splittedBundleEntry;
        // startIndex += splitSize;
    // }
    // processedBundleEntries[startIndex.toString()] = bundleEntry.slice(startIndex, length);

    return { bundleEntry };
}
