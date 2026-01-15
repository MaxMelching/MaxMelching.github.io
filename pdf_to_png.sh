#!/bin/bash

# Find GitHub directory and set input path
GITHUB_DIR=$(find ~ -type d -name "GitHub" -print -quit 2>/dev/null)
if [ -z "$GITHUB_DIR" ]; then
    echo "Error: GitHub directory not found!"
    exit 1
fi

# Find Documents directory and set input path
DOCUMENTS_DIR=~/Documents

# Input and output paths
# INPUT_PATH="data"
INPUT_PATH=$GITHUB_DIR
# INPUT_PATH=$DOCUMENTS_DIR
OUTPUT_PATH="images/pdfs"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_PATH"

# List of PDF files to convert (without extension)
PDF_FILES=(
    "gwframes/examples/all_frames"
    "gwframes/examples/signal_frame"
    "gwframes/examples/source_frame"
    "gwframes/examples/celestial_frame"
    "gwframes/examples/earth"
    "gwbar/presentation_examples/basic_example"
    "gwtheme/examples/theme_design"
    "minkowski/examples/general_demo"
    "minkowski/examples/rocket"
    "minkowski/examples/synchronization_template"
    "minkowski/examples/length_contraction_template"
    "minkowski/examples/vlorentz_demo"
    "minkowski/examples/twin_paradox"
    "physics_notes/mechanics/pictures/cylindrical_coordinates"
    "physics_notes/mechanics/pictures/spherical_coordinates"
    "physics_notes/mechanics/pictures/gauss_pillow"
    "physics_notes/mechanics/pictures/spherical_coordinates_vol_el"
    #
    # "PhD/presentations/Fisher Overview/pictures/lsa_vis"
    # "PhD/presentations/Fisher Overview/pictures/lsa_alignment_interplay_vis"
    # "PhD/presentations/Fisher Overview/pictures/pe_vis_idealized_case"
    # "PhD/presentations/Fisher Overview/pictures/pe_vis_more_realistic_case"
    # "PhD/presentations/Fisher Overview/pictures/pe_vis_real_case"
)

# Convert each PDF to PNG
for file in "${PDF_FILES[@]}"; do
    input_file="${INPUT_PATH}/${file}.pdf"
    filename="${file##*/}"
    output_file="${OUTPUT_PATH}/${filename}.png"

    if [ -f "$input_file" ]; then
        echo "Converting $input_file to $output_file..."
        # magick -density 300 "$input_file" -quality 90 "$output_file"
        magick -density 300 "$input_file" -background white -alpha remove -quality 90 "$output_file"
        echo "Done" #: $output_file"
    else
        echo "Warning: $input_file not found, skipping..."
    fi
done

echo "All conversions complete!"
