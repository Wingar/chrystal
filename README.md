# chrystal

Changes the current version of [Crystal](http://crystal-lang.org/).

## What is this?
This is a fork and repurpose of the brilliant script [chruby](https://github.com/postmodern/chruby), a script that's used to simply change the current Ruby interpreter and version. All real credit for this goes there.

## Why?
Being a big user of chruby, I saw my chance to repurpose this for use with Crystal. A there's currently only one compiler of Crystal, the amount of usefulness is vastly diminished.

However, with Crystal being native code, and Crystal advancing as fast as it is, your code might only work with certain versions of the compiler, thus, version switching.

It should work with every version of Crystal from `0.1.0` to `0.5.7`

## Install
    tar -xvf chrystal.tar.gz
    tar -xvf chrystal-master
    sudo ./scripts/setup.sh