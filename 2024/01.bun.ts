#!/usr/bin/env bun

const testInput = `3   4
4   3
2   5
1   3
3   9
3   3
`;

const file = Bun.file("./01.txt");
const text = await file.text();

// type Tuple = [number, number];
type Rows = number[][];
type Lists = { left: number[]; right: number[] };

const parse = (input: string): Rows =>
  input.split("\n").map((line) => line.split("   ").map(Number));

const transform = (rows: Rows): [number[], number[]] =>
  rows.reduce(
    ([left, right]: [number[], number[]], [r, l]) => [
      [...left, r],
      [...right, l],
    ],
    [[], []],
  );

const getLists = (input: string): Lists => {
  const parsed = parse(input);
  // remove last empty line from parsed input
  parsed.pop();
  const [left, right] = transform(parsed);
  return { left, right };
};

const partOne = (input: string) => {
  const { left, right } = getLists(input);
  left.sort();
  right.sort();
  // here we could calculate part two's similarity as well
  return left.reduce((distance, ea: number, i: number) => distance + Math.abs(ea - right[i]), 0);
};

const partTwo = (input: string) => {
  const { left, right } = getLists(input);
  return left
    .map((ea) => right.filter((eb) => eb === ea).length * ea)
    .reduce((similarity, curr) => similarity + curr, 0);
};

if (import.meta.main) {
  console.log("one", partOne(text));
  console.log("two", partTwo(text));
}
