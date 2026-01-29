# Changelog

## [1.0.0+5] - 2026-01-29

### New Features

- **Localization Support**:
  - Implementation of multi-language support (Internationalization).
  - Added support for **English (en)** and **Portuguese (pt-BR)**.
  - Added a language switcher dropdown in the Home Page.
  - Set **pt-BR** as the default language for new users.
- **Focus & Break**:
  - Full translation of the Focus & Break timer interface, including status messages, buttons, and task updates.
- **Last Time Since**:
  - Enhanced date display to include the time in the history list.

### Improvements

- **UI/UX**:
  - Updated `HomePage`, `SettingsPage`, `MultipleTimersPage`, and `WelcomePage` to reactively update text when the language changes.
  - Refined visuals for language selection.
- **Performance & Build**:
  - Enabled **R8 code shrinking and resource shrinking** for release builds to reduce app size.
  - configured ProGuard rules to ensure compatibility with Google Play Core libraries.
  - Verified and finalized Android release build configuration (Signing, KeyStore).

### Fixes

- Addressed `const` correct usage in `WelcomePage` text styles.
- Fixed `NewLastTimeSinceButton` scroll behavior.
