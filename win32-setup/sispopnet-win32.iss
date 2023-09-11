; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Sispopnet"
#define MyAppVersion "0.7.0"
#define MyAppPublisher "Sispop Project"
#define MyAppURL "https://net.sispop.site"
#define MyAppExeName "sispopnetui.exe"
; change this to avoid compiler errors  -despair
#ifndef DevPath
#define DevPath "D:\dev\external\llarp\"
#endif
#include "version.txt"

; see ../LICENSE

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{11335EAC-0385-4C78-A3AA-67731326B653}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
#ifndef RELEASE
AppVerName={#MyAppName} {#MyAppVersion}-dev
#else
AppVerName={#MyAppName} {#MyAppVersion}
#endif
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppPublisher}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile={#DevPath}LICENSE
OutputDir={#DevPath}win32-setup
OutputBaseFilename=sispopnet-win32
Compression=lzma2/ultra64
SolidCompression=yes
VersionInfoVersion=0.7.0
VersionInfoCompany=Sispop Project
VersionInfoDescription=Sispopnet for Microsoft� Windows� NT�
#ifndef RELEASE
VersionInfoTextVersion=0.7.0-dev-{#VCSRev}
VersionInfoProductTextVersion=0.7.0-dev-{#VCSRev}
#else
VersionInfoTextVersion=0.7.0
VersionInfoProductTextVersion=0.7.0 ({#Codename})
#endif
VersionInfoProductName=Sispopnet
VersionInfoProductVersion=0.7.0
InternalCompressLevel=ultra64
MinVersion=0,5.0
ArchitecturesInstallIn64BitMode=x64
VersionInfoCopyright=Copyright �2018-2020 Sispop Project
AppMutex=sispopnet_win32_daemon,sispopnet_qt5_ui,sispopnet_dotnet_ui

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked;
Name: "migrateconfigs"; Description: "Migrate existing configuration to enable modern UI"; MinVersion: 6.0

[Files]
; only one of these is installed
#ifdef SINGLE_ARCH
Source: "{#DevPath}build\sispopnet.exe"; DestDir: "{app}"; Flags: ignoreversion
; don't ship it, we don't have a public api yet!
;Source: "{#DevPath}build\libsispopnet-shared.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dbghelp64.dll"; DestName: "dbghelp.dll"; DestDir: "{app}"; Flags: ignoreversion
#else
Source: "{#DevPath}build\sispopnet.exe"; DestDir: "{app}"; Flags: ignoreversion 32bit; Check: not IsWin64
;Source: "{#DevPath}build\libsispopnet-shared.dll"; DestDir: "{app}"; Flags: ignoreversion 32bit; Check: not IsWin64
Source: "dbghelp32.dll"; DestName: "dbghelp.dll"; DestDir: "{app}"; Flags: ignoreversion; Check: not IsWin64
Source: "{#DevPath}build64\sispopnet.exe"; DestDir: "{app}"; Flags: ignoreversion 64bit; Check: IsWin64
;Source: "{#DevPath}build64\libsispopnet-shared.dll"; DestDir: "{app}"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "dbghelp64.dll"; DestDir: "{app}"; DestName: "dbghelp.dll"; Flags: ignoreversion; Check: IsWin64
#endif
; UI has landed!
#ifndef RELEASE
Source: "{#DevPath}ui-win32\bin\debug\sispopnetui.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\debug\sispopnetui.exe.config"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\debug\sispopnetui.pdb"; DestDir: "{app}"; Flags: ignoreversion
#else
Source: "{#DevPath}ui-win32\bin\release\sispopnetui.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\release\sispopnetui.exe.config"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\release\sispopnetui.pdb"; DestDir: "{app}"; Flags: ignoreversion
#endif
; eh, might as well ship the 32-bit port of everything else
;Source: "{#DevPath}build\testAll.exe"; DestDir: "{app}"; Flags: ignoreversion
;Source: "{#DevPath}build\catchAll.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}build\sispopnetctl.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "sispopnet-bootstrap.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "rootcerts.pem"; DestDir: "{app}"; Flags: ignoreversion
Source: "7z.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "inet6.7z"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall skipifsourcedoesntexist; MinVersion: 0,5.0; OnlyBelowVersion: 0,5.1; Check: not IsTcp6Installed
Source: "sispopnet-qt5-ui.7z"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall; MinVersion: 0,6.0;
Source: "sispopnet.ico"; DestDir: "{app}"; Flags: ignoreversion;
; Copy the correct tuntap driver for the selected platform
Source: "tuntapv9.7z"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall; OnlyBelowVersion: 0, 6.0; Check: not IsTapInstalled
Source: "tuntapv9_n6.7z"; DestDir: "{app}"; Flags: ignoreversion deleteafterinstall; MinVersion: 0,6.0; Check: not IsTapInstalled

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "regdbhelper.dll"; Flags: dontcopy
Source: "config_migration.bat"; DestDir: "{userappdata}\.sispopnet"; Flags: deleteafterinstall; MinVersion: 0,6.0

; build only if we have the 32-bit bins as well
; (i.e. *not* a Travis CI build, travis isn't expected to have these around)
#ifndef SINGLE_ARCH
Source: "C:\Windows\Fonts\iosevka-term-bold.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-bolditalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Bold Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-boldoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Bold Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-extralight.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Extralight"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-extralightitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Extralight Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-extralightoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Extralight Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-heavy.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Heavy"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-heavyitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Heavy Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-heavyoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Heavy Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-italic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-light.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Light"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-lightitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Light Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-lightoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Light Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-medium.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Medium"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-mediumitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Medium Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-mediumoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Medium Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-oblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-regular.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-thin.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Thin"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-thinitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Thin Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-thinoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Thin Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
#endif

[UninstallDelete]
Type: filesandordirs; Name: "{app}\tap-windows*"
Type: filesandordirs; Name: "{app}\inet6_driver"; MinVersion: 0,5.0; OnlyBelowVersion: 0,5.1
Type: filesandordirs; Name: "{app}\sispopnet-qt5-ui"; MinVersion: 0,6.0
Type: filesandordirs; Name: "{userappdata}\.sispopnet"

[UninstallRun]
Filename: "{app}\tap-windows-9.21.2\remove.bat"; WorkingDir: "{app}\tap-windows-9.21.2"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; RunOnceId: "RemoveTap"; MinVersion: 0,6.0
Filename: "{app}\tap-windows-9.9.2\remove.bat"; WorkingDir: "{app}\tap-windows-9.9.2"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; RunOnceId: "RemoveTap"; OnlyBelowVersion: 0,6.0

[Dirs]
Name: "{userappdata}\.sispopnet"

[Code]
var
TapInstalled: Boolean;
Version: TWindowsVersion;
function reg_query_helper(): Integer;
external 'reg_query_helper@files:regdbhelper.dll cdecl setuponly';

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
  if Version.NTPlatform and (Version.Major = 5) and (Version.Minor = 0) and (FileExists(ExpandConstant('{tmp}\inet6.7z')) = true) then
     // I need a better message...
    MsgBox('Restart your computer, then set up IPv6 in Network Connections. [Adapter] > Properties > Install... > Protocol > Microsoft IPv6 Driver...', mbInformation, MB_OK);
  if IsTaskSelected('migrateconfigs') then
    MsgBox('Sispopnet JSON-RPC API endpoint enabled. Any custom configuration was retained in %APPDATA%\.sispopnet\sispopnet.old.ini.', mbInformation, MB_OK);
  end;
end;

function IsTapInstalled(): Boolean;
begin
Result := TapInstalled;
end;

function IsTcp6Installed(): Boolean;
begin
  if (FileExists(ExpandConstant('{sys}\drivers\tcpip6.sys')) = false) then
  begin
    Result := true;
  end
  else
  begin
    Result := false;
  end;
end;

procedure InitializeWizard();
begin
GetWindowsVersionEx(Version);
if (reg_query_helper() = 0) then
  begin
    TapInstalled := false;
  end
else
  begin
    TapInstalled := true;
  end;
end;

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; OnlyBelowVersion: 0, 6.0; IconFilename: "{app}\sispopnet.ico"
Name: "{group}\{#MyAppName}"; Filename: "{app}\sispopnet-qt5-ui\sispopnetui.exe"; MinVersion: 0, 6.0; IconFilename: "{app}\sispopnet.ico"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; OnlyBelowVersion: 0,6.0; IconFilename: "{app}\sispopnet.ico"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\sispopnet-qt5-ui\sispopnetui.exe"; Tasks: desktopicon; MinVersion: 0,6.0; IconFilename: "{app}\sispopnet.ico"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon; OnlyBelowVersion: 0, 6.1; IconFilename: "{app}\sispopnet.ico"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\{#MyAppName}"; Filename: "{app}\sispopnet-qt5-ui\sispopnetui.exe"; Tasks: quicklaunchicon; MinVersion: 0, 6.1; IconFilename: "{app}\sispopnet.ico"

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; OnlyBelowVersion: 0, 6.0
Filename: "{app}\sispopnet-qt5-ui\sispopnetui.exe"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; MinVersion: 0,6.0
; wait until either one or two of these terminates
Filename: "{tmp}\7z.exe"; Parameters: "x tuntapv9.7z"; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "extract TUN/TAP-v9 driver"; StatusMsg: "Extracting driver..."; OnlyBelowVersion: 0, 6.0
Filename: "{tmp}\7z.exe"; Parameters: "x tuntapv9_n6.7z"; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "extract TUN/TAP-v9 driver"; StatusMsg: "Extracting driver..."; MinVersion: 0, 6.0
Filename: "{tmp}\7z.exe"; Parameters: "x inet6.7z"; WorkingDir: "{app}"; Flags: skipifdoesntexist runascurrentuser waituntilterminated skipifdoesntexist; Description: "extract inet6 driver"; StatusMsg: "Extracting IPv6 driver..."; MinVersion: 0, 5.0; OnlyBelowVersion: 0, 5.1
Filename: "{tmp}\7z.exe"; Parameters: "x sispopnet-qt5-ui.7z -aoa"; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "installing modern Qt5 UI"; StatusMsg: "Installing modern Qt5 UI..."; MinVersion: 0, 6.0;
Filename: "{app}\sispopnet-bootstrap.exe"; Parameters:"-L https://seed.sispop.site/sispopnet.signed --cacert rootcerts.pem -o ""{userappdata}\.sispopnet\bootstrap.signed"""; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated; Description: "bootstrap dht"; StatusMsg: "Downloading initial RC..."
; then ask to install drivers
Filename: "{app}\tap-windows-9.9.2\install.bat"; WorkingDir: "{app}\tap-windows-9.9.2\"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "Install TUN/TAP-v9 driver"; StatusMsg: "Installing driver..."; OnlyBelowVersion: 0, 6.0; Check: not IsTapInstalled
Filename: "{app}\tap-windows-9.21.2\install.bat"; WorkingDir: "{app}\tap-windows-9.21.2\"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "Install TUN/TAP-v9 driver"; StatusMsg: "Installing driver..."; MinVersion: 0, 6.0; Check: not IsTapInstalled
; install inet6 if not present. (I'd assume netsh displays something helpful if inet6 is already set up and configured.)
; if it doesn't exist, then the inet6 driver appears to be installed
Filename: "{app}\inet6_driver\setup\hotfix.exe"; Parameters: "/m /z"; WorkingDir: "{app}\inet6_driver\setup\"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "Install IPv6 driver"; StatusMsg: "Installing IPv6..."; OnlyBelowVersion: 0, 5.1;  Check: not FileExists(ExpandConstant('{sys}\drivers\tcpip6.sys'))
Filename: "{sys}\netsh.exe"; Parameters: "int ipv6 install"; Flags: runascurrentuser waituntilterminated; Description: "install ipv6 on whistler"; StatusMsg: "Installing IPv6..."; MinVersion: 0,5.1; OnlyBelowVersion: 0,6.0
Filename: "{userappdata}\.sispopnet\config_migration.bat"; WorkingDir: "{userappdata}\.sispopnet"; Flags: runascurrentuser waituntilterminated; Description: "migrate existing config"; StatusMsg: "Migrating old configuration..."; MinVersion: 0,6.0; Tasks: migrateconfigs;
