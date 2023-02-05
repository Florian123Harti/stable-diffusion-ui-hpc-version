#!/bin/bash

mkdir -p "stable-diffusion/gfpgan/weights"

curl -L -k https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth > stable-diffusion/gfpgan/weights/detection_Resnet50_Final.pth

curl -L -k https://github.com/xinntao/facexlib/releases/download/v0.2.2/parsing_parsenet.pth > stable-diffusion/gfpgan/weights/parsing_parsenet.pth

