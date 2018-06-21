# Frontmacs

[![ELPA Version](https://cdn.rawgit.com/thefrontside/frontmacs/master/elpa.svg?raw=true)](http://elpa.frontside.io/archive-contents)
[![Build Status](https://travis-ci.org/thefrontside/frontmacs.svg?branch=master)](https://travis-ci.org/thefrontside/frontmacs)
[![Join the chat at https://gitter.im/thefrontside/frontmacs](https://badges.gitter.im/thefrontside/frontmacs.svg)](https://gitter.im/thefrontside/frontmacs?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A _package-based_, web-centric, customizable, awesome-by-default,
acceptance-tested Emacs distribution curated by your friends at
[Frontside][frontside].

Let's face it: Emacs is an incredible technology that unfortunately is
intimidating, and quite often downright terrifying to get started with.

When you use Frontmacs, you get a version of Emacs that does all kinds
the amazing things out of the box that you would expect from
a moden IDE including Web and JavaScript development. Not only that,
you get painless upgrades to new packages and techniques as they
become available.

### Package Based.

When you maintain your own editor configuration, you are in a constant
struggle with obsolesence. Unless you're willing to constantly
research the latest techniques, and fiddle with them to work with your
unioue setup, it will inevitably fall out of sync with the
ever-evolving set of best practices.

Alternatively, you can base your configuration on some shared
repository where a common configuration is maintained and regularly
updated. You clone the repo, and then you're off to the races.

However, any customizations you make are made to files
under version control and so upgrading and keeping up with the
community is a constant battle of merges, rebases, throw-aways and
ultimately do overs. We know because we've [been there][5].

But Emacs has a mechanism to distribute elisp code without having to
use git. It's called `ELPA` and it's awesome. You can think of it like
a Ruby gem or an NPM package, and this is what Frontmacs uses for deployment.

None of us wants to maintain a private fork of a mega-repo, we just
want to enter a few keystrokes and download more awesome. And that's
what you get by using elisp packages to install Frontmacs. Now,
anytime anybody fixes a bug or make an improvement, the entire
community can benefit with a simple upgrade.

### Community Driven

A wider group of people contributing to Frontmacs development means
that if you're wanting to try something new, chances are it's
already powered up and ready to go with a great set of features. For
example, if you want to try your hand at React, you don't want to
spend the first 90 minutes fiddling with your editor. You want to
spend that time ripping code!

### Customizable

Just because the default set of packages is heavily curated, doesn't
mean that there shouldn't be room for you to innovate and exercise
your creative muscles.

In fact, because Frontmacs is distributed as an Emacs Lisp package, it is
_decoupled_ from git and so you are now free to maintain your own
customizations in your own repository without fear of conflicting with
the main distribution.

### Acceptance Tested

A modern Emacs configuration is software that is subtle and
complex. So if it's going to provide a pleasant, error-free
experience, then it needs to be treated like software of that level.

Frontmacs tests critical workflows so that you won't get bad upgrades
that ruin your day.

## Installation

It is recommended that you remove any current configuration that you
have from your emacs directory before installing Frontmacs.

Download the bootstrap script into your emacs directory

```
$ mkdir -p ~/.emacs.d && cd ~/.emacs.d
$ wget https://raw.githubusercontent.com/thefrontside/frontmacs/master/scripts/init-frontmacs.el
```

add the following lines to the top of your `init.el`:

``` emacs-lisp
;; boot frontmacs
(load (expand-file-name "init-frontmacs.el" user-emacs-directory))
```

Restart your Emacs and away you go!

---

## Configuration

Frontmacs will create several files and directories in your Emacs
directory (usually `$HOME/.emacs.d`) to help with configuration and
initialization. The first is `config.el` This file is loaded _before_
Frontmacs actually initializes, and so it's a chance to set any
well defined customizations. But don't worry, Frontmacs will generate
this file for you so that you can see what all configuration variables
are available.

For everything else, there are all of the files contained in
`$HOME/.emacs.d/initializers`. Every elisp file contained in this
directory will be evaluated _after_ Frontmacs has been fully
configured and initialized, so settings made in these files will
override anything that comes with Frontmacs out of the box. For
example, you can create your Ruby configuration with a file called:

`$HOME/.emacs.d/initializers/ruby.el`

``` emacs-lisp
(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
```

Just drop any `.el` file into the `initializers/` directory, and
Frontmacs will evaluate it.

> Note: When in doubt about whether you should put something in `config.el` or a
> custom initializer, use an initializer.

---

## Development

You will need a patched version of `Cask` to do development on.

```
$ git clone -b specify-package-descriptor --depth=1 https://github.com/cowboyd/cask.git $HOME/.cask
$ export PATH=$HOME/.cask/bin:$PATH
```

### install dependencies

```
$ cask install
```

### Run an emacs using nothing but the local frontmacs

```
$ make runlocal
```

[frontside]: http://frontside.io
[2]: https://github.com/technomancy/emacs-starter-kit
[3]: https://github.com/bbatsov/prelude
[4]: http://spacemacs.org/
[5]: https://github.com/thefrontside/.emacs.d
