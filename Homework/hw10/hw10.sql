CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT parents.child FROM parents, dogs
  WHERE parents.parent = dogs.name 
  ORDER BY dogs.height DESC;
 
-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name, sizes.size FROM dogs, sizes
  WHERE dogs.height > sizes.min and dogs.height <= sizes.max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT p1.child as first, p2.child as second
  FROM parents as p1, parents as p2
  WHERE p1.parent = p2.parent AND p1.child < p2.child;


-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || s1.first || " plus " || s1.second || " have the same size: " || d1.size
  FROM size_of_dogs as d1, size_of_dogs as d2, siblings as s1
  WHERE d1.name = s1.first AND d2.name = s1.second AND d1.size = d2.size;
  

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, max(height) - min(height) 
  FROM dogs 
  GROUP BY fur 
  HAVING max(height) < 1.3 * avg(height) AND min(height) > 0.7 * avg(height);

