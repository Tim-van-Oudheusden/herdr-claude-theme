# herdr-claude-theme

A Herdr desktop app look modeled on the Claude desktop app (claude.ai's chat UI, Code section
included). The repo mirrors the Herdr app home (`~/.config/herdr-app`): `themes/`, `layouts/`,
`mods/`. `install.sh` copies them there. Sibling repo for oh-my-pi: `~/Git/omp-claude-theme`.

## Herdr's own manual

The running app writes its full manual to `~/.config/herdr-app/AGENTS.md` and its types to
`herdr.d.ts` / `gpui-kit.d.ts` beside it. Read the "Layouts" and "The look" sections there before
changing layout or theme fields; they track the installed version. Never edit those files or the
shipped layouts/mods in the Herdr home.

## Theme files: the non-obvious parts

- Top-level `background`, `foreground`, `selection`, `cursor`, `ansi` are the **terminal's**.
  `foreground` there becomes `terminal_foreground`; the UI text color is `colors.foreground`.
- `colors` overrides any derived panel color by name: `surface`, `canvas` (behind pane cards),
  `chrome` (sidebar, bars), `popover`, `raised`, `hover`, `selected`, `border`, `input` (stronger
  border), `foreground`, `muted`, `dim`, `accent`, `accent_foreground`, `solid`,
  `solid_foreground`, `ring`, `working`, `blocked`, `done`, `idle`, `unknown`. Alpha hex
  (`#rrggbbaa`) works in `colors`.
- Light vs dark is inferred from the palette; Settings lists each theme under one of them.
- A theme file named exactly like a layout becomes that layout's private theme. Keep theme names
  (`claude-desktop-dark`, `claude-desktop-light`) distinct from layout names (`claude-code`,
  `claude-desktop`): a theme file called `claude-desktop.json` would become the layout's own.
- `themes/claude-code-*.json` are the old theme names, kept as exact copies of
  `claude-desktop-*` for one release so `settings.json` files naming them keep working. Change
  both pairs together; delete the old pair (and its `install.sh` lines) in the next release.
- Keep the palette's sources (README "Where the colors come from") in step with any color change.

## Layout look

Both layout roots own `font_weight`, `font_weight_bold`, `terminal_line_height`,
`terminal_padding` and `ui_font` (README "Type" says why). They beat the person's `settings.json`,
so change them deliberately, in both layouts, and keep the README table in step. Leave `font`
unset.

`claude-code` also sets `"terminal_opacity": 0`. Herdr paints a terminal's own background as a
square inside the card's rounded border; at 0 only the card's rounded `background` shows, so no
square corner pokes out. Cell backgrounds programs set still draw. `claude-desktop` can't do the
same: its lone pane has no card, so the terminal background would turn into `canvas`.

## The cloned mods

`mods/claude-chrome/` is a clone of Herdr's `workspace-chrome` (0.1.18, see `cloned_from` in its
`mod.json`) plus the `new_chat` row and, in the brand row, the window buttons from the shipped
`tabs` mod (shown while `tabs` is hidden; icons from `mods/tabs/` and `mods/pane/`). Only the
files it uses are kept. Herdr never updates a clone: compare it with the shipped
`workspace-chrome` and `tabs` after a Herdr upgrade. Run
`herdr-app check ~/.config/herdr-app/mods/claude-chrome` after every change.

`mods/claude-tabs/`, `mods/claude-status/` and `mods/claude-pane/` are clones of the shipped
`tabs`, `workspace-status` and `pane` (0.1.18). The first two only lose the bar's
`border_b`/`border_t` separator; `claude-pane` rounds the header's outer corners to the frame's
inner radius (`radius` minus `border.width`). `mod.clone` pointed their own icons at their own
folders. After a Herdr upgrade, diff each `main.js` against the shipped one and carry the
changes over.

Run `herdr-app check` on each clone after every change. Herdr writes `jsconfig.json` and
`gpui-kit.d.ts` into installed mod folders; don't commit them.

With `"titlebar": "system"` Herdr 0.1.18 on GNOME Wayland still reports `window().buttons: true`
(no system window buttons), so `claude-desktop` keeps `"titlebar": "none"` and draws them itself.

## Shared with omp-claude-theme

These must stay identical in both repos, dark and light:

| Value | Here (`themes/claude-desktop-*.json`) | omp (`themes/claude-desktop-*.json`) |
|---|---|---|
| Terminal background | `background` | `terminal.background` |
| Terminal text | `foreground` | `terminal.foreground` |
| 16 ANSI colors | `ansi` | `terminal.ansi` |
| Clay | `colors.accent` | `vars.clay` |
| Blocked / done | `colors.blocked`, `colors.done` | `vars.violet`, `vars.green` |

## Verify every change

1. `./install.sh`, then `herdr-app status`: `errors` must be `[]`, and no `*.error` file may
   appear in `~/.config/herdr-app/layouts/`.
2. `herdr-app shot /tmp/x.png` and look at it. Sample pixels (PIL) to confirm exact colors when
   the eye can't tell `#1f1e1d` from `#262624`.
3. To see the other appearance without touching the person's `settings.json`: write a temporary
   copy of the layout with `"theme": "claude-desktop-light"` (or `-dark`) as
   `layouts/zz-preview.json`, `herdr-app do layout.switch --name zz-preview`, shoot, switch back
   to `claude-code`, delete the temp file.
4. Dump every resolved theme color when a derived value matters: a throwaway mod under
   `mods/` that writes `JSON.stringify(themes())` with `writeTextFile` into the Herdr home, run once
   with `herdr-app check <mod folder>`, then delete the mod and the dump. `console.log` output is
   not shown by `check`.

Settings → Look in Herdr 0.1.18 draws a plain frame instead of any layout's `preview` picture,
the shipped Herdr 98 included; a missing picture there is not a bug in this repo.

## Commits

Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`), straight to `main`.
