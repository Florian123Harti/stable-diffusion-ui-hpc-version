#!/bin/bash
echo "$(pwd)"

export PATH="$(pwd)/installer_files/env/bin:$PATH";
CONDA_BASEPATH=$(conda info --base)

source "$CONDA_BASEPATH/etc/profile.d/conda.sh" # avoids the 'shell not initialized' error
conda activate ./stable-diffusion/env

export SD_UI_PATH=`pwd`/ui

cd stable-diffusion
SD_PATH=`pwd`
export PYTHONPATH="$SD_PATH:$SD_PATH/env/lib/python3.8/site-packages"

echo Start uvicorn server ...

uvicorn server:app --app-dir "$SD_UI_PATH" --host 0.0.0.0 --port 8000
