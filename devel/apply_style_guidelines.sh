#!/bin/bash

ROOT_DIR=$1

apply_style_guidelines() {

    MODULENAME=$1

    echo -e "\nApplying style guidelines to module \"${MODULENAME}\"...\n"

    # Check if include directory exists.

    if [ -d "$ROOT_DIR/sources/${MODULENAME}/include" ]; then

        # Loop over all files.

        for file in $ROOT_DIR/sources/${MODULENAME}/include/*; do

            # If there are files in the directory, apply style guidelines via astyle.

            if [ -e "$file" ]; then

                astyle --options=$ROOT_DIR/devel/astyle-header-options $file

            fi

        done

        # Remove .orig files if there are any.

        for file in $ROOT_DIR/sources/${MODULENAME}/include/*.orig; do

            if [ -e "$file" ]; then

                rm $file

            fi

        done

    fi

    # Do the same with source files.

    if [ -d "$ROOT_DIR/sources/${MODULENAME}/src" ]; then

        for file in $ROOT_DIR/sources/${MODULENAME}/src/*; do

            if [ -e "$file" ]; then

                astyle --options=$ROOT_DIR/devel/astyle-options $file

            fi

        done

        for file in $ROOT_DIR/sources/${MODULENAME}/src/*.orig; do

            if [ -e "$file" ]; then

                rm $file

            fi

        done

    fi

}

#apply_style_guidelines calculators 
apply_style_guidelines datastorages
apply_style_guidelines exceptions
apply_style_guidelines histogrammakers
apply_style_guidelines kernel 
#apply_style_guidelines models 
apply_style_guidelines optimizers
apply_style_guidelines plotters
apply_style_guidelines samplers
apply_style_guidelines tools
apply_style_guidelines variables 

echo ""
