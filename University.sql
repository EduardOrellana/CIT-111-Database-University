-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University_Project_BYU
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema University_Project_BYU
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University_Project_BYU` DEFAULT CHARACTER SET utf8 ;
USE `University_Project_BYU` ;

-- -----------------------------------------------------
-- Table `University_Project_BYU`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`students` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`students` (
  `students_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('F', 'M') NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`students_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`college` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`college` (
  `college_id` INT NOT NULL,
  `n_college` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`departments` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`departments` (
  `departments_id` VARCHAR(10) NOT NULL,
  `dep_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`departments_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`courses` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`courses` (
  `courses_id` VARCHAR(10) NOT NULL,
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `college_id` INT NOT NULL,
  `departments_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`courses_id`),
  INDEX `fk_courses_college_idx` (`college_id` ASC) VISIBLE,
  INDEX `fk_courses_departments1_idx` (`departments_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_college`
    FOREIGN KEY (`college_id`)
    REFERENCES `University_Project_BYU`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_departments1`
    FOREIGN KEY (`departments_id`)
    REFERENCES `University_Project_BYU`.`departments` (`departments_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`professors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`professors` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`professors` (
  `proffesor_id` INT NOT NULL,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  `courses_id` VARCHAR(10) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`proffesor_id`),
  INDEX `fk_professors_courses1_idx` (`courses_id` ASC) VISIBLE,
  CONSTRAINT `fk_professors_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `University_Project_BYU`.`courses` (`courses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`semesters` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`semesters` (
  `semesters_id` INT NOT NULL AUTO_INCREMENT,
  `term` ENUM('Winter', 'Spring', 'Fall') NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`semesters_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`section` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `n_section` VARCHAR(25) NOT NULL,
  `proffesor_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_professors1_idx` (`proffesor_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_professors1`
    FOREIGN KEY (`proffesor_id`)
    REFERENCES `University_Project_BYU`.`professors` (`proffesor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University_Project_BYU`.`registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University_Project_BYU`.`registration` ;

CREATE TABLE IF NOT EXISTS `University_Project_BYU`.`registration` (
  `students_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  `semesters_id` INT NOT NULL,
  PRIMARY KEY (`students_id`, `section_id`),
  INDEX `fk_students_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_students_has_section_students1_idx` (`students_id` ASC) VISIBLE,
  INDEX `fk_registration_semesters1_idx` (`semesters_id` ASC) VISIBLE,
  CONSTRAINT `fk_students_has_section_students1`
    FOREIGN KEY (`students_id`)
    REFERENCES `University_Project_BYU`.`students` (`students_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `University_Project_BYU`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registration_semesters1`
    FOREIGN KEY (`semesters_id`)
    REFERENCES `University_Project_BYU`.`semesters` (`semesters_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



#INSERT DATA INTO STUDENTS TABLE
INSERT INTO students
VALUES
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

#INSERT DATA INTO SEMESTERS
INSERT INTO semesters
(term, year)
VALUES
('Winter', 2018),
('Fall', 2019);


#INSERT DATA INTO COLLEGE, DEPARTMETNS AND COURSES

INSERT INTO college
VALUES
(1, 'College of Physical Science and Engineering'),
(2, 'College of Business and Communication'),
(3, 'College of Language and Letters');

INSERT INTO departments
VALUES
('CIT', 'Computer Information Technology'),
('ECON', 'Economics'),
('HUM', 'Humanities and Philosophy');

INSERT INTO courses
VALUES
('CIT 111', 111, 'Intro to Databases', 3, 1, 'CIT'),
('ECON 388', 388, 'Econometrics', 4, 2, 'ECON'),
('ECON 150', 150, 'Micro Economics', 3, 2, 'ECON'),
('HUM 376', 376, 'Classical Heritage', 2, 3, 'HUM');

#Insert data into Proffesors
INSERT INTO professors
VALUES
(1, 'Marty', 'Morring', 'CIT 111', 30),
(2, 'Nate', 'Nathan', 'ECON 150', 50),
(3, 'Ben', 'Barrus', 'ECON 388', 35),
(4, 'John', 'Jensen', 'HUM 376', 30),
(5, 'Bill', 'Barney', 'CIT 111', 35);

#INSERT DATA INTO CLASSES TO PREPARE THE CATALOG OF THE CLASSES FOR THE STUDENTS
INSERT INTO section
(proffesor_id, n_section)
VALUES
(1, 'Section 1'),
(1, 'Section 2'),
(1, 'Section 3'),
(2, 'Section 1'),
(2, 'Section 2'),
(2, 'Section 3'),
(3, 'Section 1'),
(3, 'Section 2'),
(3, 'Section 3'),
(4, 'Section 1'),
(4, 'Section 2'),
(4, 'Section 3'),
(5, 'Section 1'),
(5, 'Section 2'),
(5, 'Section 3');

#Registration of the Students
INSERT INTO registration
VALUES
(6, 15, 1),
(7, 2, 1),
(7, 4, 1),
(7, 10, 1),
(4, 10, 2),
(9, 5, 1),
(2, 7, 2),
(3, 7, 2),
(5, 7, 2),
(5, 10, 2),
(1, 13, 2),
(1, 5, 2),
(8, 5, 1),
(10, 14, 1);


-- ####################################################################################### --

# Queries #

#Query 1
SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %e, %Y') AS 'Sept Birthdays'
FROM students
WHERE MONTH(birthdate) = 9;

#Query 2
SELECT last_name, first_name, FLOOR(DATEDIFF(DATE('2017-01-05'),birthdate)/365) AS 'Years',
MOD(DATEDIFF(DATE('2017-01-05'),birthdate),365) AS 'Days',
CONCAT(FLOOR(DATEDIFF(DATE('2017-01-05'),birthdate)/365), " - Yrs, ",MOD(DATEDIFF(DATE('2017-01-05'),birthdate),365), " - Days") AS 'Years and Days'
FROM students
ORDER BY FLOOR(DATEDIFF(DATE('2017-01-05'),birthdate)/365) DESC;

#Query 3
SELECT stu.first_name, stu.last_name
FROM students stu
JOIN registration reg
	ON reg.students_id = stu.students_id
JOIN section sec
	ON reg.section_id = sec.section_id
WHERE sec.proffesor_id = 4
ORDER BY stu.last_name;

#Query 4
SELECT pro.faculty_fname AS 'fname', pro.faculty_lname AS 'lname'
FROM professors pro
JOIN section sec
	ON sec.proffesor_id = pro.proffesor_id
JOIN registration reg
	ON reg.section_id = sec.section_id
WHERE reg.students_id = 7 AND reg.semesters_id = 1
ORDER BY lname;

#Query 5
SELECT stu.first_name, stu.last_name
FROM students stu
JOIN registration reg
	ON reg.students_id = stu.students_id
JOIN section sec
	ON sec.section_id = reg.section_id
JOIN professors prof
	ON prof.proffesor_id = sec.proffesor_id
JOIN courses c
	ON c.courses_id = prof.courses_id
WHERE reg.semesters_id = 2 AND c.course_title = 'Econometrics'
ORDER BY last_name;


#Query 6
SELECT co.departments_id AS 'department_code', co.course_num, co.course_title AS 'name'
FROM courses co
JOIN professors prof
	ON prof.courses_id = co.courses_id
JOIN section sec
	ON sec.proffesor_id = prof.proffesor_id
JOIN registration reg
	ON reg.section_id = sec.section_id
WHERE reg.semesters_id = 1 AND reg.students_id = 7
ORDER BY name;

#Query 7
SELECT sem.term, sem.year, COUNT(*) AS 'Enrollment'
FROM registration reg
JOIN semesters sem
	ON sem.semesters_id = reg.semesters_id
WHERE reg.semesters_id = 2;

#Query 8
SELECT col.n_college AS 'Colleges', COUNT(*) AS 'Courses'
FROM courses c
JOIN college col
	ON col.college_id = c.college_id
GROUP BY c.college_id
ORDER BY Colleges;

#Query 9
SELECT prof.faculty_fname AS 'fname', prof.faculty_lname AS 'lname', ROUND(IF(prof.faculty_fname = 'Nate', 100, AVG(prof.capacity)),0) AS 'TeachingCapacity'
FROM registration reg
JOIN section sec
	ON sec.section_id = reg.section_id
JOIN professors prof
	ON prof.proffesor_id = sec.proffesor_id
WHERE reg.semesters_id = 1
GROUP BY prof.proffesor_id
ORDER BY TeachingCapacity;
    

#QUERY 10
SELECT stu.last_name, stu.first_name, prof.courses_id, SUM(co.credits) AS Credits
FROM students stu
JOIN registration reg
	ON reg.students_id = stu.students_id
JOIN section sec
	ON reg.section_id = sec.section_id
JOIN professors prof
	ON prof.proffesor_id = sec.proffesor_id
JOIN courses co
	ON prof.courses_id = co.courses_id
WHERE reg.semesters_id = 2
GROUP BY stu.students_id
HAVING SUM(co.credits) > 3
ORDER BY Credits DESC;
