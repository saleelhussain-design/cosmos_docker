import os
import sys
import subprocess
import platform
import urllib.request
import zipfile
import shutil
import tkinter as tk
from tkinter import ttk, messagebox

# Configuration
VERSION = "1.0.0"
# Replace with your actual release ZIP URL
DOWNLOAD_URL = "https://github.com/your-repo/cosmos/releases/download/v1.0.0/cosmos-package.zip" 
INSTALL_DIR = os.path.expanduser("~/CosmOS")

class CosmosInstaller:
    def __init__(self, root):
        self.root = root
        self.root.title(f"CosmOS Installer v{VERSION}")
        self.root.geometry("500x300")
        
        self.label = ttk.Label(root, text="Welcome to CosmOS Installer", font=("Arial", 14))
        self.label.pack(pady=20)
        
        self.status_var = tk.StringVar(value="Ready to install")
        self.status_label = ttk.Label(root, textvariable=self.status_var)
        self.status_label.pack(pady=10)
        
        self.progress = ttk.Progressbar(root, orient="horizontal", length=400, mode="determinate")
        self.progress.pack(pady=20)
        
        self.btn_docker = ttk.Button(root, text="Install via Docker (Recommended)", command=lambda: self.start_install("docker"))
        self.btn_docker.pack(pady=5)
        
        self.btn_bare = ttk.Button(root, text="Install via Bare Metal (Advanced)", command=lambda: self.start_install("bare"))
        self.btn_bare.pack(pady=5)

    def log(self, msg):
        self.status_var.set(msg)
        self.root.update_idletasks()

    def run_cmd(self, cmd, shell=True):
        try:
            result = subprocess.run(cmd, shell=shell, check=True, capture_output=True, text=True)
            return result.stdout
        except subprocess.CalledProcessError as e:
            return None

    def download_files(self):
        self.log("Downloading CosmOS files...")
        self.progress['value'] = 20
        self.root.update_idletasks()
        
        zip_path = os.path.join(os.getcwd(), "cosmos.zip")
        try:
            urllib.request.urlretrieve(DOWNLOAD_URL, zip_path)
            self.progress['value'] = 50
            self.log("Extracting files...")
            with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                zip_ref.extractall(INSTALL_DIR)
            os.remove(zip_path)
            self.progress['value'] = 80
            return True
        except Exception as e:
            messagebox.showerror("Error", f"Download failed: {e}")
            return False

    def start_install(self, method):
        if not self.download_files():
            return

        if method == "docker":
            self.log("Setting up Docker server...")
            server_path = os.path.join(INSTALL_DIR, "deployment/server")
            if self.run_cmd(f"cd {server_path} && docker compose up -d"):
                self.log("Server started successfully!")
            else:
                messagebox.showwarning("Warning", "Docker setup failed. Please ensure Docker Desktop is running.")
        
        elif method == "bare":
            self.log("Running bare metal setup...")
            os_type = platform.system()
            if os_type == "Windows":
                script = os.path.join(INSTALL_DIR, "deployment/windows/bare_metal_install.ps1")
                self.run_cmd(f"powershell.exe -ExecutionPolicy Bypass -File {script}")
            elif os_type == "Darwin":
                script = os.path.join(INSTALL_DIR, "deployment/mac/bare_metal_install.sh")
                self.run_cmd(f"chmod +x {script} && {script}")
            self.log("Bare metal dependencies installed.")

        self.progress['value'] = 100
        self.log("Installation complete!")
        self.launch_client()

    def launch_client(self):
        client_path = os.path.join(INSTALL_DIR, "deployment/electron_app/build/CosmOS")
        if platform.system() == "Windows":
            client_path += ".exe"
            self.run_cmd(f"start {client_path}")
        elif platform.system() == "Darwin":
            self.run_cmd(f"open {client_path}")
        else:
            self.log("Client launch not supported on this OS.")

if __name__ == "__main__":
    root = tk.Tk()
    app = CosmosInstaller(root)
    root.mainloop()
