#/bin/bash
# List all active windows and their titles, geometry and desktop

# while [ 1 ]
# do
# List all windows
windows=$(wmctrl -l -G)

# Loop through each window
    while read -r line; do
        # Get window ID
        id=$(echo "$line" | awk '{print $1}')
        # Get window desktop
        desktop=$(echo "$line" | awk '{print $2}')
        # Get window geometry
        # x
        x=$(echo "$line" | awk '{print $3}')
        # y
        y=$(echo "$line" | awk '{print $4}')
        # width
        width=$(echo "$line" | awk '{print $5}')
        # height
        height=$(echo "$line" | awk '{print $6}')
        # Get window title
        title=$(echo "$line" | awk '{$1=$2=$3=$4=$5=$6=""; print $0}')
        # Print window info
        # echo "Window ID: $id"
        # echo "Desktop: $desktop"
        # echo "X: $x"
        # echo "Y: $y"
        # echo "Width: $width"
        # echo "Height: $height"
        # echo "Title: $title"
        # echo

        preferred_width=1280
        preferred_height=1350

        # Only user Windows
        if [ "$desktop" -ne -1 ]; then
            window_x_center=$((x + width/2))

            # check if command argument is 1
            if [ "$1" = "1" ]; then
                # split through 4 screens
                

                # If the middle of the window in x axis is less than 1280
                if [ "$window_x_center" -lt "$preferred_width" ]; then
                    # Move window to the left
                    wmctrl -i -r "$id" -e 0,0,0,$preferred_width,$preferred_height
                fi

                # If the middle of the window in x axis is greater than 1280 and less than 2560
                if [ "$window_x_center" -gt "$preferred_width" ] && [ "$window_x_center" -lt "$((preferred_width*2))" ]; then
                    # Move window to the right
                    wmctrl -i -r "$id" -e 0,$preferred_width,0,$preferred_width,$preferred_height
                fi

                # If the middle of the window in x axis is greater than 2560 and less than 3840
                if [ "$window_x_center" -gt "$((preferred_width*2))" ] && [ "$window_x_center" -lt "$((preferred_width*3))" ]; then
                    # Move window to the right
                    wmctrl -i -r "$id" -e 0,$((preferred_width*2)),0,$preferred_width,$preferred_height
                fi

                # If the middle of the window in x axis is greater than 3840 and less than 5120
                if [ "$window_x_center" -gt "$((preferred_width*3))" ] && [ "$window_x_center" -lt "$((preferred_width*4))" ]; then
                    # Move window to the right
                    wmctrl -i -r "$id" -e 0,$((preferred_width*3)),0,$preferred_width,$preferred_height
                fi
            else 
                # If the middle of the window in x axis is less than 1280
                if [ "$window_x_center" -lt "$preferred_width" ]; then
                    # Move window to the left
                    wmctrl -i -r "$id" -e 0,0,0,$preferred_width,$preferred_height
                fi

                # If the middle of the window in x axis is greater than 1280 and less than 3840
                if [ "$window_x_center" -gt "$preferred_width" ] && [ "$window_x_center" -lt "$((preferred_width*3))" ]; then
                    # Move window to the right
                    wmctrl -i -r "$id" -e 0,$preferred_width,0,$((preferred_width*2)),$preferred_height
                fi

                # If the middle of the window in x axis is greater than 3840 and less than 5120
                if [ "$window_x_center" -gt "$((preferred_width*3))" ] && [ "$window_x_center" -lt "$((preferred_width*4))" ]; then
                    # Move window to the right
                    wmctrl -i -r "$id" -e 0,$((preferred_width*3)),0,$preferred_width,$preferred_height
                fi
            fi

        fi

    done <<< "$windows"
# done