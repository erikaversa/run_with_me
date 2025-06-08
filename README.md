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
  ```

## 📄 Code Citations & Licensing

- All reused or adapted code is cited in a dedicated [`Code Citations`](./Code%20Citations.md) document.
- Example: Portions of the UI and select logic adapted from [emileypalmquist/run-training-app](https://github.com/emileypalmquist/run-training-app/blob/499fd19369c19c99c292e84d2218bc4815e36a0c/runner-frontend/index.html) under the MIT License.
- The MIT license and copyright notice are included as required. See [LICENSE](./LICENSE).
