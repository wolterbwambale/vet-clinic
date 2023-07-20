/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  (1, 'Agumon', '2020-02-03', 0, true, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, true, 8),
  (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
  (4, 'Devimon', '2017-05-12', 5, true, 11);


INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES(5, 'Charmander', '2020-02-08', 0, false, -11, 'Fire Lizard'),
       (6, 'Plantmon', '2021-11-15', 2, true, -5.7, 'Plant Creature'),
       (7, 'Squirtle', '1993-04-02', 3, false, -12.13, 'Water Turtle'),
       (8, 'Angemon', '2005-06-12', 1, true, -45, 'Holy Angel'),
       (9, 'Boarmon', '2005-06-07', 7, true, 20.4, 'Boar'),
       (10, 'Blossom', '1998-10-13', 3, true, 17, 'Flower Fairy'),
       (11, 'Ditto', '2022-05-14', 4, true, 22, 'Transforming Blob');

INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Find the vet_id for each vet based on their name and species_id based on their name
INSERT INTO specializations (vet_id, species_id)
VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));



-- Agumon visited William Tatcher on May 24th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), 
(SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24');

-- Agumon visited Stephanie Mendez on Jul 22th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22');

-- Gabumon visited Jack Harkness on Feb 2nd, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02');

-- Pikachu visited Maisy Smith on Jan 5th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05');

-- Pikachu visited Maisy Smith on Mar 8th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08');

-- Pikachu visited Maisy Smith on May 14th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14')
ON CONFLICT DO NOTHING;

-- Devimon visited Stephanie Mendez on May 4th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04');

-- Charmander visited Jack Harkness on Feb 24th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24');

-- Plantmon visited Maisy Smith on Dec 21st, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21');

-- Plantmon visited William Tatcher on Aug 10th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10');

-- Plantmon visited Maisy Smith on Apr 7th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07')
ON CONFLICT DO NOTHING;

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29');

-- Angemon visited Jack Harkness on Oct 3rd, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03');

-- Angemon visited Jack Harkness on Nov 4th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04');

-- Boarmon visited Maisy Smith on Jan 24th, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24');

-- Boarmon visited Maisy Smith on May 15th, 2019
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15')
ON CONFLICT DO NOTHING;

-- Boarmon visited Maisy Smith on Feb 27th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27')
ON CONFLICT DO NOTHING;

-- Boarmon visited Maisy Smith on Aug 3rd, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03')
ON CONFLICT DO NOTHING;

-- Blossom visited Stephanie Mendez on May 24th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24');

-- Blossom visited William Tatcher on Jan 11th, 2021
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');
