use std::fs::File;
use std::io::prelude::*;
use std::io::Result;

fn parse_str(input: &str) -> (Vec<u32>, Vec<u32>) {
    let mut left: Vec<u32> = Vec::new();
    let mut right: Vec<u32> = Vec::new();
    for part in input.lines() {
        let (l, r) = part.split_once("   ").expect("Could not split line");
        left.push(l.parse::<u32>().unwrap());
        right.push(r.parse::<u32>().unwrap());
    }
    return (left, right);
}

fn part_one(input: &str) -> u32 {
    let (mut left, mut right) = parse_str(input);
    left.sort();
    right.sort();
    let mut distance = 0;
    for i in 0..left.len() {
        distance += left[i].abs_diff(right[i]);
    }
    return distance;
}

fn part_two(input: &str) -> u32 {
    let (left, right) = parse_str(input);
    let mut similarity = 0;
    for i in 0..left.len() {
        let value = left[i];
        let counts: u32 = right.iter().filter(|&n| *n == value).count() as u32;
        similarity += value * counts;
    }
    return similarity;
}

fn main() {
    let input: String = read_file("01.txt").unwrap();
    println!("Day 01");
    println!("Part 1: {}", part_one(&input));
    println!("Part 2: {}", part_two(&input));
}

fn read_file(filename: &str) -> Result<String> {
    let mut file = File::open(filename)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    return Ok(contents);
}

#[cfg(test)]
mod tests {
    use super::*;
    const TEST_INPUT: &str = "3   4
4   3
2   5
1   3
3   9
3   3";

    #[test]
    fn test_parse_str() {
        let (left, right) = parse_str(TEST_INPUT);
        assert_eq!(left, vec![3, 4, 2, 1, 3, 3]);
        assert_eq!(right, vec![4, 3, 5, 3, 9, 3]);
        // assert_eq!(left, vec![1, 2, 3, 3, 3, 4]);
        // assert_eq!(right, vec![3, 3, 3, 4, 5, 9]);
    }

    #[test]
    fn test_part_one() {
        assert_eq!(part_one(TEST_INPUT), 11);
    }

    #[test]
    fn test_part_two() {
        assert_eq!(part_two(TEST_INPUT), 31);
    }
}
