﻿using System;
using System.Diagnostics;
using System.Threading;
using System.Windows.Forms;

namespace network.sispop.sispopnet.win32.ui
{
    static class Program
    {
        public static OperatingSystem os_id = Environment.OSVersion;
        public static PlatformID platform = os_id.Platform;
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // Scrub any old sispopnet process left behind
            Mutex m = new Mutex(true, "sispopnet_dotnet_ui");
            Process[] old_pids = Process.GetProcessesByName("sispopnet");
            foreach (Process pid in old_pids)
            {
                try
                {
                    pid.Kill();
                }
                catch { } // don't yell
            }
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new main_frame());
            try
            {
                main_frame.sispopNetDaemon.Kill();
            }
            catch
            { }
            m.ReleaseMutex();
        }
    }
}
