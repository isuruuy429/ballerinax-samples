import ballerinax/health.hl7v23;
import ballerinax/health.hl7v2;
import ballerina/log;

public function main() returns error? {
    string ad1a01Msg_patient = "MSH|^~\\&|AccMgr|1|||20050110045504||ADT^A01|599102|P|2.3 \r"
                        + "EVN|A01|20050110045502 \r"
                        + "PID|||1^^^^BR||Doe^John^Leo^^Mr^PhD^M^P||1989-04-29|F|||1234 MAIN ST^APT 204^HOUSTON^TX^77001^USA^O~Abercrombie St^^Austin^Alaska^02199^ASM^H||^NET^X.400^johndoe@gmail.com \r"
                        + "PV1|1|I \r";

    string ORU_R01 = "MSH|^~\\&|SendingApp|SendingFac|ReceivingApp|ReceivingFac|20120920230252907||ORU^R01|2012092017490562|T|2.3 \r"
                    + "OBR||5234342^http://acme.com/lab/reports|R-GEN-378456-2-1|58410-2^Complete blood count (hemogram) panel - Blood by Automated count^http://loinc.org|||201209202036|||||||||||||||20120920230242||TX|X|||||||39023&Smith&Rovan&&&DR^2022-03-23^2024-03-23 ";

    byte[] byteMessage_adta01 = hl7v2:createHL7WirePayload(ad1a01Msg_patient.toBytes());
    byte[] byteMessage_orur01 = hl7v2:createHL7WirePayload(ORU_R01.toBytes());

    hl7v2:HL7Parser parser = new ();
    hl7v2:Message|hl7v2:GenericMessage|hl7v2:HL7Error parsedMsg = parser.parse(byteMessage_adta01);
    hl7v2:Message|hl7v2:GenericMessage|hl7v2:HL7Error parsedMsg2 = parser.parse(byteMessage_orur01);

    if parsedMsg is hl7v2:HL7Error {
        log:printInfo("Error occurred while parsing the received message. Details: " + (parsedMsg.detail().message ?: ""));
        return error("Error occurred while parsing the received message", parsedMsg);
    }

    if parsedMsg2 is hl7v2:HL7Error {
        log:printInfo("Error occurred while parsing the received message. Details: " + (parsedMsg2.detail().message ?: ""));
        return error("Error occurred while parsing the received message", parsedMsg2);
    }

    hl7v23:ADT_A01 adtMsg = <hl7v23:ADT_A01>parsedMsg;
    hl7v23:XPN[] patientName = adtMsg.pid.pid5;
    hl7v23:IS patientGender = adtMsg.pid.pid8;
    hl7v23:TS patientDOB = adtMsg.pid.pid7;
    hl7v23:CX[] patientId = adtMsg.pid.pid3;
    hl7v23:XAD[] patientAddress = adtMsg.pid.pid11;
    hl7v23:XTN[] patientPhone = adtMsg.pid.pid13;

    log:printInfo("Patient Family Name: " + patientName[0].xpn1);
    log:printInfo("Patient Gender: " + patientGender);
    log:printInfo("Patient DOB: " + patientDOB.ts1);
    log:printInfo("Patient ID: " + patientId[0].cx1);
    log:printInfo("Patient identifier.code: " + patientId[0].cx5);
    log:printInfo("Patient country: " + patientAddress[0].xad6);
    log:printInfo("Patient street address: " + patientAddress[0].xad1);
    log:printInfo("Patient postal code: " + patientAddress[0].xad5);
    log:printInfo("Patient telecom use: " + patientPhone[0].xtn2);
    log:printInfo("Patient telecom system: " + patientPhone[0].xtn3);
    log:printInfo("Patient telecom value: " + patientPhone[0].xtn4);

}
