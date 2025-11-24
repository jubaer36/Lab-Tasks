# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/ProjuktiByBuku_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/ProjuktiByBuku_autogen.dir/ParseCache.txt"
  "ProjuktiByBuku_autogen"
  )
endif()
