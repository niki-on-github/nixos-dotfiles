#!/usr/bin/env python3

import argparse
import os
import re
import sys
import subprocess
from typing import List


DEBUG: bool = False


def debug(msg):
    if DEBUG:
        os.system(f"notify-send 'DEBUG' '{msg}'")


def open_drag_and_drop_window(path: str, sections: List[str]) -> None:
    debug("open_drag_and_drop_window")
    file_paths = [
            os.path.join(path, x) \
            for x in sections \
            if os.path.exists(os.path.join(path, x))
        ]

    debug(file_paths)
    file_list_str = "'" + "'".join(file_paths) + "'"
    cmd = f"dragon-drop -x {file_list_str}"

    debug(cmd)
    os.system(cmd)


def open_python_trace(line: str) -> None:
    debug("open_python_trace")
    result = re.match(r".*File \"(.+)\", line (\d+).*", line)
    if result is None:
        debug("no match found")
        return

    file_path = result.group(1)
    line_number = result.group(2)

    debug(f"{file_path}:{line_number}")
    cmd = f"tmux display-popup -w 75% -E 'vim +{line_number} {file_path}'"
    subprocess.call(cmd, shell = True)


if __name__ == "__main__":
    sys.exit()
    parser = argparse.ArgumentParser()
    parser.add_argument(dest='path', help="pane path")
    parser.add_argument(dest='line', help="mouse line")
    parser.add_argument(dest='word', help="mouse word")

    args = parser.parse_args()

    sections = re.findall(f"[^ ]*{args.word}[^ ]*", args.line)

    if all(x in args.line for x in [".py\"", " line "]):
        open_python_trace(args.line)
    else:
        open_drag_and_drop_window(args.path, sections)

