# Homfince Flutter App - Splash Screen Animation Update

I've updated the **Splash Screen** to include a smooth loading animation.

## 📱 What Changed?
- **Animated Progress Bar**: The loading bar now animates from 0% to 100% over 3 seconds.
- **Dynamic Percentage**: The text updates in real-time (e.g., "45%", "89%") alongside the bar.
- **Auto-Navigation**: Once the animation hits 100%, the app automatically navigates to the **Onboarding Screen**.

## 🛠️ How to Test
1. Restart the app (`Shift + R` in terminal).
2. Watch the loading bar fill up.
3. Verify it transitions to the "Track Your Finances" screen automatically.

## 📁 Updated File
- `lib/screens/splash_screen.dart`: Added `AnimationController` and state management for the loading effect.
