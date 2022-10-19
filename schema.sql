/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    species VARCHAR(250),
    PRIMARY KEY(id)
);

-- Owners table
CREATE TABLE owners (
    owner_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(owner_id)
);



