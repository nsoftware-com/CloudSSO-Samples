object FormOidcdesktop: TFormOidcdesktop
  Left = 0
  Top = 0
  Caption = 'OIDC Desktop Demo'
  ClientHeight = 636
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    780
    636)
  TextHeight = 15
  object RelyingGroup: TGroupBox
    Left = 8
    Top = 103
    Width = 764
    Height = 257
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Relying Party Information'
    TabOrder = 0
    DesignSize = (
      764
      257)
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 102
      Height = 15
      Caption = 'Discovery Doc URL:'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 48
      Height = 15
      Caption = 'Client ID:'
    end
    object Label3: TLabel
      Left = 16
      Top = 91
      Width = 126
      Height = 15
      Caption = 'Client Secret (Optional):'
    end
    object Label4: TLabel
      Left = 16
      Top = 124
      Width = 144
      Height = 16
      Caption = 'Web Server Port (Optional):'
    end
    object Label9: TLabel
      Left = 16
      Top = 157
      Width = 59
      Height = 15
      Caption = 'Grant Type:'
    end
    object Label10: TLabel
      Left = 16
      Top = 222
      Width = 103
      Height = 15
      Caption = 'Additional Options:'
    end
    object Label11: TLabel
      Left = 16
      Top = 192
      Width = 115
      Height = 15
      Caption = 'Authorization Scopes:'
    end
    object txtClientSecret: TEdit
      Left = 166
      Top = 88
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      ExplicitWidth = 427
    end
    object txtClientId: TEdit
      Left = 166
      Top = 53
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 427
    end
    object txtDiscovery: TEdit
      Left = 166
      Top = 21
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      ExplicitWidth = 427
    end
    object txtWebServerPort: TEdit
      Left = 166
      Top = 121
      Width = 583
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 3
      Text = '0'
      ExplicitWidth = 584
    end
    object cmbGrant: TComboBox
      Left = 166
      Top = 154
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ItemIndex = 0
      TabOrder = 4
      Text = 'Authorization Code'
      Items.Strings = (
        'Authorization Code'
        'Implicit'
        'Hybrid')
    end
    object boxPkce: TCheckBox
      Left = 166
      Top = 222
      Width = 97
      Height = 17
      Caption = 'Use PKCE'
      TabOrder = 6
    end
    object boxNonce: TCheckBox
      Left = 281
      Top = 222
      Width = 97
      Height = 17
      Caption = 'Use Nonce'
      TabOrder = 7
    end
    object boxPrompt: TCheckBox
      Left = 396
      Top = 222
      Width = 149
      Height = 17
      Caption = 'Request User Consent'
      TabOrder = 8
    end
    object txtScopes: TEdit
      Left = 166
      Top = 189
      Width = 583
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      Text = 'openid profile email'
    end
  end
  object btnAuthenticate: TButton
    Left = 8
    Top = 377
    Width = 764
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Authenticate'
    TabOrder = 1
    OnClick = btnAuthenticateClick
  end
  object ResponseGroup: TGroupBox
    Left = 8
    Top = 416
    Width = 764
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Response Information'
    TabOrder = 2
    DesignSize = (
      764
      201)
    object Label5: TLabel
      Left = 16
      Top = 134
      Width = 120
      Height = 15
      Caption = 'Authenticated Subject:'
    end
    object Label6: TLabel
      Left = 16
      Top = 99
      Width = 73
      Height = 15
      Caption = 'Access Token:'
    end
    object Label7: TLabel
      Left = 16
      Top = 64
      Width = 76
      Height = 15
      Caption = 'Refresh Token:'
    end
    object Label8: TLabel
      Left = 16
      Top = 32
      Width = 78
      Height = 15
      Caption = 'ID Token (raw):'
    end
    object Label12: TLabel
      Left = 16
      Top = 169
      Width = 110
      Height = 15
      Caption = 'Authenticated Email:'
    end
    object txtSubject: TEdit
      Left = 166
      Top = 131
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 3
    end
    object txtAccessToken: TEdit
      Left = 166
      Top = 96
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 2
      ExplicitWidth = 584
    end
    object txtRefreshToken: TEdit
      Left = 166
      Top = 61
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 584
    end
    object txtIdToken: TEdit
      Left = 166
      Top = 29
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 0
      ExplicitWidth = 584
    end
    object txtEmail: TEdit
      Left = 166
      Top = 166
      Width = 583
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 4
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 764
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      
        'This demo showcases how to use the OIDCDesktop component to auth' +
        'enticate a user of a desktop application. First, before this dem' +
        'o can be '
      
        'used, your application needs to be registered with an OpenID Pro' +
        'vider such as Microsoft Entra or Google Identity. Then setup the' +
        ' demo using '
      
        'the information provided by the OpenID Provider. Once ready, pre' +
        'ss authenticate to start the authentication process. If the auth' +
        'entication is '
      
        'successful, the demo should output the subject of the authentica' +
        'ted user.')
    ReadOnly = True
    TabOrder = 3
  end
  object oidcDesktop: TciOIDCDesktop
    AuthorizationScope = 'openid'
    SSLAcceptServerCertStore = 'MY'
    SSLCertStore = 'MY'
    WebServerSSLCertStore = 'MY'
    Left = 8
    Top = 368
  end
end


