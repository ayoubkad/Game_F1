# Game_F1 - 3D Adventure Game

A simple and beautiful 3D game built with Godot Engine using GDScript.

## Features

### 🎮 Core Gameplay
- **3D Character Control**: Control a capsule character with smooth physics-based movement
- **WASD Movement**: Intuitive keyboard controls for movement in all directions
- **Jump Mechanics**: Space bar to jump with realistic gravity
- **Collectible System**: Golden rotating collectibles scattered throughout the world

### 🎥 Camera System
- **Third-Person Camera**: Smooth camera that follows the player
- **Mouse Controls**: Rotate camera around the player with mouse movement
- **Zoom Controls**: Mouse wheel to zoom in/out
- **Adaptive Following**: Camera smoothly tracks player movement

### 🌍 Environment
- **Beautiful Sky**: Procedural sky with horizon colors
- **Lighting**: Directional sunlight with shadows
- **Floor Plane**: Large walkable surface for exploration
- **Atmospheric Effects**: Glow and tone mapping for visual appeal

## Controls

| Input | Action |
|-------|--------|
| **W** | Move Forward |
| **A** | Move Left |
| **S** | Move Backward |
| **D** | Move Right |
| **Space** | Jump |
| **Mouse Movement** | Rotate Camera |
| **Mouse Wheel** | Zoom In/Out |

## Technical Details

### Project Structure
```
Game_F1/
├── project.godot          # Main project configuration
├── scenes/
│   └── Main.tscn         # Main game scene
├── scripts/
│   ├── Player.gd         # Player controller
│   ├── ThirdPersonCamera.gd  # Camera system
│   └── Collectible.gd    # Collectible objects
└── icon.svg              # Project icon
```

### Scripts Overview

#### Player.gd
- Physics-based character controller using CharacterBody3D
- Camera-relative movement system
- Smooth acceleration and friction
- Jump mechanics with gravity

#### ThirdPersonCamera.gd
- Smooth camera following system
- Mouse-controlled camera rotation
- Zoom functionality
- Configurable follow speed and sensitivity

#### Collectible.gd
- Animated rotating collectibles
- Floating motion effect
- Golden material with emission
- Collection detection and effects

## Getting Started

1. **Open in Godot**: Open the `project.godot` file in Godot Engine 4.x
2. **Run the Game**: Press F5 or click the play button
3. **Select Main Scene**: Choose `scenes/Main.tscn` as the main scene
4. **Play**: Use WASD to move, Space to jump, and mouse to control camera

## Expansion Ideas

The code is designed to be modular and easily expandable. Consider adding:

- 🏆 Score system for collected items
- 🎵 Sound effects and background music
- 🌟 Particle effects for collectibles
- 🚪 Multiple levels or areas
- 👾 NPCs or enemies
- 🎨 Better 3D models and textures
- 🏅 Achievement system
- 💾 Save/load functionality

## Requirements

- Godot Engine 4.x
- Supports Windows, macOS, and Linux

## License

Open source - feel free to modify and expand!
