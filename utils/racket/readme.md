# Racket

## racket in a nix shell

```bash
nix shell nixpkgs#racket
```

## Development

### Run code

Re-run code if file has changed (requires `fd` and `entr`):

```shell
fd .rkt | entr -c -r racket (date +"%d").rkt
```

On another day replace `%d` with current day.

## Editor setup

Use *rainbow brackets* for racket and other lispy languages!
