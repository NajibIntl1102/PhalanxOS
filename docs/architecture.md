# PhalanxOS Architecture

PhalanxOS is planned as a security-conscious Linux distribution for builders, privacy-minded users, and authorized security practitioners. The project combines a modern desktop, reproducible image builds, privacy-preserving defaults, and AI-assisted workflows without normalizing unsafe or unlawful activity.

## Goals

- Provide a usable daily-driver Linux desktop with strong privacy and security defaults.
- Make ISO and image generation repeatable from versioned manifests and build scripts.
- Offer a curated set of networking, synchronization, anonymity, and collaboration tools.
- Keep offensive-security tooling optional, clearly labeled, and bounded by responsible-use guidance.
- Enable local-first AI assistance for system help, configuration review, and developer workflows where practical.

## Target users

- Developers who want a hardened workstation with modern Wayland-first UX.
- Privacy-conscious users who rely on encrypted sync, Tor Browser, OnionShare, and remote storage tools.
- Students, researchers, and defenders learning security in labs they own or are authorized to test.
- Incident responders and administrators who need portable diagnostics and defensive validation tools.

PhalanxOS is not intended to be an anonymous-abuse platform, malware toolkit, or turnkey offensive appliance.

## Base build approach

The initial distro build structure uses **Debian Live Build** as the default base approach.

Reasons for this choice:

- Debian has broad architecture support, mature package repositories, and a stable release cadence.
- `live-build` provides a well-documented path for generating bootable live ISOs and installable images.
- Most requested desktop, privacy, sync, and security tools are available directly from Debian repositories or can be layered via documented external sources.
- Debian's licensing metadata and archive sections make redistributability review easier than ad-hoc binary bundling.

Alternative build systems such as Arch ISO tooling, Buildroot, and Yocto may be evaluated later for specialized editions, but the first implementation should prioritize maintainability and package availability.

## Security model

PhalanxOS should assume a hostile network and potentially untrusted documents. The baseline model is defense-in-depth rather than a single security mechanism.

Planned security principles:

- Prefer signed packages from trusted repositories.
- Minimize services enabled by default.
- Use full-disk encryption for installed systems where supported.
- Keep Tor Browser and privacy tooling isolated from normal browsing profiles.
- Separate optional security tools from the default desktop profile.
- Record provenance for third-party repositories, binary downloads, and manually packaged software.
- Require explicit user action before installing tools with licensing, export-control, or dual-use concerns.

The project should avoid claiming perfect anonymity, exploit immunity, or legal protection. Documentation must explain operational limits clearly.

## AI features

AI features should assist users without replacing user judgment or weakening privacy.

Potential AI-enabled capabilities:

- Offline documentation search and command explanation.
- Configuration linting for firewall, SSH, package, and desktop settings.
- Threat-modeling prompts for personal workstation hardening.
- Log summarization for local troubleshooting.
- Optional code and shell assistance with clear previews before commands are executed.

AI features should be local-first when feasible. If a cloud AI provider is configured, the UI and documentation must disclose what data may leave the device, how credentials are stored, and how to disable the integration.

## Legal and ethical boundaries for offensive-security tools

Some requested tools can be used for legitimate security testing or for harmful activity. PhalanxOS treats them as optional lab and defensive tools, not as default end-user applications.

Project boundaries:

- Security tools must be documented for authorized systems, owned labs, training ranges, and defensive validation only.
- The default ISO should not auto-run scanners, exploit frameworks, credential attacks, wireless attacks, or brute-force workflows.
- Documentation should avoid instructions for unauthorized access, persistence, evasion, credential theft, or exploitation of real third-party targets.
- Tools with restrictive redistribution terms must not be bundled into default images until their licenses are reviewed and recorded.
- Users are responsible for complying with local law, workplace policy, service terms, and export restrictions.

Maintainers should prefer safe examples that use local containers, intentionally vulnerable lab targets, or mock data.
