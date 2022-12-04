# Advent of Code 

> [https://adventofcode.com/](https://adventofcode.com/)

There are directories for each year.

### Preparation

Login at https://adventofcode.com/ and save `session` cookie value to `session.txt`.

### Start on a new day

```shell
sh newday.sh
```

This will create a new (racket) file and download the input.

### Download input

Add your session cookie value (can be taken from your browser) and add it into the `download.sh` file.

Download for today:

```shell
sh download.sh
```

Others days must be done manually.


### Run code

Creating a nix shell with `racket` dependency:

```shell
nix develop -c $SHELL
```

Re-run code if file has changed (requires `fd` and `entr`):

```shell
fd .rkt | entr -c -r racket (date +"%d").rkt
```


### Editor setup

Use rainbow brackets for racket and other lispy languages!
