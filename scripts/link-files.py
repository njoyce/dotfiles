#!/usr/bin/env python

import os
import subprocess
import sys


def get_source_directory():
    return os.path.abspath(os.path.expanduser(sys.argv[1]))


def get_dest_directory():
    return os.path.abspath(os.path.expanduser(sys.argv[2]))


def main():
    for file_path in os.listdir(get_source_directory()):
        source_path = os.path.join(get_source_directory(), file_path)
        dest_path = os.path.join(get_dest_directory(), file_path)

        if os.path.exists(dest_path):
            if not os.path.islink(dest_path):
                sys.stderr.write(
                    "{} already exists - not overwriting\n".format(dest_path)
                )

                return 1

        if os.path.islink(dest_path):
            link_dest = os.readlink(dest_path)

            if link_dest != source_path:
                sys.stderr.write(
                    "{} does not link to dotfiles {!r} - not overwriting\n".format(
                        link_dest, file_path
                    )
                )

                return 1

    for file_path in os.listdir(get_source_directory()):
        source_path = os.path.join(get_source_directory(), file_path)
        dest_path = os.path.join(get_dest_directory(), file_path)

        if not os.path.islink(dest_path):
            os.symlink(source_path, dest_path)


if __name__ == "__main__":
    sys.exit(main() or 0)
