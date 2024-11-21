import subprocess
import sys

import env

if __name__ == "__main__":
    subprocess.run([sys.executable, "-m", "venv", "venv"])
    subprocess.run([env.pip(), "install", "-r", "requirements.txt"])
