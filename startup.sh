#!/bin/bash

# Поиск ComfyUI в разных возможных директориях
COMFYUI_PATHS=(
    "./ComfyUI"
    "/ComfyUI"
    "$HOME/ComfyUI"
    "/opt/ComfyUI"
)

for path in "${COMFYUI_PATHS[@]}"; do
    if [ -d "$path" ]; then
        echo "Found ComfyUI at: $path"
        cd "$path" || exit 1
        nohup python main.py --listen 0.0.0.0 > /var/log/comfyui.log 2>&1 &
        echo "ComfyUI started on port 8188"
        break
    fi
done

if [ ! -d "$path" ]; then
    echo "Error: ComfyUI directory not found in any of the searched locations!"
    exit 1
fi

# Запуск Jupyter Lab (аналогично можно добавить поиск notebooks)
cd /notebooks || { echo "Notebooks directory not found"; exit 1; }
echo "Starting Jupyter Lab on port 8888"
jupyter lab --allow-root --no-browser --ip=0.0.0.0 --port=8888