# Homebrew Tap for Solus

This tap distributes the Solus macOS application and the optional headless
server/CLI.

## Desktop application

```sh
brew install --cask Ashton-Sidhu/tap/solus
```

After the tap has been added, the short form also works:

```sh
brew install --cask solus
```

## Headless server and CLI

```sh
brew install Ashton-Sidhu/tap/solus-server
brew services start solus-server
solus claim
```

Release automation in
[`Ashton-Sidhu/solus`](https://github.com/Ashton-Sidhu/solus) updates both
package definitions for stable tagged releases.
