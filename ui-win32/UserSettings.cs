using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace network.sispop.sispopnet.win32.ui
{
    public partial class UserSettingsForm : Form
    {
        public UserSettingsForm()
        {
            InitializeComponent();
            if (Program.platform == PlatformID.Win32NT)
                config_path = Environment.ExpandEnvironmentVariables("%APPDATA%\\.sispopnet");
            else
                config_path = Environment.ExpandEnvironmentVariables("%HOME%/.sispopnet");
        }

        private string config_path;
        private LogDumper ld;

        private void btnOK_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBoot_Click(object sender, EventArgs e)
        {
            dlgBootstrap b = new dlgBootstrap();
            b.ShowDialog();
            b.Dispose();
        }

        private void btnDumpLog_Click(object sender, EventArgs e)
        {
            if (main_frame.isConnected)
                MessageBox.Show("Cannot dump log when client is running.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            else
            {
                if (main_frame.logText == string.Empty)
                {
                    MessageBox.Show("Log is empty", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return;
                }
                if (ld == null)
                    ld = new LogDumper(main_frame.logText);
                else
                    ld.setText(main_frame.logText);

                ld.CreateLog(config_path);
                MessageBox.Show(string.Format("Wrote log to {0}, previous log rotated", ld.getLogPath()), "SispopNET", MessageBoxButtons.OK, MessageBoxIcon.Information);
                main_frame.logText = string.Empty;
            }
        }

        private void btnVSettings_Click(object sender, EventArgs e)
        {
            VisualSettings v = new VisualSettings();
            v.ShowDialog();
            v.Dispose();
        }

        private void BtnEditCfg_Click(object sender, EventArgs e)
        {
            try {
                Process.Start(string.Format("{0}/sispopnet.ini", config_path)); }
            catch
            {
                MessageBox.Show("No existing config found");
                BtnNewCfg_Click(sender, e);
            }

        }

        private void BtnNewCfg_Click(object sender, EventArgs e)
        {
            if (File.Exists(string.Format("{0}/sispopnet.ini", config_path)))
            {
                DialogResult resp = MessageBox.Show("WARNING: This will overwrite your existing config file, Continue?", "Sispopnet", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                switch(resp)
                {
                    case DialogResult.Yes:
                        File.Delete(string.Format("{0}/sispopnet.ini", config_path));
                        break;
                    case DialogResult.No:
                        return;
                }
            }
            
            string sispopnetExeString;

            if (Program.platform == PlatformID.Win32NT)
                sispopnetExeString = String.Format("{0}\\sispopnet.exe", Directory.GetCurrentDirectory());
            else
                sispopnetExeString = String.Format("{0}/sispopnet", Directory.GetCurrentDirectory());
            Process p = new Process();
            p.StartInfo.FileName = sispopnetExeString;
            p.StartInfo.Arguments = "-g";
            p.StartInfo.CreateNoWindow = true;
            p.StartInfo.UseShellExecute = false;
            p.EnableRaisingEvents = true;
            p.Exited += new EventHandler(msg);
            p.Start();
        }

        private void msg(object sender, EventArgs e)
        {
            MessageBox.Show(string.Format("Created new config file at {0}/sispopnet.ini", config_path), "Success", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
        }
    }
}
