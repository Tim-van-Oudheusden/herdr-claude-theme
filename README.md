# Herdr — Claude Code look

Makes the [Herdr](https://herdr.dev) desktop app look like the Claude Code desktop app: warm
off-black or ivory surfaces, ivory/ink text, clay accents, and Claude Code's status colors for
agents.

![Preview](layouts/claude-code.svg)

## What's here

| File | What it is |
|---|---|
| `themes/claude-code-dark.json` | Dark palette: `#1f1e1d` frame, `#262624` cards, `#faf9f5` text, `#d97757` clay |
| `themes/claude-code-light.json` | Light palette: `#f5f4ed` frame, `#faf9f5` cards, `#141413` text, `#c6613f` clay |
| `layouts/claude-code.json` | Herdr's `main` layout with both themes (follows system light/dark), no sidebar divider line, 12px cards, a subtler focus border, and unfocused splits faded slightly |
| `layouts/claude-code.svg` | The layout's picture for Settings → Look |
| `install.sh` | Copies the files above into the Herdr app home |

Agent status colors follow Claude Code: **working** is clay (the spinner), **blocked** is the
permission-prompt blue-violet, **done** is the success green.

## Install

```sh
./install.sh --switch   # copy into ~/.config/herdr-app and switch the window to the layout
```

`./install.sh` copies without switching; `./install.sh --uninstall` removes the files.
`HERDR_APP_HOME` picks another Herdr home. Back to the stock layout: `ctrl-shift-l`, or
Settings → Look → Herdr.

### Themes only, on your current layout

After installing, pick **claude code dark** / **claude code light** in Settings → Look → Theme,
or set them in `~/.config/herdr-app/settings.json` (used wherever a layout sets no theme):

```json
{ "theme": { "light": "claude-code-light", "dark": "claude-code-dark" } }
```

## Where the colors come from

- Surfaces and text: claude.ai's `--bg-*` / `--text-*` tokens (dark `bg-200` frame, `bg-100`
  cards, `bg-000` popovers; light `bg-200` frame, `bg-100` cards).
- Clay `#d97757` (`--accent-brand`); `#c6613f` (`--brand-000`) in light for contrast.
- Status colors: the Claude Code CLI's dark/light themes (`claude`, `permission`, `success`).
- Terminal ANSI colors: built from the same token families (danger, success, warning, accent,
  pro violet, mineral) and checked for contrast against the card background.
