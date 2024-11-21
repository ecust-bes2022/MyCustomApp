import argparse
import subprocess
from pathlib import Path
from textwrap import dedent

import env

TOOL_DESCRIPTION = dedent(f"""
                          This scripty start the application
                          """)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=TOOL_DESCRIPTION)
    parser.add_argument("-f", "--fast", action="store_true", help="Run fast start application")
    parser.add_argument("-r", "--reload", action="store_true", help="Enable hot reload")
    args = parser.parse_args()
    if not args.fast:
        subprocess.run([env.python(), Path('update-translations.py')])
        subprocess.run([env.python(), Path('update-resource.py')])
    mapping = dict()
    if args.reload:
        mapping["build_hotreload"] = 'ON'
    env.generate_python_file(Path(f'{env.build_name()}/GlobalConfig.py'), mapping)
    subprocess.run([env.python(), Path(f'{env.build_name()}/main.py')], env=env.environment())
