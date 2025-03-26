# import tkinter as tk
# import os
# import re
# import distro 

# current_distro = distro.name()

# def switch_os(os_name):
#     os.system(f"pkexec grub-reboot \"{os_name}\" && reboot")

# # Main GUI
# root = tk.Tk()
# root.title("OS Switcher")


# # Set window size
# window_width = 500
# window_height = 400

# # Get screen dimensions
# screen_width = root.winfo_screenwidth()
# screen_height = root.winfo_screenheight()

# # Calculate position to center the window
# x = (screen_width // 2) - (window_width // 2)
# y = (screen_height // 2) - (window_height // 2)

# # Set geometry with centered position
# root.geometry(f"{window_width}x{window_height}+{x}+{y}")

# # Extract GRUB menu entries
# try:
#     raw_entries = os.popen("pkexec grep -E 'menuentry' /boot/grub/grub.cfg").read().strip().split("\n")
# except Exception as e:
#     print(f"Error fetching GRUB entries: {e}")
#     # Create a label to show error if needed
#     tk.Label(root, text="Error fetching GRUB entries").pack()
#     root.mainloop()
#     exit()

# os_entries = []
    
# for line in raw_entries:
#     match = re.search(r"menuentry ['\"]([^'\"]+)['\"]", line)
#     if match:
#         entry = match.group(1)
#         if current_distro in entry or "Linux" in entry or "Windows" in entry:
#             os_entries.append(entry)

# if not os_entries:
#     tk.Label(root, text="No OS entries found").pack()
# else:
#     tk.Label(root, text="Select OS to reboot into:").pack(pady=5)
#     for os_name in os_entries:
#         tk.Button(root, text=os_name, command=lambda name=os_name: switch_os(name)).pack(pady=2, fill=tk.X, padx=20)

# root.mainloop()

import tkinter as tk
from tkinter import ttk
import os
import re
import distro

# Get current distribution name
current_distro = distro.name()

def switch_os(os_name):
    os.system(f"pkexec grub-reboot \"{os_name}\" && reboot")

# Main GUI
root = tk.Tk()
root.title("OS Switcher")

# Set window size
window_width = 500
window_height = 400

# Get screen dimensions
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()

# Calculate position to center the window
x = (screen_width // 2) - (window_width // 2)
y = (screen_height // 2) - (window_height // 2)

# Set geometry with centered position
root.geometry(f"{window_width}x{window_height}+{x}+{y}")

# Style configuration
style = ttk.Style()
style.theme_use("clam")  # You can try other themes like 'alt', 'default', etc.
style.configure("TLabel", font=("Arial", 14))
style.configure("TButton", font=("Arial", 12), padding=5)

# Create a frame for better layout
frame = ttk.Frame(root, padding=20)
frame.pack(fill=tk.BOTH, expand=True)

# Extract GRUB menu entries
try:
    raw_entries = os.popen("pkexec grep -E 'menuentry' /boot/grub/grub.cfg").read().strip().split("\n")
except Exception as e:
    ttk.Label(frame, text=f"Error fetching GRUB entries: {e}", foreground="red").pack()
    root.mainloop()
    exit()

os_entries = []
for line in raw_entries:
    match = re.search(r"menuentry ['\"]([^'\"]+)['\"]", line)
    if match:
        entry = match.group(1)
        if current_distro in entry or "Linux" in entry or "Windows" in entry:
            os_entries.append(entry)

# Add content to the GUI
if not os_entries:
    ttk.Label(frame, text="No OS entries found.", foreground="red").pack(pady=10)
else:
    ttk.Label(frame, text="Select OS to reboot into:", anchor="center").pack(pady=10)
    button_frame = ttk.Frame(frame)
    button_frame.pack(fill=tk.BOTH, expand=True)
    for os_name in os_entries:
        ttk.Button(button_frame, text=os_name, command=lambda name=os_name: switch_os(name)).pack(pady=5, fill=tk.X)

# Add an exit button for convenience
ttk.Button(frame, text="Exit", command=root.destroy).pack(pady=10)

# Run the GUI loop
root.mainloop()
