#!/bin/sh
curl -s \
 -d "compilation_level=SIMPLE_OPTIMIZATIONS" \
 -d "output_format=text" \
 -d "output_info=compiled_code" \
 --data-urlencode "js_code@pwadapter.js" \
 "https://closure-compiler.appspot.com/compile" \
 -o "pwadapter.min.js"