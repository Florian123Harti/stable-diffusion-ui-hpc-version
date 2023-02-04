#!/bin/bash

SD_PATH=`pwd`
CONDA_BASEPATH=$(conda info --base)

source "$CONDA_BASEPATH/etc/profile.d/conda.sh" # avoids the 'shell not initialized' error
conda activate || fail "Failed to activate conda"

export PYTHONPATH="$INSTALL_ENV_DIR/lib/python3.8/site-packages"
echo "PYTHONPATH=$PYTHONPATH"

which python
python --version

cd ..
export SD_UI_PATH=`pwd`/ui
cd stable-diffusion
echo Start uvicorn server ...

uvicorn main:server_api --app-dir "$SD_UI_PATH" --port ${SD_UI_BIND_PORT:-9000} --host ${SD_UI_BIND_IP:-0.0.0.0} --log-level error
