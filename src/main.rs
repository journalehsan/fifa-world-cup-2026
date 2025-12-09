use actix_web::{App, HttpServer, web};
use actix_files::Files;
use std::env;

mod routes;
mod templates;

use routes::home;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Load environment variables
    dotenv::dotenv().ok();
    
    // Initialize logger
    env_logger::init();

    let host = env::var("HOST").unwrap_or_else(|_| "127.0.0.1".to_string());
    let port = env::var("PORT").unwrap_or_else(|_| "8080".to_string());
    let server_addr = format!("{}:{}", host, port);

    println!("🚀 Starting World Cup Hub server at http://{}", server_addr);

    HttpServer::new(move || {
        App::new()
            // Home route - server-side rendered HTML
            .route("/", web::get().to(home::index))
            // Static files (CSS, JS, images)
            .service(Files::new("/assets", "./public/assets").show_files_listing())
            // API routes (optional)
            .route("/api/home", web::get().to(home::api_index))
    })
    .bind(&server_addr)?
    .run()
    .await
}