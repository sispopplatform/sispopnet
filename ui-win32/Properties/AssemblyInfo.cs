// WARNING: for the love of all that is good and holy
// please DO NOT convert this file to UTF-8, much less
// UTF-16 - the UNIX port of Roslyn does not understand UTF-16,
// and UTF-8 chews up the copyright symbols.
// -rick
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// General Information about an assembly is controlled through the following
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
[assembly: AssemblyTitle("Sispopnet for Windows")]
[assembly: AssemblyDescription("Sispopnet end-user UI")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("Sispop Project")]
[assembly: AssemblyProduct("Sispopnet Launcher")]
[assembly: AssemblyCopyright("Copyright �2018-2020 Sispop Project. All rights reserved. See LICENSE for more details.")]
[assembly: AssemblyTrademark("Sispop, Sispop Project, SispopNET are � & �2018-2020 Sispop Foundation")]
[assembly: AssemblyCulture("")]

// Setting ComVisible to false makes the types in this assembly not visible
// to COM components.  If you need to access a type in this assembly from
// COM, set the ComVisible attribute to true on that type.
[assembly: ComVisible(false)]

// The following GUID is for the ID of the typelib if this project is exposed to COM
[assembly: Guid("1cdee73c-29c5-4781-bd74-1eeac6f75a14")]

// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Build and Revision Numbers
// by using the '*' as shown below:
// [assembly: AssemblyVersion("1.0.*")]
[assembly: AssemblyVersion("0.7.0")]
[assembly: AssemblyFileVersion("0.7.0")]
#if DEBUG
[assembly: AssemblyInformationalVersion("0.7.0-dev-{chash:8}")]
#else
[assembly: AssemblyInformationalVersion("0.7.0 (RELEASE_CODENAME)")]
#endif