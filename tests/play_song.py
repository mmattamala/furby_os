import yt_dlp
import vlc
import time

url = "https://www.youtube.com/watch?v=TCd6PfxOy0Y"
#url = "https://www.youtube.com/watch?v=XnZH4izf_rIy"

ydl_opts = {'format': 'm4a', 'quiet': False, 'no_warnings': True}

print("Extracting video URL...")
with yt_dlp.YoutubeDL(ydl_opts) as ydl:
  info = ydl.extract_info(url, download=False)
playurl = info.get('url')

Instance = vlc.Instance()
player = Instance.media_player_new()
media = Instance.media_new(playurl)
media.get_mrl()
print(media)

print("Playing...")
player.set_media(media)
player.play()

while True:
  pass
#player.is_playing() == 0:
#  time.sleep(1)
