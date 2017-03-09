# Frontmacs

An awesome-out-of-the-box configuration for Emacs maintained by the
Frontside.

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
