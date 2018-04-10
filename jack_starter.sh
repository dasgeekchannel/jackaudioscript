#!/bin/bash

#This is an example script for starting/re-starting an audio setup using jack, pulseaudio, and non-mixer.

#These lines make sure none of the applications and processes we need to configure, are currently running.
#Killing these apps makes for a clean restart of the audio engine should the need arise.
killall -9 carla
killall -9 non-mixer
killall -9 jackdbus
killall -9 pulseaudio
sleep 1

#Here we start jack first. This alllows jack to take control of our audio interface.
jack_control start & 
sleep 1
pulseaudio --start
cadence &
sleep 2 

#The next 2 lines remove the default pulseaudio bridges. Next we will create custom labled bridges for easy identification.
pacmd unload-module module-jack-sink
pacmd unload-module module-jack-source
sleep 5

#The following lines will create our custom pulse bridges for specific applications.
#These show up in our pulse audio settings as input/output devices, and on the carla patchbay.
#Sources are for inputs, and sink is for output.

#For voip (discord, mumble, zoom, ect...)

#for application input
#pacmd load-module module-jack-source channels=2 source_name=voip client_name=Voip-IN connect=false

#for application output
#pacmd load-module module-jack-sink channels=2 sink_name=voip client_name=Voip-Out connect=false

#There is no need for games to have a dedicated input.
#pacmd load-module module-jack-sink channels=2 sink_name=games-out client_name=games-out connect=false

#I use this bridge for all my media playback.
pacmd load-module module-jack-source channels=2 source_name=media-in client_name=jackaudio-in connect=false
pacmd load-module module-jack-sink channels=2 sink_name=media-out client_name=jackaudio-out connect=false
sleep 2

#Now that jack is running and our pulseaudio bridges are setup, we can start our front end apps to put it all in motion.

#this line starts non-mixer with our saved mixer strips.
#non-mixer ~/jacksetup/non.mix &
#sleep 5

#also starts carla with our saved audio routing.
carla &
#carla ~/jacksetup/default.carxp &
sleep 3
killall -9 pulseaudio
sleep 3
pulseaudio  --start
sleep 3
#now we just give ourselves a system message to know that our audio is up and running.
wall "Audio systems up and running"
sleep 1
exit 0