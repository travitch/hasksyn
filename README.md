# Introduction

hasksyn is a vim plugin to highlight and indent Haskell source code.  It is
written almost entirely from scratch and has slightly different goals than the
original Haskell syntax highlighting code.  Most importantly, this version
explicitly does _not_ handle Literate Haskell files at all.  In exchange, it
provides more comprehensive syntax highlighting for normal Haskell code, along
with fairly reasonable indentation.  It also includes improved highlighting
for cabal files.

Unlike [haskellmode-vim](http://projects.haskell.org/haskellmode-vim/) and
[vim2hs](https://github.com/dag/vim2hs), this package does not support running
external tools over code in fancy ways or recognizing cabal files.

## Screenshot

Here is a screenshot of the syntax highlighting (included in the demos
directory):

![screenshot](https://raw.github.com/travitch/hasksyn/master/demos/test1.png "Sample screenshot")

## Stability

This mode seems to work reasonably well.  That said, it hasn't been thoroughly
tested.  Additionally, configuration options are still subject to change.

## Performance

I've tested things out on files around 1000 lines and it seems to perform well.
I don't see a visible slowdown with this code, whereas vim2hs was pegging a CPU
while scrolling.  The indent code can do a non-trivial amount of work, but it
does not really seem to be an issue.

## TODO

 * Highlighting for `mdo`, `proc`, and `rec`
 * Nesting block comments inside of haddock block documentation comments
 * Indentation for quasi-quotes (maybe)
 * More clever indentation, where sensible

# Requirements

The code has only been tested with vim 7.3, but it should work for almost any
reasonable version.  Feel free to report bugs; I'll try to support all
reasonable versions.  There is also no platform-specific code.

# Indentation Policy

As far as I can tell, this package should provide better Haskell indentation
than other modes.  Here is a brief overview of its features:

 * Smart handling of comments and strings; it should be doing the right thing
   almost all of the time.  The expected exception is if you are inside of a
   very long block comment where the comment beginning is farther back than
   the search allowance.

 * Indent after where/case .. of/operators at the end of lines

 * Align | and ,

 * Align bindings in let expressions, and snap `in` to its proper spot

 * De-indent after `return` at the end of a `do` block.

 * De-indent after the catchall case of a case expression.

# Installation

## With [pathogen](https://github.com/tpope/vim-pathogen)

Just clone into the standard pathogen location:

```bash
cd ~/.vim/bundle
git clone git://github.com/travitch/hasksyn.git
```

If you use git submodules:

```bash
cd ~/.vim
git submodule add git://github.com/travitch/hasksyn.git bundle/hasksyn
```

## Manually

```bash
git clone git://github.com/travitch/hasksyn.git
cd hasksyn
cp -R * ~/.vim
```

# Configuration

Below are the configuration options available, along with their default values.
If you want to change them, just copy the relevant line into your `~/.vimrc`.

## Indentation

```
" How many lines should be searched for context
let g:hasksyn_indent_search_backward = 100

" Should we try to de-indent after a return
let g:hasksyn_dedent_after_return = 1

" Should we try to de-indent after a catchall case in a case .. of
let g:hasksyn_dedent_after_catchall_case = 1
```

# Notes

If you use [rainbow_parentheses](https://github.com/kien/rainbow_parentheses.vim),
do *not* enable `RainbowParenthesesLoadBraces` for Haskell files.  It seems to
interfere with highlighting block comments.

I have also disabled so-called three part comments for Haskell.  These
look like:

```haskell
{-
 -
 -
 -}
```

These are three-part comments because of the start token `{-`, the middle token
`-`, and the end token `-}`.  Whatever vim does to make this magic happen was
interfering with the indentation script, so I disabled it.  I also find it kind
of obnoxious.  If you really want it back, I could make that configurable or
you can just use `~/.vim/after/ftplugin/haskell.vim`.

