# Frontmacs

[![Build Status](https://circleci.com/gh/thefrontside/frontmacs.svg?style=shield)](https://app.circleci.com/pipelines/github/thefrontside/frontmacs?branch=release)
[![Chat on Discord](https://img.shields.io/discord/700803887132704931?Label=Discord)](https://discord.gg/JNnzuSSSb4)
[![Created by Frontside](https://img.shields.io/badge/created%20by-frontside-26abe8.svg)](https://frontside.com)

A collection Emacs Packages maintained by your friends at [Frontside][].

## frontside-javascript

[![MELPA](https://melpa.org/packages/frontside-javascript-badge.svg)](https://melpa.org/#/frontside-javascript)

*JS development that just works™️*

Modern JavaScript development is so much more than just syntax highlighting, or even a language server. This package make sure that your JavaScript environment works "out of the box". This means:

* JavaScript, TypeScript, plus support for JSX, TSX, and MDX
* Code navigation and refactoring
* Support for [NodeJS][] and executables in `node_modules`
* Automatically setup error highlighting with project-local tools like [ESLint] and Prettier.

> Currently, `frontside-javascript` uses [tide-mode][] for TypeScript and language server support. Like that project, we have our eye on [LSP-mode][], and when it's ready will migrate to use that system instead. For the time-being however, we've found tide to be the more consistently reliable alternative.

### Usage
Install the `frontside-javascript` and add a call to `(frontside-javascript)` somewhere in your init process. For example with `use-package`:

```emacs-lisp
(use-package frontside-javascript
  :init (frontside-javascript))
```

[Frontside]: http://frontside.com
[discord]: https://discord.com/invite/JNnzuSSSb4
[prelude]: https://github.com/bbatsov/prelude
[nodejs]: https://nodejs.org
[tide-mode]: https://github.com/ananthakumaran/tide
[lsp-mode]: https://github.com/emacs-lsp/lsp-mode
[eslint]: https://eslint.org
