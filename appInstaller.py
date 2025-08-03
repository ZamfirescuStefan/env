import subprocess
import platform
import json
import shutil
import sys


class Installer:
    def __init__(self, path, dry_run):
        self.system = platform.system();
        self.dry_run = dry_run;
        self.config_path = path
        self.install_command = {
                "Darwin" : "brew install ",
                "Linux" : "sudo apt install -y "
                }

    def is_installed(self, app_name):
        return shutil.which(app_name) is not None


    def install_app(self, cmd_info):
        if not self.is_installed(cmd_info['name']):
            exec_cmd = self.install_command[self.system] + cmd_info['name']
            self.exec_term_cmd(exec_cmd)
        else:
            self.log_warning(f"The application {cmd_info['name']} is already installed!")


    def run_cmd(self, cmd):
        self.exec_term_cmd(cmd['name'])


    def loadJson(self):
        with open(self.config_path, 'r') as file:
            data = json.load(file)
            data = data['commands']
            for cmd_info in data:
                cmd_os = cmd_info.get('os', None)
                if not cmd_os or self.system in cmd_os:
                    if 'app' not in cmd_info or cmd_info['app'] is False:
                        self.run_cmd(cmd_info)
                    else:
                        self.install_app(cmd_info)
                else:
                    self.log_warning(f"Skipped command: {cmd_info['name']}")


    def install(self):
        self.loadJson()

    def log_warning(self, arg):
        print(f"\033[33m[WARNING]: " + arg + '\033[0m')

    def log_error(self, arg):
        print(f"\033[31m[ERROR]: " + arg + '\033[0m')

    def log_info(self, arg):
        print(f"\033[32m[INFO]: " + arg + '\033[0m')

    def exec_term_cmd(self, cmd):
        if not self.dry_run:
            try:
                self.log_info('Running command: ' + cmd)
                subprocess.run(cmd, shell=True, check=True);
            except Exception as e:
                self.log_error('Command failed: ' + cmd + f". Error message {e}")
        else:
            self.log_info('DRY RUN: ' + cmd)


def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("json_file", help="Path to JSON file")
    parser.add_argument("--dry", action="store_true", help="Dry run mode")
    args = parser.parse_args()

    obj = Installer(args.json_file, args.dry)
    obj.install()
    # obj = Installer(sys.argv[1], True)
    # obj.install()


if __name__ == "__main__":
    main()



