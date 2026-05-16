# Zubia Samreen — HR Portfolio (Flutter Web)

## Project Structure

```
lib/
  main.dart                  ← App entry point
  home_screen.dart           ← Assembles all sections
  data/
    portfolio_data.dart      ← ⭐ EDIT ALL CONTENT HERE
  widgets/
    app_theme.dart           ← Colors, fonts, spacing
  sections/
    hero_section.dart        ← Name, tagline, CTA buttons
    metrics_section.dart     ← Business outcome numbers
    case_studies_section.dart← Expandable case study cards
    systems_section.dart     ← HR systems/tools built
    skills_contact_section.dart ← Skills + contact footer
```

---

## ⭐ To Update Content

**Only edit `lib/data/portfolio_data.dart`**

- Change name, email, LinkedIn URL, resume URL
- Update metrics (numbers, labels)
- Edit case studies (situation, action, result, impact)
- Add/remove systems built
- Update skills list

No need to touch any other file for content changes.

---

## Setup

```bash
# 1. Get dependencies
flutter pub get

# 2. Run locally in browser
flutter run -d chrome

# 3. Build for web (production)
flutter build web --release
```

---

## Deployment Options

### Option A — Firebase Hosting (Recommended)
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize (choose Hosting, set public dir to "build/web")
firebase init

# Build and deploy
flutter build web --release
firebase deploy
```
Your site will be live at: `https://your-project-id.web.app`

### Option B — GitHub Pages
```bash
flutter build web --release --base-href "/your-repo-name/"
# Copy build/web contents to your GitHub Pages repo
# Enable GitHub Pages in repo settings
```

### Option C — Vercel / Netlify
- Build command: `flutter build web --release`
- Publish directory: `build/web`

---

## Customization Tips

**Change accent color:** Edit `AppTheme.accent` in `app_theme.dart`

**Add a profile photo to hero:** Add image to `assets/` folder, reference in `pubspec.yaml`, use `Image.asset()` in `hero_section.dart`

**Add resume PDF link:** Replace `resumeUrl` in `portfolio_data.dart` with a Google Drive shareable link or Dropbox link to the PDF

**Add real LinkedIn URL:** Replace `linkedinUrl` in `portfolio_data.dart`

---

## Notes

- Mobile responsive by default
- Works on all modern browsers
- No backend needed — pure static site
- Fast load time (~2MB Flutter web bundle)
