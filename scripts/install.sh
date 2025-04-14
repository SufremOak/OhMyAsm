#!/bin/bash

read -p "Do you want to install OhMyAsm? [y/N] " choice
case "$choice" in
    [Yy]* ) echo "Installing OhMyAsm...";;
    [Nn]* ) echo "Installation cancelled."; exit 0;;
    * ) echo "Invalid input. Installation cancelled."; exit 1;;
esac

which deno || { echo "Deno is not installed. Please install Deno first."; exit 1; }
deno install -A -q -n ohmyasm ../cli.ts

echo "Welcome to ..."
echo "____ ____ ____ ____ ____ ____ ____"
echo "||O |||h |||M |||y |||A |||s |||m ||"
echo "||__|||__|||__|||__|||__|||__|||__||"
echo "|/__\|/__\|/__\|/__\|/__\|/__\|/__\|"
echo "v0.2!"
echo "Enjoy using OhMyAsm!"
echo "Star me on github!"
echo "https://github.com/sufremoak/ohmyasm"
