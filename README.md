# 🚀 J.A.R.V.I.S. 2.0 – Venom Edition

> *"All systems are online and ready, boss."*

J.A.R.V.I.S. is a **voice-interactive AI assistant** with a **Venom-style personality**. Built with Flutter, it runs on **Android, Windows, macOS, and Linux** – and supports **multiple AI providers** (OpenAI, Anthropic, Google Gemini, Custom).

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎙️ **Voice** | Speech-to-text + Text-to-speech (Venom-style voice) |
| 🧠 **AI Chat** | OpenAI GPT-4, Anthropic Claude, Google Gemini, Custom |
| 📱 **Device Control** | Open apps, send SMS, open settings (Android) |
| 🏠 **IoT** | MQTT support – control smart devices |
| 🔍 **Search** | Web search via Brave API |
| 📰 **News** | Latest headlines via NewsAPI |
| 🛡️ **Security** | Shodan integration (ethical research) |
| 💻 **Code Gen** | AI writes code for you |
| 🎨 **3D Hologram** | Animated wireframe orb with glowing core |
| 💾 **Memory** | Remembers past conversations (last 50 exchanges) |
| ⚙️ **Custom** | Add your own API endpoints |
| 🔒 **Secure** | API keys stored encrypted |
| 🌍 **Cross-Platform** | Android, Windows, macOS, Linux |

---

## 📦 Downloads

### From GitHub Releases
- **Android**: APK (arm64, armeabi-v7a, x86_64)
- **Windows**: EXE (64-bit)
- **macOS**: DMG or App bundle
- **Linux**: AppImage or bundle

### Manual Build
```bash
flutter build apk --release --split-per-abi
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

---

## 🚀 Quick Start

### 1. Clone or Download

```
git clone https://github.com/yourusername/jarvis-ai-flutter.git
cd jarvis-ai-flutter
```

### 2. Get Dependencies

```
flutter pub get
```

### 3. Generate Icons (Optional)

```
flutter pub run flutter_launcher_icons
```

### 4. Run

```
flutter run -d android   # or windows, macos, linux
```

### 5. Configure API Keys

- Open app → Settings (⚙️ icon)
- Add your API keys:

- OpenAI (`sk-...`)
- Anthropic (`sk-ant-...`)
- Google Gemini (`AIza...`)
- Brave Search, NewsAPI, Shodan (optional)
- Click **SAVE SETTINGS**

---

## 🎮 Commands You Can Try

```
"Hey Jarvis, what time is it?"
"What's the weather in Tokyo?"
"Tell me a joke"
"Open YouTube"
"Send SMS to Mom: I'm coming home"
"Search for Flutter 3.0 release"
"News about AI"
"Shodan search for port 22"
"Write a Python script to sort a list"
"Turn on living room light"
```

---

## 🔧 Customization

### Change Voice Personality

Edit `lib/services/multi_provider_service.dart` – modify `_getSystemPrompt()`.

### Add Your Own AI Provider

Go to **Settings → Custom Endpoints** and add your own API URL.

---

## 🛠️ Built With

- **Flutter** – UI framework
- **Provider** – State management
- **Hive** – Local storage (memory)
- **Flutter Secure Storage** – Encrypted API keys
- **Speech_to_text** – Voice input
- **Flutter TTS** – Voice output
- **HTTP** – API calls
- **Android Intent Plus** – Device control (Android)

---

## 📄 License

MIT – see [LICENSE](https://LICENSE) file.

---

## 👨‍💻 Made With ❤️

*"J.A.R.V.I.S. – Just A Rather Very Intelligent System"*

