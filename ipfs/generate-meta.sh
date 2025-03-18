#!/bin/bash

# Define the list of traits
traits=("Black_and_White" "Digital-Painting" "Floral" "Oil-Painting" "Realism" "Sci-Fi")

# Read names from the file into an array
names=()
while IFS= read -r line; do
    names+=("$line")
done < names.txt  # Ensure names.txt contains 37 unique names

# Ensure the images folder exists
if [ ! -d "images" ]; then
    echo "Error: 'images' folder not found!"
    exit 1
fi

# Create output folder if it doesn't exist
mkdir -p output

# Counter to match names with images
index=1

# Loop through all images in the images folder
for img in images/*; do
    # Extract filename without extension
    filename=$(basename "$img")
    
    # Assign a name from the list, ensuring we don't exceed the name count
    if [ "$index" -le "${#names[@]}" ]; then
        name=${names[$((index-1))]}
    else
        name="Unnamed $index"
    fi
    
    # Determine trait based on filename
    trait="Unknown"
    for t in "${traits[@]}"; do
        formatted_t=$(echo "$t" | tr '-' ' ' | tr '_' ' ' | awk '{print tolower($0)}')
        formatted_filename=$(echo "$filename" | tr '-' ' ' | tr '_' ' ' | awk '{print tolower($0)}')
        if [[ "$formatted_filename" == *"$formatted_t"* ]]; then
            trait="$formatted_t"
            break
        fi
    done
    
    # Create JSON content
    cat <<EOF > "meta/$index.json"
{
   "name":"$name",
   "description":"This is a $name",
   "image":"ipfs://QmWQdK2rhBFn3i2TwWCuzTsx2au4mvoF8TKBT5seo3K73p/$filename",
   "attributes":[
      {
         "trait_type":"Art",
         "value":"$trait"
      }
   ]
}
EOF

    echo "Generated: meta/$index.json"
    
    # Increment index
    ((index++))

done
