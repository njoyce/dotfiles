#!/usr/bin/env python

import os
import subprocess
import sys

import brew


def get_formulae():
    for line in sys.stdin.readlines():
        line = line.strip()

        if line.startswith("#"):
            continue

        yield line


def is_formulae_installed(formulae):
    try:
        brew.call("ls", "--versions", formulae)
    except brew.BrewError:
        return False

    return True


def install_formulae(formulae):
    try:
        brew.call("install", formulae)
    except brew.BrewError:
        sys.stderr.write("Unable to install formulae {}\n".format(formulae))

        return False

    return True


if __name__ == "__main__":
    for formulae in get_formulae():
        if is_formulae_installed(formulae):
            sys.stdout.write("{} is already installed\n".format(formulae))

            continue

        sys.stdout.write("Installing {}\n".format(formulae))

        if install_formulae(formulae):
            raise SystemExit(1)
