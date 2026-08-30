# Responsible Security Tooling Policy

PhalanxOS treats security tooling as defensive, educational, and dual-use software that must be selected, installed, and documented with care. The default experience must help people harden their own systems, study privacy, and validate defenses without encouraging unauthorized access or harmful activity.

This policy applies to security-related packages, examples, onboarding text, image profiles, and future installer choices.

## Policy goals

- Keep the default desktop suitable for everyday users who want privacy and defensive security without offensive tooling enabled by default.
- Make privacy tooling available with clear provenance and realistic safety notes.
- Support authorized auditors and students through explicit opt-in profiles and responsible-use warnings.
- Gate high-risk tools behind informed user action, not silent dependency pulls or default image inclusion.
- Track package source, license, redistribution status, default installation status, and legal or ethical usage constraints before a tool is shipped.

## Install profiles

PhalanxOS classifies security and privacy tools into four install profiles. A package may be listed in more than one profile only when the safer profile uses a constrained role and the high-risk behavior remains gated.

| Profile | Intended audience | Installation stance | Tooling boundary |
| --- | --- | --- | --- |
| Default desktop | General users and developers | Installed by default only when the tool is privacy-preserving, defensive, broadly useful, and redistributable | No exploit frameworks, password cracking, wireless attack suites, or brute-force login tooling |
| Privacy profile | Privacy researchers, journalists, and users who opt into anonymity or secure-sharing workflows | Optional opt-in during install or post-install onboarding | Must emphasize operational limits, metadata risks, and lawful use |
| Security-auditor profile | Administrators, incident responders, students, and defenders working on owned or authorized systems | Optional opt-in with responsible-use acknowledgement | Network discovery, local diagnostics, defensive validation, and offline password auditing only |
| Advanced pentesting profile | Experienced practitioners working in labs, ranges, or client-authorized engagements | Optional opt-in with high-risk gate and package-specific warnings | Exploit frameworks, credential-audit tools, wireless auditing suites, and web proxy tooling with strict authorization language |

## Package classification

| Tool | Install profile | Package source | License | Redistribution status | Default installation status | Legal/ethical usage note |
| --- | --- | --- | --- | --- | --- | --- |
| Tor Browser launcher | Default desktop, privacy profile | Debian package for `torbrowser-launcher`; browser retrieved and verified from Tor Project mechanisms | Launcher follows Debian package metadata; Tor Browser follows Tor Project licensing | Candidate when installed through signed Debian packages and verified upstream downloads | Installed by default as a privacy entry point, subject to signature verification | Use to protect privacy and reduce tracking; do not claim it provides legal immunity or complete anonymity |
| OnionShare | Default desktop, privacy profile | Debian package `onionshare` | Open source; verify exact license from Debian copyright metadata during packaging | Candidate for default ISO from Debian repositories | Installed by default when sourced from Debian | Use for consent-based file sharing, receiving, and publishing; warn users about content, metadata, and local law |
| Nmap | Security-auditor profile | Debian package `nmap` | Nmap Public Source License / GPL-derived terms; verify Debian copyright metadata | Candidate for optional auditor image from Debian repositories | Not installed by default | Scan only networks, hosts, and services the user owns or is explicitly authorized to test |
| John the Ripper | Security-auditor profile | Debian package `john` | GPL; verify Debian copyright metadata | Candidate for optional auditor image from Debian repositories | Not installed by default | Use for offline password auditing of owned password hashes or approved training data only |
| Hashcat | Advanced pentesting profile | Debian package `hashcat`; GPU runtime dependencies may come from Debian non-free or vendor sources | MIT; verify Debian copyright metadata and driver licenses | Conditional: core package may be redistributable from Debian, but GPU stacks require separate review | Not installed by default; high-risk gate required | Use only for password recovery or auditing with explicit authorization; never target third-party credentials |
| Aircrack-ng | Advanced pentesting profile | Debian package `aircrack-ng` | GPL; verify Debian copyright metadata | Candidate for optional advanced profile from Debian repositories after policy review | Not installed by default; high-risk gate required | Test only owned lab wireless networks or client-authorized environments; comply with radio, privacy, and wiretap laws |
| Hydra | Advanced pentesting profile | Debian package `hydra` | AGPL/GPL-family; verify Debian copyright metadata | Candidate for optional advanced profile from Debian repositories after policy review | Not installed by default; high-risk gate required | Use only for authorized login control validation; do not run password attacks against public or third-party services |
| Metasploit Framework | Advanced pentesting profile | External repository, Kali source, or upstream packages; no default Debian main package assumption | BSD-style components plus Rapid7 packaging terms; requires version-specific review | Not redistributable in default ISO until license, update, and provenance review is complete | Not installed by default; high-risk gate required | Use only in owned labs, ranges, or client-authorized engagements; documentation must not provide unauthorized exploitation playbooks |
| Burp Suite Community | Advanced pentesting profile | Debian non-free where available or PortSwigger vendor download | Proprietary/freeware terms for Community edition; Professional has separate commercial terms | Not redistributable in default ISO without edition-specific terms review | Not installed by default; high-risk gate required | Use only for authorized web application testing; do not intercept third-party traffic without consent |
| Burp Suite Professional | Advanced pentesting profile | PortSwigger vendor installer or licensed account download | Commercial proprietary license | Do not redistribute; user must obtain directly under their own license | Never installed by default; user-provided installer/license only | Use only under a valid license and explicit testing authorization |

## High-risk installation gate

High-risk tools must not be installed by dependency surprise, default profile selection, or unattended first-boot scripts. This requirement applies at minimum to Metasploit Framework, Hydra, Aircrack-ng, Hashcat, and Burp Suite.

A future installer, package-manager helper, or onboarding screen must require an explicit acknowledgement before installing high-risk tools. The gate should:

1. Identify the requested high-risk packages by name.
2. State that the tools are dual-use and may be regulated by law, workplace policy, service terms, export controls, or client contracts.
3. Require the user to confirm that they will use the tools only on systems, networks, accounts, and data they own or are authorized to assess.
4. Link to this policy and any package-specific license or redistribution notes.
5. Record only the minimum local state needed to avoid repeated prompts; do not transmit an acknowledgement to third parties by default.

Recommended onboarding warning text:

> You are enabling advanced dual-use security tools. Use them only for defensive auditing, privacy research, training labs, or systems where you have explicit authorization. Unauthorized scanning, exploitation, password attacks, wireless attacks, traffic interception, or credential testing may be illegal and harmful. If you are unsure whether you have permission, do not install these tools.

## Default user experience requirements

The default PhalanxOS desktop must reinforce safe, defensive use:

- Present privacy and defensive-auditing tools before offensive or exploit-oriented tools.
- Avoid desktop shortcuts, welcome flows, or examples that imply attacking third-party systems.
- Use sample targets that are local, intentionally vulnerable, containerized, or mock-only.
- Explain that anonymity, encryption, and security tools reduce risk but do not guarantee safety or legality.
- Keep high-risk packages out of the default ISO unless maintainers formally change this policy with documented rationale.
- Require maintainers to review source, license, redistribution status, and ethical notes before moving any tool into a broader profile.

## Maintainer checklist for new tools

Before adding or promoting a security tool, maintainers must document:

- Package name, upstream project, and repository source.
- Exact license and where it was verified.
- Whether the package can be redistributed in a public ISO.
- Which profile owns the package and whether a gate is required.
- Whether non-free drivers, firmware, signatures, accounts, or vendor downloads are needed.
- Safe example scenarios and prohibited documentation patterns.
- Any known legal, export-control, radio-spectrum, privacy, or service-terms concerns.
