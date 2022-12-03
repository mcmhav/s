use std::process::Command;

use clap::Parser;

#[derive(Parser, Debug)]
pub struct Install {
    pub package: String,
}

impl Install {
    pub fn exec(&self) {
        println!("{} install pacakge", 389247);

        let output = Command::new("sh")
            .arg("-c")
            .arg("echo hello")
            .output()
            .expect("failed to execute process");

        if output.status.success() {
            let raw_output = String::from_utf8(output.stdout);
            println!("{}, cmd output", raw_output);
        }
    }
}
