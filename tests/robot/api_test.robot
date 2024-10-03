*** Settings ***
Library  RequestsLibrary

*** Variables ***
${BASE_URL}  http://127.0.0.1:8000

*** Test Cases ***
Test Root Endpoint
    [Documentation]  Test the root (/) endpoint
    Create Session  api  ${BASE_URL}
    ${response}=  Get Request  api  /
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${response.json()["message"]}  Hello World!!!!

Test Get Item Endpoint
    [Documentation]  Test the /items/{item_id} endpoint
    Create Session  api  ${BASE_URL}
    ${response}=  Get Request  api  /items/1?q=test_query
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${response.json()["item_id"]}  1
    Should Be Equal As Strings  ${response.json()["q"]}  test_query
