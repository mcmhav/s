use clap::Parser;

#[derive(Parser, Debug)]
pub struct Update {
    #[arg(short, long)]
    pub package: String,
}

impl Update {
    pub fn exec(&self) {
        println!("{} install pacakge", 389247)
    }
}
