-- from the terminal run:
-- psql < soccer_league.sql

DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;


\c soccer_league


-- Create Teams Table
CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) UNIQUE NOT NULL
);

-- Create Players Table
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    team_id INTEGER REFERENCES Teams(team_id)
);

-- Create Referees Table
CREATE TABLE Referees (
    referee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Create Seasons Table
CREATE TABLE Seasons (
    season_id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Create Matches Table
CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    season_id INTEGER REFERENCES Seasons(season_id),
    team1_id INTEGER REFERENCES Teams(team_id),
    team2_id INTEGER REFERENCES Teams(team_id),
    match_date DATE NOT NULL
);

-- Create MatchReferees Table (Junction Table)
CREATE TABLE MatchReferees (
    match_id INTEGER REFERENCES Matches(match_id),
    referee_id INTEGER REFERENCES Referees(referee_id),
    PRIMARY KEY (match_id, referee_id)
);

-- Create Goals Table
CREATE TABLE Goals (
    goal_id SERIAL PRIMARY KEY,
    match_id INTEGER REFERENCES Matches(match_id),
    player_id INTEGER REFERENCES Players(player_id),
    team_id INTEGER REFERENCES Teams(team_id),
    goal_time TIME NOT NULL
);

-- Create Standings Table
CREATE TABLE Standings (
    standing_id SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES Teams(team_id),
    season_id INTEGER REFERENCES Seasons(season_id),
    matches_played INTEGER DEFAULT 0,
    matches_won INTEGER DEFAULT 0,
    matches_lost INTEGER DEFAULT 0,
    matches_drawn INTEGER DEFAULT 0,
    points INTEGER DEFAULT 0
);


-- Insert Sample Data into Teams
INSERT INTO Teams (team_name) VALUES ('Team A');
INSERT INTO Teams (team_name) VALUES ('Team B');

-- Insert Sample Data into Players
INSERT INTO Players (first_name, last_name, team_id) VALUES ('John', 'Doe', 1);
INSERT INTO Players (first_name, last_name, team_id) VALUES ('Jane', 'Smith', 2);

-- Insert Sample Data into Referees
INSERT INTO Referees (first_name, last_name) VALUES ('Referee', 'One');
INSERT INTO Referees (first_name, last_name) VALUES ('Referee', 'Two');

-- Insert Sample Data into Seasons
INSERT INTO Seasons (start_date, end_date) VALUES ('2024-01-01', '2024-12-31');

-- Insert Sample Data into Matches
INSERT INTO Matches (season_id, team1_id, team2_id, match_date) VALUES (1, 1, 2, '2024-06-15');

-- Insert Sample Data into MatchReferees
INSERT INTO MatchReferees (match_id, referee_id) VALUES (1, 1);
INSERT INTO MatchReferees (match_id, referee_id) VALUES (1, 2);

-- Insert Sample Data into Goals
INSERT INTO Goals (match_id, player_id, team_id, goal_time) VALUES (1, 1, 1, '00:15:00');
INSERT INTO Goals (match_id, player_id, team_id, goal_time) VALUES (1, 2, 2, '00:30:00');

-- Insert Sample Data into Standings
INSERT INTO Standings (team_id, season_id, matches_played, matches_won, matches_lost, matches_drawn, points) VALUES (1, 1, 1, 0, 0, 1, 1);
INSERT INTO Standings (team_id, season_id, matches_played, matches_won, matches_lost, matches_drawn, points) VALUES (2, 1, 1, 0, 0, 1, 1);
