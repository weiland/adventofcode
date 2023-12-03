# Using JavaScript/Typescript with deno

Most part of the code would also run with `ts-node` except for the deno parts.

## deno shell with nix

```bash
nix shell nixpkgs#deno
```

### Development

## develop deno code

```bash
deno test --allow-read --watch 03.ts
```

## run deno code (once)

```bash
deno test --allow-read 03.ts
```
