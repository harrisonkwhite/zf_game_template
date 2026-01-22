cmake_minimum_required(VERSION 3.28)

project(zf_game_template LANGUAGES C CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(zeta_framework)

add_executable(zf_game_template
    src/entry.cpp
    src/game.cpp

    src/pch.h
    src/game.h
)

target_precompile_headers(zf_game_template PRIVATE src/pch.h)
target_compile_features(zf_game_template PRIVATE cxx_std_20)
target_link_libraries(zf_game_template PRIVATE zf_game_lib)
target_compile_definitions(zf_game_template PRIVATE _CRT_SECURE_NO_WARNINGS)

set_target_properties(zf_game_template PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "$<TARGET_FILE_DIR:zf_game_template>"
)

if (WIN32)
    target_link_options(zf_game_template PRIVATE
        $<$<NOT:$<CONFIG:Debug>>:/SUBSYSTEM:WINDOWS>
        $<$<NOT:$<CONFIG:Debug>>:/ENTRY:mainCRTStartup>
    )
endif()

add_custom_target(build_assets
    COMMAND zf_asset_builder "zf_asset_build_instrs.json"
    COMMAND ${CMAKE_COMMAND} -E rm -rf "$<TARGET_FILE_DIR:zf_game_template>/assets"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "assets" "$<TARGET_FILE_DIR:zf_game_template>/assets"
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    COMMENT "Building assets..."
    VERBATIM
)

add_dependencies(zf_game_template build_assets)
