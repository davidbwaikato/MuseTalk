@echo off
setlocal

:: Set the checkpoints directory
set CheckpointsDir=models

:: Create necessary directories
mkdir %CheckpointsDir%\musetalk
mkdir %CheckpointsDir%\musetalkV15
mkdir %CheckpointsDir%\syncnet
mkdir %CheckpointsDir%\dwpose
mkdir %CheckpointsDir%\face-parse-bisent
mkdir %CheckpointsDir%\sd-vae-ft-mse
mkdir %CheckpointsDir%\whisper

:: Install required packages
::pip install -U "huggingface_hub[hf_xet]"
pip install hf

:: Set HuggingFace endpoint
echo ----
echo Suppressing the setting of the HF_ENDPOINT mirror, as not all the models appear to be stored there
echo ----
REM set HF_ENDPOINT=https://hf-mirror.com

:: Download MuseTalk weights
hf download TMElyralab/MuseTalk --local-dir %CheckpointsDir%

echo ----
echo Python code for model now expects Musetalk config file to be 'config.json' not 'musetalk.json'
echo Copying models/musetalk/musetalk.json => models/musetalk/config.json
copy models\musetalk\musetalk.json  models\musetalk\config.json

echo Python code for model now expects MusetalkV15 config file to be 'config.json' not 'musetalk.json'
echo Copying models/musetalkV15/musetalk.json => models/musetalkV15/config.json
copy models\musetalkV15\musetalk.json  models\musetalkV15\config.json
echo ----

:: Download SD VAE weights
hf download stabilityai/sd-vae-ft-mse --local-dir %CheckpointsDir%\sd-vae "config.json" "diffusion_pytorch_model.bin" "diffusion_pytorch_model.safetensors"

:: Download Whisper weights
hf download openai/whisper-tiny --local-dir %CheckpointsDir%\whisper "config.json" "pytorch_model.bin" "preprocessor_config.json"

:: Download DWPose weights
hf download yzd-v/DWPose --local-dir %CheckpointsDir%\dwpose "dw-ll_ucoco_384.pth"

:: Download SyncNet weights
hf download ByteDance/LatentSync --local-dir %CheckpointsDir%\syncnet "latentsync_syncnet.pt"

:: Download face-parse-bisent weights
hf download ManyOtherFunctions/face-parse-bisent --local-dir %CheckpointsDir%\face-parse-bisent "79999_iter.pth" "resnet18-5c106cde.pth"

echo All weights have been downloaded successfully!
endlocal 
