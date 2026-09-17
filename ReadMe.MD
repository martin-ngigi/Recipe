# Recipe App

## Install
```
brew install swift-format
brew install swiftlint
```

## Format and lint
- Format
```
swift-format format --recursive --in-place .
```
- Lint fix
```
swiftlint --fix
```
- Lint
```
swiftlint --strict
```


A beautifully designed mobile app to explore delicious recipes, discover top chefs, and manage your favorite dishes. This app supports both Dark and Light modes for an elegant user experience.

---

## Screenshots – Dark & Light Mode
<table>
  <tr>
    <th>Dark Mode</th>
    <th>Light Mode</th>
  </tr>
  <tr>
    <td><img src="screenshots/1_Landing.png" width="200"/></td>
    <td><img src="screenshots/1_Landing_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/2_Home.png" width="200"/></td>
    <td><img src="screenshots/2_Home_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/3_Recipe_Details.png" width="200"/></td>
    <td><img src="screenshots/3_Recipe_Details_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/4_Chef_Details.png" width="200"/></td>
    <td><img src="screenshots/4_Chef_Details_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/5_Favourites.png" width="200"/></td>
    <td><img src="screenshots/5_Favourites_Light.png" width="200"/></td>
  </tr>
    <tr>
    <td><img src="screenshots/5_Favourites_Empty.png" width="200"/></td>
    <td><img src="screenshots/5_Favourites_Empty_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/6_Login.png" width="200"/></td>
    <td><img src="screenshots/6_Login_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/7_Register.png" width="200"/></td>
    <td><img src="screenshots/7_Register_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/8_Profile.png" width="200"/></td>
    <td><img src="screenshots/8_Profile_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/9_Settings.png" width="200"/></td>
    <td><img src="screenshots/9_Settings_Light.png" width="200"/></td>
  </tr>
  <tr>
    <td><img src="screenshots/10_Rate_Chef.png" width="200"/></td>
    <td><img src="screenshots/10_Rate_Chef_Light.png" width="200"/></td>
  </tr>
    <tr>
    <td><img src="screenshots/11_Chef_Profile.png" width="200"/></td>
    <td><img src="screenshots/11_Chef_Profile_Light.png" width="200"/></td>
  </tr>
    <tr>
    <td><img src="screenshots/12_Favourite_Menu.png" width="200"/></td>
    <td><img src="screenshots/12_Favourite_Menu_Light.png" width="200"/></td>
  </tr>
    <tr>
    <td><img src="screenshots/13_Search.png" width="200"/></td>
    <td><img src="screenshots/13_Search_Light.png" width="200"/></td>
  </tr>
</table>

---

## Screenshots – Dark & Light Mode

| Dark Mode | Light Mode |
|---|---|
| ![Landing](screenshots/1_Landing.png) | ![Landing Light](screenshots/1_Landing_Light.png) |
| ![Home](screenshots/2_Home.png) | ![Home Light](screenshots/2_Home_Light.png) |
| ![Recipe Details](screenshots/3_Recipe_Details.png) | ![Recipe Details Light](screenshots/3_Recipe_Details_Light.png) |
| ![Chef Details](screenshots/4_Chef_Details.png) | ![Chef Details Light](screenshots/4_Chef_Details_Light.png) |
| ![Favourites](screenshots/5_Favourites.png) | ![Favourites Light](screenshots/5_Favourites_Light.png) |
| ![Favourites Empty](screenshots/5_Favourites_Empty.png) | ![Favourites Empty Light](screenshots/5_Favourites_Empty_Light.png) |
| ![Login](screenshots/6_Login.png) | ![Login Light](screenshots/6_Login_Light.png) |
| ![Register](screenshots/7_Register.png) | ![Register Light](screenshots/7_Register_Light.png) |
| ![Profile](screenshots/8_Profile.png) | ![Profile Light](screenshots/8_Profile_Light.png) |
| ![Settings](screenshots/9_Settings.png) | ![Settings Light](screenshots/9_Settings_Light.png) |
| ![Rate Chef](screenshots/10_Rate_Chef.png) | ![Rate Chef Light](screenshots/10_Rate_Chef_Light.png) |
| ![Chef Profile](screenshots/11_Chef_Profile.png) | ![Chef Profile Light](screenshots/11_Chef_Profile_Light.png) |
| ![Favourite Menu](screenshots/12_Favourite_Menu.png) | ![Favourite Menu Light](screenshots/12_Favourite_Menu_Light.png) |
| ![Search](screenshots/13_Search.png) | ![Search Light](screenshots/13_Search_Light.png) |

## Features

### Home Page
- **Just For You**: Personalized recipe recommendations based on preferences.
- **Trending Recipes**: Popular and most-viewed recipes of the week.
- **Popular Chefs**: Showcasing top-rated chefs with their specialties.

### Recipe Details
- **Ingredients**: Cleanly displayed list of all required ingredients.
- **Instructions**: Step-by-step cooking instructions to follow with ease.
- **Chef Info**: Shortcut to view the chef's profile who submitted the recipe.

### Chef Details
- **Chef’s Recipes**: View all recipes submitted by a specific chef.
- **Ratings & Reviews**: See what others think about the chef’s work.

### Favourite Recipes
- **Mark as Favourite**: Save any recipe to your favorites list.
- **Unmark**: Remove from favorites at any time.
- **Share**: Share your favorite recipes with friends and family.

### Authentication
- **Login**: Sign in with your email and password.
- **Register**: Create a new account with personal information.

### Profile
- **User Info**: View and edit your name, email, and other personal details.

### Settings
- **Theme Settings**: Toggle between Light and Dark mode.
- **Notification Preferences**: Turn on/off push notifications for updates.

---

## Tech Stack

- **Frontend**: SwiftUI / Jetpack Compose (depending on platform)
- **Backend**: Firebase / REST API (Laravel REST Framework)
- **State Management**: MVVM Architecture
- **Other Tools**: 
  - Firebase Auth & Firestore (for user and data management)
  - Responsive design for Dark and Light themes

---

## 📂 Folder Structure (Sample)
```
screens/
│
├── Home/
├── RecipeDetails/
├── ChefDetails/
├── Favourites/
├── Auth/
├── Profile/
└── Settings/
```


## Swift-lint ordering properties
```
Type aliases / enums
Static properties
Stored properties
Computed properties
Initializers
Lifecycle methods
Functions
```

## Pinning SSL certficate
- [Documentation](https://developer.apple.com/news/?id=g9ejcf8y) Apple official documenation.
- Generate SHA 256 KEY
```
openssl s_client \
  -connect recipe.safiribytes.com:443 \
  -servername recipe.safiribytes.com \
  -showcerts 2>/dev/null </dev/null > chain.pem


awk '/-----BEGIN CERTIFICATE-----/{i++} i==2' chain.pem > intermediate.pem

openssl x509 -in intermediate.pem -pubkey -noout \
  | openssl pkey -pubin -outform DER \
  | openssl dgst -sha256 -binary \
  | base64
  
```
- Add it to Info.Plist in the SPKI-SHA256-BASE64 section

# Color Palette

A warm, appetite-friendly color system built around a coral primary, designed to pass WCAG AA contrast in both light and dark mode.

## Primary

| Name | Hex | Usage |
|---|---|---|
| Coral | `#C4544A` | CTAs, active tab/state, key icons, price highlights |

- Contrast vs white (`#FFFFFF`): **4.53:1** — passes AA
- Contrast vs black (`#000000`): **4.63:1** — passes AA

*Kept as a single flat value across both modes — simpler to implement (no Any/Dark asset variant needed) and still clears AA on both backgrounds.*

## Secondary

| Name | Usage |
|---|---|
| Deep Teal | Secondary buttons, filter chips, dietary tags (e.g. "vegetarian," "healthy"), chart accents |

| Mode | Hex | Contrast |
|---|---|---|
| Light | `#256B5C` (deep teal) | **6.30:1** vs white — passes AA |
| Dark | `#4FBFA0` (bright teal) | **9.29:1** vs black — passes AA |

## Semantic Colors

| Purpose | Light Mode | Dark Mode |
|---|---|---|
| Success | `#2F7A3E` — 5.29:1 vs white | `#6FCB7F` — 10.54:1 vs black |
| Warning | `#9C6B0F` — 4.65:1 vs white | `#E8B84B` — 11.39:1 vs black |
| Error | `#B3261E` — 6.54:1 vs white | `#E5564C` — 5.77:1 vs black |

All semantic values pass WCAG AA (≥4.5:1) against their respective mode's background. Error's light value carries over unchanged from the original flat palette since it already cleared AA comfortably.

## Backgrounds

| Role | Light Mode | Dark Mode |
|---|---|---|
| Background | `#E8E2DA` (warm greige / stone) | `#14100D` (deep warm near-black) |
| Surface / Card | `#FFFFFF` | `#2E251F` (warm charcoal-brown) |

Neutral, desaturated warm tones — no pink/peach or cold-gray undertone — chosen with a visible luminance step between Background and Surface so card boundaries are distinguishable without relying on borders or shadows.

## Text

| Role | Light Mode | Dark Mode |
|---|---|---|
| Primary Text | `#2B1B16` | `#F5EAE6` |
| Secondary Text | `#6B5750` | `#B8A39C` |

Both pairs are high-contrast against their matching background/surface colors. These are dedicated text colors — not the accent color — so they don't need to straddle both modes the way Primary Coral does.

## Usage Guide

- **Coral** (`#C4544A`) → primary buttons, active states, price highlights
- **Teal** (Light `#256B5C` / Dark `#4FBFA0`) → secondary buttons, filter chips, dietary tags
- **Warm greige / near-black** (Light `#E8E2DA` / Dark `#14100D`) → screen backgrounds
- **Brown-toned text colors** → body copy, ties everything together instead of flat gray

## Implementation Notes

- **Primary Coral** stays a single flat hex (`#C4544A`) across both modes — no asset-catalog Any/Dark split needed, and it already clears AA on both white and black.
- Secondary, Semantic, Background, and Text each have dedicated Light and Dark values, tuned for strong contrast against their own mode's background.
- All light/dark pairs are matched to their own mode — they are not required to pass contrast against the *opposite* mode's background.
- Recommended implementation: define each split color as a Color Set in the Xcode asset catalog with **Any Appearance** and **Dark Appearance** variants, then reference via `Color("ColorName")` in SwiftUI rather than hardcoding hex values in code. Primary Coral can be a single flat Color Set with no Dark variant.
- Always test contrast against actual UI surfaces (cards, buttons, list backgrounds) — not just pure white/black — before shipping.
- **Common wiring bug:** if a text color renders correctly in light mode but fails contrast in dark mode (e.g. Primary Text showing as `#2B1B16` — the *light-mode* value — against a dark background), the Color Set almost certainly has no Dark Appearance variant configured, or the color was hardcoded in code (`Color(hex:)` / static `UIColor`) instead of referencing the named asset (`Color("PrimaryText")` / `UIColor(named:)`). Verify every text/background Color Set has both "Any" and "Dark" swatches explicitly set before shipping.

