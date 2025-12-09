-- World Cup Hub Database Initialization
-- This file is automatically executed when the PostgreSQL container starts

-- Create extensions if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Create sample tables (you can expand these as needed)
-- This is just a basic structure to get started

-- Teams table
CREATE TABLE IF NOT EXISTS teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    country_code VARCHAR(3) NOT NULL,
    flag_url VARCHAR(255),
    group_stage VARCHAR(20),
    world_cup_wins INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Players table
CREATE TABLE IF NOT EXISTS players (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    team_id UUID REFERENCES teams(id),
    position VARCHAR(50),
    jersey_number INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Matches table
CREATE TABLE IF NOT EXISTS matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    home_team_id UUID REFERENCES teams(id),
    away_team_id UUID REFERENCES teams(id),
    venue VARCHAR(100),
    match_date TIMESTAMP WITH TIME ZONE,
    stage VARCHAR(50), -- Group Stage, Round of 16, etc.
    home_score INTEGER,
    away_score INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Venues table
CREATE TABLE IF NOT EXISTS venues (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    capacity INTEGER,
    stadium_image_url VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert some sample data for testing
INSERT INTO teams (name, country_code, flag_url, group_stage, world_cup_wins) VALUES
('Brazil', 'BRA', 'https://flagcdn.com/w160/br.png', 'Group TBD', 5),
('Argentina', 'ARG', 'https://flagcdn.com/w160/ar.png', 'Group TBD', 3),
('France', 'FRA', 'https://flagcdn.com/w160/fr.png', 'Group TBD', 2),
('Germany', 'DEU', 'https://flagcdn.com/w160/de.png', 'Group TBD', 4),
('Spain', 'ESP', 'https://flagcdn.com/w160/es.png', 'Group TBD', 1),
('England', 'ENG', 'https://flagcdn.com/w160/gb-eng.png', 'Group TBD', 1),
('Portugal', 'PRT', 'https://flagcdn.com/w160/pt.png', 'Group TBD', 0),
('USA', 'USA', 'https://flagcdn.com/w160/us.png', 'Host Nation', 0),
('Mexico', 'MEX', 'https://flagcdn.com/w160/mx.png', 'Host Nation', 0),
('Canada', 'CAN', 'https://flagcdn.com/w160/ca.png', 'Host Nation', 0)
ON CONFLICT DO NOTHING;

INSERT INTO venues (name, city, country, capacity, stadium_image_url) VALUES
('MetLife Stadium', 'East Rutherford', 'USA', 82500, 'https://images.unsplash.com/photo-1577223625816-7546f13df25d?w=400'),
('AT&T Stadium', 'Arlington', 'USA', 80000, 'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=400'),
('Estadio Azteca', 'Mexico City', 'Mexico', 87000, 'https://images.unsplash.com/photo-1459865264687-595d652de67e?w=400'),
('BMO Field', 'Toronto', 'Canada', 45000, 'https://images.unsplash.com/photo-1522778119026-d647f0596c20?w=400')
ON CONFLICT DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_teams_name ON teams(name);
CREATE INDEX IF NOT EXISTS idx_players_name ON players(name);
CREATE INDEX IF NOT EXISTS idx_players_team_id ON players(team_id);
CREATE INDEX IF NOT EXISTS idx_matches_date ON matches(match_date);
CREATE INDEX IF NOT EXISTS idx_matches_teams ON matches(home_team_id, away_team_id);
CREATE INDEX IF NOT EXISTS idx_venues_city ON venues(city);

-- Create updated_at trigger function (optional, for automatic timestamp updates)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_teams_updated_at BEFORE UPDATE ON teams
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_players_updated_at BEFORE UPDATE ON players
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_matches_updated_at BEFORE UPDATE ON matches
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_venues_updated_at BEFORE UPDATE ON venues
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

COMMENT ON TABLE teams IS 'Teams participating in World Cup 2026';
COMMENT ON TABLE players IS 'Player information and statistics';
COMMENT ON TABLE matches IS 'Match schedule and results';
COMMENT ON TABLE venues IS 'Stadium and venue information';