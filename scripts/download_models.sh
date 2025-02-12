#!/bin/bash



mkdir -p "models/stable-diffusion"
mkdir -p "models/vae"
mkdir -p "models/hypernetwork"
echo "" > "models/stable-diffusion/Put your custom ckpt files here.txt"
echo "" > "models/vae/Put your VAE files here.txt"
echo "" > "models/hypernetwork/Put your hypernetwork files here.txt"

if [ -f "sd-v1-4.ckpt" ]; then
    model_size=`find "sd-v1-4.ckpt" -printf "%s"`

    if [ "$model_size" -eq "4265380512" ] || [ "$model_size" -eq "7703807346" ] || [ "$model_size" -eq "7703810927" ]; then
        echo "Data files (weights) necessary for Stable Diffusion were already downloaded"
    else
        printf "\n\nThe model file present at $PWD/sd-v1-4.ckpt is invalid. It is only $model_size bytes in size. Re-downloading.."
        rm sd-v1-4.ckpt
    fi
fi

if [ ! -f "sd-v1-4.ckpt" ]; then
    echo "Downloading data files (weights) for Stable Diffusion.."

    curl -L -k https://me.cmdr2.org/stable-diffusion-ui/sd-v1-4.ckpt > sd-v1-4.ckpt

    if [ -f "sd-v1-4.ckpt" ]; then
        model_size=`find "sd-v1-4.ckpt" -printf "%s"`
        if [ ! "$model_size" == "4265380512" ]; then
	    fail "The downloaded model file was invalid! Bytes downloaded: $model_size"
        fi
    else
        fail "Error downloading the data files (weights) for Stable Diffusion"
    fi
fi


if [ -f "GFPGANv1.3.pth" ]; then
    model_size=`find "GFPGANv1.3.pth" -printf "%s"`

    if [ "$model_size" -eq "348632874" ]; then
        echo "Data files (weights) necessary for GFPGAN (Face Correction) were already downloaded"
    else
        printf "\n\nThe model file present at $PWD/GFPGANv1.3.pth is invalid. It is only $model_size bytes in size. Re-downloading.."
        rm GFPGANv1.3.pth
    fi
fi

if [ ! -f "GFPGANv1.3.pth" ]; then
    echo "Downloading data files (weights) for GFPGAN (Face Correction).."

    curl -L -k https://github.com/TencentARC/GFPGAN/releases/download/v1.3.0/GFPGANv1.3.pth > GFPGANv1.3.pth

    if [ -f "GFPGANv1.3.pth" ]; then
        model_size=`find "GFPGANv1.3.pth" -printf "%s"`
        if [ ! "$model_size" -eq "348632874" ]; then
            fail "The downloaded GFPGAN model file was invalid! Bytes downloaded: $model_size"
        fi
    else
        fail "Error downloading the data files (weights) for GFPGAN (Face Correction)."
    fi
fi


if [ -f "RealESRGAN_x4plus.pth" ]; then
    model_size=`find "RealESRGAN_x4plus.pth" -printf "%s"`

    if [ "$model_size" -eq "67040989" ]; then
        echo "Data files (weights) necessary for ESRGAN (Resolution Upscaling) x4plus were already downloaded"
    else
        printf "\n\nThe model file present at $PWD/RealESRGAN_x4plus.pth is invalid. It is only $model_size bytes in size. Re-downloading.."
        rm RealESRGAN_x4plus.pth
    fi
fi

if [ ! -f "RealESRGAN_x4plus.pth" ]; then
    echo "Downloading data files (weights) for ESRGAN (Resolution Upscaling) x4plus.."

    curl -L -k https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth > RealESRGAN_x4plus.pth

    if [ -f "RealESRGAN_x4plus.pth" ]; then
        model_size=`find "RealESRGAN_x4plus.pth" -printf "%s"`
        if [ ! "$model_size" -eq "67040989" ]; then
            fail "The downloaded ESRGAN x4plus model file was invalid! Bytes downloaded: $model_size"
        fi
    else
        fail "Error downloading the data files (weights) for ESRGAN (Resolution Upscaling) x4plus"
    fi
fi


if [ -f "RealESRGAN_x4plus_anime_6B.pth" ]; then
    model_size=`find "RealESRGAN_x4plus_anime_6B.pth" -printf "%s"`

    if [ "$model_size" -eq "17938799" ]; then
        echo "Data files (weights) necessary for ESRGAN (Resolution Upscaling) x4plus_anime were already downloaded"
    else
        printf "\n\nThe model file present at $PWD/RealESRGAN_x4plus_anime_6B.pth is invalid. It is only $model_size bytes in size. Re-downloading.."
        rm RealESRGAN_x4plus_anime_6B.pth
    fi
fi

if [ ! -f "RealESRGAN_x4plus_anime_6B.pth" ]; then
    echo "Downloading data files (weights) for ESRGAN (Resolution Upscaling) x4plus_anime.."

    curl -L -k https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.4/RealESRGAN_x4plus_anime_6B.pth > RealESRGAN_x4plus_anime_6B.pth

    if [ -f "RealESRGAN_x4plus_anime_6B.pth" ]; then
        model_size=`find "RealESRGAN_x4plus_anime_6B.pth" -printf "%s"`
        if [ ! "$model_size" -eq "17938799" ]; then
            fail "The downloaded ESRGAN x4plus_anime model file was invalid! Bytes downloaded: $model_size"
        fi
    else
        fail "Error downloading the data files (weights) for ESRGAN (Resolution Upscaling) x4plus_anime."
    fi
fi


if [ -f "models/vae/vae-ft-mse-840000-ema-pruned.ckpt" ]; then
    model_size=`find models/vae/vae-ft-mse-840000-ema-pruned.ckpt -printf "%s"`

    if [ "$model_size" -eq "334695179" ]; then
        echo "Data files (weights) necessary for the default VAE (sd-vae-ft-mse-original) were already downloaded"
    else
        printf "\n\nThe model file present at models/vae/vae-ft-mse-840000-ema-pruned.ckpt is invalid. It is only $model_size bytes in size. Re-downloading.."
        rm models/vae/vae-ft-mse-840000-ema-pruned.ckpt
    fi
fi

printf "Downloading checkpoint_liberty_with_aug.pth for hardnet"
mkdir -p  ~/.cache/torch2/hub/checkpoints
curl -L -k https://github.com/DagnyT/hardnet/raw/master/pretrained/train_liberty_with_aug/checkpoint_liberty_with_aug.pth > ~/.cache/torch/hub/checkpoints/checkpoint_liberty_with_aug.pth


if [ ! -f "models/vae/vae-ft-mse-840000-ema-pruned.ckpt" ]; then
    echo "Downloading data files (weights) for the default VAE (sd-vae-ft-mse-original).."

    curl -L -k https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.ckpt > models/vae/vae-ft-mse-840000-ema-pruned.ckpt

    if [ -f "models/vae/vae-ft-mse-840000-ema-pruned.ckpt" ]; then
        model_size=`find models/vae/vae-ft-mse-840000-ema-pruned.ckpt -printf "%s"`
        if [ ! "$model_size" -eq "334695179" ]; then
            printf "\n\nError: The downloaded default VAE (sd-vae-ft-mse-original) file was invalid! Bytes downloaded: $model_size\n\n"
            printf "\n\nError downloading the data files (weights) for the default VAE (sd-vae-ft-mse-original). Sorry about that, please try to:\n  1. Run this installer again.\n  2. If that doesn't fix it, please try the common troubleshooting steps at https://github.com/cmdr2/stable-diffusion-ui/wiki/Troubleshooting\n  3. If those steps don't help, please copy *all* the error messages in this window, and ask the community at https://discord.com/invite/u9yhsFmEkB\n  4. If that doesn't solve the problem, please file an issue at https://github.com/cmdr2/stable-diffusion-ui/issues\nThanks!\n\n"
            # read -p "Press any key to continue"
            exit
        fi
    else
        printf "\n\nError downloading the data files (weights) for the default VAE (sd-vae-ft-mse-original). Sorry about that, please try to:\n  1. Run this installer again.\n  2. If that doesn't fix it, please try the common troubleshooting steps at https://github.com/cmdr2/stable-diffusion-ui/wiki/Troubleshooting\n  3. If those steps don't help, please copy *all* the error messages in this window, and ask the community at https://discord.com/invite/u9yhsFmEkB\n  4. If that doesn't solve the problem, please file an issue at https://github.com/cmdr2/stable-diffusion-ui/issues\nThanks!\n\n"
        # read -p "Press any key to continue"
        exit
    fi
fi

