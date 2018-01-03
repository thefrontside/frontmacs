# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)

## [0.2.17] - 2018-01-02

### Changed

- Fix api compatibility with `counnsel-projectile`
  https://github.com/thefrontside/frontmacs/pull/95

## [0.2.15] - 2017-10-23

### Added
- default `rspec-use-rake-when-possible` to false. Rake just takes up
  a bunch of extra memory and computational power when invoked for
  little added benefit. Now when running rspec from emacs, it runs
  `bundle exec rspec` instead of `bundle exec rake spec`
- Add compilation regexes for node.js. Emacs doesn't know how to parse
  Node stack traces out of the box, so stack trace links aren't
  clickable or navigable with `goto-next-error`. Now they are.
