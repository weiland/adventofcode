import { assertEquals } from "https://deno.land/std@0.208.0/assert/mod.ts";

const decoder = new TextDecoder('utf-8');
const data = Deno.readFileSync('./input/03.txt');
const rawInput = decoder.decode(data);

const testInput = 
`467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
`;

function findNeighbours(lst:string[], pos: number) {
	const prev = pos - 1;
	const next = pos + 1;
	const result = [];
	const curr = lst[pos];
	// skip numbers
	// @ts-ignore: using string
	if (isNaN(curr)) {
		result.push(curr);
	}
	if (prev >= 0) {
		result.push(lst[prev]);
	}
	if (next < lst.length) {
		result.push(lst[next]);
	}
	return result;
}

function solveOne(input: string) {
	const lines = input.split('\n');
	// remove last empty line
	lines.pop();
	const matrix = lines.map((value) => value.split('').filter(c => c !== ''));

	const matrixRows = matrix.length;
	const matrixCols = matrix[0].length;

	function getNeighbours(x:number, y:number) {
		let result = findNeighbours(matrix[y], x);

		if (y > 0) {
			result = [...result, ...findNeighbours(matrix[y - 1], x)]
		}

		const maxY = y + 1;
		if (maxY < matrixRows) {
			result = [...result, ...findNeighbours(matrix[maxY], x)]
		}

		return result;
	}

	// @ts-ignore: using string
	const isValid = (arr: string[]) => arr.reduce((acc: boolean, curr: string) => acc || (isNaN(curr) && curr !== '.'), false);

	const validNumbers = []

	let n = '';
	let neighbours: string[] = [];

	for (let y = 0; y < matrix.length; y++) {
		for (let x = 0; x < matrix[0].length; x++) {
			const value: string = matrix[y][x];
			// @ts-ignore: using string
			if (!isNaN(value)) {
				n = `${n}${value}`
				neighbours = [...neighbours, ...getNeighbours(x, y)]

				// reached end of col or next char is a sign or dot -> terminus
				// @ts-ignore: using string
				if (x+1 === matrixCols || isNaN(matrix[y][x + 1])) {
					if (isValid(neighbours)) {
						validNumbers.push(n);
					} 
					n = '';
					neighbours = []
				}
			}
		}
	}

	const result = validNumbers.map(n => parseInt(n)).reduce((a, c) => a + c, 0);

	return result
}

function solveTwo(input: string) {
	const lines = input.split('\n');
	// remove last empty line
	lines.pop();
	const matrix = lines.map((value) => value.split('').filter(c => c !== ''));

	const matrixRows = matrix.length;

	function findWholeNumber(lst: string[], pos: number) {
		const value: string = lst[pos];
		let whole: string = value;
		// @ts-ignore: using string
		if (isNaN(value)) return false;
		// possible prefix
		let prefixPos = pos;
		while (prefixPos > 0) {
			prefixPos--;
			const prefix = lst[prefixPos];
				// @ts-ignore: using string
			if (isNaN(prefix)) break;
			whole = `${prefix}${whole}`
		}
		// possible suffic
		let suffixPos = pos + 1;
		while (suffixPos < lst.length) {
			const suffix = lst[suffixPos];
			// @ts-ignore: using string
			if (isNaN(suffix)) break;
			whole = `${whole}${suffix}`
			suffixPos++;
		}

		return parseInt(whole);
	}

	function findNumericNeihbours(lst: string[], pos: number) {

		const curr = lst[pos];
		// If current element is numeric we don't have to look up prev and next.
		// @ts-ignore: using string
		if (!isNaN(curr)) {
			return [findWholeNumber(lst, pos)]
		}

		const result = [];
		const prev = pos - 1;
		if (prev >= 0) {
			result.push(findWholeNumber(lst, prev));
		}

		const next = pos + 1;
		if (next < lst.length) {
			result.push(findWholeNumber(lst, next));
		}

		return result;
	}

	function getNeighbours(x:number, y:number) {
		let result = findNumericNeihbours(matrix[y], x);

		if (y > 0) {
			result = [...result, ...findNumericNeihbours(matrix[y - 1], x)]
		}

		const maxY = y + 1;
		if (maxY < matrixRows) {
			result = [...result, ...findNumericNeihbours(matrix[maxY], x)]
		}

		const filtered: number[] = result.filter((n): n is number => n !== false);
		if (filtered.length === 2) {
			const [a, b] = filtered;
			return a * b;
		}
		return false
	}

	let sum = 0;
	for (let y = 0; y < matrix.length; y++) {
		for (let x = 0; x < matrix[0].length; x++) {
			const value: string = matrix[y][x];
			if (value === '*') {
				const product = getNeighbours(x, y)
				if (product) {
					sum = sum + product;
				}
			}
		}
	}

	return sum
}

// Smoke tests
Deno.test('part number sum is 4361', () => {
  const testOne = solveOne(testInput);
  assertEquals(testOne, 4361);
});

Deno.test('gear ratio sum is 467835', () => {
  const testTwo = solveTwo(testInput);
  assertEquals(testTwo, 467835);
});

// Results
console.log('part one is', solveOne(rawInput));
console.log('part two is', solveTwo(rawInput));
