/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: audits
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `userId` int(11) NOT NULL,
  `refId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `audits_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 70 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: fuel_logs
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `fuel_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleId` int(11) NOT NULL,
  `fuelLevel` float NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `action` enum('add', 'remove') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicleId` (`vehicleId`),
  CONSTRAINT `fuel_logs_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: maintenances
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `maintenances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleId` int(11) NOT NULL,
  `payment` float NOT NULL,
  `startFrom` date NOT NULL,
  `stopAt` date NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `isPaid` tinyint(1) NOT NULL,
  `imgUrl` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicleId` (`vehicleId`),
  CONSTRAINT `maintenances_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: places
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `notes` text,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB AUTO_INCREMENT = 15 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sequelizemeta
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: trip_details
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `trip_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tripId` int(11) DEFAULT NULL,
  `placeId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tripId` (`tripId`),
  KEY `placeId` (`placeId`),
  CONSTRAINT `trip_details_ibfk_1` FOREIGN KEY (`tripId`) REFERENCES `trips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_details_ibfk_2` FOREIGN KEY (`placeId`) REFERENCES `places` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: trips
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `trips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleId` int(11) DEFAULT NULL,
  `driverId` int(11) DEFAULT NULL,
  `startFrom` date NOT NULL,
  `stopAt` date NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `allowances` double DEFAULT NULL,
  `status` enum(
  'pending',
  'ongoing',
  'canceled',
  'finished',
  'expired'
  ) NOT NULL DEFAULT 'pending',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicleId` (`vehicleId`),
  KEY `driverId` (`driverId`),
  CONSTRAINT `trips_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trips_ibfk_2` FOREIGN KEY (`driverId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `gender` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profileImg` varchar(255) DEFAULT NULL,
  `nic` varchar(255) NOT NULL,
  `notes` text,
  `role` enum('admin', 'manager', 'staff', 'driver') NOT NULL,
  `address` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `contactNumber1` varchar(255) DEFAULT NULL,
  `contactNumber2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nic` (`nic`)
) ENGINE = InnoDB AUTO_INCREMENT = 19 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: vehicles
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `make` varchar(255) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `vin` varchar(255) NOT NULL,
  `tankVolume` float DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `fuelLevel` float NOT NULL DEFAULT '0',
  `image` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `fuelType` enum('petrol', 'diesel') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vin` (`vin`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 23 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: audits
# ------------------------------------------------------------

INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    1,
    'User',
    'Create',
    'Created kkkkk l',
    1,
    7,
    '2019-08-14 16:28:06',
    '2019-08-14 16:28:06'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    2,
    'User',
    'Create',
    'Created user rushi rodriguz',
    1,
    8,
    '2019-08-14 17:15:03',
    '2019-08-14 17:15:03'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    'Category',
    'Create',
    'Created category dsrrete',
    1,
    5,
    '2019-09-03 17:06:41',
    '2019-09-03 17:06:41'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    'User',
    'Create',
    'Created user kkkkkkkkkkkkkkkkkkkkkk kljk',
    1,
    9,
    '2019-09-07 04:49:44',
    '2019-09-07 04:49:44'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    'Category',
    'Create',
    'Created category abc',
    1,
    6,
    '2019-09-07 04:54:33',
    '2019-09-07 04:54:33'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    6,
    'Category',
    'Update',
    'Created category ddd',
    1,
    6,
    '2019-09-07 04:55:32',
    '2019-09-07 04:55:32'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    7,
    'Category',
    'Create',
    'Created category ggggggggggg',
    1,
    7,
    '2019-09-07 05:11:44',
    '2019-09-07 05:11:44'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    8,
    'Category',
    'Update',
    'Created category kkkkkkk',
    1,
    7,
    '2019-09-07 05:12:02',
    '2019-09-07 05:12:02'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    9,
    'User',
    'Create',
    'Created user Dhdjdjd Ehskskd',
    1,
    10,
    '2019-09-07 06:03:29',
    '2019-09-07 06:03:29'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    10,
    'User',
    'Create',
    'Created user dulandi illeperuma',
    1,
    11,
    '2019-09-07 14:31:22',
    '2019-09-07 14:31:22'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    11,
    'User',
    'Create',
    'Created user uyy uyu',
    1,
    12,
    '2019-09-07 14:52:50',
    '2019-09-07 14:52:50'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    12,
    'User',
    'Create',
    'Created user hhhhhhhhhhhhhhh iiiiiiiiiiiiiiiiiii',
    1,
    13,
    '2019-09-07 15:05:06',
    '2019-09-07 15:05:06'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    13,
    'Category',
    'Create',
    'Created category 12345',
    1,
    8,
    '2019-09-07 15:51:25',
    '2019-09-07 15:51:25'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    14,
    'Category',
    'Create',
    'Created category 12345555555555555555555555555555555',
    1,
    9,
    '2019-09-07 15:54:42',
    '2019-09-07 15:54:42'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    15,
    'Category',
    'Update',
    'Created category 123455555555555dfwef',
    1,
    9,
    '2019-09-07 15:55:44',
    '2019-09-07 15:55:44'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    16,
    'Place',
    'Create',
    'Created place yhkjttttt',
    1,
    8,
    '2019-09-08 02:50:17',
    '2019-09-08 02:50:17'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    17,
    'Place',
    'Create',
    'Created place 5656',
    1,
    9,
    '2019-09-08 02:50:26',
    '2019-09-08 02:50:26'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    18,
    'Place',
    'Create',
    'Created place 6666',
    1,
    10,
    '2019-09-08 02:50:37',
    '2019-09-08 02:50:37'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    19,
    'User',
    'Create',
    'Created user jagath kumara',
    1,
    14,
    '2019-09-08 03:35:36',
    '2019-09-08 03:35:36'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    20,
    'Vehicle',
    'Add',
    'Added 3 liters',
    1,
    12,
    '2019-09-10 16:07:43',
    '2019-09-10 16:07:43'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    21,
    'Vehicle',
    'Remove',
    'Removed 9 liters',
    1,
    13,
    '2019-09-10 16:08:21',
    '2019-09-10 16:08:21'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    22,
    'Fuel',
    'Add',
    'Added 1 liters',
    1,
    14,
    '2019-09-10 16:23:50',
    '2019-09-10 16:23:50'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    23,
    'Category',
    'Create',
    'Created category good',
    1,
    10,
    '2019-09-15 03:54:00',
    '2019-09-15 03:54:00'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    24,
    'Category',
    'Update',
    'Created category ddded',
    1,
    10,
    '2019-09-15 03:55:07',
    '2019-09-15 03:55:07'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    25,
    'Place',
    'Create',
    'Created place hhh',
    1,
    11,
    '2019-09-16 15:24:35',
    '2019-09-16 15:24:35'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    26,
    'Place',
    'Create',
    'Created place rajigiriya',
    1,
    12,
    '2019-09-16 15:29:56',
    '2019-09-16 15:29:56'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    27,
    'Place',
    'Update',
    'Update place kkk',
    1,
    1,
    '2019-09-16 15:31:47',
    '2019-09-16 15:31:47'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    28,
    'Place',
    'Update',
    'Update place kkkk',
    1,
    11,
    '2019-09-16 15:32:04',
    '2019-09-16 15:32:04'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    29,
    'Vehicle',
    'Create',
    'Created vehicle 98990',
    1,
    19,
    '2019-09-16 16:17:54',
    '2019-09-16 16:17:54'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    30,
    'Vehicle',
    'Update',
    'Updated vehicle 98990',
    1,
    19,
    '2019-09-16 16:18:11',
    '2019-09-16 16:18:11'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    31,
    'User',
    'Create',
    'Created user kenita hashani',
    1,
    15,
    '2019-09-21 04:21:25',
    '2019-09-21 04:21:25'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    32,
    'User',
    'Update',
    'Updated user chamindu aiya',
    1,
    15,
    '2019-09-21 05:34:45',
    '2019-09-21 05:34:45'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    33,
    'user',
    'Update',
    'Updated user to false',
    1,
    14,
    '2019-09-21 05:40:01',
    '2019-09-21 05:40:01'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    34,
    'user',
    'Update',
    'Updated user to false',
    1,
    13,
    '2019-09-21 05:40:03',
    '2019-09-21 05:40:03'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    35,
    'Category',
    'Create',
    'Created category dfcc',
    1,
    11,
    '2019-09-21 06:13:08',
    '2019-09-21 06:13:08'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    36,
    'Category',
    'Update',
    'Created category ccc',
    1,
    11,
    '2019-09-21 06:13:32',
    '2019-09-21 06:13:32'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    37,
    'category',
    'Update',
    'Updated category to true',
    1,
    10,
    '2019-09-21 06:14:16',
    '2019-09-21 06:14:16'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    38,
    'Vehicle',
    'Create',
    'Created vehicle 8888',
    1,
    20,
    '2019-09-21 06:29:35',
    '2019-09-21 06:29:35'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    39,
    'Vehicle',
    'Update',
    'Updated vehicle 8451',
    1,
    20,
    '2019-09-21 06:30:11',
    '2019-09-21 06:30:11'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    40,
    'Place',
    'Create',
    'Created place habara',
    1,
    13,
    '2019-09-21 06:57:38',
    '2019-09-21 06:57:38'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    41,
    'Place',
    'Update',
    'Update place panni',
    1,
    13,
    '2019-09-21 06:58:07',
    '2019-09-21 06:58:07'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    42,
    'user',
    'Update',
    'Updated user 14 to true',
    1,
    14,
    '2019-09-25 16:30:06',
    '2019-09-25 16:30:06'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    43,
    'Trip',
    'Create',
    'Created trip 13',
    1,
    13,
    '2019-09-25 16:37:26',
    '2019-09-25 16:37:26'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    44,
    'User',
    'Create',
    'Created user yasantha kodagoda',
    1,
    16,
    '2019-10-02 12:43:06',
    '2019-10-02 12:43:06'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    45,
    'User',
    'Update',
    'Updated user pathum kalhan',
    1,
    1,
    '2019-10-02 12:50:39',
    '2019-10-02 12:50:39'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    46,
    'user',
    'Update',
    'Updated user 15 to true',
    1,
    15,
    '2019-10-02 12:54:42',
    '2019-10-02 12:54:42'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    47,
    'user',
    'Update',
    'Updated user 13 to true',
    1,
    13,
    '2019-10-02 12:54:44',
    '2019-10-02 12:54:44'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    48,
    'user',
    'Update',
    'Updated user 9 to true',
    1,
    9,
    '2019-10-02 12:54:45',
    '2019-10-02 12:54:45'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    49,
    'Category',
    'Create',
    'Created category weired',
    1,
    12,
    '2019-10-02 13:20:36',
    '2019-10-02 13:20:36'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    50,
    'Category',
    'Update',
    'Created category eewrewr',
    1,
    12,
    '2019-10-02 13:22:53',
    '2019-10-02 13:22:53'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    51,
    'Category',
    'Update',
    'Created category ddddfer',
    1,
    11,
    '2019-10-02 13:23:25',
    '2019-10-02 13:23:25'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    52,
    'Vehicle',
    'Create',
    'Created vehicle 344556',
    1,
    344556,
    '2019-10-02 13:26:01',
    '2019-10-02 13:26:01'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    53,
    'Vehicle',
    'Update',
    'Updated vehicle 344556',
    1,
    344556,
    '2019-10-02 13:28:04',
    '2019-10-02 13:28:04'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    54,
    'Vehicle',
    'Create',
    'Created vehicle 3445569',
    1,
    3445569,
    '2019-10-02 13:31:37',
    '2019-10-02 13:31:37'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    55,
    'Place',
    'Create',
    'Created place fffffffffffffffffffffffffffhhhh9999',
    1,
    14,
    '2019-10-02 13:38:08',
    '2019-10-02 13:38:08'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    56,
    'Place',
    'Update',
    'Update place ghghjgjh',
    1,
    14,
    '2019-10-02 13:39:23',
    '2019-10-02 13:39:23'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    57,
    'Fuel',
    'Remove',
    'Removed 50 liters',
    1,
    15,
    '2019-10-03 01:57:39',
    '2019-10-03 01:57:39'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    58,
    'Fuel',
    'Add',
    'Added 2 liters',
    1,
    16,
    '2019-10-03 02:02:06',
    '2019-10-03 02:02:06'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    59,
    'Fuel',
    'Add',
    'Added 6 liters',
    1,
    17,
    '2019-10-03 02:02:38',
    '2019-10-03 02:02:38'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    60,
    'Maintenance',
    'Create',
    'Add job to 2',
    1,
    2,
    '2019-10-03 14:54:03',
    '2019-10-03 14:54:03'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    61,
    'Trip',
    'Create',
    'Created trip 14',
    1,
    14,
    '2019-10-04 02:54:13',
    '2019-10-04 02:54:13'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    62,
    'trip',
    'Update',
    'Updated trip 14 to ongoing',
    5,
    14,
    '2019-10-04 06:21:29',
    '2019-10-04 06:21:29'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    63,
    'User',
    'Create',
    'Created user chapa arundathi',
    1,
    17,
    '2020-01-05 03:48:00',
    '2020-01-05 03:48:00'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    64,
    'Trip',
    'Create',
    'Created trip 15',
    1,
    15,
    '2020-01-12 07:52:15',
    '2020-01-12 07:52:15'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    65,
    'trip',
    'Update',
    'Updated trip 15 to canceled',
    1,
    15,
    '2020-01-12 07:58:08',
    '2020-01-12 07:58:08'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    66,
    'Trip',
    'Create',
    'Created trip 16',
    1,
    16,
    '2020-01-12 08:06:54',
    '2020-01-12 08:06:54'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    67,
    'Trip',
    'Create',
    'Created trip 17',
    1,
    17,
    '2020-01-12 08:07:13',
    '2020-01-12 08:07:13'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    68,
    'trip',
    'Update',
    'Updated trip 17 to canceled',
    1,
    17,
    '2020-01-12 08:07:31',
    '2020-01-12 08:07:31'
  );
INSERT INTO
  `audits` (
    `id`,
    `area`,
    `action`,
    `description`,
    `userId`,
    `refId`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    69,
    'User',
    'Create',
    'Created user kkk dflkds',
    1,
    18,
    '2020-01-12 08:30:53',
    '2020-01-12 08:30:53'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: categories
# ------------------------------------------------------------

INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    1,
    'Small Trucks',
    'patta wesi',
    1,
    '2019-07-23 16:03:03',
    '2019-09-03 17:03:03'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    2,
    'bus',
    'buzZz...',
    0,
    '2019-07-23 16:03:26',
    '2019-09-15 04:08:14'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    'abccccc',
    'wkjewfkljefkl',
    0,
    '2019-07-27 03:46:27',
    '2019-09-15 04:08:13'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    'mean',
    'meaning full',
    0,
    '2019-09-03 16:56:07',
    '2019-09-15 04:08:12'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    'dsrrete',
    'dsfdsgrwgtergt',
    0,
    '2019-09-03 17:06:41',
    '2019-09-15 04:08:12'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    6,
    'ddd',
    'ddd',
    0,
    '2019-09-07 04:54:33',
    '2019-09-07 04:56:03'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    7,
    'kkkkkkk',
    '',
    0,
    '2019-09-07 05:11:44',
    '2019-09-15 04:08:07'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    8,
    '12345',
    'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',
    0,
    '2019-09-07 15:51:25',
    '2019-09-15 04:08:07'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    9,
    '123455555555555dfwef',
    'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
    0,
    '2019-09-07 15:54:42',
    '2019-09-15 04:08:06'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    10,
    'Heavy duty',
    '111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111',
    1,
    '2019-09-15 03:54:00',
    '2019-09-21 06:14:16'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    11,
    'LIGHT & INTERMEDIATE Trucks',
    '',
    1,
    '2019-09-21 06:13:08',
    '2019-10-02 13:23:25'
  );
INSERT INTO
  `categories` (
    `id`,
    `name`,
    `description`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    12,
    'eewrewr',
    'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj',
    1,
    '2019-10-02 13:20:36',
    '2019-10-02 13:22:53'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: fuel_logs
# ------------------------------------------------------------

INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    1,
    7,
    12,
    '2019-08-11 11:34:43',
    '2019-08-11 11:34:43',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    2,
    7,
    34,
    '2019-08-11 13:07:07',
    '2019-08-11 13:07:07',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    3,
    2,
    3,
    '2019-09-07 04:15:30',
    '2019-09-07 04:15:30',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    4,
    2,
    3,
    '2019-09-07 04:15:37',
    '2019-09-07 04:15:37',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    5,
    1,
    78778,
    '2019-09-07 05:20:37',
    '2019-09-07 05:20:37',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    6,
    2,
    3,
    '2019-09-09 16:08:22',
    '2019-09-09 16:08:22',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    7,
    2,
    4,
    '2019-09-09 16:39:17',
    '2019-09-09 16:39:17',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    8,
    2,
    4,
    '2019-09-09 16:39:22',
    '2019-09-09 16:39:22',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    9,
    2,
    1.5,
    '2019-09-09 16:39:39',
    '2019-09-09 16:39:39',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    10,
    1,
    78790,
    '2019-09-10 15:56:42',
    '2019-09-10 15:56:42',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    11,
    1,
    12,
    '2019-09-10 15:56:54',
    '2019-09-10 15:56:54',
    NULL
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    12,
    7,
    3,
    '2019-09-10 16:07:43',
    '2019-09-10 16:07:43',
    'add'
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    13,
    7,
    9,
    '2019-09-10 16:08:21',
    '2019-09-10 16:08:21',
    'remove'
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    14,
    7,
    1,
    '2019-09-10 16:23:50',
    '2019-09-10 16:23:50',
    'add'
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    15,
    9,
    50,
    '2019-10-03 01:57:39',
    '2019-10-03 01:57:39',
    'remove'
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    16,
    22,
    2,
    '2019-10-03 02:02:06',
    '2019-10-03 02:02:06',
    'add'
  );
INSERT INTO
  `fuel_logs` (
    `id`,
    `vehicleId`,
    `fuelLevel`,
    `createdAt`,
    `updatedAt`,
    `action`
  )
VALUES
  (
    17,
    22,
    6,
    '2019-10-03 02:02:38',
    '2019-10-03 02:02:38',
    'add'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: maintenances
# ------------------------------------------------------------

INSERT INTO
  `maintenances` (
    `id`,
    `vehicleId`,
    `payment`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `isPaid`,
    `imgUrl`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    1,
    1,
    890,
    '2019-08-11',
    '2019-08-21',
    'kl;;;;;;;;;;',
    1,
    NULL,
    '2019-08-11 15:18:52',
    '2019-08-11 15:18:52'
  );
INSERT INTO
  `maintenances` (
    `id`,
    `vehicleId`,
    `payment`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `isPaid`,
    `imgUrl`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    2,
    22,
    4500,
    '2019-10-03',
    '2019-10-03',
    '',
    1,
    NULL,
    '2019-10-03 13:17:28',
    '2019-10-03 13:17:28'
  );
INSERT INTO
  `maintenances` (
    `id`,
    `vehicleId`,
    `payment`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `isPaid`,
    `imgUrl`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    3,
    2,
    1200,
    '2019-10-03',
    '2019-10-04',
    '',
    1,
    NULL,
    '2019-10-03 14:51:04',
    '2019-10-03 14:51:04'
  );
INSERT INTO
  `maintenances` (
    `id`,
    `vehicleId`,
    `payment`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `isPaid`,
    `imgUrl`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    4,
    2,
    1200,
    '2019-10-03',
    '2019-10-04',
    '',
    1,
    NULL,
    '2019-10-03 14:54:02',
    '2019-10-03 14:54:02'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: places
# ------------------------------------------------------------

INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    1,
    'Fort',
    'habarakada',
    'nudi owns',
    88888889,
    9999999999,
    '2019-08-01 16:32:31',
    '2019-09-16 15:31:47',
    0,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    2,
    'elephant house',
    'ranala',
    'some text',
    29343,
    9809,
    '2019-08-01 16:53:13',
    '2019-08-01 17:06:12',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    3,
    'ragama',
    'ytyutyutyujkh kjhkjhjk jkhkjh jk jkhkjhkjhjkh',
    'uyiyiuyiuy guityiu uyui iuyiu',
    34.6767,
    455.878788,
    '2019-09-07 05:10:28',
    '2019-09-07 05:11:21',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    4,
    '2222222222222',
    '22222222222222',
    '22222222222222',
    222222222222222,
    2.222222222222222e15,
    '2019-09-08 01:56:08',
    '2019-09-08 01:59:52',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    5,
    'hhhh',
    '',
    '',
    8888888,
    888888,
    '2019-09-08 02:37:13',
    '2019-09-16 15:30:54',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    6,
    'abcd',
    'uuuuuuuuuuu',
    '',
    8888888,
    888888,
    '2019-09-08 02:37:29',
    '2019-09-08 02:37:29',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    7,
    'yhkjhkjhkjhkj',
    'uuuuuuuuuuu',
    '',
    8888888,
    888888,
    '2019-09-08 02:38:22',
    '2019-09-08 02:38:22',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    8,
    'Dematagoda',
    'uuuuuuuuuuu',
    'ggggggggggggg',
    8888888,
    888888,
    '2019-09-08 02:50:16',
    '2019-09-08 02:50:16',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    9,
    'Borella',
    'tyuty',
    NULL,
    567567,
    67567,
    '2019-09-08 02:50:26',
    '2019-09-08 02:50:26',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    10,
    'Maradana',
    'tytyu',
    'yutyu',
    6567,
    67576,
    '2019-09-08 02:50:37',
    '2019-09-08 02:50:37',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    11,
    'Horana',
    'jkhhj',
    'jhkhkj',
    88,
    88,
    '2019-09-16 15:24:35',
    '2019-09-16 15:32:04',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    12,
    'rajigiriya',
    '',
    '',
    12,
    95,
    '2019-09-16 15:29:56',
    '2019-09-16 15:29:56',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    13,
    'Pannipitiya',
    'jjj',
    '',
    88.88877,
    77.144,
    '2019-09-21 06:57:38',
    '2019-09-21 06:58:07',
    1,
    NULL
  );
INSERT INTO
  `places` (
    `id`,
    `name`,
    `address`,
    `notes`,
    `lat`,
    `lng`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `img`
  )
VALUES
  (
    14,
    'ghghjgjh',
    'jhjhg ghjggggh hgfhjghjg jhgfhjfhj fghf fghfhgfgh ghfghfghf fghfghf gfhfghfhjjkhjkhjkhjkhkjhkjh hgjg',
    'fdfgfgffgdfgffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff dfgdfg dfgdfgdf dfgfg gfdgdfgdf dfgdfgsfg fgdfgdf dfgdfgdfg dfgfdgfddfgdfgf hjkdfhgkj jkghdfkjgh kjghjfkghk hfkjghdfkjgh dfjkghjdfkjkfdghkj hfg',
    3245346546,
    54645657,
    '2019-10-02 13:38:08',
    '2019-10-02 13:39:23',
    1,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sequelizemeta
# ------------------------------------------------------------

INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190720100745-create-user.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190720124838-addColStatusToUsers.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190721173831-seedUsers.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190722152915-create-category.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190722154740-create-vehicle.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190801162424-create-place.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190801165809-addColStatusAndImg.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190805142135-create-trip.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190805143532-create-trip-detail.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190811070326-fuelLevelRequired.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190811111108-create-fuel-log.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190811134703-create-audit.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190811144530-create-maintenance.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190814162021-addColsContactNumbs.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190907161626-addFuelTypeEnum.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190908022543-changeColLengthNotes.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20190910155906-addColAction.js');
INSERT INTO
  `sequelizemeta` (`name`)
VALUES
  ('20191002124540-changeColLengthNotes.js');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: trip_details
# ------------------------------------------------------------

INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    1,
    7,
    1,
    '2019-08-05 15:41:07',
    '2019-08-05 15:41:07'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    2,
    7,
    2,
    '2019-08-05 15:41:07',
    '2019-08-05 15:41:07'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    3,
    8,
    1,
    '2019-08-07 15:46:42',
    '2019-08-07 15:46:42'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    4,
    9,
    1,
    '2019-08-07 16:33:08',
    '2019-08-07 16:33:08'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    5,
    9,
    2,
    '2019-08-07 16:33:08',
    '2019-08-07 16:33:08'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    6,
    10,
    1,
    '2019-08-07 16:42:41',
    '2019-08-07 16:42:41'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    7,
    10,
    2,
    '2019-08-07 16:42:41',
    '2019-08-07 16:42:41'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    8,
    11,
    9,
    '2019-09-25 16:30:30',
    '2019-09-25 16:30:30'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    9,
    11,
    11,
    '2019-09-25 16:30:30',
    '2019-09-25 16:30:30'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    10,
    12,
    8,
    '2019-09-25 16:36:06',
    '2019-09-25 16:36:06'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    11,
    12,
    11,
    '2019-09-25 16:36:06',
    '2019-09-25 16:36:06'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    12,
    12,
    10,
    '2019-09-25 16:36:06',
    '2019-09-25 16:36:06'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    13,
    13,
    8,
    '2019-09-25 16:37:26',
    '2019-09-25 16:37:26'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    14,
    13,
    11,
    '2019-09-25 16:37:26',
    '2019-09-25 16:37:26'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    15,
    13,
    10,
    '2019-09-25 16:37:26',
    '2019-09-25 16:37:26'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    16,
    14,
    11,
    '2019-10-04 02:54:13',
    '2019-10-04 02:54:13'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    17,
    14,
    12,
    '2019-10-04 02:54:13',
    '2019-10-04 02:54:13'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    18,
    14,
    13,
    '2019-10-04 02:54:13',
    '2019-10-04 02:54:13'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    19,
    15,
    10,
    '2020-01-12 07:52:15',
    '2020-01-12 07:52:15'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    20,
    15,
    9,
    '2020-01-12 07:52:15',
    '2020-01-12 07:52:15'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    21,
    15,
    11,
    '2020-01-12 07:52:15',
    '2020-01-12 07:52:15'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    22,
    16,
    11,
    '2020-01-12 08:06:54',
    '2020-01-12 08:06:54'
  );
INSERT INTO
  `trip_details` (`id`, `tripId`, `placeId`, `createdAt`, `updatedAt`)
VALUES
  (
    23,
    17,
    10,
    '2020-01-12 08:07:13',
    '2020-01-12 08:07:13'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: trips
# ------------------------------------------------------------

INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    5,
    1,
    1,
    '2019-08-05',
    '2019-08-14',
    'nalaaaaa',
    45645,
    'expired',
    '2019-08-05 15:24:38',
    '2019-08-05 15:24:38'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    6,
    1,
    2,
    '2019-08-05',
    '2019-08-13',
    'yyyyyyyy',
    999999,
    'expired',
    '2019-08-05 15:40:14',
    '2019-08-05 15:40:14'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    7,
    1,
    1,
    '2019-08-05',
    '2019-08-12',
    'yyyyyyyyyyyyy',
    456,
    'expired',
    '2019-08-05 15:41:07',
    '2019-08-05 15:41:07'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    8,
    3,
    5,
    '2019-08-07',
    '2019-08-14',
    '',
    0,
    'expired',
    '2019-08-07 15:46:42',
    '2019-08-07 15:46:42'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    9,
    1,
    5,
    '2019-09-16',
    '2019-09-25',
    '',
    0,
    'expired',
    '2019-08-07 16:33:08',
    '2019-08-07 16:33:08'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    10,
    3,
    5,
    '2019-10-01',
    '2019-10-24',
    '',
    0,
    'expired',
    '2019-08-07 16:42:41',
    '2019-08-07 16:42:41'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    11,
    19,
    14,
    '2019-09-25',
    '2019-09-27',
    '',
    1000,
    'expired',
    '2019-09-25 16:30:30',
    '2019-09-25 16:30:30'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    12,
    16,
    14,
    '2019-10-03',
    '2019-10-17',
    'Please meet Mrs. Dulandi',
    1400,
    'expired',
    '2019-09-25 16:36:06',
    '2019-09-25 16:36:06'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    13,
    2,
    14,
    '2019-11-01',
    '2019-12-26',
    'Please meet Mrs. Methma',
    1400,
    'expired',
    '2019-09-25 16:37:26',
    '2019-09-25 16:37:26'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    14,
    3,
    5,
    '2019-10-04',
    '2019-10-07',
    '',
    1200,
    'ongoing',
    '2019-10-04 02:54:13',
    '2019-10-04 06:21:28'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    15,
    20,
    5,
    '2020-01-12',
    '2020-01-22',
    '',
    0,
    'canceled',
    '2020-01-12 07:52:15',
    '2020-01-12 07:58:08'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    16,
    22,
    5,
    '2020-03-03',
    '2020-03-26',
    'llllllllllllll',
    1200,
    'expired',
    '2020-01-12 08:06:54',
    '2020-01-12 08:06:54'
  );
INSERT INTO
  `trips` (
    `id`,
    `vehicleId`,
    `driverId`,
    `startFrom`,
    `stopAt`,
    `notes`,
    `allowances`,
    `status`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    17,
    21,
    14,
    '2020-03-05',
    '2020-03-10',
    'kkkkkkkkk',
    0,
    'canceled',
    '2020-01-12 08:07:13',
    '2020-01-12 08:07:31'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    1,
    'pathum',
    'kalhan',
    1,
    'pathumsimpson@gmail.com',
    '$2a$10$EX/xFyXsVUnckG1SUBDfO.KAcFY6syE4CbIIQK/rOyFm5upl8bB1m',
    NULL,
    '961962633V',
    NULL,
    'admin',
    NULL,
    '2019-07-20 11:27:33',
    '2019-10-03 01:18:26',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    2,
    'kaushalya',
    'lakmini',
    1,
    'kau@gmail.com',
    '$2a$10$2s4l/vrnauPmjxWW8l/3Z.WhMlC1asEgk5PcdUk.ymD6y6Oxo.NPm',
    NULL,
    '96196263382',
    NULL,
    'admin',
    NULL,
    '2019-07-20 11:28:50',
    '2019-08-01 16:14:00',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    3,
    'dilpa',
    'sirimanna',
    1,
    'dili@gmail.com',
    '$2a$10$UU2NZVWtpKi4RNlakTts7OuUNnXdudbzq214F9/z2R9RX29hplBsi',
    NULL,
    '999999999V',
    'gud guy',
    'admin',
    'coop lane',
    '2019-07-21 15:38:07',
    '2019-07-21 15:51:51',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    4,
    'Lahiru',
    'Bandara',
    1,
    'ulb1994@gmail.com',
    '$2a$10$gH1mfn2jqp6xq7gSVn.FAO8oh4Mcw6kd2nL/0GKFAaaNiDau3JsNm',
    NULL,
    '961962666V',
    NULL,
    'admin',
    NULL,
    '2019-07-21 17:53:11',
    '2019-07-21 17:53:11',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    5,
    'lal',
    'senarathne',
    1,
    'lal@gmail.com',
    '$2a$10$SsQShGYgPCaQpLNaTUSoKedAs6cs1umoK6QDrX/DnzrM1JkUCWuuK',
    NULL,
    '981962633V',
    '',
    'driver',
    '',
    '2019-08-06 16:09:48',
    '2019-09-08 03:36:17',
    1,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    6,
    'kkkkk',
    'l',
    1,
    'jkljkl@kljdf.lk',
    '$2a$10$AfrEJe6pSQioEUFxYg1TyO2OBqtSxByTqp.6c7fT77Hn2vWwvrvgS',
    NULL,
    '981963633v',
    'kkkkkkkkk',
    'staff',
    'jjjjjjjjjjjjjjjj',
    '2019-08-14 16:26:31',
    '2019-08-14 16:26:31',
    1,
    '8888888888',
    '961962633'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    7,
    'kkkkk',
    'l',
    1,
    'jkjkl@kljdf.lk',
    '$2a$10$Y1NetB5bTxwXu7BeDNBwjuSzO13wFUayQ7NeZfnvq2XUz25/05xxi',
    NULL,
    '081963633v',
    'kkkkkkkkk',
    'staff',
    'jjjjjjjjjjjjjjjj',
    '2019-08-14 16:28:06',
    '2019-08-14 16:28:06',
    1,
    '8888888888',
    '961962633'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    8,
    'rushi',
    'rodriguz',
    1,
    'rush@gmail.com',
    '$2a$10$MvFr5x1Mjwn9rNVjadw0melEL57fWLTtsHcN68WbFUjDVuiQ/SWWi',
    NULL,
    '982345732V',
    'hhhhhhhhhhhhhhhh',
    'staff',
    'hhhhhhhhhhhhhhhhhhhhhh',
    '2019-08-14 17:15:03',
    '2019-08-14 17:15:03',
    1,
    '7777777777',
    '961962633'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    9,
    'kkkkkkkkkkkkkkkkkkkkkk',
    'kljk',
    0,
    'ytrututyutyu@d.lk',
    '$2a$10$OSn5MSUROt65BohEdD8kA.2EvRc5I2LGyKd4B/fr7euG9FIU0ylc6',
    NULL,
    '961962654V',
    'kkkkkkkkkkkkkkkkkk',
    'staff',
    'errrrrrrrrrrrrrrrreeeeeeeeeeeeeeeeeeeeeeeeeeeeeewereerterr',
    '2019-09-07 04:49:43',
    '2019-10-02 12:54:45',
    1,
    '6666666666',
    '111111111'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    10,
    'Dhdjdjd',
    'Ehskskd',
    1,
    'dhkgkftkwktidbgs@gnd.com',
    '$2a$10$9eM6Y1a22FsWH7SC9RfzaeWbfQsgRy31IJeYMHysG1d6mFBBJtLia',
    NULL,
    '183777947V',
    '',
    'staff',
    'Wuwidnxkckd',
    '2019-09-07 06:03:28',
    '2019-09-07 06:03:28',
    1,
    '1738888837',
    '1234435444'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    11,
    'dulandi',
    'illeperuma',
    1,
    'dulandi@mongal.com',
    '$2a$10$//u6e5Yj0L3wqDEBfaQg0.aby9TAB3BEcNO2w5lg2C7jnDRAvOVDi',
    NULL,
    '961962345V',
    'cool',
    'staff',
    'Rajagiriya',
    '2019-09-07 14:31:22',
    '2019-09-07 14:31:22',
    1,
    '1111111111',
    '2222222222'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    12,
    'uyy',
    'uyu',
    1,
    'yuiyiu@jhd.lk',
    '$2a$10$haPms6MwQmqBjUbYeAwuNeH.3JCrnWAK7o7BqARPxnFcdZxHuZiMS',
    NULL,
    '961966345V',
    'hhhhhhhhhhh',
    'staff',
    'hhhhhhh',
    '2019-09-07 14:52:50',
    '2019-09-07 14:52:50',
    1,
    '9999999999',
    '961962633'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    13,
    'hhhhhhhhhhhhhhh',
    'iiiiiiiiiiiiiiiiiii',
    1,
    'pathumsimpson@d.lk',
    '$2a$10$BSDXkEgGeGofNqr6LAe3W.qt/lkBdkKmIpRAD6hvOUynNu0II9pU.',
    NULL,
    '967962633V',
    'hhhhhhhhhhhhhhhhhhhhhhhh',
    'staff',
    'hhhhhhhhhhhhhhhhhhhhhhhhhhhh',
    '2019-09-07 15:05:06',
    '2019-10-02 12:54:44',
    1,
    '1234567899',
    '9999999999'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    14,
    'jagath',
    'kumara',
    1,
    'kumara@gmail.com',
    '$2a$10$z2WpqlAVOe5OhytbttDR2ORtlRI0NIebEjcY2mwXFXkwRpbcD222S',
    NULL,
    '971963644V',
    'jjjjjjjjjjjjjjjjjjj',
    'driver',
    'jjjjjjjjjjjjjjjjjjjjjjj',
    '2019-09-08 03:35:36',
    '2019-09-25 16:30:06',
    1,
    '1111111111',
    '4444444444'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    15,
    'chamindu',
    'aiya',
    1,
    'suda@gmail.com',
    '$2a$10$hBNwXY4mu6RGh40tkjBXR.qMHrlS2vOx79voWu9XRNDCyo5FgTz/q',
    NULL,
    '699162633V',
    'bro',
    'manager',
    'army',
    '2019-09-21 04:21:25',
    '2019-10-02 12:54:42',
    1,
    '0112751058',
    '0112751058'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    16,
    'yasantha',
    'kodagoda',
    1,
    'pathumsimpsone@gmail.com',
    '$2a$10$3X7bCGGknYyfANZLLEZJ3ekV/yMHVjdzNTKIbwmNnNGBqnsJYkBI6',
    NULL,
    '991962633V',
    'reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
    'staff',
    'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkr',
    '2019-10-02 12:43:06',
    '2019-10-02 12:43:06',
    1,
    '0717565094',
    '0717565094'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    17,
    'chapa',
    'arundathi',
    1,
    'chapa@gmail.com',
    '$2a$10$h5hdQqETwRRg3bpZ3R4Moe2EAhPBIT/9YP5gggL2Us6BWBg7yw0gq',
    NULL,
    '951962645V',
    '',
    'staff',
    '',
    '2020-01-05 03:47:59',
    '2020-01-05 03:47:59',
    1,
    '0778565218',
    '0717985165'
  );
INSERT INTO
  `users` (
    `id`,
    `firstName`,
    `lastName`,
    `gender`,
    `email`,
    `password`,
    `profileImg`,
    `nic`,
    `notes`,
    `role`,
    `address`,
    `createdAt`,
    `updatedAt`,
    `status`,
    `contactNumber1`,
    `contactNumber2`
  )
VALUES
  (
    18,
    'kkk',
    'dflkds',
    1,
    'dskjf@jklldf.lk',
    '$2a$10$r66519O3lhAi.fExG/LLqewxW4y.Ka5zFT7GQnJvR/Rz0/Q3DQGYC',
    NULL,
    '967585421V',
    '',
    'staff',
    '',
    '2020-01-12 08:30:53',
    '2020-01-12 08:30:53',
    1,
    '0718565154',
    '0112758964'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: vehicles
# ------------------------------------------------------------

INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    1,
    'bmw',
    1023,
    'blue',
    '1232432435',
    12,
    0,
    12,
    NULL,
    'discade',
    2,
    '2019-07-24 15:22:45',
    '2019-09-07 05:07:04',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    2,
    'Benz',
    2019,
    'red',
    '32955934',
    12,
    1,
    2.5,
    NULL,
    'fuck',
    2,
    '2019-07-24 15:45:00',
    '2019-09-08 03:34:19',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    3,
    'prado',
    1299,
    'blue',
    '980989090',
    99,
    1,
    40,
    NULL,
    'fuck you my dear',
    1,
    '2019-07-24 16:02:09',
    '2019-07-24 16:02:09',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    4,
    'Train',
    2019,
    'green',
    '99999999',
    99,
    1,
    50,
    NULL,
    '999',
    1,
    '2019-07-24 16:04:27',
    '2019-09-08 03:34:08',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    7,
    'Train',
    2019,
    'green',
    '76877897',
    99,
    0,
    41,
    NULL,
    '999',
    1,
    '2019-07-24 16:06:22',
    '2019-08-06 16:03:50',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    8,
    '009',
    1299,
    'jkjlk',
    '9079807890',
    79,
    0,
    50,
    NULL,
    'hjkhkj',
    2,
    '2019-07-24 16:07:41',
    '2019-08-06 16:03:55',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    9,
    'hhhh',
    9809,
    'kjljlk',
    '90890890',
    98,
    0,
    50,
    NULL,
    'hjkjh',
    2,
    '2019-07-24 16:08:48',
    '2019-08-06 16:03:55',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    10,
    '1200',
    1230,
    'jkjkl',
    '8097897',
    78,
    0,
    0,
    NULL,
    'jhkjhkj',
    1,
    '2019-07-24 16:11:00',
    '2019-08-06 16:03:56',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    11,
    '2354',
    89780,
    'lkjlkjkl',
    '879879',
    89,
    1,
    0,
    NULL,
    'dfkljwefkl rek hjgjhgh hjkhkjh kjhgkjh jkhjkhkhj ferg fgrgfgh htyuytu',
    4,
    '2019-09-07 04:21:24',
    '2019-09-07 04:21:24',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    12,
    'kjjkl',
    67878,
    'uiuoiu',
    '898798',
    78,
    1,
    0,
    NULL,
    'jhkjhkjhkj',
    3,
    '2019-09-07 04:22:15',
    '2019-09-07 04:22:15',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    13,
    'HONDA 2339',
    9999,
    'green',
    '9999',
    9,
    0,
    0,
    NULL,
    '9',
    3,
    '2019-09-07 05:03:48',
    '2019-09-07 05:07:08',
    NULL
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    14,
    '99999999999',
    2018,
    '99999999999',
    '00000000',
    234,
    1,
    0,
    NULL,
    '',
    1,
    '2019-09-15 04:42:59',
    '2019-09-15 04:42:59',
    'petrol'
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    15,
    '5546',
    1991,
    'black',
    '4453',
    234,
    1,
    0,
    NULL,
    '',
    1,
    '2019-09-15 04:44:31',
    '2019-09-15 11:13:24',
    'petrol'
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    16,
    'TATA SUPER ACE NON AC EURO4',
    1989,
    'blue',
    '1295',
    9,
    1,
    0,
    NULL,
    '',
    1,
    '2019-09-16 16:04:12',
    '2019-09-16 16:04:12',
    'diesel'
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    19,
    'DIMO BATTA HT2 EURO4',
    1989,
    'blue',
    '98990',
    9,
    1,
    0,
    NULL,
    '',
    1,
    '2019-09-16 16:17:54',
    '2019-09-16 16:18:11',
    'diesel'
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    20,
    'TATA SUPER ACE SPORT EURO4',
    2001,
    'white',
    '8451',
    12,
    1,
    0,
    NULL,
    '',
    1,
    '2019-09-21 06:29:35',
    '2019-09-21 06:30:11',
    'petrol'
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    21,
    'LPT 709 EURO4',
    1989,
    'red',
    '344556',
    12,
    1,
    0,
    NULL,
    '',
    11,
    '2019-10-02 13:26:01',
    '2019-10-02 13:28:04',
    'diesel'
  );
INSERT INTO
  `vehicles` (
    `id`,
    `make`,
    `year`,
    `color`,
    `vin`,
    `tankVolume`,
    `status`,
    `fuelLevel`,
    `image`,
    `notes`,
    `categoryId`,
    `createdAt`,
    `updatedAt`,
    `fuelType`
  )
VALUES
  (
    22,
    'TATA LPT 1109 36 EURO4',
    1990,
    'red',
    '3445569',
    8,
    1,
    8,
    NULL,
    '',
    10,
    '2019-10-02 13:31:37',
    '2019-10-02 13:31:37',
    'diesel'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
