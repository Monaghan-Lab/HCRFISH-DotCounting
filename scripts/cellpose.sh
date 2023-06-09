#!/bin/bash

conda activate cellpose

# Edit the parameters below for your segmentation
# Descriptions of parameters and additional flags are available in the cellpose documentation
# Be sure to edit the file path to your images!!!
python -m cellpose \
  --verbose \
  --use_gpu \
  --dir </path/to/images/> \
  --pretrained_model cyto2 \
  --chan 0 --chan2 0 \
  --diameter 0 \
  --save_txt \
  --no_npy
