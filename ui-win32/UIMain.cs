using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Windows.Forms;

namespace network.sispop.sispopnet.win32.ui
{
    public partial class main_frame : Form
    {
        public static Process sispopNetDaemon = new Process();
        public static bool isConnected;
        public static string logText;
        private string config_path;
        private LogDumper ld;

        void UpdateUI(string text)
        {
            this.Invoke(new MethodInvoker(delegate () { sispopnetd_fd1.AppendText(text); }));
        }

        public main_frame()
        {
            InitializeComponent();
            if (Program.platform == PlatformID.Win32NT)
                config_path = Environment.ExpandEnvironmentVariables("%APPDATA%\\.sispopnet");
            else
                config_path = Environment.ExpandEnvironmentVariables("%HOME%/.sispopnet");
            StatusLabel.Text = "Disconnected";
            var build = ((AssemblyInformationalVersionAttribute)Assembly
  .GetAssembly(typeof(main_frame))
  .GetCustomAttributes(typeof(AssemblyInformationalVersionAttribute), false)[0])
  .InformationalVersion;
            UIVersionLabel.Text = String.Format("Sispopnet version {0}", build);
            sispopnetd_fd1.Text = string.Empty;
            logText = string.Empty;
            sispopNetDaemon.OutputDataReceived += new DataReceivedEventHandler((s, ev) =>
            {
                if (!string.IsNullOrEmpty(ev.Data))
                {
                    UpdateUI(ev.Data + Environment.NewLine);
                }
            });
        }

        private void btnConfigProfile_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("not implemented yet", "error", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            UserSettingsForm f = new UserSettingsForm();
            f.ShowDialog();
            f.Dispose();
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            string sispopnetExeString;

            if (Program.platform == PlatformID.Win32NT)
                sispopnetExeString = String.Format("{0}\\sispopnet.exe", Directory.GetCurrentDirectory());
            else
                sispopnetExeString = String.Format("{0}/sispopnet", Directory.GetCurrentDirectory());

            sispopNetDaemon.StartInfo.UseShellExecute = false;
            sispopNetDaemon.StartInfo.RedirectStandardOutput = true;
            //sispopNetDaemon.EnableRaisingEvents = true;
            sispopNetDaemon.StartInfo.CreateNoWindow = true;
            sispopNetDaemon.StartInfo.FileName = sispopnetExeString;
            sispopNetDaemon.Start();
            sispopNetDaemon.BeginOutputReadLine();
            btnConnect.Enabled = false;
            TrayConnect.Enabled = false;
            StatusLabel.Text = "Connected";
            isConnected = true;
            NotificationTrayIcon.Text = "Sispopnet - connected";
            btnDrop.Enabled = true;
            TrayDisconnect.Enabled = true;
            NotificationTrayIcon.ShowBalloonTip(5, "Sispopnet", "Connected to network.", ToolTipIcon.Info);
        }

        private void btnDrop_Click(object sender, EventArgs e)
        {
            sispopNetDaemon.CancelOutputRead();
            sispopNetDaemon.Kill();
            btnConnect.Enabled = true;
            TrayConnect.Enabled = true;
            btnDrop.Enabled = false;
            TrayDisconnect.Enabled = false;
            StatusLabel.Text = "Disconnected";
            NotificationTrayIcon.Text = "Sispopnet - disconnected";
            isConnected = false;
            logText = sispopnetd_fd1.Text;
            sispopnetd_fd1.Text = string.Empty;
            NotificationTrayIcon.ShowBalloonTip(5, "Sispopnet", "Disconnected from network.", ToolTipIcon.Info);

        }

        private void sispopnetd_fd1_TextChanged(object sender, EventArgs e)
        {
            if (Properties.Settings.Default.autoScroll)
                sispopnetd_fd1.ScrollToCaret();
            else
                return;
        }

        private void btnHide_Click(object sender, EventArgs e)
        {
            Hide();
            if (isConnected)
                NotificationTrayIcon.ShowBalloonTip(5, "Sispopnet", "Currently connected.", ToolTipIcon.Info);
            else
                NotificationTrayIcon.ShowBalloonTip(5, "Sispopnet", "Currently disconnected.", ToolTipIcon.Info);
        }

        private void NotificationTrayIcon_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (!Visible)
            {
                Show();
            }
        }

        private void btnAbout_Click(object sender, EventArgs e)
        {
            AboutBox a = new AboutBox();
            a.ShowDialog(this);
            a.Dispose();
        }

        private void saveLogToFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (isConnected)
                MessageBox.Show("Cannot dump log when client is running.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            else
            {
                if (logText == string.Empty)
                {
                    MessageBox.Show("Log is empty", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return;
                }
                if (ld == null)
                    ld = new LogDumper(logText);
                else
                    ld.setText(logText);

                ld.CreateLog(config_path);
                MessageBox.Show(string.Format("Wrote log to {0}, previous log rotated", ld.getLogPath()), "Sispopnet", MessageBoxButtons.OK, MessageBoxIcon.Information);
                logText = string.Empty;
            }
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            AboutBox a = new AboutBox();
            a.ShowDialog();
            a.Dispose();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void TrayDisconnect_Click(object sender, EventArgs e)
        {
            btnDrop_Click(sender, e);
        }

        private void TrayConnect_Click(object sender, EventArgs e)
        {
            btnConnect_Click(sender, e);
        }

        private void showToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Show();
        }
    }
}
