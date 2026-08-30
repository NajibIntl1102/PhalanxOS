# Build directory

This directory will contain scripts and configuration for generating PhalanxOS ISO and image artifacts.

## Selected base: Debian Live Build

The initial build pipeline should use Debian Live Build (`live-build`) to create bootable live images from version-controlled package manifests.

Expected future layout:

- `auto/` - `live-build` helper scripts such as `config`, `build`, and `clean`.
- `config/` - Debian Live Build configuration, package lists, hooks, includes, and installer settings.
- `scripts/` - repository-specific wrappers for validation, manifest expansion, and artifact naming.

## Early workflow

1. Install host prerequisites listed in the repository `README.md`.
2. Review package manifests in `manifests/`.
3. Generate or update live-build package lists from the manifests.
4. Run the live-build configuration step.
5. Build the ISO in a clean environment.

No production ISO script is committed yet; this directory establishes the documented structure for the first implementation.
