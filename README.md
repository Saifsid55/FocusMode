# 📱 FocusMode – iOS Productivity Timer App

**FocusMode** is a simple and elegant iOS app that helps users improve productivity by entering focused states like **Work**, **Play**, **Rest**, or **Sleep**. Built using **UIKit** and **MVVM architecture**, the app encourages consistency through rewarding sessions with points and badges.

---

## ✨ Features

- ⏱️ **Focus Timer**
  - Starts counting in `00:00` format and switches to `00:00:00` after 1 hour
  - Awards 1 point and a random emoji badge every 2 minutes of focus

- 🧠 **Four Focus Modes**
  - Work, Play, Rest, and Sleep – each starts a new session

- 🔄 **Session Persistence**
  - Timer continues after app is closed or relaunched

- 👤 **Profile View**
  - Shows user's name, avatar, total points, all earned badges
  - Displays recent sessions (with delete support)

- 🧾 **Session Tracking**
  - Tracks duration, mode, start time, points, and badges
  - Swipe to delete old sessions

- 💾 **Local Storage**
  - Uses `UserDefaults` + `Codable` to persist data across launches

---

## 🧱 Built With

- ✅ UIKit (no Storyboards)
- ✅ MVVM architecture
- ✅ Auto Layout (Programmatic UI)
- ✅ Codable + UserDefaults
- ✅ NotificationCenter for timer updates
- ✅ Reusable UI components

---
