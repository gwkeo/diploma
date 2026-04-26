#!/usr/bin/env bash
set -euo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script targets Ubuntu/Debian systems with apt-get." >&2
  exit 1
fi

PYTHON_BIN="${PYTHON_BIN:-python3}"
VENV_DIR="${VENV_DIR:-.venv}"

sudo apt-get update
sudo apt-get install -y \
  build-essential \
  cmake \
  ninja-build \
  git \
  python3-dev \
  python3-venv

"$PYTHON_BIN" -m venv "$VENV_DIR"
# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"

python -m pip install -U pip setuptools wheel
unset CC CXX || true
python -m pip install -r requirements.txt

python -c "import tick; print('tick ok')"
