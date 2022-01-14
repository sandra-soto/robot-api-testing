# Using https://github.com/MarketSquare/robotframework-requests
*** Settings ***
Library               RequestsLibrary

*** Variables ***
${SERVER}         https://api.tvmaze.com
${SHOW URL}      ${SERVER}/shows
${SEARCH URL}      ${SERVER}/search
${SINGLESEARCH URL}      ${SERVER}/singlesearch


*** Test Cases ***

Get Show By ID
    ${response}=    GET  ${SHOW URL}/103    expected_status=200

Returns 404 Not Found When Searching For Nonexistent Show ID
    ${response}=    GET  ${SHOW URL}/92359    expected_status=404

Get Request With Parameters
    ${response}=    GET  ${SEARCH URL}/shows  params=q=girls  expected_status=200

Search Returns Expected Show On Top
    ${response}=    GET  ${SEARCH URL}/shows  params=q=girls  expected_status=200
    Should Be Equal As Strings    139  ${response.json()[0]["show"]["id"]}

Single Search Returns Expected Show
    ${response}=    GET  ${SINGLESEARCH URL}/shows  params=q=girls  expected_status=200
    Should Be Equal As Strings    139  ${response.json()["id"]}
