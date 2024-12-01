const testInput = `3   4
4   3
2   5
1   3
3   9
3   3
`;

const file = Bun.file("./01.txt");
const text = await file.text();

const parse = (input: string) =>
  input.split("\n").map((line) => line.split("   ").map((n) => Number.parseInt(n)));
type Rows = number[][];
type Lists = { a: number[]; b: number[] };
const transform = (rows: Rows): Lists =>
  rows.reduce(
    ({ a, b }, [ea, eb]) => {
      a.push(ea);
      b.push(eb);
      return { a, b };
    },
    { a: [], b: [] },
  );

const getLists = (input: string): Lists => {
  const parsed = parse(input);
  // remove last line from parsed input
  parsed.pop();
  return transform(parsed);
};
const partOne = (input: string) => {
  const { a, b } = getLists(input);
  a.sort();
  b.sort();
  const diff = a.map((ea: number, i: number) => ea - b[i]).reduce((a: number, b: number) => a + b);
  return diff;
};

const partTwo = (input: string) => {
  const { a, b } = getLists(input);
  return a
    .map((ea, i) => b.filter((eb) => eb === ea).length * ea)
    .reduce((acc, curr) => acc + curr, 0);
};

if (import.meta.main) {
  console.log("one", partOne(text));
  console.log("two", partTwo(text));
}
