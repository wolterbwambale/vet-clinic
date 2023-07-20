/*Queries that provide answers to the questions from all projects.*/

/*Find all animals whose name ends in "mon".*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*List the name of all animals born between 2016 and 2019.*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals WHERE (neutered = true AND escape_attempts < 3);

/*List the date of birth of all animals named either "Agumon" or "Pikachu"*/
SELECT date_of_birth FROM animals WHERE (name = 'Agumon' OR name = 'Pikachu');

/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Find all animals that are neutered.*/
SELECT * FROM animals WHERE neutered = true;

/*Find all animals not named Gabumon.*/
SELECT * FROM animals WHERE name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg 
(including the animals with the weights that equals precisely
 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made.*/
BEGIN;
UPDATE animals SET species = 'unspecified';

ROLLBACK;

/*Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.*/
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
COMMIT;

/*Update the animals table by setting the species column to pokemon for all animals that don't have species already set.*/
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

/*Verify that changes were made.*/
SELECT * FROM animals;

/*Commit the transaction*/
COMMIT;

/*Verify that changes persist after commit.*/
SELECT * FROM animals;

/*Delete animals */
BEGIN;
DELETE FROM animals;
ROLLBACK;

/*Delete all animals born after Jan 1st, 2022.*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT SP;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;


UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/*How many animals are there?*/
SELECT COUNT(*) AS total_animals FROM animals;

/*How many animals have never tried to escape?*/
SELECT COUNT(*) AS never_tried_to_escape FROM animals WHERE escape_attempts = 0;

/*the average weight of animals?*/
SELECT AVG(weight_kg) AS average_weight FROM animals;

/*Who escapes the most, neutered or not neutered animals */
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts FROM animals GROUP BY neutered;

/*the minimum and maximum weight of each type of animal*/
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

/*the average number of escape attempts per animal type of those born between 1990 and 2000*/
SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

--If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

/*All other animals are Pokemon*/
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

/*animals belong to Melody Pond*/
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

/*List of all animals that are Pokemon*/
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal*/
SELECT full_name as owner, animals.name as animal
FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id;

/*How many animals are there per species?*/
SELECT species.name, COUNT(*)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

/*List all Digimon owned by Jennifer Orwell*/
SELECT * 
FROM animals
JOIN owners ON owner_id = owners.id
JOIN species ON species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape*/

SELECT *FROM animals
JOIN owners ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/*Who owns the most animals?*/
SELECT full_name, COUNT(animals.name) as total FROM owners
JOIN animals ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY total DESC LIMIT 1;

/*-- Who was the last animal seen by William Tatcher?*/
SELECT animals.name, visits.date_of_visits
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visits DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see?*/
SELECT COUNT(animals.name) FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

/*List all vets and their specialties, including vets with no specialties.*/
SELECT vets.name, species.name
FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT animals.name FROM animals JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

/*What animal has the most visits to vets?*/
SELECT animals.name FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

/*Who was Maisy Smith's first visit?*/
SELECT animals.name FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_birth ASC
LIMIT 1;

/*Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT animals.*, vets.*,visits date_of_visits
FROM visits JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id ORDER BY visits.date_of_visits DESC
LIMIT 1;

/*How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(*) FROM visits JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
LEFT JOIN specializations ON vets.id = specializations.vet_id
AND animals.species_id = specializations.species_id
WHERE specializations.vet_id IS NULL;

/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT species.name, COUNT(visits.animal_id) FROM visits
JOIN vets ON visits.vet_id = vets.id FULL JOIN animals ON visits.animal_id = animals.id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name ORDER BY COUNT(visits.animal_id)  DESC
LIMIT 1;





