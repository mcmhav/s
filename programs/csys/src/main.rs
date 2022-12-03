use crate::install::Install;
use crate::update::Update;
use clap::Parser;

mod install;
mod update;

#[derive(Parser, Debug)]
enum Subcommands {
    /// Install package
    Install(Install),
    /// Update packages
    Update(Update),
}

/// Search for a pattern in a file and display the lines that contain it.
#[derive(Parser)]
struct Cli {
    /// Enable verbose logging.
    #[arg(short, long, group = "verbosity")]
    pub verbose: bool,

    #[command(subcommand)]
    subcommands: Subcommands,
}

impl Subcommands {
    pub fn exec(&self) {
        match self {
            Subcommands::Install(executor) => executor.exec(),
            Subcommands::Update(executor) => executor.exec(),
        }
    }
}

fn main() {
    let args = Cli::parse();

    args.subcommands.exec()
}
