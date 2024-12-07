use std::fs;

struct Item {
    result: u64,
    input: Vec<u64>,
}

fn parse(input: &str) -> Vec<Item> {
    input
        .lines()
        .map(|line| {
            let (result, input) = line.split_once(": ").expect("no colon in input");
            let result = result.parse::<u64>().expect("could not parse int");
            let input = input
                .split(" ")
                .map(|s| s.parse::<u64>().unwrap())
                .collect();
            Item { result, input }
        })
        .collect()
}

/// recursively attempt to find if the result is possible
fn is_match(total: &u64, result: &u64, inputs: &[u64], is_part_two: bool) -> bool {
    // if no inputs are left
    if inputs.is_empty() {
        // must be equal to be successful
        return total == result;
    }

    // cancel if the calculation is too high
    if total > result {
        return false;
    }

    // try out addition
    is_match(&(total + inputs[0]), result, &inputs[1..], is_part_two)
    // or mulltiplication
    || is_match(&(total * inputs[0]), result, &inputs[1..], is_part_two)
    // or with concatenation
    || is_part_two && is_match(&(format!("{}{}", total, inputs[0]).parse::<u64>().unwrap()), result, &inputs[1..], is_part_two)
}

fn run(input: &str, with_concatenation: bool) -> u64 {
    parse(input)
        .into_iter()
        .filter_map(|item| {
            if is_match(&0, &item.result, &item.input, with_concatenation) {
                Some(item.result)
            } else {
                None
            }
        })
        .sum()
}

fn part_one(input: &str) -> u64 {
    run(input, false)
}

fn part_two(input: &str) -> u64 {
    run(input, true)
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20";

    #[test]
    fn test_parse() {
        let parsed = parse(INPUT);
        let first = parsed.first().unwrap();
        let last = parsed.last().unwrap();
        assert_eq!(first.result, 190);
        assert_eq!(first.input, vec![10, 19]);
        assert_eq!(last.result, 292);
        assert_eq!(last.input, vec![11, 6, 16, 20]);
    }

    #[test]
    fn test_is_match() {
        assert_eq!(is_match(&0, &29, &[10, 19], false), true);
        assert_eq!(is_match(&0, &190, &[10, 19], false), true);
        assert_eq!(is_match(&0, &3267, &[81, 40, 27], false), true);
        assert_eq!(is_match(&0, &292, &[11, 6, 16, 20], false), true);
    }

    #[test]
    fn test_part_one() {
        assert_eq!(part_one(INPUT), 3749);
    }

    #[test]
    fn test_part_one_prod() {
        let input: String = fs::read_to_string("inputs/day07.txt").unwrap();
        assert_eq!(part_one(&input), 1611660863222);
    }

    #[test]
    fn test_part_two() {
        assert_eq!(part_two(INPUT), 11387);
    }

    #[test]
    fn test_part_two_prod() {
        let input: String = fs::read_to_string("inputs/day07.txt").unwrap();
        assert_eq!(part_two(&input), 945341732469724);
    }
}

fn main() {
    let input: String = fs::read_to_string("inputs/day07.txt").unwrap();
    println!("Day 07");
    println!("Part 1: {}", part_one(&input));
    println!("Part 2: {}", part_two(&input));
}
