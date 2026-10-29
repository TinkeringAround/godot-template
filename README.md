# 🚀 Godot Template Project

A production-ready architecture template for **Godot 4.x** designed to kickstart your game development with essential global systems pre-configured.

---

## ✨ Features Checklist

- [x] 🧠 **State Manager** – Hierarchical or state-machine based logic for clean game states.
- [x] 🚌 **Global Event Bus** – Centralized publish-subscribe pattern for decoupled node communication.
- [ ] ⚙️ **Global Settings** – Persistent configuration management (audio, video, controls).
- [ ] 🛠️ **Built-in Debug Layer** – On-screen performance overlays and runtime debugging tools.

---

## 🛠️ Architecture Overview

### 🧠 State Manager

Handles complex game and entity states without spaghetti code. It allows you to easily separate logic for player states, game phases, or UI flows.

### 🚌 Global Event Bus

An autoloaded singleton (`EventBus.gd`) that manages global signals. Connect any node to any event without direct referencing.

```gdscript
# Example usage:
EventBus.emit(Event.new())
```

### ⚙️ Global Settings

Automatically handles saving and loading user configurations (e.g., volume sliders, screen resolution, keybindings) to a local configuration file.

### 🛠️ Debug Layer

A toggleable in-game overlay to monitor FPS at runtime.
