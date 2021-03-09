# Stream audio 
This is example how you can use [Shairport Sync](https://github.com/mikebrady/shairport-sync) to send audio to Snapcast server.  Audio can be streamed from a Windows PC using [TuneBlade](http://www.tuneblade.com/) or with AirPlay. Shairport Sync runs on Linux, FreeBSD and OpenBSD; this example cannot be used on Docker Desktop for Windows and Mac.

   **Tuneblade**

TuneBlade is a simple tray utility that lets you stream system-wide audio to AirPort Express, Apple TV, AirPlay enabled speakers and HiFi receivers, and to AirPlay audio receiving applications such as ShairPort, XBMC/Kodi and TuneAero.

To avoid loop-back echo when streaming from Windows we need to use virtual audio output this can be done with [VB-CABLE Virtual Audio Device](https://vb-audio.com/Cable/index.htm). After installation of VB-CABLE, in TuneBlade settings under Audio Capture we select `Specific Endpoint` and add `VoiceMeeter Input` as an endpoint device. If Shairport Sync is running without a problem, you should see the Airplay endpoint and you can start streaming to it.

Then on your Windows PC go to  `Setting > Sound > Advanced sound options` and change audio output of your audio application to `VoiceMeeter Input`. At this stage, you will lose audio from that application on your speakers, than you need to stream audio back to your speakers from the Snapcast server using the [Snap.net](https://github.com/stijnvdb88/Snap.Net/releases) or Snapcast WebUI. Note, if you're using a web browser (Chrome, Firefox, Edge) to play sound from your PC, for example playing Youtube songs, you cannot use same browser to listen to Snapcast server WebUI; you need to use different browser or Snap.Net.


  **Airplay**


If you own an Apple device (iPhone, iPad or Mac), you can start streaming to the Shairport Sync endpoint. You don't need TuneBlade.


   **Shairport Sync**


When Shairport Sync is run with  `-o pipe`, its output is directed to a FIFO pipe which is located in the `/tmp` folder. Inside the Docker container, there are two pipes: `shairport-sync-audio` and `shairport-sync-metadata`. The output audio format of the `shairport-sync-audio` pipe is `44100:16:2`. Also, Shairport Sync must be run on the host network.
Shairport Sync can be run with the `-a Somename` option at the entrypoint `entrypoint: /start.sh -a Somename -o pipe` to use a specific name for the Airplay receiver; by default it uses hostname of the host OS.


   **Snapcast Server**


If you overwrite the existing `snapserver.conf` with the provided one, it will provide two streams in the Snapcast Server: one from Mopidy named `Mopidy` which is the default, and one from Shairport Sync named `Airplay`. You can select the stream you want to listen to by clicking the name in Snapserver WebUI for each client which is listening from Snapcast Server, or swap the lines in the config file, and Airplay will be default.
You don't need to use Mopidy if you just want to stream from a Windows PC. You can remove the line for Mopidy in the `snapserver.conf` and delete the Mopidy service provided in the `shairport.yml`. If you're using your own Snapcast Server, you can set that up by adding an extra stream `stream = pipe:///tmp/snapcast/shairport-sync-audio?name=Airplay&sampleformat=44100:16:2`.


# Output audio from speaker connected  to the host

You can output audio from a speaker connected to a host which has the containers running. This can be done by running Snapcast Client on the host and connecting to the Snapcast Server, or by running another Docker container with a Snapcast Client and passing the sound card to container with `--device /dev/snd`. More info can be found on the [Snapcast  Github](https://github.com/badaix/snapcast#client).

# Some Notes / Troubleshooting steps

- Problem: Airplay receiver visible in TuneBlade but not visible on Mac devices (IPhone IPad). This happens if the container gets recreated or the Airplay name gets changed. Solution: restarting the avahi-daemon on the host with `systemctl restart avahi-daemon` or reboot the host with `sudo reboot`.
- Be sure to check the owner and group of created folders. To change it, you can use `sudo chown -c user:group *` inside the folder where your `docker-compose.yml` is. (user:group was pi:pi for me)
- The [Snap.net](https://github.com/stijnvdb88/Snap.Net/releases) client could be useful
- Try clearing `ledfx-config` and restart
- Access Snapcast via browser: http://your-pi-ip:1780
- Access Mopidy via browser: http://your-pi-ip:6680 -> iris
- Add `network_mode: host` to ledfx (and shairport) inside `docker-compose.yml` to enable WLED autodiscovery
