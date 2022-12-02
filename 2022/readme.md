# 2022 Advent of Code 🎄

### Start on a new day

```shell
sh newday.sh
```

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


### Boilerplate:

```racket
#lang racket

; (require test-engine/racket-tests)

;; input
(define input (file->string "./input/N.txt"))

(test)
```

or see `boilerplate.rkt`

### Editor setup

Use rainbow brackets!
