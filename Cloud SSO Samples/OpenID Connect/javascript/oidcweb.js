/*
 * Cloud SSO 2024 JavaScript Edition - Sample Project
 *
 * This sample project demonstrates the usage of Cloud SSO in a 
 * simple, straightforward way. It is not intended to be a complete 
 * application. Error handling and other checks are simplified for clarity.
 *
 * www.nsoftware.com/cloudsso
 *
 * This code is subject to the terms and conditions specified in the 
 * corresponding product license agreement which outlines the authorized 
 * usage and restrictions.
 */
 
const readline = require("readline");
const cloudsso = require("@nsoftware/cloudsso");

if(!cloudsso) {
  console.error("Cannot find cloudsso.");
  process.exit(1);
}
let rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


//Node JS Modules
const http = require('http');
const url = require('url');

//Varriables 
var discUrl = "";
var clientId = "";
var clientSecret = "";
var port = 8080;
var returnUrl = "";
main();

async function main() {
	const argv = process.argv;
	if(argv.length !== 6) {
		console.log("Usage: node oidcweb.js disc_url client_id client_secret port");
		console.log("  disc_url: the url to fetch");
		console.log("  client_id: the url to fetch");
		console.log("  client_secret: the url to fetch");
		console.log("  port: the url to fetch");

		console.log("Example: node oidcweb.js https://exmaple.com/.well-known/openid-configuration CLIENT_ID CLIENT_SECRET 8080");
		process.exit();
	}

	discUrl = argv[2];
	clientId = argv[3];
	clientSecret = argv[4];
	port = parseInt(argv[5]);
	returnUrl = `http://localhost:${port}/landing`;

	console.log("Starting Server...");
	http.createServer(async function (req, res) {

		var uriParsed = url.parse(req.url, true)
		var qParams = uriParsed.query;
		
		console.log(`Processing incoming rquest...`);
		if(uriParsed.pathname === "/landing" && qParams.code){

			console.log(`Processing OpenID authorization response.`);

			var userDetails = await processResponse(qParams.code);
			var htmlPage = `<html><h1>User Details</h1><p>Name: ${userDetails.name}</p><p>Email: ${userDetails.email}</p><p>Subject ID: ${userDetails.subject}</p></html>`;
			
			res.writeHead(200, {'Content-Type': 'text/html'});
			res.end(htmlPage);
		} else if (uriParsed.pathname === "/landing"){
			console.log(`Processing OpenID authorization error response.`);
			//error
			var htmlPage = "";
			if(qParams.error){
				htmlPage = `<html><p>Error Code: ${qParams.error}</p><p>Error Description: ${qParams.error_description}</p><p>Error Page: ${qParams.error_uri}</p></html>`;
			} else {
				htmlPage = `<html><p>Error getting authorization!</p></html>`
			}
			res.writeHead(200, {'Content-Type': 'text/html'});
			res.end(htmlPage);
		} else {
			console.log(`Starting authentication.`);
			var redirectUri = await buildRequest();
			if(redirectUri === ""){
				var htmlPage = `<html><p>Error generating authorization URL. Check server logs.</p></html>`;
				res.writeHead(200, {'Content-Type': 'text/html'});
				res.end(htmlPage);
			} else {
				res.statusCode = 302;
				res.setHeader('Location', redirectUri);
				res.end();
			}


		}

	}).listen(port);

}

async function  buildRequest(){
	const oidc = new cloudsso.oidcweb();

	var authURI = "";

	console.log(`Requesting discovery document.`);
	try{
		await oidc.requestDiscoveryDoc(discUrl);
		
		oidc.setAuthorizationScope("openid email profile");
		oidc.setReturnURL(returnUrl);
		oidc.setClientId(clientId);

		//Force consent prompt to be asked.
		oidc.addParam("prompt", "consent");

		console.log(`Building authorization URL.`);
		authURI = await oidc.getAuthorizationURL();
	} catch (e){
		console.log(`${e.name}: ${e.message}`);
		authURI = "";
	}

	return authURI;
}

async function processResponse(code){
	const oidc = new cloudsso.oidcweb();
	await oidc.requestDiscoveryDoc(discUrl);

	oidc.setAuthorizationScope("openid email profile");
	oidc.setReturnURL(returnUrl);
	oidc.setClientId(clientId);
	oidc.setClientSecret(clientSecret);
	await oidc.config(`AuthorizationCode=${code}`);

	await oidc.processOIDCResponse();

	var name = oidc.getUserDetails().getName();
	var email = oidc.getUserDetails().getEmail();
	var subject = oidc.getUserDetails().getSubject();

	name = name ? name : "Name not specified";
	email = email ? email : "Email not specified";
	subject = subject ? subject : "Subject not specified";

	return {
		name: name,
		email: email,
		subject: subject
	};
}


function prompt(promptName, label, punctuation, defaultVal)
{
  lastPrompt = promptName;
  lastDefault = defaultVal;
  process.stdout.write(`${label} [${defaultVal}]${punctuation} `);
}
