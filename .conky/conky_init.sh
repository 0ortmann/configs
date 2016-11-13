# small script starting conky with my config file 
# first echo some json stuff. this script is meant to init the i3bar to eat json. conky will produce json.

#!/bin/sh
echo '{"version":1}'
echo '['
echo '[],'
exec conky -c $HOME/.conky/conky.cfg 
