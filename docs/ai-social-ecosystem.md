# AI and Social Ecosystem Architecture Proposal

This proposal defines the intended architecture for PhalanxOS AI assistance and social features. It keeps the distribution useful for daily work, privacy-minded collaboration, and authorized security practice while avoiding designs that encourage surveillance, spam, harassment, or unsafe automation.

## Design goals

- Provide a built-in assistant that helps users understand and manage their own system.
- Preserve privacy by default, especially for local files, contacts, command history, and social metadata.
- Make all networked AI and social integrations explicit, inspectable, and optional.
- Support local-first identity and data storage so users can keep working without a central service.
- Allow future federation with established protocols without making PhalanxOS dependent on any single social platform.
- Include abuse-prevention controls from the first design phase rather than adding them after deployment.

## Built-in AI assistant scope

The built-in assistant should be a system helper, not an autonomous operator. It may propose commands, package changes, configuration edits, and troubleshooting steps, but privileged actions require clear user review and confirmation before execution.

Initial assistant capabilities:

- **Local command help:** Explain installed commands, summarize manual pages, suggest safe flags, and generate shell snippets with previews. Destructive commands should be labeled clearly and should not run automatically.
- **System search:** Search local documentation, settings, application launchers, package metadata, logs selected by the user, and indexed help content. Search indexes should remain local unless the user opts into a remote backend.
- **Package suggestions:** Recommend packages from configured repositories based on a user's stated goal, with license, repository origin, approximate install size, and security notes when available.
- **Security-tool guidance:** Explain defensive and lab-oriented security tools, suggest authorized testing workflows, and direct users toward local ranges, mock services, or owned infrastructure. The assistant should refuse guidance for unauthorized access, persistence, evasion, credential theft, malware deployment, and abuse of third-party systems.
- **Privacy-preserving defaults:** Avoid uploading prompts, command history, file paths, documents, logs, contacts, social graph data, or telemetry unless the user explicitly enables a remote provider and approves the relevant data flow.

The assistant should present uncertainty and risk plainly. For example, it should distinguish between a package available from Debian repositories, a third-party repository, and a vendor binary that needs separate redistribution or trust review.

## AI inference model

PhalanxOS should use a **hybrid, local-first** AI inference model.

### Local inference baseline

Local inference is the default architecture for common system-help tasks:

- Documentation search and retrieval-augmented answers over local docs.
- Command explanations and shell snippet drafting.
- Basic package discovery from local package indexes.
- Configuration review for files the user explicitly selects.
- Local log summarization where hardware resources allow it.

Local models should run under a confined service account with limited filesystem access. The assistant should request per-session access to sensitive locations such as home directories, SSH configuration, browser profiles, password stores, private keys, chat history, and cloud-sync folders.

### Optional remote inference

Remote inference may be supported for users who want larger models or cloud-backed code assistance. It must be disabled by default and gated by explicit setup.

Remote-provider configuration should include:

- Provider name, endpoint, and model identifier.
- A plain-language data disclosure describing what prompts, files, logs, or metadata may leave the device.
- Credential storage through the desktop secret service or another encrypted local store.
- A visible remote-mode indicator in assistant UI surfaces.
- Per-request confirmation when sensitive files, logs, social data, or command history are attached.
- A one-click disable control that removes active credentials from the assistant runtime.

### Policy routing

The assistant should route requests according to sensitivity:

| Request type | Default route | Notes |
| --- | --- | --- |
| Manual pages, local docs, package metadata | Local | Safe default for most help queries. |
| Selected config files or logs | Local | User must choose files or grant scoped access. |
| General knowledge without personal context | Local or remote opt-in | Remote use requires prior provider setup. |
| Social graph, private messages, contacts | Local only by default | Remote use should require explicit per-request approval. |
| Secrets, keys, password stores | Not attached | Assistant may explain concepts but should not process secrets. |

## Social ecosystem model

PhalanxOS social features should be implemented as a local-first personal data layer with optional bridges to federated or peer-to-peer networks. The operating system should own the local identity, permissions, and storage boundaries; external protocols should be adapters.

### Local profile

Each user may create one or more local profiles containing:

- Display name, avatar, bio, pronouns, public keys, and optional links.
- Visibility settings for public, friends-only, group-only, or local-only fields.
- Separate personas for daily use, anonymous mode, professional collaboration, or lab environments.
- Export and delete controls for profile data.

Profiles should be stored locally in an encrypted user data store when full-disk encryption or home-directory encryption is available. Public profile exports should be generated intentionally rather than mirrored automatically.

### Friend and follow graph

The social graph should support both mutual friendships and one-way follows:

- **Friends:** Mutual relationship suitable for private messaging, private activity, and trusted groups.
- **Follows:** One-way subscription suitable for public posts, project updates, or federated feeds.
- **Blocks and mutes:** Local controls that suppress unwanted accounts, domains, groups, keywords, or applications.
- **Graph portability:** Users should be able to export follows, friends, blocks, and mutes in a documented format.

Graph data is sensitive metadata. It should not be exposed to apps, remote AI providers, or federation bridges without scoped permission.

### Encrypted messaging

Messaging should provide end-to-end encryption for private conversations:

- One-to-one direct messages.
- Small private groups.
- Attachment encryption before upload or relay.
- Device verification and key-change warnings.
- Local searchable message indexes that remain encrypted at rest where possible.

The UX should make delivery mode clear: local peer-to-peer, relay-assisted, federated bridge, or platform-specific integration. Users should know when metadata such as recipient IDs, timestamps, IP addresses, or relay identifiers may be visible to network operators.

### Activity feed

The activity feed should aggregate local and remote events with strong filters:

- Local application events selected by the user, such as published notes, package build updates, or project releases.
- Posts from followed people, projects, or groups.
- Replies, mentions, reactions, and reposts where supported by the active protocol.
- Content warnings, media controls, keyword filters, and per-source visibility rules.

The feed should avoid dark patterns. Chronological mode should be available, ranking should be explainable, and remote recommendation engines should not be enabled by default.

### Group spaces

Group spaces provide collaboration areas for friends, projects, classes, incident-response teams, and lab communities:

- Shared posts, files, links, and pinned resources.
- Role-based permissions for owners, moderators, members, and guests.
- Optional encrypted rooms for private groups.
- Join policies such as invite-only, approval-required, local-only, or federated-public.
- Audit logs for moderation actions without exposing private message content.

Groups used for security education should include responsible-use reminders and should discourage requests for unauthorized targeting or harmful tooling.

### Optional federation

Federation should be optional and adapter-based. A user who never enables federation should still have a useful local profile, contacts, encrypted messages, and local group spaces.

Federation adapters should declare:

- Supported protocol and server requirements.
- Data types synchronized or published.
- Identity mapping between local profiles and remote accounts.
- Moderation capabilities available through the protocol.
- Known privacy and metadata limitations.

## Privacy controls

Privacy controls must be visible during onboarding and available later in settings.

### Anonymous mode

Anonymous mode should create a temporary or compartmentalized persona with reduced linkability:

- Separate profile identity, browser profile, assistant context, app permissions, and social graph.
- No automatic reuse of default account names, avatars, contacts, or device identifiers.
- Clear warnings about behavioral fingerprinting, logged-in accounts, file metadata, and network-level correlation.
- Easy reset or destruction of the anonymous-mode workspace.

Anonymous mode should not promise perfect anonymity or protection from legal process, endpoint compromise, or user mistakes.

### Tor routing option

PhalanxOS should provide a Tor routing option for selected applications and social adapters:

- Per-app Tor routing toggles where technically feasible.
- Onion service support for self-hosted local-first endpoints when appropriate.
- Leak warnings for protocols that do not safely support proxying.
- Clear separation between Tor-routed and clearnet identities.

Tor should be available as a privacy tool, not as a bypass for abuse, harassment, or unauthorized activity.

### Telemetry disabled by default

Telemetry must be disabled by default across AI and social components.

If maintainers later add opt-in diagnostics, the implementation should provide:

- A concise list of collected fields.
- Local preview before upload.
- No collection of message contents, social graphs, command history, file contents, or precise identifiers by default.
- Separate toggles for crash reports, performance metrics, package statistics, and AI-quality feedback.
- Retention and deletion documentation.

### Per-app permission controls

Applications and integrations should request scoped access to social and AI data:

- Profile fields.
- Friend/follow graph.
- Contacts.
- Direct messages.
- Group memberships.
- Activity feed publishing.
- Local documents, logs, and command history used by the assistant.
- Remote AI-provider access.

Permissions should be revocable, auditable, and separated by local persona. High-risk permissions should expire automatically unless the user pins them.

## Abuse prevention and moderation

PhalanxOS should combine local user controls, group moderation, and protocol-level enforcement where available.

Recommended mechanisms:

- **Rate limits:** Bound outbound messages, follows, invites, mentions, and federation requests per account, app, and relay.
- **Reputation signals:** Show account age, verification state, mutual connections, server reputation, and moderation history where available without turning them into opaque social scores.
- **Reporting flows:** Let users report spam, harassment, impersonation, malware, doxxing, non-consensual intimate content, child-safety issues, and illegal content to group moderators, instance administrators, or platform operators depending on the active protocol.
- **Local safety filters:** Support blocks, mutes, keyword filters, media blur, content warnings, domain blocks, group-level allowlists, and attachment quarantine.
- **Invite controls:** Use invite links with expiration, member caps, and revocation for private groups.
- **Attachment scanning:** Inspect downloads and shared files with local malware scanning where available, while avoiding server-side content inspection for encrypted messages.
- **Moderation logs:** Record group moderation actions such as deletion, warning, timeout, ban, appeal, and moderator note events.
- **Appeals:** Provide a simple appeal path for group or instance actions when federation protocols support it.
- **Bridge containment:** Disable or throttle federation bridges that relay spam, abusive content, malicious attachments, or policy-violating automation.

Moderation should be transparent about who can see what. Moderators may see group posts and reports, but encrypted private-message content should remain unavailable unless a participant reports and voluntarily attaches the relevant content.

## Candidate protocols and platforms

PhalanxOS should evaluate several integration paths before committing to a default social backend.

| Candidate | Strengths | Risks and open questions | Suggested role |
| --- | --- | --- | --- |
| ActivityPub | Mature federated social protocol with broad Fediverse adoption and support for follows, posts, replies, and moderation concepts. | End-to-end encrypted messaging is not a core strength; server moderation and metadata exposure vary by instance. | Best candidate for public profiles, follows, activity feeds, project accounts, and optional federation. |
| Matrix | Strong room model, mature encrypted messaging, bridges, and multi-device support. | Homeserver operation can be resource-intensive; metadata privacy depends on deployment and federation choices. | Best candidate for encrypted messaging and group spaces. |
| Nostr | Simple relay model, portable identities, and censorship-resistant publishing patterns. | Moderation, spam control, key recovery, and UX conventions are still uneven. | Experimental adapter for portable public notes and relay-based follows. |
| Custom local-first protocol | Can be designed around PhalanxOS privacy, local storage, offline operation, and per-app permissions. | Requires substantial design, security review, interoperability work, and long-term maintenance. | Internal data model and offline sync layer; expose bridges to ActivityPub, Matrix, or Nostr rather than replacing them immediately. |

## Open implementation questions

- Which local model sizes and runtimes are realistic for the minimum supported hardware profile?
- Should the assistant index all documentation by default or wait for first-run consent?
- What encrypted local database format should store profiles, messages, graph data, permissions, and feed indexes?
- Should Matrix be bundled as a client only, or should PhalanxOS support an optional personal homeserver profile?
- How should federation adapters be sandboxed and updated independently from the base OS?
- What export format should be used for local profiles, social graph data, moderation lists, and group metadata?

## Initial roadmap

1. Define the local identity, permission, and encrypted storage schemas.
2. Build a local-only assistant prototype over system docs, package metadata, and selected configuration files.
3. Add a local profile manager with persona separation and anonymous-mode workspaces.
4. Prototype Matrix-based encrypted messaging and ActivityPub-based public feed adapters as optional integrations.
5. Add per-app permission prompts and audit logs for social and assistant data access.
6. Validate Tor routing for selected apps and document unsupported or unsafe proxying cases.
7. Run threat-modeling and abuse-case reviews before enabling federation by default in any future edition.
