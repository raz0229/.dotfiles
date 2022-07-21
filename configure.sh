#!/bin/bash

# External dependencies
# clipit
# pavucontrol
# rofi
# i3status-rust
# gsimplecal
# feh

configDIR="$HOME/.config"

# add or remove configuration file in this array
config=(
"i3/config" #i3
"clipit/clipitrc" #clipit
"fish/functions/fish_greeting.fish" #fish shell
"gtk-3.0/settings.ini" #gtk3
"i3status-rust/config.toml" #i3status
"lvim/config.lua" #lunarvim
"polybar/config" #polybar
"rofi/config.rasi" #rofi dmenu
"neofetch/config.conf" # neofetch
)

themes=(
".icons"
".fonts"
".themes"
)

for item in ${config[@]}; do
	if [ -f $item ]; then
            echo "=> Linking: $item"
            unlink $configDIR/$item
            rm -rf $configDIR/$item # removes default config
            ln -s $PWD/$item $configDIR/$item
         else
            echo "ERROR: $configDIR/$item not found. Please install it first"
         fi
done

# for other files outside $configDIR, added manually
localDIR="$HOME/.local/share"

# fish_history: $HOME/.local/share/fish/fish_history
if [ -f "$localDIR/fish/fish_history" ]; then
	echo "=> Linking: fish/fish_history"
	unlink $localDIR/fish/fish_history
	rm -rf $localDIR/fish/fish_history
	ln -s $PWD/share/fish/fish_history $localDIR/fish/fish_history
else
	echo "ERROR: $localDIR/fish/fish_history not found. Please install it first"
fi

# copy themes and icons
for item in ${themes[@]}; do
	if [ -d $item ]; then
            echo "=> Replacing directory: $item"
            rm -rf $HOME/$item # removes current DIR
            cp -R $PWD/$item $HOME/$item
         else
            echo "ERROR: $HOME/$item not found. Please install it first"
         fi
done

# wallpaper
feh --bg-scale "$PWD/cosmos.jpg"

# end
