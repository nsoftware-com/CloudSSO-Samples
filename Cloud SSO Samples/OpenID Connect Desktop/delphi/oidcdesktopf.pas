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
unit oidcdesktopf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cicore, citypes,
  cioidcdesktop;

type
  TFormOidcdesktop = class(TForm)
    oidcDesktop: TciOIDCDesktop;
    RelyingGroup: TGroupBox;
    ResponseGroup: TGroupBox;
    btnAuthenticate: TButton;
    cmbGrant: TComboBox;
    txtAccessToken: TEdit;
    txtClientId: TEdit;
    txtClientSecret: TEdit;
    txtDiscovery: TEdit;
    txtIdToken: TEdit;
    txtRefreshToken: TEdit;
    txtSubject: TEdit;
    txtWebServerPort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    boxPkce: TCheckBox;
    boxNonce: TCheckBox;
    boxPrompt: TCheckBox;
    Label10: TLabel;
    txtScopes: TEdit;
    Label11: TLabel;
    Memo1: TMemo;
    Label12: TLabel;
    txtEmail: TEdit;
    procedure btnAuthenticateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOidcdesktop: TFormOidcdesktop;

implementation

{$R *.dfm}

procedure TFormOidcdesktop.btnAuthenticateClick(Sender: TObject);
begin
  oidcDesktop.RequestDiscoveryDoc(txtDiscovery.Text);

  oidcDesktop.ClientId := txtClientId.Text;
  oidcDesktop.ClientSecret := txtClientSecret.Text;
  oidcDesktop.AuthorizationScope := txtScopes.Text;
  oidcDesktop.GrantType := TciTGrantTypes(cmbGrant.ItemIndex);
  oidcDesktop.RefreshToken := txtRefreshToken.Text;
  oidcDesktop.UsePkce := boxPkce.Checked;
  oidcDesktop.UseNonce := boxNonce.Checked;
  oidcDesktop.WebServerPort := StrToInt(txtWebServerPort.Text);

  IF boxPrompt.Checked THEN
  begin
    //oidcDesktop.Config('prompt=consent'); //Another way to set the prompt
    oidcDesktop.AddParam('prompt', 'consent');
  end;

  oidcDesktop.AuthenticateUser();

  txtIdToken.Text := oidcDesktop.IDtokenInfo.IdTokenContent;
  txtRefreshToken.Text := oidcDesktop.RefreshToken;
  txtAccessToken.Text := oidcDesktop.AccessToken;
  txtSubject.Text := oidcDesktop.UserDetails.Subject;
  txtEmail.Text := oidcDesktop.UserDetails.Email;
end;

end.

