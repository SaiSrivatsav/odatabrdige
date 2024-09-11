const cds = require('@sap/cds');
const { useOrFetchDestination } = require('@sap-cloud-sdk/connectivity');
const { executeHttpRequest } = require('@sap-cloud-sdk/http-client');
const controller = require('./proxy-controller');

module.exports = cds.service.impl(async function(){
    const { CompanyCodes, GlAccounts, CreateJournal } = this.entities;
    const ecc_globaljet = await cds.connect.to('API_GLOBAL_JET');
    try{
        //Read Company Codes
        this.on('READ', CompanyCodes, req=>{
            return ecc_globaljet.tx(req).run(req.query);
        });

        //Read GL Accounts
        this.on('READ', GlAccounts, req=>{
            return ecc_globaljet.tx(req).run(req.query);
        });

        //Post Accrual/Reposting/General Journal
        this.on('CREATE', CreateJournal, async req=>{
            const destination = await controller.getDestination('API_GLOBAL_JET');
            console.info("Connected to destination: " + destination.name);
            const authHeader = 'Basic ' + Buffer.from(destination.username + ":" + destination.password).toString('base64');
            const jwt = req.user && req.user.jwt;
            const csrfResp = await executeHttpRequest({
                destinationName: 'API_GLOBAL_JET', jwt},
                {
                    method: 'GET',
                    url: `${destination.url}/`,
                    headers:{
                        'x-csrf-token': 'Fetch',
                        'Authorization': authHeader
                    }
                });
                const csrfToken = csrfResp.headers['x-csrf-token']; 
                console.info("CSRF token fetched sucessfully ; Token: " + csrfToken);
                const cookies = csrfResp.headers['set-cookie']; 
                const postResp = await executeHttpRequest({
                    destinationName: 'API_GLOBAL_JET', jwt},{
                method: 'POST',
                url: `${destination.url}/HeaderDataSet`,
                headers:{
                    'x-csrf-token': csrfToken,
                    'Authorization': authHeader,
                    'Cookie': cookies.join(';'),
                    'Content-Type': 'application/json'
                },
                data: req.data
            });
            console.info("Status is: " + postResp.status);
            return postResp.data;
        })
    }catch(error){
        console.info("I am here in error place");
        throw error;
    }
});