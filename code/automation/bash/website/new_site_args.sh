#!/usr/bin/env bash
#---
# Excerpted from "Small, Sharp, Software Tools",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/bhcldev for more book information.
#---

set -e

if [ $# -eq 0 ]; then
  read -p "Enter the name of the directory to create: " directory

  if [ -z "$directory" ]; then
    echo "You didn't enter anything. Exiting."
    exit 1
  fi
else
  directory=$1
fi
mkdir -p "${directory}"/{images,scripts,styles}
touch "${directory}"/styles/style.css
cat << 'EOF' > "${directory}"/index.html
<!DOCTYPE html>
<html lang="en-US">
  <head>
    <meta charset="utf-8">
    <title>My Website</title>
    <link rel="stylesheet" href="styles/style.css">
  </head>
  <body>
  </body>
</html>
EOF
