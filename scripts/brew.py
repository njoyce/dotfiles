import os
import subprocess

__all__ = [
    "call",
    "BrewError",
]

BREW = os.getenv("BREW", "/usr/local/bin/brew")


class BrewError(Exception):
    def __init__(self, args, retcode, stdout, stderr):
        self.args = args
        self.retcode = retcode
        self.stdout = stdout
        self.stderr = stderr


def call(*args):
    cmd = [BREW] + list(args)

    proc = subprocess.Popen(
        " ".join(cmd),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=True
    )

    if proc.wait() != 0:
        raise BrewError(
            list(args),
            proc.returncode,
            proc.stdout,
            proc.stderr
        )

    return proc.stdout
