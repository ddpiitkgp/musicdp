# MusicDP

MusicDP - A modern distributed music player designed to organize, stream, and understand your music.

MusicDP is a lightweight music player and streaming app that combines local music folders with remote URL-based music libraries. It focuses on smart playback, listening history, and curated playlists generated from user behavior.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Using adb and emulator

### adb
- adb devices : list of Devices
- adb start-server
- adb stop-server
- adb -s emulator-5554 emu kill : Kills a running device

### emulator
- emulator -list-avds   : WIll shoe lis of available devices
- emulator -avd Pixel_9a -no-window &  [ background ]
  disown
- nohup emulator -avd Pixel_9a -no-window > emulator.log & [background]
- emulator -avd Pixel_9a -netdelay none -netspeed full
- nohup emulator -avd Pixel_9a -no-window -no-boot-anim -gpu swiftshader_indirect > emulator.log & [background]


## Local Music Library
- Scan device folders
- Read song metadata
- Album art support
## Remote Music Source
- Add URL containing MP3 files
- Stream songs directly
- Save metadata locally
## Streaming Player
- Play / Pause
- Seek
- Queue system
- Shuffle / Repeat
- Background playback
## Simple Login
- Email or mobile
- Lightweight account
## Listening History
- Track plays
- Skip detection
- Behavior analysis
## Curated Playlists
- Daily mix
- Rediscover songs
- Most played
## Comments & Ads Section
- Song comments
- Replies
- Sponsored posts

# Logo Concept
## Primary Idea:
- Play button combined with soundwave bars representing music + data.

## Alternative Ideas:
- Headphones + play icon
- Soundwave forming DP
- Folder + music note
- Minimal equalizer triangle

## Color Palette
- Option A: Purple → Blue gradient
- Option B: Black + Neon Green
- Option C: Orange + Pink
- Option D: Dark background + Cyan accent

## Typography
- Recommended fonts: Poppins, Inter, Montserrat, Space Grotesk. Preferred: Poppins SemiBold.

# App Structure
## Screens:
- Home
- Search
- Library
- Player
- History
- Playlists
- Comments
- Settings

## Future Vision
- Smart recommendations
- Distributed music sources
- AI playlist generator
- Social listening
- Offline intelligent downloads


