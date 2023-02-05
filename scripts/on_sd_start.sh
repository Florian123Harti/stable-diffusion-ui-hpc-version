#!/bin/bash

source ./scripts/functions.sh

cp sd-ui-files/scripts/on_env_start.sh scripts/
cp sd-ui-files/scripts/bootstrap.sh scripts/

# activate the installer env
CONDA_BASEPATH=$(conda info --base)
source "$CONDA_BASEPATH/etc/profile.d/conda.sh" # avoids the 'shell not initialized' error

conda activate || fail "Failed to activate conda"

# remove the old version of the dev console script, if it's still present
if [ -e "open_dev_console.sh" ]; then
    rm "open_dev_console.sh"
fi

python -c "import os; import shutil; frm = 'sd-ui-files/ui/hotfix/9c24e6cd9f499d02c4f21a033736dabd365962dc80fe3aeb57a8f85ea45a20a3.26fead7ea4f0f843f6eb4055dfd25693f1a71f3c6871b184042d4b126244e142'; dst = os.path.join(os.path.expanduser('~'), '.cache', 'huggingface', 'transformers', '9c24e6cd9f499d02c4f21a033736dabd365962dc80fe3aeb57a8f85ea45a20a3.26fead7ea4f0f843f6eb4055dfd25693f1a71f3c6871b184042d4b126244e142'); shutil.copyfile(frm, dst) if os.path.exists(dst) else print(''); print('Hotfixed broken JSON file from OpenAI');" 

# Caution, this file will make your eyes and brain bleed. It's such an unholy mess.
# Note to self: Please rewrite this in Python. For the sake of your own sanity.

if [ "$test_sd2" == "" ]; then
    export test_sd2="N"
fi

if [ -e "scripts/install_status.txt" ] && [ `grep -c sd_git_cloned scripts/install_status.txt` -gt "0" ]; then
    echo "Stable Diffusion's git repository was already installed. Updating.."

    cd stable-diffusion

    git remote set-url origin https://github.com/easydiffusion/diffusion-kit.git

    git reset --hard
    git pull

    if [ "$test_sd2" == "N" ]; then
        git -c advice.detachedHead=false checkout 7f32368ed1030a6e710537047bacd908adea183a
    elif [ "$test_sd2" == "Y" ]; then
        git -c advice.detachedHead=false checkout 733a1f6f9cae9b9a9b83294bf3281b123378cb1f
    fi

    cd ..
else
    printf "\n\nDownloading Stable Diffusion..\n\n"

    if git clone https://github.com/easydiffusion/diffusion-kit.git stable-diffusion ; then
        echo sd_git_cloned >> scripts/install_status.txt
    else
        fail "git clone of basujindal/stable-diffusion.git failed"
    fi

    cd stable-diffusion
    git -c advice.detachedHead=false checkout 7f32368ed1030a6e710537047bacd908adea183a

    cd ..
fi

cd stable-diffusion

if [ `grep -c conda_sd_env_created ../scripts/install_status.txt` -gt "0" ]; then
    echo "Packages necessary for Stable Diffusion were already installed"

    conda activate ./env || fail "conda activate failed"
else
    printf "\n\nDownloading packages necessary for Stable Diffusion..\n"
    printf "\n\n***** This will take some time (depending on the speed of the Internet connection) and may appear to be stuck, but please be patient ***** ..\n\n"

    # prevent conda from using packages from the user's home directory, to avoid conflicts
    export PYTHONNOUSERSITE=1
    export PYTHONPATH="$(pwd):$(pwd)/env/lib/site-packages"

    if conda env create --prefix env --force -f environment.yaml ; then
        echo "Installed. Testing.."
    else
        fail "'conda env create' failed"
    fi

    conda activate ./env || fail "conda activate failed"

    out_test=`python -c "import torch; import ldm; import transformers; import numpy; import antlr4; print(42)"`
    if [ "$out_test" != "42" ]; then
        fail "Dependency test failed"
    fi

    echo conda_sd_env_created >> ../scripts/install_status.txt
fi

# allow rolling back the sdkit-based changes
if [ -e "src-old" ] && [ ! -e "src" ]; then
    mv src-old src

    if [ -e "ldm-old" ]; then rm -r ldm-old; fi

    pip uninstall -y sdkit stable-diffusion-sdkit
fi

if [ `grep -c conda_sd_gfpgan_deps_installed ../scripts/install_status.txt` -gt "0" ]; then
    echo "Packages necessary for GFPGAN (Face Correction) were already installed"
else
    printf "\n\nDownloading packages necessary for GFPGAN (Face Correction)..\n"

    export PYTHONNOUSERSITE=1
    export PYTHONPATH="$(pwd):$(pwd)/env/lib/site-packages"

    out_test=`python -c "from gfpgan import GFPGANer; print(42)"`
    if [ "$out_test" != "42" ]; then
        echo "EE The dependency check has failed. This usually means that some system libraries are missing."
	echo "EE On Debian/Ubuntu systems, this are often these packages: libsm6 libxext6 libxrender-dev"
	echo "EE Other Linux distributions might have different package names for these libraries."
        fail "GFPGAN dependency test failed"
    fi

    echo conda_sd_gfpgan_deps_installed >> ../scripts/install_status.txt
fi

if [ `grep -c conda_sd_esrgan_deps_installed ../scripts/install_status.txt` -gt "0" ]; then
    echo "Packages necessary for ESRGAN (Resolution Upscaling) were already installed"
else
    printf "\n\nDownloading packages necessary for ESRGAN (Resolution Upscaling)..\n"

    export PYTHONNOUSERSITE=1
    export PYTHONPATH="$(pwd):$(pwd)/env/lib/site-packages"

    out_test=`python -c "from basicsr.archs.rrdbnet_arch import RRDBNet; from realesrgan import RealESRGANer; print(42)"`
    if [ "$out_test" != "42" ]; then
        fail "ESRGAN dependency test failed"
    fi

    echo conda_sd_esrgan_deps_installed >> ../scripts/install_status.txt
fi

if [ `grep -c conda_sd_ui_deps_installed ../scripts/install_status.txt` -gt "0" ]; then
    echo "Packages necessary for Stable Diffusion UI were already installed"
else
    printf "\n\nDownloading packages necessary for Stable Diffusion UI..\n\n"

    export PYTHONNOUSERSITE=1
    export PYTHONPATH="$(pwd):$(pwd)/env/lib/site-packages"

    if conda install -c conda-forge --prefix ./env -y uvicorn fastapi ; then
        echo "Installed. Testing.."
    else
        fail "'conda install uvicorn' failed" 
    fi

    if ! command -v uvicorn &> /dev/null; then
        fail "UI packages not found!"
    fi

    echo conda_sd_ui_deps_installed >> ../scripts/install_status.txt
fi

if python -m picklescan --help >/dev/null 2>&1; then
    echo "Picklescan is already installed."
else
    echo "Picklescan not found, installing."
    pip install picklescan || fail "Picklescan installation failed."
fi

if python -c "import safetensors" --help >/dev/null 2>&1; then
    echo "SafeTensors is already installed."
else
    echo "SafeTensors not found, installing."
    pip install safetensors || fail "SafeTensors installation failed."
fi


if [ "$test_sd2" == "Y" ]; then
    pip install open_clip_torch==2.0.2
fi

if [ `grep -c sd_install_complete ../scripts/install_status.txt` -gt "0" ]; then
    echo sd_weights_downloaded >> ../scripts/install_status.txt
    echo sd_install_complete >> ../scripts/install_status.txt
fi

printf "\n\nStable Diffusion is ready!\n\n"

# SD_PATH=`pwd`
# export PYTHONPATH="$SD_PATH:$SD_PATH/env/lib/python3.8/site-packages"
# echo "PYTHONPATH=$PYTHONPATH"

# which python
# python --version

# cd ..
# export SD_UI_PATH=`pwd`/ui
# cd stable-diffusion

# uvicorn server:app --app-dir "$SD_UI_PATH" --port ${SD_UI_BIND_PORT:-9000} --host ${SD_UI_BIND_IP:-0.0.0.0}

# read -p "Press any key to continue"
