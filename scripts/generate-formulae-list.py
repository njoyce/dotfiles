#!/usr/bin/env python

import json
import os
import subprocess
import sys

import brew


def get_formulae_info(formulae):
    try:
        out = brew.call("info", "--json=v1", formulae)
    except brew.BrewError:
        sys.stderr.write(
            "Unable to get info for formulae {}\n".format(formulae)
        )

        raise RuntimeError

    data = json.loads(out.read())

    assert len(data) == 1

    return data[0]


def get_top_level_formulae():
    try:
        out = brew.call("leaves")
    except brew.BrewError:
        sys.stderr.write("Unable to get top level dependencies\n")

        raise RuntimeError

    for line in out.readlines():
        line = line.strip()

        yield line


def get_used_options(formulae):
    formulae_info = get_formulae_info(formulae)

    installed_version = formulae_info["linked_keg"]

    if not installed_version:
        installed_version = formulae_info["versions"]["stable"]

    for installed_meta in formulae_info["installed"]:
        if installed_meta["version"] != installed_version:
            continue

        return installed_meta["used_options"]

    raise RuntimeError("Can't get here: {}".format(formulae))


def output_formulae_txt():
    for formulae in get_top_level_formulae():
        used_options = get_used_options(formulae)

        yield "{} {}".format(formulae, " ".join(used_options)).strip()


if __name__ == "__main__":
    for line in output_formulae_txt():
        sys.stdout.write(line + "\n")
