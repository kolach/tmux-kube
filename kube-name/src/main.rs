#[macro_use]
extern crate clap;
extern crate serde;
#[macro_use]
extern crate serde_derive;
extern crate serde_yaml;

use clap::{App, Arg};
use std::fs::OpenOptions;
use std::io::BufReader;

#[derive(Debug, Deserialize)]
struct KubeConfig {
    #[serde(rename = "current-context")]
    current_context: String,
}

fn main() {
    let m = App::new("kube-name")
        .version(crate_version!())
        .author("Nick Chistyakov <chikolad@gmail.com>")
        .about("Gets current k8s cluster name")
        .arg(
            Arg::with_name("config")
                .short("c")
                .long("config")
                .value_name("FILE")
                .help("Path to k8s config file")
                .takes_value(true),
        )
        .get_matches();

    let config = m.value_of("config").unwrap_or("$HOME/.kube/config");
    println!("Value for config: {}", config);

    let file = OpenOptions::new()
        .read(true)
        .open(config)
        .expect("failed to open config file");

    let reader = BufReader::new(&file);

    let konfig: KubeConfig = serde_yaml::from_reader(reader).unwrap();

    println!("Current context is: {}", konfig.current_context);
}
