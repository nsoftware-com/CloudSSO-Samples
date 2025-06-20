<?php
/*
 * Cloud SSO 2024 PHP Edition - Sample Project
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
require_once('../include/cloudsso_oidcdesktop.php');
require_once('../include/cloudsso_const.php');
?>
<?php
class MyOIDCDesktop extends CloudSSO_OIDCDesktop
{
  function fireSSLServerAuthentication($param) {
    $param['accept'] = true;
    return $param;
  }
}

global $argc, $argv;

if ($argc < 5) {
  echo "Usage: php oidcdesktop.php disc_url client_id client_secret port\n";
  echo "       disc_url: the url for the discovery document\n";
  echo "      client_id: the id provided by the OpenID provider for your application\n";
  echo "  client_secret: the secret provided by the OpenID provider for your application\n";
  echo "           port: the port that the application will be listening on through localhost\n";
  echo "Example: php oidcdesktop.php https://exmaple.com/.well-known/openid-configuration CLIENT_ID CLIENT_SECRET 8080";
  return;
} else {
  $disc_url = $argv[1];
  $client_id = $argv[2];
  $client_secret = $argv[3];
  $port = $argv[4];
}

$oidc = new MyOIDCDesktop();

try {
  //Request discovery document
  $oidc->doRequestDiscoveryDoc($disc_url);
  
  //Setup component for authorization and authentication.
  $oidc->setClientId($client_id );
  $oidc->setClientSecret($client_secret);
  $oidc->setWebServerPort($port );
  $oidc->setAuthorizationScope("openid profile email");

  //Optional Security Settings
  //$oidc->setUsePKCE(true);
  //$oidc->setUseNonce(true);

  //For demo purposes, always ask for user consent
  $oidc->doAddParam("prompt", "consent");

  //Authenticate User
  $oidc->doAuthenticateUser();

  //Output user details
  echo "User Details: \n";
  echo "        Name: " . $oidc->getUserDetailsName(). "\n";
  echo "       Email: " . $oidc->getUserDetailsEmail(). "\n";
  echo "     Subject: " . $oidc->getUserDetailsSubject(). "\n";
} catch (Exception $e) {
  echo "Error: " . $e->getMessage() . "\n";
}
?>
