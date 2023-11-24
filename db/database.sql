CREATE TABLE `user` (
	`user_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR(30) NULL,
    `user_surname` VARCHAR(30) NULL,
    `user_email` VARCHAR(45) NULL,
    `is_admin` TINYINT NULL DEFAULT 0,
    `user_login` VARCHAR(30) NULL,
    `user_password` VARCHAR(30) NULL,
    PRIMARY KEY (`user_id`)
);

CREATE TABLE `group` (
    `group_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `group_name` VARCHAR(30) NULL,
    `group_cist_id` INT NULL,
    `semester_number` INT NULL,
    PRIMARY KEY (`group_id`),
    UNIQUE KEY (`group_cist_id`),
    FOREIGN KEY (`division_id`) REFERENCES `division`(`division_id`) ON DELETE CASCADE
);

CREATE TABLE `division` (
    `division_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `division_name` VARCHAR(30) NULL,
    `start_year` INT NULL,
    PRIMARY KEY (`division_id`),
    FOREIGN KEY (`speciality_id`) REFERENCES `speciality`(`speciality_id`) ON DELETE CASCADE
);

CREATE TABLE `speciality` (
    `speciality_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `speciality_name` VARCHAR(30) NULL,
    `speciality_code` VARCHAR(30) NULL,
    PRIMARY KEY (`speciality_id`)
);

CREATE TABLE `subject` (
    `subject_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `subject_name` VARCHAR(100) NULL,
    `subject_short_name` VARCHAR(30) NULL,
    PRIMARY KEY (`subject_id`)
);

CREATE TABLE `lesson_type` (
    `lesson_type_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `lesson_type` VARCHAR(30) NULL,
    `number_of_classes` INT NULL,
    PRIMARY KEY (`lesson_type_id`)
);

CREATE TABLE `class` (
    `class_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `class_start_time` TIME NULL,
    `class_end_time` TIME NULL,
    `class_№` INT NULL,
    PRIMARY KEY (`class_id`)
);

CREATE TABLE `day_of_week` (
    `day_of_week_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `day_of_week` VARCHAR(30) NULL,
    PRIMARY KEY (`day_of_week_id`)
);

CREATE TABLE `audience` (
    `audience_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `audience_name` VARCHAR(30) NULL,
    `audience_floor` INT NULL,
    `audience_building` INT NULL,
    `audience_cist_id` INT NULL,
    PRIMARY KEY (`audience_id`),
    UNIQUE KEY (`audience_cist_id`)
);

CREATE TABLE `teacher` (
    `teacher_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `teacher_name` VARCHAR(30) NULL,
    `teacher_surname` VARCHAR(30) NULL,
    `teacher_patronymic` VARCHAR(30) NULL,
    `teacher_email` VARCHAR(45) NULL,
    `teacher_cist_id` INT NULL UNIQUE,
    PRIMARY KEY (`teacher_id`),
    UNIQUE KEY (`teacher_cist_id`)
);

CREATE TABLE `subject_in_schedule` (
    `subject_in_schedule_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `number_of_lectures` INT NULL,
    `number_of_practicies` INT NULL,
    `number_of_laboratories` INT NULL,
    PRIMARY KEY (`subject_in_schedule_id`),
    FOREIGN KEY (`subject_id`) REFERENCES `subject`(`subject_id`) ON DELETE CASCADE,
    FOREIGN KEY (`division_id`) REFERENCES `division`(`division_id`) ON DELETE CASCADE
);

CREATE TABLE `group_lesson` (
    `group_lesson_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`group_lesson_id`),
    FOREIGN KEY (`group_id`) REFERENCES `group`(`group_id`) ON DELETE CASCADE,
    FOREIGN KEY (`lesson_id`) REFERENCES `lesson`(`lesson_id`) ON DELETE CASCADE
);

CREATE TABLE `change` (
    `change_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `change_date` DATE NULL,
    PRIMARY KEY (`change_id`),
    `moved_from_lesson_id` REFERENCES `lesson`(`lesson_id`) ON DELETE CASCADE,
    `moved_to_lesson_id` REFERENCES `lesson`(`lesson_id`) ON DELETE CASCADE
);

CREATE TABLE `lesson` (
    `lesson_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `lesson_date` DATE NULL,
    `lesson_status` VARCHAR(30) NULL,
    PRIMARY KEY (`lesson_id`),
    FOREIGN KEY (`class_id`) REFERENCES class(`class_id`) ON DELETE CASCADE,
    FOREIGN KEY (`day_of_week_id`) REFERENCES `day_of_week`(`day_of_week_id`) ON DELETE CASCADE,
    FOREIGN KEY (`audience_id`) REFERENCES `audience`(`audience_id`) ON DELETE CASCADE,
    FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`teacher_id`) ON DELETE CASCADE,
    FOREIGN KEY (`subject_in_schedule_id`) REFERENCES `subject_in_schedule`(`subject_in_schedule_id`) ON DELETE CASCADE,
    FOREIGN KEY (`lesson_type_id`) REFERENCES `lesson_type`(`lesson_type_id`) ON DELETE CASCADE
);
