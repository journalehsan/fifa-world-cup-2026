use actix_web::{HttpResponse, Result};
use askama_actix::TemplateToResponse;
use serde_json::json;
use crate::templates::HomeTemplate;

pub async fn index() -> Result<HttpResponse> {
    let template = HomeTemplate {
        title: "World Cup 2026 Hub | News, Teams, Stats, History & More".to_string(),
        description: "Your ultimate destination for FIFA World Cup 2026 - News, Teams, Players, Match Schedules, Venues, History Wiki and more.".to_string(),
    };
    Ok(template.to_response())
}

// Optional API endpoint for future use
pub async fn api_index() -> Result<HttpResponse> {
    Ok(HttpResponse::Ok().json(json!({
        "message": "World Cup 2026 Hub API",
        "version": "1.0.0",
        "endpoints": [
            "/api/home"
        ]
    })))
}