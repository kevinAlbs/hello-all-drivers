use mongodb::{bson::doc, Client};

const DRIVER_VERSION: &str = env!("MONGODB_CRATE_VERSION");

#[tokio::main]
async fn main() -> mongodb::error::Result<()> {
    println!("Ping from mongodb {} ...", DRIVER_VERSION);

    let client = Client::with_uri_str("mongodb://localhost:27017").await?;
    client
        .database("admin")
        .run_command(doc! { "ping": 1 })
        .await?;

    println!("Ping from mongodb {} ... OK", DRIVER_VERSION);
    Ok(())
}
