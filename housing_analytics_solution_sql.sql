
-- Table for housing details
CREATE TABLE housing (
    housing_id INT PRIMARY KEY,
    location VARCHAR(255),
    total_rent DECIMAL(10, 2),
    individual_rent DECIMAL(10, 2),
    rooms INT,
    roommates INT,
    distance_from_university DECIMAL(5, 2),
    public_transport BOOLEAN
);

-- Table for student preferences from the survey
CREATE TABLE student_preferences (
    student_id INT PRIMARY KEY,
    max_budget DECIMAL(10, 2),
    preferred_location VARCHAR(255),
    preferred_amenities VARCHAR(255),
    preferred_roommates INT
);

-- Table for amenities data (multiple amenities per housing unit)
CREATE TABLE housing_amenities (
    housing_id INT,
    amenity_name VARCHAR(255),
    FOREIGN KEY (housing_id) REFERENCES housing(housing_id)
);

-- Query to Get Housing Options Within Budget
SELECT 
    h.housing_id, 
    h.location, 
    h.total_rent, 
    h.individual_rent, 
    h.rooms, 
    h.roommates, 
    h.distance_from_university, 
    s.max_budget,
    s.preferred_amenities
FROM 
    housing h
JOIN 
    student_preferences s ON s.max_budget >= h.individual_rent
WHERE 
    h.total_rent <= 4000
AND 
    h.location = s.preferred_location
AND 
    h.public_transport = TRUE;

-- Query to Gather Housing Statistics for Students
SELECT 
    location, 
    AVG(total_rent) AS avg_total_rent, 
    AVG(individual_rent) AS avg_individual_rent, 
    AVG(rooms) AS avg_rooms, 
    AVG(distance_from_university) AS avg_distance
FROM 
    housing
GROUP BY 
    location
ORDER BY 
    avg_total_rent;

-- Query to Find Preferred Amenities by Location
SELECT 
    h.location, 
    ha.amenity_name, 
    COUNT(*) AS amenity_count
FROM 
    housing h
JOIN 
    housing_amenities ha ON h.housing_id = ha.housing_id
GROUP BY 
    h.location, ha.amenity_name
ORDER BY 
    amenity_count DESC;

-- Query to Find Housing with a Specific Number of Roommates
SELECT 
    h.housing_id, 
    h.location, 
    h.individual_rent, 
    h.roommates 
FROM 
    housing h
JOIN 
    student_preferences s ON s.preferred_roommates = h.roommates
WHERE 
    h.individual_rent <= s.max_budget;

-- Data Insertion Example
INSERT INTO housing (housing_id, location, total_rent, individual_rent, rooms, roommates, distance_from_university, public_transport)
VALUES 
(1, 'Mission Hill', 3500, 875, 4, 3, 1.2, TRUE),
(2, 'Fenway', 4000, 1000, 3, 2, 0.8, TRUE),
(3, 'Allston', 3000, 750, 5, 4, 1.5, FALSE);

INSERT INTO student_preferences (student_id, max_budget, preferred_location, preferred_amenities, preferred_roommates)
VALUES 
(1, 900, 'Mission Hill', 'gymnasium, pharmacy', 3),
(2, 1000, 'Fenway', 'transport, conveniencestore', 2),
(3, 800, 'Allston', 'pharmacy, gymnasium', 4);

INSERT INTO housing_amenities (housing_id, amenity_name)
VALUES 
(1, 'gymnasium'),
(1, 'pharmacy'),
(2, 'transport'),
(2, 'conveniencestore'),
(3, 'pharmacy'),
(3, 'gymnasium');
