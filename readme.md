# OS Switcher

**OS Switcher** is a script that helps you streamline the process of switching operating systems. Follow the steps below to install and use it effectively.

![image](https://i.imgur.com/smwCwnb.gif)

---

### □ Dependencies

Make sure the following dependencies are installed before using OS Switcher:

- **Python 3**
- **Tkinter** – for the GUI
- **GRUB** – required for reboot configuration
- **Polkit** – for privilege elevation
- **A Polkit authentication agent** – for GUI password prompts (e.g., `polkit-gnome`, `lxqt-policykit`)

#### □Install on Arch-based systems (Arch, Manjaro):

\`\`\`bash
sudo pacman -S python tk grub polkit polkit-gnome
\`\`\`

Then, to autostart the authentication agent (if you're using a window manager like i3 or Awesome):
\`\`\`bash
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
\`\`\`

#### □ Install on Debian-based systems (Ubuntu, Mint, etc.):

\`\`\`bash
sudo apt install python3 python3-tk grub-common policykit-1 policykit-1-gnome
\`\`\`

Then ensure the agent starts in your session (usually auto-started in desktop environments).

---

### ⚙️ Automatic Installation

1. Clone the repo:
   \`\`\`bash
   git clone https://github.com/EasyCanadianGamer/os-switcher.git
   cd os-switcher
   \`\`\`
2. Run the installation script:
   \`\`\`bash
   sudo bash install.sh
   \`\`\`

---

### □ Manual Installation

1. Clone the repo:
   \`\`\`bash
   git clone https://github.com/EasyCanadianGamer/os-switcher.git
   cd os-switcher
   \`\`\`
2. Install Python dependencies:
   \`\`\`bash
   pip install -r requirements.txt
   \`\`\`
3. Make the script executable:
   \`\`\`bash
   sudo chmod +x os-switcher.py
   \`\`\`
4. Run the script:
   \`\`\`bash
   python os-switcher.py
   \`\`\`

---

### ❌ Uninstalling

To remove OS Switcher and its configurations:

\`\`\`bash
sudo bash uninstall.sh
\`\`\`
