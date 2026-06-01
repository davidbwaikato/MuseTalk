#!/bin/bash

# Set the checkpoints directory
CheckpointsDir="models"

# Create necessary directories
mkdir -p models/musetalk models/musetalkV15 models/syncnet models/dwpose models/face-parse-bisent models/sd-vae models/whisper

# Install required packages
#pip install -U "huggingface_hub[cli]"
#pip install gdown

pip install hf

# Set HuggingFace mirror endpoint
echo "----"
echo "Suppressing the setting of the HF_ENDPOINT mirror, as not all the models appear to be stored there"
echo "----"
#export HF_ENDPOINT=https://hf-mirror.com

## Download MuseTalk V1.0 weights
#hf download TMElyralab/MuseTalk \
#  --local-dir $CheckpointsDir \
#  "musetalk/musetalk.json" "musetalk/pytorch_model.bin"
#
## Download MuseTalk V1.5 weights (unet.pth)
#hf download TMElyralab/MuseTalk \
#  --local-dir $CheckpointsDir \
#  "musetalkV15/musetalk.json" "musetalkV15/unet.pth"

echo "----"
echo "Changed 'hf download TMElyralab/MuseTalk' to be the same as its DOS bat counterpart"
echo "----"

# Download MuseTalk V1.0 weights and V1.5 weights (unet.pth)
hf download TMElyralab/MuseTalk \
  --local-dir $CheckpointsDir

echo "----"
echo "Python code for model now expects Musetalk config file to be 'config.json' not 'musetalk.json'"
echo "Copying models/musetalk/musetalk.json => models/musetalk/config.json"
/bin/cp models/musetalk/musetalk.json  models/musetalk/config.json

echo "Python code for model now expects MusetalkV15 config file to be 'config.json' not 'musetalk.json'"
echo "Copying models/musetalkV15/musetalk.json => models/musetalkV15/config.json"
/bin/cp models/musetalkV15/musetalk.json  models/musetalkV15/config.json
echo "----"


    

# Download SD VAE weights
hf download stabilityai/sd-vae-ft-mse \
  --local-dir $CheckpointsDir/sd-vae \
  "config.json" "diffusion_pytorch_model.bin"

# Download Whisper weights
hf download openai/whisper-tiny \
  --local-dir $CheckpointsDir/whisper \
  "config.json" "pytorch_model.bin" "preprocessor_config.json"

# Download DWPose weights
hf download yzd-v/DWPose \
  --local-dir $CheckpointsDir/dwpose \
  "dw-ll_ucoco_384.pth"

# Download SyncNet weights
hf download ByteDance/LatentSync \
  --local-dir $CheckpointsDir/syncnet \
  "latentsync_syncnet.pt"

echo "----"
echo "Based on download_weights.bat, replacing use of 'gdown' and 'curl' commands"
echo "for '79999_iter.pth' and 'resnet18-5c106cde.pth' with 'hf download ...'"
echo "----"

hf download ManyOtherFunctions/face-parse-bisent \
   --local-dir $CheckpointsDir/face-parse-bisent "79999_iter.pth" "resnet18-5c106cde.pth"

# Download Face Parse Bisent weights
#echo "----"
#echo "Altered gdown command as it no longer supports --id argument"
#echo "=> Needs to be the final argument given on the command line"
#echo "----"
##gdown --id 154JgKpzCPW82qINcVieuPH3fZ2e0P812 -O $CheckpointsDir/face-parse-bisent/79999_iter.pth
#gdown -O "models/face-parse-bisent/79999_iter.pth" 154JgKpzCPW82qINcVieuPH3fZ2e0P812
#
#curl -L https://download.pytorch.org/models/resnet18-5c106cde.pth \
#  -o $CheckpointsDir/face-parse-bisent/resnet18-5c106cde.pth

echo "✅ All weights have been downloaded successfully!" 
