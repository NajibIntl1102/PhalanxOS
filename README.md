# PhalanxOS

PhalanxOS is an AI-assisted Linux distribution concept with a rebellious, privacy-first attitude and a strong bias toward responsible security practice.

The repository currently contains the initial distro planning and build structure. It does not yet produce a release ISO.

## Project goals

- Build a usable, modern Linux desktop with strong privacy and security defaults.
- Use a documented, repeatable image build process.
- Provide AI-assisted local workflows for documentation, configuration review, and troubleshooting.
- Keep offensive-security tools optional, legally reviewed, and framed for authorized use only.

See the architecture overview for more detail: [`docs/architecture.md`](docs/architecture.md).

## Base build approach

PhalanxOS will start with **Debian Live Build** for ISO and image creation.

Debian Live Build was chosen because Debian provides mature package repositories, broad hardware support, licensing metadata, and a well-established live-image workflow. Future specialized editions may evaluate Arch ISO tooling, Buildroot, or Yocto, but Debian Live Build is the default starting point.

Build scaffolding lives in [`build/`](build/), and package selections live in [`manifests/`](manifests/).

## Repository layout

```text
.
├── build/                  # Future ISO/image build scripts and live-build configuration
├── docs/                   # Architecture and project documentation
├── manifests/              # Package manifests for core and optional profiles
├── LICENSE                 # Repository license
└── README.md               # Project overview and developer workflow
```

## Package manifests

- [`manifests/core.yaml`](manifests/core.yaml) lists core distro components such as the Linux kernel, GNU userland, BusyBox, Wayland, Niri, KDE Plasma, Nextcloud client, Tor Browser support, OnionShare, rclone, and pCloud integration notes.
- [`manifests/security-tools.yaml`](manifests/security-tools.yaml) lists optional security tools such as Nmap, Metasploit Framework, Burp Suite, John the Ripper, Hashcat, Aircrack-ng, and Hydra.

The optional security manifest is not intended for default installation in the first desktop ISO.

## Licensing and redistribution notes

Default images should prefer packages from Debian `main` whenever possible. Tools or integrations from Debian `non-free`, vendor binaries, third-party repositories, or upstream release downloads require explicit license and provenance review before they are bundled.

Special attention is required for:

- pCloud desktop integration, because redistribution terms for vendor binaries may differ from Debian packages.
- Tor Browser, which should be installed and verified through trusted Tor Project mechanisms.
- Burp Suite, because Community and Professional editions have different terms.
- Metasploit Framework, because bundling and update workflows require additional review.
- GPU-accelerated password-auditing stacks, because drivers and runtime components may involve non-free licensing.

Security tools must only be used on systems and networks where the user has explicit authorization.

## Supported host systems

The initial supported build hosts are:

- Debian stable or testing
- Ubuntu LTS releases

Other Linux distributions may work if they provide recent `live-build`, `debootstrap`, and related Debian image-building tools, but they are not the primary target yet.

## Build prerequisites

Install the baseline tools on a Debian or Ubuntu host:

```sh
sudo apt update
sudo apt install --yes \
  live-build \
  debootstrap \
  xorriso \
  isolinux \
  syslinux-common \
  squashfs-tools \
  mtools \
  dosfstools \
  git \
  make
```

Additional packages may be required once the first `live-build` configuration is added under `build/`.

## Basic development workflow

1. Create a feature branch.
2. Update architecture docs, build scripts, or manifests.
3. Validate manifests and scripts locally.
4. Build test images in a clean Debian or Ubuntu environment once build scripts exist.
5. Record licensing notes for any package that is not sourced from Debian `main`.
6. Open a pull request that summarizes changes, validation steps, and any redistribution concerns.

Current bootstrap validation:

```sh
git status --short
find build docs manifests -maxdepth 2 -type f | sort
```

## Responsible-use policy

PhalanxOS may document optional defensive and lab security tooling, but the project should not encourage unauthorized access, credential attacks against third-party systems, persistence, evasion, or malware deployment. Examples should use owned labs, mock services, or intentionally vulnerable local targets.
