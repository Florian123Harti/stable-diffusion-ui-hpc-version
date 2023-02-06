#!/bin/bash

SD_PATH=`pwd`
if [ -e "installer_files/env" ]; then
    export INSTALL_ENV_DIR="$(pwd)/installer_files/env"
fi

export PATH="$(pwd)/installer_files/env/bin:$PATH";
CONDA_BASEPATH=$(conda info --base)

source "$CONDA_BASEPATH/etc/profile.d/conda.sh" # avoids the 'shell not initialized' error
conda activate || fail "Failed to activate conda"

export PYTHONPATH="$INSTALL_ENV_DIR/lib/python3.8/site-packages"
echo "PYTHONPATH=$PYTHONPATH"

which python
python --version

export SD_UI_PATH=`pwd`/ui
cd stable-diffusion
echo Start uvicorn server ...

uvicorn main:server_api --app-dir "$SD_UI_PATH" --port 8000 --host 0.0.0.0 --log-level error
