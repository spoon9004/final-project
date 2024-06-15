-- Удаляем все записи из таблиц, чтобы избежать дублирования при повторных запусках
DELETE FROM USER_ROLE;
DELETE FROM CONTACT;
DELETE FROM PROFILE;
DELETE FROM ACTIVITY;
DELETE FROM TASK;
DELETE FROM SPRINT;
DELETE FROM PROJECT;
DELETE FROM USERS;

-- Сбрасываем последовательности для таблиц, использующих их
ALTER SEQUENCE ACTIVITY_ID_SEQ RESTART WITH 1;
ALTER SEQUENCE TASK_ID_SEQ RESTART WITH 1;
ALTER SEQUENCE SPRINT_ID_SEQ RESTART WITH 1;
ALTER SEQUENCE PROJECT_ID_SEQ RESTART WITH 1;
ALTER SEQUENCE USERS_ID_SEQ RESTART WITH 1;

-- Вставляем данные

-- Вставляем пользователей
INSERT INTO USERS (ID, EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, DISPLAY_NAME)
VALUES (1, 'user@gmail.com', '{noop}password', 'userFirstName', 'userLastName', 'userDisplayName'),
       (2, 'admin@gmail.com', '{noop}admin', 'adminFirstName', 'adminLastName', 'adminDisplayName'),
       (3, 'guest@gmail.com', '{noop}guest', 'guestFirstName', 'guestLastName', 'guestDisplayName'),
       (4, 'manager@gmail.com', '{noop}manager', 'managerFirstName', 'managerLastName', 'managerDisplayName');

-- Вставляем роли пользователей
INSERT INTO USER_ROLE (USER_ID, ROLE)
VALUES (2, 'ADMIN'),
       (3, 'MANAGER'),
       (4, 'DEV');

-- Вставляем профили
INSERT INTO PROFILE (ID, LAST_FAILED_LOGIN, LAST_LOGIN, MAIL_NOTIFICATIONS)
VALUES (1, NULL, NULL, 49),
       (2, NULL, NULL, 14);

-- Вставляем контактные данные
INSERT INTO CONTACT (ID, CODE, VALUE)
VALUES (1, 'skype', 'userSkype'),
       (1, 'mobile', '+01234567890'),
       (1, 'website', 'user.com'),
       (2, 'github', 'adminGitHub'),
       (2, 'tg', 'adminTg');

-- Вставляем проекты
INSERT INTO PROJECT (ID, CODE, TITLE, DESCRIPTION, TYPE_CODE, PARENT_ID)
VALUES (1, 'PR1', 'PROJECT-1', 'test project 1', 'task_tracker', NULL),
       (2, 'PR2', 'PROJECT-2', 'test project 2', 'task_tracker', 1);

-- Вставляем спринты
INSERT INTO SPRINT (ID, STATUS_CODE, STARTPOINT, ENDPOINT, CODE, PROJECT_ID)
VALUES (1, 'finished', TIMESTAMP '2023-05-01 08:05:10', TIMESTAMP '2023-05-07 17:10:01', 'SP-1.001', 1),
       (2, 'active', TIMESTAMP '2023-05-01 08:06:00', NULL, 'SP-1.002', 1),
       (3, 'active', TIMESTAMP '2023-05-01 08:07:00', NULL, 'SP-1.003', 1),
       (4, 'planning', TIMESTAMP '2023-05-01 08:08:00', NULL, 'SP-1.004', 1),
       (5, 'active', TIMESTAMP '2023-05-10 08:06:00', NULL, 'SP-2.001', 2),
       (6, 'planning', TIMESTAMP '2023-05-10 08:07:00', NULL, 'SP-2.002', 2),
       (7, 'planning', TIMESTAMP '2023-05-10 08:08:00', NULL, 'SP-2.003', 2);

-- Вставляем задачи
INSERT INTO TASK (ID, TITLE, TYPE_CODE, STATUS_CODE, PROJECT_ID, SPRINT_ID, STARTPOINT)
VALUES (1, 'Data', 'epic', 'in_progress', 1, 1, TIMESTAMP '2023-05-15 09:05:10'),
       (2, 'Trees', 'epic', 'in_progress', 1, 1, TIMESTAMP '2023-05-15 12:05:10'),
       (3, 'task-3', 'task', 'ready_for_test', 2, 5, TIMESTAMP '2023-06-14 09:28:10'),
       (4, 'task-4', 'task', 'ready_for_review', 2, 5, TIMESTAMP '2023-06-14 09:28:10'),
       (5, 'task-5', 'task', 'todo', 2, 5, TIMESTAMP '2023-06-14 09:28:10'),
       (6, 'task-6', 'task', 'done', 2, 5, TIMESTAMP '2023-06-14 09:28:10'),
       (7, 'task-7', 'task', 'canceled', 2, 5, TIMESTAMP '2023-06-14 09:28:10');

-- Вставляем активности
INSERT INTO ACTIVITY (AUTHOR_ID, TASK_ID, UPDATED, COMMENT, TITLE, DESCRIPTION, ESTIMATE, TYPE_CODE, STATUS_CODE, PRIORITY_CODE)
VALUES (1, 1, TIMESTAMP '2023-05-15 09:05:10', NULL, 'Data', NULL, 3, 'epic', 'in_progress', 'low'),
       (2, 1, TIMESTAMP '2023-05-15 12:25:10', NULL, 'Data', NULL, NULL, NULL, NULL, 'normal'),
       (1, 1, TIMESTAMP '2023-05-15 14:05:10', NULL, 'Data', NULL, 4, NULL, NULL, NULL),
       (1, 2, TIMESTAMP '2023-05-15 12:05:10', NULL, 'Trees', 'Trees desc', 4, 'epic', 'in_progress', 'normal');

-- Вставляем принадлежность пользователей к объектам
INSERT INTO USER_BELONG (ID, OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE, STARTPOINT, ENDPOINT)
VALUES (1, 1, 2, 2, 'task_developer', TIMESTAMP '2023-06-14 08:35:10', TIMESTAMP '2023-06-14 08:55:00'),
       (2, 2, 2, 2, 'task_reviewer', TIMESTAMP '2023-06-14 09:35:10', NULL),
       (3, 3, 2, 1, 'task_developer', TIMESTAMP '2023-06-12 11:40:00', TIMESTAMP '2023-06-12 12:35:00'),
       (4, 4, 2, 1, 'task_developer', TIMESTAMP '2023-06-13 12:35:00', NULL),
       (5, 5, 2, 1, 'task_tester', TIMESTAMP '2023-06-14 15:20:00', NULL),
       (6, 6, 2, 2, 'task_developer', TIMESTAMP '2023-06-08 07:10:00', NULL),
       (7, 7, 2, 1, 'task_developer', TIMESTAMP '2023-06-09 14:48:00', NULL),
       (8, 8, 2, 1, 'task_tester', TIMESTAMP '2023-06-10 16:37:00', NULL);
