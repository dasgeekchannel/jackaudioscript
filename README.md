# jackaudioscript
Script to use for initiating JackD, Carla, non-mixer setup during boot
This script is courtesy of Skrappjaw

!!!! Save the file(s) to a folder named jacksetup in your Home Directory !!!!

You will need to make the file executable. Right click it and choose 'is executable'.
Or use the chmod command on the file.

Put this script in your autostart if you want it to run each time it boots.
There is an additional killall and restart on lines 54 & 56 to compensate for Kubuntu KDE save session. If this causes issues you can comment it out with an #
