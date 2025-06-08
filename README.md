# 🏃‍♀️ Run With Me – Project Roadmap

Welcome to the development roadmap for **Run With Me**, the personalized running companion powered by **Erika & Aión**. This document outlines the structure, tasks, and milestones to guide our development journey.

---

## ✅ 1. Core Structure & App Architecture

- [ ] Split current `main.dart` into multiple modules:
  - `main.dart`: Entry point
  - `home_page.dart`: Main UI & interaction
  - `run_controller.dart`: Logic & state management
  - `audio_manager.dart`: Coaching voice/music playback
  - `models/`: Folder for data models (run stats, user settings)

- [ ] Implement proper folder structure:
  ```bash
  lib/
  ├── main.dart
  ├── pages/
  │   └── home_page.dart
  ├── controllers/
  │   └── run_controller.dart
  ├── services/
  │   └── audio_manager.dart
  ├── widgets/
  │   └── stat_tile.dart
  └── models/
      └── run_data.dart
