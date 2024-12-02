use std::fs;

fn parse_reports(input: &str) -> Vec<Vec<u32>> {
    input
        .lines()
        .map(|line| {
            line.split_whitespace()
                .map(|x| x.parse::<u32>().unwrap())
                .collect()
        })
        .collect()
}

fn is_safe(report: Vec<u32>) -> bool {
    const MAX_GAP: u32 = 3;
    let mut prev: u32 = report.first().unwrap().clone();
    let mut is_increasing = 0;
    let mut is_decreasing = 0;
    for i in 1..report.len() {
        let curr = report[i].clone();
        let diff: u32 = curr.abs_diff(prev);
        // if a gap is too hughe or a letter exists twice
        if diff > MAX_GAP || diff == 0 {
            return false;
        }

        if curr > prev {
            is_increasing += 1;
        } else {
            is_decreasing += 1;
        }

        if is_increasing > 0 && is_decreasing > 0 {
            return false;
        }

        prev = curr;
    }

    return true;
}

fn is_safe_two(report: Vec<u32>) -> bool {
    let safe = is_safe(report.clone());
    if safe {
        return true;
    }

    // brute force
    for i in 0..report.len() {
        let mut new_report = report.clone();
        new_report.remove(i);
        if is_safe(new_report) {
            return true;
        }
    }

    // let diffs = get_diffs(report);
    // let gap_problems = diffs
    //     .iter()
    //     .enumerate()
    //     .filter(|&(_index, x)| x.abs() > MAX_GAP || *x == 0);
    // if gap_problems.count() > 1 {
    //     return false;
    // }
    // let signums = diffs.iter().map(|x| x.signum()).collect::<Vec<i32>>();

    return false;
}

fn safe_reports(reports: Vec<Vec<u32>>) -> usize {
    reports.iter().filter(|&x| is_safe(x.clone())).count()
}

fn main() {
    println!("Day 02");
    let message: String = fs::read_to_string("inputs/day02.txt").unwrap();
    let reports = parse_reports(&message);
    let safe_reports = safe_reports(reports.clone());

    println!("Part 1: {}", safe_reports);
    println!(
        "Part 2: {}",
        reports
            .clone()
            .iter()
            .filter(|&x| is_safe_two(x.clone()))
            .count()
    );
    // 443 is too low
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9";

    #[test]
    fn test_parse_reports() {
        let reports = parse_reports(TEST_INPUT);
        assert_eq!(
            reports,
            vec![
                vec![7, 6, 4, 2, 1],
                vec![1, 2, 7, 8, 9],
                vec![9, 7, 6, 2, 1],
                vec![1, 3, 2, 4, 5],
                vec![8, 6, 4, 4, 1],
                vec![1, 3, 6, 7, 9]
            ]
        );
    }

    #[test]
    fn test_is_safe() {
        assert!(is_safe(vec![7, 6, 4, 2, 1]));
        assert!(!is_safe(vec![1, 2, 7, 8, 9]));
        assert!(!is_safe(vec![9, 7, 6, 2, 1]));
        assert!(!is_safe(vec![1, 3, 2, 4, 5]));
        assert!(!is_safe(vec![8, 6, 4, 4, 1]));
        assert!(is_safe(vec![1, 3, 6, 7, 9]));
    }

    #[test]
    fn test_is_safe_two() {
        assert!(is_safe_two(vec![7, 6, 4, 2, 1]));
        assert!(!is_safe_two(vec![1, 2, 7, 8, 9]));
        assert!(!is_safe_two(vec![9, 7, 6, 2, 1]));
        assert!(is_safe_two(vec![1, 3, 2, 4, 5]));
        assert!(is_safe_two(vec![8, 6, 4, 4, 1]));
        assert!(is_safe_two(vec![1, 3, 6, 7, 9]));
    }

    fn get_diffs(report: Vec<u32>) -> Vec<i32> {
        let mut prev: i32 = report.first().unwrap().clone() as i32;
        let mut diffs: Vec<i32> = vec![];
        for i in 1..report.len() {
            let curr = report[i].clone() as i32;
            diffs.push(curr - prev);
            prev = curr;
        }
        diffs
    }

    #[test]
    fn test_get_diffs() {
        assert_eq!(get_diffs(vec![7, 6, 4, 2, 1]), vec![-1, -2, -2, -1]);
    }
}
