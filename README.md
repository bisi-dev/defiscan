# DeFi Scan
This is the official repository for DeFi Scan - a mobile blockchain explorer built with Dart/Flutter for searching, curating and storing details of cryptocurrency accounts.

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-green)](https://opensource.org/licenses/Apache-2.0)
[![Codemagic build status](https://api.codemagic.io/apps/634695f7e6fd8707a9c2015c/634695f7e6fd8707a9c2015b/status_badge.svg)](https://codemagic.io/apps/634695f7e6fd8707a9c2015c/634695f7e6fd8707a9c2015b/latest_build)

## Get it on
<!-- [<img src="assets/screenshots/playstore_badge.png" width="250">](https://play.google.com/store/apps/details?id=dev.bisi.defiscan)   -->
[<img src="assets/screenshots/appstore_badge.png" width="250">](https://apps.apple.com/us/app/defi-scan/id1644035976?platform=iphone)

You can also try out a web demo on my flutter portfolio page [DeFi Scan](https://flutter.bisi.dev).

<!-- ## In App Preview -->

## In App Screenshots
<img src="assets/screenshots/home.png" width="200"> <img src="assets/screenshots/details.png" width="200"> <img src="assets/screenshots/history.png" width="200"> <img src="assets/screenshots/settings.png" width="200">

---

## Development - Mini Documentation

### VERSIONING
- Dart: >= 2.12.0 < 3.0.0
- Flutter: Flutter 3.0.2
- State Management: Provider 6.0.0
- Other Packages : [List](pubspec.yaml)

### STRUCTURE
This project currently implements a Dev Layer-First File Structure. Current High Level Look:
```
‣ lib
  ‣ core
    ‣ constants
    ‣ routes
    ‣ themes
    ‣ utils
  ‣ data
    ‣ prefs
    ‣ models
    ‣ services
  ‣ domain
    ‣ providers
    ‣ repositories
    ‣ state
  ‣ presentation
    ‣ pages
    ‣ components
  main.dart
```
System Design for Seperation of Concerns:
<br> Data Sources (DB) : Infura and MaticVigil Blockchain nodes
<img src="assets/screenshots/dev_structure.png">

## CI/CD
This repository utilizes Continuous Integration against all pushes made to the main branch. 
<br>
All APKs can be found as artifacts in the GitHub Actions TAB. In addition, you can download more artifacts by visiting the latest build on the codemagic webpage. 
<br>
CI / CD tool: Github Actions / codemagic
<br>
Builds/Releases: [APK artifacts](https://github.com/bisi-dev/defiscan/actions/workflows/flutter-ci.yml) , 
[APK + AAR + Runner(ios) artifacts](https://codemagic.io/apps/634695f7e6fd8707a9c2015c/634695f7e6fd8707a9c2015b/latest_build)

---

## Development - Contribution
You can contribute by reporting bugs, suggesting improvements, and/or by helping out in code.
UI/UX designers are always welcome. I always appreciate feedback, so share your thoughts and suggestions with me: [mail@bisi.dev](mailto:yinka.olabisi@yahoo.com).
1. Feel free to fork this repo and help out
2. Make small, concise, and well documented commits.
3. No idea where to start? Contact me and we can discuss appropriate tasks.

### Getting Started
Check out [Flutter's official guide](https://flutter.dev/docs/get-started/install) to installing and running Flutter on your system.

### Prerequisites
- Download IDE either [Android Studio](https://developer.android.com/studio) or [VSC](https://code.visualstudio.com/)
- Install Flutter SDK and Dart plugin.
- Flutter stable channel is used for development.
- Mobile device (emulator or physical).

### Steps
- Clone this repo to your local machine: `git clone https://github.com/bisi-dev/defiscan.git`
- Run `flutter run pub get` in terminal inside project root directory.
- Run `main.dart` on emulator or physical device.
- All set!

### License
This project is licensed under [Apache-2.0 License](https://opensource.org/licenses/Apache-2.0). It means you're free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell this project.

#### Thank You
Wow, Thank you for visiting this page. I appreciate the time you took to read through this. I would extra love if you could promote the app on social media or be kind enough to leave a star 🙏

Thanks a lot! 💪
Ayodeji Olabisi – [bisi.dev](https://bisi.dev)
