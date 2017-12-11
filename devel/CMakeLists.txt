# todo look for astyle
add_custom_target( stylish ${PROJECT_SOURCE_DIR}/devel/apply_style_guidelines.sh ${PROJECT_SOURCE_DIR} SOURCES apply_style_guidelines.sh astyle-header-options astyle-options  )

# remaining dev files
list( APPEND dev_src Fittino.xmi )
list( APPEND dev_src Models.xmi )
list( APPEND dev_src FittinoClassTemplate.h )
list( APPEND dev_src FittinoClassTemplate.cpp )
list( APPEND dev_src FittinoOptimizerTemplate.h )
list( APPEND dev_src FittinoOptimizerTemplate.cpp )

add_custom_target( dev SOURCES ${dev_src} )
