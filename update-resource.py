from pathlib import Path
import subprocess

import env


def generate_resource(_project_path):
    subprocess.run([env.pyside6_rcc(), Path(_project_path) / 'resource.qrc', "-o",
                    Path(_project_path) / 'resource_rc.py'])


if __name__ == "__main__":
    generate_resource("FluentUI")
    generate_resource(env.build_name())
