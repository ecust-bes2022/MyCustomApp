import sys
import os
import string
from pathlib import Path
from configparser import ConfigParser


def __scripts_path():
    if sys.platform.startswith("win"):
        return Path("venv/Scripts")
    return Path("venv/bin")


def __path_separator():
    if sys.platform.startswith("darwin"):
        return ":"
    return ";"


def pip():
    return Path(f"{__scripts_path()}/pip")


def python():
    return Path(f"{__scripts_path()}/python")


def pyside6_rcc():
    return Path(f"{__scripts_path()}/pyside6-rcc")


def pyside6_metaobjectdump():
    return Path(f"{__scripts_path()}/pyside6-metaobjectdump")


def pyside6_qmltyperegistrar():
    return Path(f"{__scripts_path()}/pyside6-qmltyperegistrar")


def pyside6_l_update():
    return Path(f"{__scripts_path()}/pyside6-lupdate")


def pyside6_l_release():
    return Path(f"{__scripts_path()}/pyside6-lrelease")


def environment():
    environ = os.environ.copy()
    current = os.environ.get('PYTHONPATH', '')
    work_path = str(Path().absolute())
    if current != '':
        work_path = work_path + __path_separator() + current
    environ["PYTHONPATH"] = work_path
    return environ


def read_properties(file_path):
    config = ConfigParser(allow_no_value=True)
    config.optionxform = str
    config.read(file_path)
    _properties = {}
    for section in config.sections():
        for _key, _value in config.items(section):
            _properties[_key] = _value
    return _properties


properties = read_properties("config.properties")


def application_id():
    return properties.get('appId', '')


def application_name():
    return properties.get('appName', '')


def application_company():
    return properties.get('company', '')


def application_copyright():
    return properties.get('copyright', '')


def application_domain():
    return properties.get('domain', '')


def application_version():
    return properties.get('version', '')


def build_name():
    return properties.get('projectName', '')


def build_hotload():
    return properties.get('hotLoad', '')


def build_exclude_files():
    files_str = properties.get('excludeFiles', '').replace("\n", "").replace("\\", "")
    return files_str.split(',')


def build_project_path():
    return str(Path(build_name()).absolute().as_posix())


def generate_python_file(output_file, mapping=None):
    target = dict(
        application_id=application_id(),
        application_name=application_name(),
        application_company=application_company(),
        application_copyright=application_copyright(),
        application_domain=application_domain(),
        application_version=application_version(),
        build_name=build_name(),
        build_hotreload=build_hotload(),
        build_project_path=build_project_path()
    )
    if mapping is None:
        mapping = dict()
    for key, value in target.items():
        if key in mapping:
            target[key] = mapping[key]
    template = string.Template("""\
application_id = "${application_id}"
application_name = "${application_name}"
application_company = "${application_company}"
application_copyright = "${application_copyright}"
application_domain = "${application_domain}"
application_version = "${application_version}"
build_name = "${build_name}"
build_hotreload = "${build_hotreload}"
build_project_path = "${build_project_path}"
""")
    rendered_content = template.substitute(target)
    with open(output_file, 'w', encoding='utf-8') as file:
        file.write(rendered_content)


def generateTemplateFile(source, dist, _mapping):
    source_path = source.absolute()
    dist_path = dist.absolute()
    with open(source_path, 'r', encoding='utf-8') as _file:
        content = _file.read()
    template = string.Template(content)
    rendered_content = template.substitute(_mapping)
    dist_path.parent.mkdir(parents=True, exist_ok=True)
    with open(dist_path, 'w', encoding='utf-8') as _file:
        _file.write(rendered_content)
