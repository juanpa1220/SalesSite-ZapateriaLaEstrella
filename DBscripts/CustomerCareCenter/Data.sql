INSERT INTO city(idCity, province, city, coordinates)
VALUES (1, 'Cartago', 'San Rafael', ST_GeomFromText('POINT(9.869835 -83.904305)')),
       (2, 'Cartago', 'Tejar', ST_GeomFromText('POINT(9.842911 -83.950090)')),
       (3, 'San Jose', 'San Pedro', ST_GeomFromText('POINT(9.934134 -84.052551)')),
       (4, 'San Jose', 'Sabana', ST_GeomFromText('POINT(9.935592 -84.100445)')),
       (5, 'Alajuela', 'Palmares', ST_GeomFromText('POINT(10.055801 -84.432867)')),
       (6, 'Alajuela', 'Alajuela', ST_GeomFromText('POINT(10.014725 -84.213462)'));



INSERT INTO `contact_type` (idContactType, `name`, `description`, `enable`)
VALUES (1, 'Telefono', 'Telefono Celular', 1),
       (2, 'Correo', 'Correo Electrónico', 1);

INSERT INTO `account_type`(idAccountType, `name`, `description`, `enable`)
VALUES (1, 'Admin Account', 'Cuenta de administrador', 1),
       (2, 'User Account', 'Cuenta de usuario', 1);

INSERT INTO `permission`(idPermission, `name`, `description`, `enable`)
VALUES (1, 'Admin', 'Admin full of permissions', 1),
       (2, 'User', 'User permissions', 1);

INSERT INTO `role`(idRole, `name`, `description`, `enable`)
VALUES (1, 'Admin', 'Admin full of permissions', 1),
       (2, 'User', 'User permissions', 1);

INSERT INTO `role_permission`(idPermission, idRolePermission, idRole, `enable`)
VALUES (1, 1, 1, 1),
       (2, 2, 2, 1);

INSERT INTO `user_contact`(idUserContact, idUser, idType, `value`, `enable`)
VALUES (1, 1, 1, '78080906', 1),
       (2, 2, 1, '71050807', 1),
       (3, 3, 1, '78074906', 1),
       (4, 4, 1, '70401020', 1);



INSERT INTO `permission`(idPermission, `name`, `description`, `enable`)
VALUES (3, 'Employee', 'Employee with Sale permissions', 1);

INSERT INTO `role`(idRole, `name`, `description`, `enable`)
VALUES (3, 'Employee', 'Employee with Sale permissions', 1);

INSERT INTO `role_permission`(idPermission, idRolePermission, idRole, `enable`)
VALUES (3, 3, 3, 1);

INSERT INTO `account_type`(idAccountType, `name`, `description`, `enable`)
VALUES (3, 'Employee account', 'Cuenta de empleado', 1);






