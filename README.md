# valU Home Screen Clone

A pixel-focused Flutter clone of the **valU** app home screen, built with a production-grade architecture.

## Features

- 🎨 **Light & Dark themes** — persisted with `ThemeCubit` + SharedPreferences, in-app toggle in the header
- 🌍 **Localization** — English & Arabic with full RTL support (`easy_localization`)
- 🧩 **Feature-first Clean Architecture** — `core/` (theme, routing, DI, animations, error handling) + `features/home/`
- 📱 **Responsive** — `flutter_screenutil` (design size 360×690)
- ✨ **Motion** — consistent entrance/tap animations via a shared `flutter_animate` kit, Lottie illustrations
- 🖼️ Real valU brand assets rendered with `flutter_svg`

## Screen anatomy

| Section | Widget |
|---|---|
| Header (logo, theme toggle, notifications) | `home_header.dart` |
| Registration stepper card + Lottie | `registration_progress_card.dart` |
| Promo banner carousel | `promo_banner_carousel.dart` |
| Buy now, pay later + store search | `bnpl_section.dart` |
| SHOP'IT product rail | `shop_it_section.dart` / `product_card.dart` |
| Floating bottom navigation with fade | `home_bottom_nav_bar.dart` |

## Getting started

```bash
flutter pub get
flutter run
```

## Stack

`flutter_bloc` · `get_it` · `dartz` · `easy_localization` · `flutter_screenutil` · `flutter_svg` · `lottie` · `flutter_animate` · `google_fonts`
