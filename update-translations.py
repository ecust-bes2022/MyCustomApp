import os
import subprocess
import env
from pathlib import Path


def get_py_files_with_tr(directory):
    py_files_with_tr = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".py"):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    if 'self.tr' in f.read():
                        py_files_with_tr.append(file_path)
    return py_files_with_tr


def generateTranslations(project_name: str, localeDatas):
    project_path = Path('.') / project_name
    files = get_py_files_with_tr(Path(project_path))
    if not files:
        files = []
    for locale in localeDatas:
        ts_file_name = f"{project_name}_{locale}.ts"
        ts_file_path = f"{os.path.join('.', project_name, ts_file_name)}"
        commands = [env.pyside6_l_update(), os.path.join('.', project_name, "resource.qrc")]
        for file in files:
            commands.append(file)
        commands.append("-ts")
        commands.append(ts_file_path)
        subprocess.run(commands)
        subprocess.run([env.pyside6_l_release(), ts_file_path])


if __name__ == "__main__":
    generateTranslations("FluentUI", ["en_US", "zh_CN"])
    generateTranslations(env.build_name(), ["en_US", "zh_CN"])
