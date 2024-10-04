*** Settings ***
Library    library/serial_library.py
Library    Collections
Suite Setup   Setup Serial Connections
Suite Teardown  Teardown Serial Connections

*** Variables ***
${MASTER_PORT}   /dev/cu.wchusbserial110
${SLAVE_PORT}    /dev/cu.wchusbserial140
${BAUDRATE}      115200

*** Test Cases ***
Test Strictly Incremental Communication Between Master and Slave
    [Documentation]  Test that the numbers received from both Master and Slave ESP32 devices are strictly increasing by 1.
    Check Strictly Incremental Data

*** Keywords ***
Setup Serial Connections
    Log To Console    Resetting and connecting Master and Slave ESP32 devices
    Reset Board    ${SLAVE_PORT}     ${BAUDRATE}
    Connect To Slave     ${SLAVE_PORT}     ${BAUDRATE}

    Reset Board    ${MASTER_PORT}    ${BAUDRATE}
    Connect To Master    ${MASTER_PORT}    ${BAUDRATE}
    Log To Console    Master and Slave connected successfully.

Teardown Serial Connections
    Log To Console    Closing Master and Slave connections...
    Close Connections
    Log To Console    Connections closed.

Check Strictly Incremental Data
    Log To Console    Starting to check strictly incremental data from Master and Slave

    ${previous_master_value}=    Process Master Serial
    Log To Console    Initial master value: ${previous_master_value}

    ${previous_slave_value}=    Process Slave Serial
    Log To Console    Initial slave value: ${previous_slave_value}

    FOR    ${index}    IN RANGE    500    # Repeat 500 times to check 500 values
        ${current_master_value}=    Process Master Serial
        Log To Console    Current master value: ${current_master_value}
        Should Be True    ${current_master_value} == ${previous_master_value} + 1  Log To Console Master value did not increment by 1!
        ${previous_master_value} =    Set Variable    ${current_master_value}

        ${current_slave_value}=    Process Slave Serial
        Log To Console    Current slave value: ${current_slave_value}
        Should Be True    ${current_slave_value} == ${previous_slave_value} + 1  Log To Console Slave value did not increment by 1!
        ${previous_slave_value}=    Set Variable    ${current_slave_value}
    END
    Log To Console    Successfully checked 500 incremental values from both Master and Slave.

Convert From Bytes
    [Arguments]    ${byte_data}
    ${int_value}=    Evaluate    int.from_bytes(${byte_data}, 'little')
    RETURN    ${int_value}
