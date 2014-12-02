DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS path;
DROP TABLE IF EXISTS point_location;
DROP TABLE IF EXISTS floor_location;
DROP TABLE IF EXISTS point;
DROP TABLE IF EXISTS floor;
DROP TABLE IF EXISTS building;
DROP TABLE IF EXISTS administrator;

-- --------------------------------------------------------

--
-- Table structure for table administrator
--

CREATE TABLE `administrator` (
  `id` varchar(80) NOT NULL COMMENT 'Administrator''s name',
  `password` varchar(80) NOT NULL COMMENT 'Admin''s password',
  PRIMARY KEY (`id`)
) COMMENT='Table of administators.';

--
-- Dumping data for table administrator
--

INSERT INTO `administrator` (`id`, `password`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Table structure for table building
--

CREATE TABLE `building` (
  `id` varchar(80) NOT NULL COMMENT 'Unique name of building like ''F1'', ''F2'', ''P'', ''M'', ''I'', etc.',
  PRIMARY KEY (`id`)
) COMMENT='Table of all buildings.';

--
-- Dumping data for table building
--

INSERT INTO `building` (`id`) VALUES
('F1'),
('F2'),
('I'),
('M'),
('P');

-- --------------------------------------------------------

--
-- Table structure for table floor
--

CREATE TABLE `floor` (
  `id` varchar(80) NOT NULL COMMENT 'Unique name of floor among all floors of all buildings like ''F1_0'', ''F1_1'', ''F1_2'', ''I_-1'', ''I_0'', etc.',
  `level` int(11) NOT NULL COMMENT 'Vertical position of floor in building.',
  PRIMARY KEY (`id`)
) COMMENT='All floors of all buildings included in map.';

--
-- Dumping data for table floor
--

INSERT INTO `floor` (`id`, `level`) VALUES
('F1_0', 0),
('F1_1', 1),
('F1_2', 2),
('F1_3', 3),
('I_-1', -1),
('I_0', 0),
('P_0', 0);

-- --------------------------------------------------------

--
-- Table structure for table floor_location
--

CREATE TABLE `floor_location` (
  `building_id` varchar(80) NOT NULL COMMENT 'ID of building, in which is located the floor.',
  `floor_id` varchar(80) NOT NULL COMMENT 'ID of floor located in the building.',
  FOREIGN KEY (`building_id`)
	REFERENCES `building` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  FOREIGN KEY (`floor_id`)
	REFERENCES `floor` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) COMMENT='Which floors are located in which building.';

--
-- Dumping data for table floor_location
--

INSERT INTO `floor_location` (`building_id`, `floor_id`) VALUES
('F1', 'F1_0'),
('F1', 'F1_1'),
('F1', 'F1_2'),
('F1', 'F1_3'),
('I', 'I_-1'),
('I', 'I_0'),
('P', 'P_0');

-- --------------------------------------------------------
--
-- Table structure for table point
--

CREATE TABLE `point` (
  `id` varchar(80) NOT NULL COMMENT 'Unique name of point among all points of all floors of all buildings. Must be exactly the same as room''s ID, if point represents a room.',
  `x` int(11) NOT NULL COMMENT 'X-coordinate of point at map graphics.',
  `y` int(11) NOT NULL COMMENT 'Y-coordinate of point at map graphics.',
  PRIMARY KEY (`id`)
) COMMENT='These path points are used to draw path from one room to another.';

--
-- Dumping data for table point
--

INSERT INTO `point` (`id`, `x`, `y`) VALUES
('A', 0, 0),
('B', 0, 0);


-- --------------------------------------------------------

--
-- Table structure for table path
--

CREATE TABLE `path` (
  `from_point_id` varchar(80) NOT NULL COMMENT 'ID of point connected to the point with ID "to_point_id".',
  `to_point_id` varchar(80) NOT NULL COMMENT 'ID of point connected from point with ID "from_point_id".',
  FOREIGN KEY (`from_point_id`)
	REFERENCES `point` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  FOREIGN KEY (`to_point_id`)
	REFERENCES `point` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) COMMENT='Table of connection from one path point to another.';

-- --------------------------------------------------------

--
-- Table structure for table point_location
--

CREATE TABLE `point_location` (
  `floor_id` varchar(80) NOT NULL COMMENT 'ID of floor, at which is located the point.',
  `point_id` varchar(80) NOT NULL COMMENT 'ID of point located at the floor.',
  FOREIGN KEY (`floor_id`)
	REFERENCES `floor` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
  FOREIGN KEY (`point_id`)
	REFERENCES `point` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) COMMENT='Which points are located at which floors';

--
-- Dumping data for table point_location
--

INSERT INTO `point_location` (`floor_id`, `point_id`) VALUES
('P_0', 'A'),
('P_0', 'B');

-- --------------------------------------------------------

--
-- Table structure for table room
--

CREATE TABLE `room` (
  `id` varchar(80) NOT NULL COMMENT 'Unique name of room matching one of points.',
  `shape_coords` varchar(80) NOT NULL COMMENT 'Coordinates needed to display room over map graphics.',
  `embedded_data` varchar(4000) NOT NULL COMMENT 'Information about room in HTLM format that will be seen by users.',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id`)
	REFERENCES `point` (`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) COMMENT='Table of rooms that will be interactive.';

--
-- Dumping data for table room
--

INSERT INTO `room` (`id`, `shape_coords`, `embedded_data`) VALUES
('A', '0,0,0,0,0,0,0,0', '<strong>Poslucháreň A</strong>'),
('B', '1,1,1,1,1,1,1,1,1,11,1,1', '<strong>Poslucháreň B</strong>');
