# PhalanxOS KDE Plasma Add-on

This directory contains KDE Plasma shell components for the PhalanxOS desktop experience.
The initial add-on is a Plasma 6 applet named **PhalanxOS Start Sidebar**. It provides a sidebar-style Start Menu surface with PhalanxOS branding: a black base, crimson accents, dark gunmetal panels, and subtle cyberpunk grid/glow details rather than Windows-derived visuals.

## Package layout

```text
plasma/
└── phalanx-start-sidebar/
    ├── metadata.json
    └── contents/
        ├── config/
        │   ├── config.qml
        │   └── main.xml
        └── ui/
            ├── configGeneral.qml
            ├── main.qml
            └── ModuleButton.qml
```

## Included modules

The sidebar ships with configurable launch/status slots for:

- System status: CPU, memory, thermals, and battery.
- AI assistant launcher: entry point for local or cloud copilots.
- Security tools launcher: hardening, firewall, and scanner workflows.
- Network status: interface, VPN, and throughput checks.
- Privacy / Tor status: circuit, proxy, and anonymity-mode surfaces.
- Nextcloud / rclone sync status: cloud and remote sync health.
- Social ecosystem notifications: federated and community updates.

These entries are currently UI integration points. Future service backends can bind each module to D-Bus, KStatusNotifierItem, KRunner, or local PhalanxOS service APIs.

## User customization

Open the applet settings in Plasma to customize:

- Enabled modules.
- Primary crimson accent color.
- Secondary glow accent color.
- Panel transparency.
- Preferred panel position label.
- Animation intensity.

## Installation

From the repository root, install the applet into the current user's Plasma package directory:

```bash
kpackagetool6 --type Plasma/Applet --install plasma/phalanx-start-sidebar
```

If you are replacing an existing development install, use:

```bash
kpackagetool6 --type Plasma/Applet --upgrade plasma/phalanx-start-sidebar
```

Then restart Plasma Shell or log out and back in:

```bash
systemctl --user restart plasma-plasmashell.service
```

If your distribution does not expose that user service, restart manually:

```bash
kquitapp6 plasmashell && kstart plasmashell
```

## Testing

Validate package metadata and configuration syntax:

```bash
python3 -m json.tool plasma/phalanx-start-sidebar/metadata.json >/dev/null
xmllint --noout plasma/phalanx-start-sidebar/contents/config/main.xml
```

Inspect the package with Plasma tooling when available:

```bash
kpackagetool6 --type Plasma/Applet --show org.phalanxos.plasma.startsidebar
```

For an interactive smoke test:

1. Install or upgrade the package with `kpackagetool6`.
2. Add **PhalanxOS Start Sidebar** to a Plasma panel or desktop.
3. Open the applet and verify the module cards render with the black/crimson/gunmetal theme.
4. Open applet settings, toggle modules, adjust colors/transparency/animation intensity, and reopen the applet.
5. Confirm the sidebar respects the selected modules and updated visual settings.

## Development notes

- The applet targets Plasma 6 and declares `X-Plasma-API-Minimum-Version` as `6.0`.
- Visual assets are implemented in QML using Plasma/Kirigami primitives, so there are no copied third-party shell graphics.
- Module cards are deliberately backend-neutral until PhalanxOS system services define stable integration contracts.
