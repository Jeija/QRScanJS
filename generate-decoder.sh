#!/bin/bash

set -e

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Delete all -Werror strings from configure.ac
# Don't treat warnings as errors!
sed -i "s/ -Werror//" $CWD/configure.ac

# Generate automake files
autoreconf -i

# Configure: Disable all codes except QR code, disable all unneccesary features
# This may produce red error messages, but it is safe to ignore them (it assumes that
# emscripten is GCC and uses invalid parameters on it)
emconfigure ./configure --enable-codes=qrcode --without-x --without-jpeg --without-imagemagick --without-npapi --without-gtk --without-python --without-qt --without-xshm --disable-video --disable-pthread

# Compile!
emmake make

# Glue javascript and compiled code together
emcc -O1 -I`pwd`/include ./templates/zbar-main.c ./zbar/.libs/libzbar.a --js-library ./templates/zbar-callbacks.js -o ./decoder-content.js
sed '/\/\* EMSCRIPTEN_CODE \*\//r ./decoder-content.js' ./templates/zbar-processor-wrapper.js > ./decoder.js

echo ""
echo "If everything worked, there should now be a functional decoder.js file"
echo "Use any JavaScript Minifier to reduce its file size and thereby server bandwidth"
echo "The resulting decoder.min.js will be used by QRScanJS"
