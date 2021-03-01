# Stream audio 
This is example how you can use [Shairport Sync](https://github.com/mikebrady/shairport-sync) to send audio to Snapcast server.  Audio can be stream from windows pc using [TuneBlade](http://www.tuneblade.com/) or whit AirPlay.  Shairport Sync runs on Linux, FreeBSD and OpenBSD this example cannot be used  on DockerDesktop for windows and mac.


   **Tuneblade**

TuneBlade is a simple tray utility that lets you stream system-wide audio to AirPort Express, Apple TV, AirPlay enabled speakers and HiFi receivers, and to AirPlay audio receiving applications such as ShairPort, XBMC/Kodi and TuneAero.

To avoid loop back echo when streaming from windows we need to use virtual audio output this can be done whit [VB-CABLE Virtual Audio Device](https://vb-audio.com/Cable/index.htm) after installation of VB-CABLE  in TuneBlade settings under Audio Capture we select `Specific Endpoint` and add `VoiceMeeter Input` like endpoint device, if Shairport Sync is running whit out a problem you can see the Airplay endpoint and you can start streaming to it 

Then on your Windows PC go to  `Setting > Sound > Advanced sound options`, change audio output of your audio application to `VoiceMeeter Input` at this stage you will lost audio from that aplication on your speakers, than you need to stream audio back to your speakers from the Snapcast server using the [Snap.net](https://github.com/stijnvdb88/Snap.Net/releases) or Snapcast WebUI note if you using Web Browser (like Chrome, Firefox, Edge) to play sound from your pc for example playing Youtube songs  you cannot use same browser to listen from Snapcast server WebUI you need to use diferent browser or Snap.Net.


   **Shairport Sync**


When Shairport Sync is run whit  `-o pipe` it's output to FIFO file what is located in `/tmp` folder inside of the docker container whit two pipes `shairport-sync-audio` and `shairport-sync-metadata` the output audio format of the `shairport-sync-audio`  is `44100:16:2` also Shairport Sync must be run on the host network


   **Snapcast Server**


Provided `snapserver.conf` is override for the existing one and will provide two streams in the Snapcast Server one from Mopidy named like `Mopidy` and is set like default and one from Shairport Sync named like `Airplay` you can select the stream you want to listen by pressing the name in Snapserver WebUI for each client what is listening from Snapcast Server or swop the lines in the config file and Airplay will be default.
You don't need to use Mopidy if you just like to stream from Windows Pc  you can remove the line for Mopidy in the `snapserver.conf`  and delete the mopidy service provided in the `shairport.yml` if you using own Snapcast Server you can adjusted by just adding extra stream `stream = pipe:///tmp/snapcast/shairport-sync-audio?name=Airplay&sampleformat=44100:16:2` 


# Some Notes / Troubleshooting

- Check owner and group of created folders (to change you can `sudo chown -c user:group *` inside the folder where your docker-compose.yml is. user:group was pi:pi for me)
- [Snap.net](https://github.com/stijnvdb88/Snap.Net/releases) client could be useful
- Clear ledfx-config and restart
- Access snapcast via browser: http://your-pi-ip:1780
- Access mopidy via browser: http://your-pi-ip:6680 -> iris
- add `network_mode: host` to ledfx (and shairport) inside docker-compose.yml to enable WLED autodiscovery