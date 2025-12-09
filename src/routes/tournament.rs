use actix_web::{HttpResponse, Result};
use askama::Template;
use crate::models::{Tournament, Group, RoundSchedule};

#[derive(Template)]
#[template(path = "tournament.html")]
struct TournamentTemplate<'a> {
    title: String,
    description: String,
    tournament: &'a Tournament,
    groups: &'a [Group],
    rounds: &'a [RoundSchedule],
}

#[derive(Template)]
#[template(path = "worldcup-2026-info.html")]
struct WorldCupInfoTemplate {
    title: String,
    description: String,
}

pub async fn tournament_page() -> Result<HttpResponse> {
    let tournament = Tournament::sample();
    let groups = Group::sample_groups();
    let rounds = RoundSchedule::sample_rounds();
    
    let template = TournamentTemplate {
        title: format!("{} – Tournament Overview", tournament.name),
        description: format!("{} – hosted by {} from {} to {}.", tournament.name, tournament.hosts.join(", "), tournament.start_date.format("%B %e, %Y"), tournament.end_date.format("%B %e, %Y")),
        tournament: &tournament,
        groups: &groups,
        rounds: &rounds,
    };
    
    let rendered = template.render().map_err(|e| {
        actix_web::error::ErrorInternalServerError(format!("Template error: {}", e))
    })?;
    
    Ok(HttpResponse::Ok().content_type("text/html").body(rendered))
}

pub async fn worldcup_info_page() -> Result<HttpResponse> {
    let template = WorldCupInfoTemplate {
        title: "2026 World Cup – Format, Venues & More".to_string(),
        description: "A deeper look at how the expanded 48-team World Cup works, where matches will be played, and the branding, mascots, tickets and controversies around the tournament.".to_string(),
    };
    
    let rendered = template.render().map_err(|e| {
        actix_web::error::ErrorInternalServerError(format!("Template error: {}", e))
    })?;
    
    Ok(HttpResponse::Ok().content_type("text/html").body(rendered))
}