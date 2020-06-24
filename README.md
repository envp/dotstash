# `dotstash` -- Backup and install system, app configurations

## Why

Most configuration, dotfile management systems do exactly that:
Manage (backup / install) dotfile and application configuration in different
ways. These work well, but aren't automated enough to my liking, I want to see
if I can improve upon them, without too much complexity. The improvements I
would want to introduce are documented in the '[What](#what)' section

## What

The 'promise' of this tool so to speak, is:

- [ ] At minimum, good old declarative dotfile backup / install
- [ ] Built in support to query / command package managers for backup / install
- [ ] Ability to specify bootstrap dependencies of your dotfiles, e.g.:

More goals added as I understand this better. My use case is limited to figuring
out what to `brew install` along with my dotfiles

## How

[Rationale documented here](./RATIONALE.md)
