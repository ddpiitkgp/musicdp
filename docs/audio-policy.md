# Audio Handling Policy

## Overview

This document explains how the MusicDP application handles audio files from both local storage and online directories.

The goal is to ensure:

- Small file sizes
- Supported audio formats
- Safe handling of external URLs
- Clear rules for developers and users

---

# Supported Audio Formats

The application only supports the following audio formats:

- mp3
- m4a
- aac
- wav
- ogg

Files with other extensions will be ignored.

---

# File Size Limit

For **local audio files**, the maximum allowed size is:

**1 MB**

Files larger than this limit will not be shown in the application.

This restriction helps:

- Reduce storage usage
- Improve loading speed
- Keep audio suitable for MusicDP usage

---

# Online Audio Sources

The application can load audio from **online directory listings** provided by the user.

The user provides a URL that points to a directory containing audio files.  
The application then scans the page and extracts supported audio files.

Example workflow:

1. User finds an online directory containing audio files
2. User copies the directory URL
3. User pastes the URL into the app
4. The app scans the directory
5. Supported audio files are listed

---

# Example Directory URLs (FAKE)

The following examples demonstrate the type of URLs the app expects.
These URLs are **examples only** and do not point to real files.

https://example.com/music/  
https://files.example.org/audio-library/  
https://cdn.example.net/sounds/

These domains are reserved for documentation purposes.
---

# Example Directory Listing (FAKE)

A typical directory page might look like this:

Index of /music/ 
song1.mp3 
song2.mp3 
ambient.ogg 
demo-track.m4a 
voice.wav

The application scans the page and extracts files with supported extensions.

---

# Example Direct Audio URLs (FAKE)

Sometimes a directory may expose direct links to files.

Example structure:

https://example.com/music/song1.mp3  
https://example.com/music/song2.mp3  
https://example.com/music/ambient.ogg

These examples are **not real audio files**.

---

# How Users Can Find Audio Directories

Users may search online for publicly available audio directories.

Example search queries:

- index of mp3
- index of music mp3
- public domain audio directory
- free sound effects wav index

Users should only use **legal and publicly accessible audio sources**.

---

