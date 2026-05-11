mod monitor;

use mongodb::{bson::doc, options::ClientOptions, Client};

const DRIVER_VERSION: &str = env!("MONGODB_CRATE_VERSION");

#[tokio::main]
async fn main() -> mongodb::error::Result<()> {
    println!("Ping from mongodb {} ...", DRIVER_VERSION);

    let mut options = ClientOptions::parse("mongodb://localhost:27017").await?;
    options.command_event_handler = monitor::make_handler();
    let client = Client::with_options(options)?;
    client
        .database("admin")
        .run_command(doc! { "ping": 1 })
        .await?;

    println!("Ping from mongodb {} ... OK", DRIVER_VERSION);

    // TODO: add your code here

    Ok(())
}
