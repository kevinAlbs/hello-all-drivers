fn main() {
    let lock = std::fs::read_to_string("Cargo.lock").expect("Cargo.lock not found");
    let version = extract_version(&lock, "mongodb").unwrap_or("unknown");
    println!("cargo:rustc-env=MONGODB_CRATE_VERSION={}", version);
}

fn extract_version<'a>(lock: &'a str, package: &str) -> Option<&'a str> {
    let needle = format!("name = \"{}\"", package);
    let mut in_pkg = false;
    for line in lock.lines() {
        let line = line.trim();
        if line == "[[package]]" {
            in_pkg = false;
        } else if line == needle {
            in_pkg = true;
        } else if in_pkg && line.starts_with("version = \"") {
            return line.split('"').nth(1);
        }
    }
    None
}
