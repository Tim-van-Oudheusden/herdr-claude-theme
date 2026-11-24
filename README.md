# Herdr — Claude desktop look

Makes the [Herdr](https://herdr.dev) desktop app look like the Claude desktop app (claude.ai's
chat UI, Code section included): warm off-black or ivory surfaces, ivory/ink text, clay accents,
and status colors from the same palette. The same palette ships for
[oh-my-pi](https://github.com/can1357/oh-my-pi) in
[omp-claude-theme](https://github.com/Tim-van-Oudheusden/omp-claude-theme), so an omp session
inside Herdr matches its frame.

![Preview](layouts/claude-code.svg)

## What's here

| File | What it is |
|---|---|
| `themes/claude-desktop-dark.json` | Dark palette: `#1f1e1d` frame, `#262624` cards, `#faf9f5` text, `#d97757` clay |
| `themes/claude-desktop-light.json` | Light palette: `#f5f4ed` frame, `#faf9f5` cards, `#141413` text, `#c6613f` clay |
| `themes/claude-code-dark.json`, `themes/claude-code-light.json` | The same palettes under their old names, removed in the next release |
| `layouts/claude-code.json` | Herdr's `main` layout with both themes (follows system light/dark), no sidebar divider line, 12px cards, a subtler focus border, and unfocused splits faded slightly |
| `layouts/claude-code.svg` | The layout's picture for Settings → Look |
| `install.sh` | Copies the files above into the Herdr app home |

Agent status colors: **working** is clay, **blocked** is Claude's violet, **done** is its
success green.

## Install

```sh
./install.sh --switch   # copy into ~/.config/herdr-app and switch the window to the layout
```

`./install.sh` copies without switching; `./install.sh --uninstall` removes the files.
`HERDR_APP_HOME` picks another Herdr home. Back to the stock layout: `ctrl-shift-l`, or
Settings → Look → Herdr.

### Themes only, on your current layout

After installing, pick **claude desktop dark** / **claude desktop light** in Settings → Look →
Theme, or set them in `~/.config/herdr-app/settings.json` (used wherever a layout sets no theme):

```json
{ "theme": { "light": "claude-desktop-light", "dark": "claude-desktop-dark" } }
```

The themes used to be called `claude-code-dark` / `claude-code-light`. Those names still install
for this release and then go away; switch a `settings.json` that names them to the new ones.

## Type

Claude's chat sets regular-weight text with generous leading; Herdr's defaults (Medium weight,
line height 1) read denser and heavier. The layout sets:

| Field | Value | Why |
|---|---|---|
| `font_weight` | `400` | Regular body text, the biggest single difference from Herdr's 500 |
| `font_weight_bold` | `600` | Semibold emphasis, as Claude's headings and `**strong**` are |
| `terminal_line_height` | `1.2` | Airier rows; box-drawing characters still join |
| `terminal_padding` | `[16, 20]` | Horizontal room so prose doesn't touch the card edge |
| `ui_font` | `Geist` | Claude's own faces can't ship; Geist is bundled with Herdr, set explicitly so a change in Herdr's default doesn't change the layout |

These win over the same fields in `settings.json` while the layout shows, so the layout's
`ui_font` replaces a personal one there. The terminal face (`font`) stays yours. For a softer one:

```json
{ "font": "Geist Mono", "font_ligatures": false }
```

## Where the colors come from

- Surfaces and text: claude.ai's `--bg-*` / `--text-*` tokens (dark `bg-200` frame, `bg-100`
  cards, `bg-000` popovers; light `bg-200` frame, `bg-100` cards).
- Clay `#d97757` (`--accent-brand`); `#c6613f` (`--brand-000`) in light for contrast.
- Status colors: **working** clay `#d97757` (`--accent-brand`); **blocked** violet `#9b87f5` /
  `#5645a1` (`--accent-pro-*`); **done** green `#65bb30` / `#2f7613` (`--success-*`). The same
  values are omp-claude-theme's `violet` and `green`.
- Terminal ANSI colors: built from the same token families (danger, success, warning, accent,
  pro violet, mineral) and checked for contrast against the card background.
