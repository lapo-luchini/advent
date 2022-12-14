// this is my first Rust program ever
use std::{io, io::prelude::*};
fn main() {
    let mut num: i32 = 0;
    for line in io::stdin().lock().lines() {
        let a: Vec<i32> = line.unwrap()
            .split(|c| c == '-' || c == ',')
            .flat_map(|x| x.parse()).collect();
        if (a[0] <= a[2] && a[1] >= a[3]) ||
           (a[0] >= a[2] && a[1] <= a[3]) {
            num = num + 1;
        }
        println!("{}-{},{}-{}={}", a[0], a[1], a[2], a[3], num);
    }
}
