-- from the terminal run:
-- psql < craigslist.sql

DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;


\c craigslist


-- Create Regions Table
CREATE TABLE Regions (
    region_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Create Users Table
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    preferred_region_id INTEGER REFERENCES Regions(region_id)
);

-- Create Categories Table
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Create Posts Table
CREATE TABLE Posts (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    text TEXT NOT NULL,
    user_id INTEGER REFERENCES Users(user_id),
    location VARCHAR(100) NOT NULL,
    region_id INTEGER REFERENCES Regions(region_id)
);

-- Create PostCategories Table (Junction Table)
CREATE TABLE PostCategories (
    post_id INTEGER REFERENCES Posts(post_id),
    category_id INTEGER REFERENCES Categories(category_id),
    PRIMARY KEY (post_id, category_id)
);


-- Insert Sample Data into Regions
INSERT INTO Regions (name) VALUES ('San Francisco');
INSERT INTO Regions (name) VALUES ('Atlanta');
INSERT INTO Regions (name) VALUES ('Seattle');

-- Insert Sample Data into Users
INSERT INTO Users (username, email, preferred_region_id) VALUES ('john_doe', 'john@example.com', 1);
INSERT INTO Users (username, email, preferred_region_id) VALUES ('jane_smith', 'jane@example.com', 2);

-- Insert Sample Data into Categories
INSERT INTO Categories (name) VALUES ('Housing');
INSERT INTO Categories (name) VALUES ('Jobs');
INSERT INTO Categories (name) VALUES ('For Sale');

-- Insert Sample Data into Posts
INSERT INTO Posts (title, text, user_id, location, region_id) VALUES ('Apartment for Rent', 'Great apartment in the heart of the city.', 1, 'Downtown', 1);
INSERT INTO Posts (title, text, user_id, location, region_id) VALUES ('Job Opening: Software Developer', 'Looking for a skilled developer.', 2, 'Midtown', 2);

-- Insert Sample Data into PostCategories
INSERT INTO PostCategories (post_id, category_id) VALUES (1, 1);  -- Apartment for Rent -> Housing
INSERT INTO PostCategories (post_id, category_id) VALUES (2, 2);  -- Job Opening: Software Developer -> Jobs
