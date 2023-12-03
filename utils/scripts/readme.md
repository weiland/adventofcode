# Shell scripts


## Preparation

Login at https://adventofcode.com/ and save `session` cookie value to `session.txt`.

## Scripts

### Start on a new day

```shell
sh newday.sh
```

This will create a new (racket) file and download the input.

### Download input

Note: the session cookie is required.

Download for today:

```shell
sh download.sh
```

### Create git commit

```shell
sh commit.sh
```
