# Stream audio 
This is example how you can use [Shairport Sync](https://github.com/mikebrady/shairport-sync) to send audio to Snapcast server.  Audio can be stream from windows pc using [TuneBlade](http://www.tuneblade.com/) or whit AirPlay.  Shairport Sync runs on Linux, FreeBSD and OpenBSD this example cannot be used  on DockerDesktop for windows and mac.


   **Tuneblade**

TuneBlade is a simple tray utility that lets you stream system-wide audio to AirPort Express, Apple TV, AirPlay enabled speakers and HiFi receivers, and to AirPlay audio receiving applications such as ShairPort, XBMC/Kodi and TuneAero.

To avoid loop back echo when streaming from windows we need to use virtual audio output this can be done whit [VB-CABLE Virtual Audio Device](https://vb-audio.com/Cable/index.htm) after installation  in TuneBlade settings under Audio Capture we select `Specific Endpoint` and add `VoiceMeeter Input` like endpoint device 

Then on your Windows PC go to  `Setting > Sound > Advanced sound options`, change audio output of your audio application to `VoiceMeeter Input` note if you using Web Browser (like Chrome, Firefox, Edge) to play sound from your pc  you cannot use same browser to listen from Snapcast server WebUI you need to use diferent browser or application like Snap.Net.


   **Shairport Sync**


When Shairport Sync is run whit  `-o pipe` it's output to FIFO file what is located in `/tmp` folder also Shairport Sync must be run on the host network


   **Snapcast Server**


Provided `snapserver.conf` is override for the existing one and will provide two streams in the Snapcast Server one from Mopidy and one from Shairport Sync you don't need to use Mopidy if you just like to stream from Windows Pc if you using own Snapcast Server you can adjusted by just adding extra stream `stream = pipe:///tmp/snapcast/shairport-sync-audio?name=Airplay&sampleformat=44100:16:2` 
