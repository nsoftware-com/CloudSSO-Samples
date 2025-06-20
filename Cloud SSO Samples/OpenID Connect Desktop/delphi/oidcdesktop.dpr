(*
 * Cloud SSO 2024 Delphi Edition - Sample Project
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
 *)

program oidcdesktop;

uses
  Forms,
  oidcdesktopf in 'oidcdesktopf.pas' {FormOidcdesktop};

begin
  Application.Initialize;

  Application.CreateForm(TFormOidcdesktop, FormOidcdesktop);
  Application.Run;
end.


         
