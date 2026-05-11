use mongodb::{bson::doc, Client};

#[tokio::main]
async fn main() -> mongodb::error::Result<()> {
    let client = Client::with_uri_str("mongodb://localhost:27017").await?;
    let result = client
        .database("admin")
        .run_command(doc! { "ping": 1 })
        .await?;
    println!("{:?}", result);
    Ok(())
}
