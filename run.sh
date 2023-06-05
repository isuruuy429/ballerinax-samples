#!/bin/bash

directoryArray=(test_epicconnect test_aubase410 test_fhirr4 test_metadata2 test_patientAPI_template102 test_r4utils test_smartConfig test_uscore102_template test_uscore501)

for i in ${directoryArray[@]}
do
       bal run $i &.
done


