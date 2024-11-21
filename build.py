import shutil
import os
import subprocess
import env
import sys

from pathlib import Path

if __name__ == "__main__":
    dist_dir = Path('dist')
    try:
        shutil.rmtree(dist_dir)
    except FileNotFoundError:
        pass
    subprocess.run([env.python(), Path('update-translations.py')])
    subprocess.run([env.python(), Path('update-resource.py')])
    env.generate_python_file(Path(f'{env.build_name()}/GlobalConfig.py'))
    path = Path(f"{env.build_name()}/main.py")
    args = [
        env.python(),
        "-m",
        "nuitka",
        "--standalone",
        "--disable-console",
        "--show-progress",
        "--plugin-enable=pyside6",
        "--include-qt-plugins=qml",
        f"--macos-app-icon={Path('favicon.icns')}",
        f"--linux-icon={Path('favicon.png')}",
        f"--windows-icon-from-ico={Path('favicon.ico')}",
        f"--output-filename={env.application_name()}",
        f"--company-name={env.application_company()}",
        f"--product-name={env.application_name()}",
        f"--file-description={env.application_name()}",
        f"--file-version={env.application_version()}",
        f"--product-version={env.application_version()}",
        f"--copyright={env.application_copyright()}",
        "--assume-yes-for-downloads",
        "--remove-output"
    ]
    if sys.platform.startswith("darwin"):
        args.append("--macos-create-app-bundle")
        args.append("--disable-ccache")
    args.append(path)
    subprocess.run(args, env=env.environment())
    os.rename("main.dist", "dist")
    if sys.platform.startswith("darwin"):
        shutil.move(Path("main.app"), dist_dir)
    excludeFiles = env.build_exclude_files()
    delete_files = []
    for root, dirs, files in os.walk(dist_dir):
        for fileName in files:
            filePath = str(Path(f"{root}/{fileName}"))
            if filePath.endswith('.qml'):
                delete_files.append(filePath)
            else:
                for excludeFile in excludeFiles:
                    if excludeFile.lower() in filePath.lower():
                        delete_files.append(filePath)
    for file in delete_files:
        try:
            os.remove(file)
            print(f'Successfully deleted {file}')
        except Exception as e:
            print(f'Error deleting {file}: {e}')

    if sys.platform.startswith("win"):
        env.generateTemplateFile(Path(".template/InstallerScript.iss.in"), Path("package/InstallerScript.iss"), dict(
            application_version=env.application_version(),
            application_id=env.application_id(),
            application_name=env.application_name(),
            application_domain=env.application_domain(),
            application_company=env.application_company(),
        ))
