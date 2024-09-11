const cds = require('@sap/cds');
const { useOrFetchDestination } = require('@sap-cloud-sdk/connectivity');
const { executeHttpRequest } = require('@sap-cloud-sdk/http-client');

async function getDestination(destinationName){
    return await useOrFetchDestination({
        destinationName: destinationName
    });
}

async function getCSRFToken(destination, jwtToken){
    const csrfResp = await executeHttpRequest({
        destinationName: destination.name, jwtToken },
        {
            method: 'GET',
            url: `${destination.url}/`,
            headers:{
                'x-csrf-token': 'Fetch',
                'Authorization': authHeader
        }
    });

    const csrfToken = csrfResp.headers['x-csrf-token'];
    const cookies = csrfResp.headers['set-cookie']; 
    return { csrfToken, cookies };
}

module.exports={ getDestination, getCSRFToken }