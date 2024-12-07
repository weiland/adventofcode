use chrono::*;
use std::env;
use std::fs;

// mod day03;

trait Day {
    fn part_one() -> u32;
    fn part_two() -> u32;
}

const INPUT_DIR: &str = "./inputs";

fn get_day() -> String {
    // use CLI arg if provided
    if let Some(day) = env::args().nth(1) {
        return format!("{:0>2}", day);
    }

    // next, try to ready the ENV
    if let Some(day) = env::var("DAY").ok() {
        return format!("{:0>2}", day);
    }

    // otheriwse use the current day
    let now: DateTime<Utc> = Utc::now();
    now.format("%d").to_string()
}

// TODO
fn download() {
    // let value = dotenv::var("COOKIE").unwrap();
}

fn main() {
    let day = get_day();
    println!("Day {}", day);
    let input: String = fs::read_to_string(format!("{}/day{}.txt", INPUT_DIR, day)).unwrap();
    // println!("Part 1: {}", part_one(&input));
    // println!("Part 2: {}", part_two(&input));
}
