#!/bin/bash

# Directory to search for image files
directory="."

image_files=()
while IFS= read -r -d $'\0' file; do
    image_files+=("$(basename "$file")")
done < <(find "$directory" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)
# Print the list of image files
echo "Image Files:"
for image_file in "${image_files[@]}"; do
  #echo "'s/$image_file/rc\/$image_file/g'"
  echo "grep -rl \"$image_file\" ./ --exclude-dir=.git --include=*.md | xargs sed -i 's/$image_file/rc\/$image_file/g'"
  #grep -rl "$image_file" ./ --exclude-dir=.git --include=*.md
  #break
  #grep -rl "$image_file" ./ --exclude-dir=.git --include=*.md
  #grep -rl "Pasted Image 20230713105200_463.png" ./ --exclude-dir=.git --include=*.md
done

