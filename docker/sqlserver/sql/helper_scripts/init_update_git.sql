/*
By default, executing user: "NT Service\MSSQLLaunchpad".
does not have access to file system:
https://stackoverflow.com/questions/56611792/sql-server-python-machine-learning-cannot-access-filesystem
*/
EXECUTE sp_execute_external_script 
	@language = N'Python',
	@script = N'
import os
import platform
import subprocess

local_path_windows = "/temp/"
local_path_linux = "/usr/src/app/git/"
git_url = "https://github.com/jbmadsen/dbt-demo.git"
git_folder = "dbt-demo"
remote_branch = "origin/master"


def terminal_command(args):
    process = subprocess.Popen(args, stdout=subprocess.PIPE)
    output, error = process.communicate(timeout=60)
    if output is not None:
        output = output.decode("utf-8")
    if error is not None:
        error = error.decode("utf-8")
    return (output, error)

def check_git_installed():
    print("Checking for Git installation")
    (_, error) = terminal_command(["git", "--version"])
    if error:
        return False
    return True

def git_clone_or_update(url, target_path):
    if not os.path.exists(target_path):
        print("Cloning Git repo")
        output, error = terminal_command(["git", "clone", url])
        if error or "fatal" in output: 
            return False
        return True
    else:
        print("Fetching and updating Git repo")
        os.chdir(target_path)
        output, error = terminal_command(["git", "fetch", "--all"])
        if error or "fatal" in output: 
            return False
        _, error = terminal_command(["git", "reset", "--hard", remote_branch])
        if error or "fatal" in output: 
            return False
        return True

def create_folder(create_dir):
    if not os.path.exists(create_dir):
        print(f"Creating folder: {create_dir}")
        terminal_command(["mkdir", create_dir])
        #os.makedirs(create_dir)

def run():
    if not check_git_installed():
        print("Git not found on system")
        return
    current_platform = platform.system() # Windows or Linux
    print(f"Executing on target platform: {current_platform}")
    target_dir = local_path_windows if current_platform == "Windows" else local_path_linux
    create_folder(target_dir)
    os.chdir(target_dir)
    print(f"Setting working directory for working with Git: {os.getcwd()}")
    response = git_clone_or_update(git_url, git_folder)
    if response:
        print(f"Final response: {response}")

run()


OutputDataSet = InputDataSet', 
	@input_data_1 = N'select 1'
GO
