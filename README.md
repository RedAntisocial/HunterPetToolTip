# HunterPetToolTip

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
![WoW Version](https://img.shields.io/badge/WoW-Retail-orange)
![Language](https://img.shields.io/badge/Lua-5.1%2B-lightgrey)
![Status](https://img.shields.io/badge/Status-Active-green)

---

**HunterPetToolTip** is a lightweight, no-config World of Warcraft addon that displays hunter pet family and taming requirement information directly in unit tooltips. I would love to figure out a method to show the EXACT source information for each tame (the initial target of this addon), but at present, when a player tames a pet it becomes a Beast (regardless of original typing) and loses it's originating NPC ID, instead being replaced with a standard "Hunter Pet" NPC ID. I'm still searching.

---

## Features

- **Pet Family Information**
  - Displays pet family type (Beast, Demon, Dragon, etc.) in tooltips
- **Taming Requirements**
  - Shows the minimum hunter level required to tame the pet
- **Seamless Integration**
  - Integrates directly into standard unit tooltips
  - No configuration needed—works out of the box

---

## Installation

1. **Download from CurseForge or Wago** or **clone** this repository:
   ```bash
   git clone https://github.com/RedAntisocial/HunterPetToolTip.git
   ```
2. Put the `HunterPetToolTip` folder inside your WoW AddOns directory:
   ```
   World of Warcraft/_retail_/Interface/AddOns/HunterPetToolTip/
   ```
3. Reload your UI (`/reload`).

Alternatively, use your favourite addon manager (Wago, CurseForge, etc).

---

## Usage

Once enabled, HunterPetToolTip automatically enhances pet tooltips with:
- **Pet Family:** The family classification of the pet
- **Taming Classification:** Exotic, or Spirit Beast
- **Extra Notes** Any further special requirements (Tomes etc.) to tame it

Simply hover over any tameable creature and the additional information will appear in the tooltip.

---

## Technical Summary

- **Language:** Lua, WoW API (no dependencies outside Blizzard UI)
- **Event-driven:** Handles tooltip updates automatically

---

## Contributing

Contributions, translations, and feature requests are welcome!

- Submit issues or pull requests via GitHub.
- Follow Blizzard's Lua API standards.
- Test changes with `/reload` and enable script errors using `/console scriptErrors 1`.
- Ensure compatibility with whatever the current *Retail* version is.

---

## License

This project is licensed under the **GNU General Public License v3.0 (GPL v3)**.  
You are free to modify and redistribute under the same terms.  
Full text: [https://www.gnu.org/licenses/gpl-3.0.html](https://www.gnu.org/licenses/gpl-3.0.html)

---
