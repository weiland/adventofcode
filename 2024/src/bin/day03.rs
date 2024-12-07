use regex::Regex;
use std::fs;

// use crate::Day;

// pub struct Day01;

fn extract_instructions(str: &str) -> u32 {
    let re = Regex::new(r"mul\((?<lhs>\d{1,3})\,(?<rhs>\d{1,3})\)").unwrap();
    re.captures_iter(str)
        .map(|cap| {
            cap.name("lhs").unwrap().as_str().parse::<u32>().unwrap()
                * cap.name("rhs").unwrap().as_str().parse::<u32>().unwrap()
        })
        .sum()
}

#[test]
fn test_extract_instructions() {
    let str = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
    assert_eq!(extract_instructions(str), 161);
    assert_eq!(extract_instructions("mul(2,4)"), 8);
    assert_eq!(extract_instructions("mul(2,4)xmul(4,8)"), 40);
    assert_eq!(extract_instructions("dontdo"), 0);
}

fn split(str: &str) -> Vec<&str> {
    let mut instructions: Vec<&str> = vec![];
    for s in str.split("do()") {
        let has_dont = Regex::new(r"don't\(\)").unwrap();
        let re = Regex::new(r"(.*?)don't\(\)").unwrap();
        if has_dont.is_match(s) {
            let caps = re.captures(s).unwrap();
            // let ins: &str = caps.name("i").unwrap().as_str();
            let ins: &str = caps.get(0).unwrap().as_str();
            // println!("match: {}", &caps["i"]);
            instructions.push(ins);
        } else {
            instructions.push(s);
        }
    }
    instructions
}

fn part_two(str: &str) -> u32 {
    let mut is_do = true;
    let mut sum = 0;
    let re =
        Regex::new(r"(?<do>do\(\))|(?<dont>don't\(\))|mul\((?<lhs>\d{1,3})\,(?<rhs>\d{1,3})\)")
            .unwrap();
    re.captures_iter(str).for_each(|cap| {
        if cap.name("do").is_some() {
            is_do = true;
        } else if cap.name("dont").is_some() {
            is_do = false;
        } else {
            let lhs = cap.name("lhs").unwrap().as_str().parse::<u32>().unwrap();
            let rhs = cap.name("rhs").unwrap().as_str().parse::<u32>().unwrap();
            if is_do {
                sum += lhs * rhs;
            }
        }
    });
    println!("sum: {}", sum);
    return sum;
}

#[test]
fn test_part_two() {
    let res = part_two("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))");
    assert_eq!(res, 48);
}

// #[ignore = "only for prod"]
#[test]
fn assert_part_two() {
    let res = part_two("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))");
    assert_eq!(res, 48);
    let input: String =
        fs::read_to_string("/Users/pw/Documents/Code/adventofcode/2024/inputs/day03.txt").unwrap();
    let prod_res = part_two(&input);
    assert!(prod_res < 115584669);
    assert!(prod_res > 87336064);
}

#[test]
fn test_split() {
    let res = split("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))");
    assert_eq!(res, vec!["xmul(2,4)&mul[3,7]!^don't()", "?mul(8,5))"]);
    assert_eq!(
        split("xmul(2,4)&mul[3,7]!^_muul(5,5)+muul(32,64](muul(11,8)undo()?mul(8,5))"),
        vec![
            "xmul(2,4)&mul[3,7]!^_muul(5,5)+muul(32,64](muul(11,8)un",
            "?mul(8,5))"
        ]
    );
    assert_eq!(split("mul(2,4)do()mul(4,8)"), vec!["mul(2,4)", "mul(4,8)"]);
    assert_eq!(split("mul(2,4)don't()mul(4,8)"), vec!["mul(2,4)don't()"]);
    assert_eq!(
        split("mul(2,4)do()don't()mul(4,8)"),
        vec!["mul(2,4)", "don't()"]
    );
}

fn main() {
    let input: String = fs::read_to_string("inputs/day03.txt").unwrap();
    println!("Part 1: {}", extract_instructions(&input));
    // 115584669 too high
    println!("Part 2: {}", part_two(&input));
}
