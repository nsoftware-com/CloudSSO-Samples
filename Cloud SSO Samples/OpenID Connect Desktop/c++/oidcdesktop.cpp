/*
 * Cloud SSO 2024 C++ Edition - Sample Project
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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "../../include/cloudsso.h"
#define LINE_LEN 100

class MyOIDCDesktop : public OIDCDesktop
{
public:

	virtual int FireSSLServerAuthentication(OIDCDesktopSSLServerAuthenticationEventParams *e)
	{
		if (e->Accept) return 0;
		printf("Server provided the following certificate:\nIssuer: %s\nSubject: %s\n",
			e->CertIssuer, e->CertSubject);
		printf("The following problems have been determined for this certificate: %s\n", e->Status);
		printf("Would you like to continue anyways? [y/n] ");
		if (getchar() == 'y') e->Accept = true;
		else exit(0);
		return 0;
	}
};

int main(int argc, char **argv)
{

	if (argc < 5)
	{
		fprintf(stderr, "Usage: php oidcdesktop.php disc_url client_id client_secret port\n");
		fprintf(stderr, "\n");
		fprintf(stderr, "       disc_url: the url for the discovery document\n");
		fprintf(stderr, "      client_id: the id provided by the OpenID provider for your application\n");
		fprintf(stderr, "  client_secret: the secret provided by the OpenID provider for your application\n");
		fprintf(stderr, "           port: the port that the application will be listening on through localhost\n");
		fprintf(stderr, "\nExample: oidcdesktop.exe https://exmaple.com/.well-known/openid-configuration CLIENT_ID CLIENT_SECRET 8080\n\n");
		printf("Press enter to continue.");
		getchar();

	}
	else
	{
		MyOIDCDesktop oidc;
		int ret_code = 0;

		//Request discovery document
		ret_code = oidc.RequestDiscoveryDoc(argv[1]);
		if (ret_code) { goto done; }

		//Setup component for authorization and authentication
		oidc.SetClientId(argv[2]);
		oidc.SetClientSecret(argv[3]);
		oidc.SetAuthorizationScope("openid profile email");

		//Set the webserver port
		int port;
		sscanf(argv[4], "%d", &port);
		oidc.SetWebServerPort(port);

		//Optional Security Settings
		oidc.SetUsePKCE(true);
		oidc.SetUseNonce(true);

		//For demo purposes, always ask for user consent
		oidc.AddParam("prompt", "consent");

		//Authenticate User
		ret_code = oidc.AuthenticateUser();
		if (ret_code) { goto done; }

		printf("User Details\n");
		printf("        Name: %s\n", oidc.GetUserDetails()->GetName());
		printf("       Email: %s\n", oidc.GetUserDetails()->GetEmail());
		printf("     Subject: %s\n", oidc.GetUserDetails()->GetSubject());

done:
		if (ret_code)     // Got an error.  The user is done.
		{
			printf("\nError: %d", ret_code);
			if (oidc.GetLastError())
			{
				printf(" \"%s\"\n", oidc.GetLastError());
			}
		}

		fprintf(stderr, "\npress <return> to continue...\n");
		getchar();
		exit(ret_code);
		return 0;
	}

}










