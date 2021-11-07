USE Workshop;

------------------------- CATEGORIAS -------------------------
INSERT INTO [dbo].Category(idCategory, name, description, enable)
VALUES (1, 'Sala',
        N'FurniTEC Desing líder en amueblamiento para el hogar y oficina en Costa Rica, pone a su disposición la más exclusiva línea de Muebles de Salas, Sofás, Mesas de Centro, Muebles de Bar y Muebles de TV.',
        1);
INSERT INTO [dbo].Category(idCategory, name, description, enable)
VALUES (2, 'Comedor',
        N'FurniTEC Desing líder en amueblamiento para el hogar y oficina en Costa Rica, pone a su disposición la más exclusiva línea de Muebles de Comedor, Mesas de Comedor, Barstools, Sillas y Bancos, Bufeteras.',
        1);
INSERT INTO [dbo].Category(idCategory, name, description, enable)
VALUES (3, 'Dormitorio',
        N'FurniTEC Desing líder en amueblamiento para el hogar y oficina en Costa Rica, pone a su disposición la más exclusiva línea de Mueble de Dormitorios, Mesas de Noche, Gaveteros y Camas',
        1);
INSERT INTO [dbo].Category(idCategory, name, description, enable)
VALUES (4, 'Oficina',
        N'FurniTEC Desing líder en amueblamiento para el hogar y oficina en Costa Rica, pone a su disposición la más exclusiva línea de Muebles de Oficina, Escritorios, Estanterías, Sillas de Oficina.',
        1);
INSERT INTO [dbo].Category(idCategory, name, description, enable)
VALUES (5, 'Exterior',
        N'FurniTEC Desing líder en amueblamiento para el hogar y oficina en Costa Rica, pone a su disposición la más exclusiva línea de Muebles de Exteriores, Terraza y Intemperie.',
        1);


------------------------- PRODUCTOS -------------------------
-- Productos de Sala
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (1, 1, N'Sofá Reclinable Vanessa', N'Medidas: 99X94X99cm Color: Café Claro y Gris Claro',
        'https://www.alteadesign.com/9594-large_default/sofa-reclinable-vanessa-tela.jpg', '2020-01-25', 200, 499, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (2, 1, N'Sofá Russi Gris', 'Medidas: 140 x 87 x 84 cm Material: Tela',
        'https://www.alteadesign.com/10492-large_default/sofa-russi-2-puestos-azul.jpg', '2020-01-25', $200, $489, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (3, 1, N'Sofá Russi Azul', 'Medidas 184 x 87 x 84 cm Material Tela',
        'https://www.alteadesign.com/10484-large_default/sofa-russi-3-puestos-azul.jpg', '2020-01-25', 250, 599, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (4, 1, N'Sofá Shell Velvet Gris',
        'Color: Gris marengo Material: Terciopelo y Madera Medidas: 126 x 73 x 72 cm Peso: 18 Kg',
        'https://www.alteadesign.com/13066-large_default/sofa-shell-velvet-gris-126x725x72cm.jpg', '2020-01-25', 240,
        519, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (5, 1, N'Sofá Cama Lia Izquierdo', 'Medidas: 219x130x85 cm Material: Tela',
        'https://www.alteadesign.com/10701-large_default/sofa-cama-lia-rojo-izquierda.jpg', '2020-01-25', 520, 1199, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (6, 1, 'Mueble Tv 4Caj. Fresno', 'Medidas: 120x40x46cm Material: Madera',
        'https://www.alteadesign.com/10306-large_default/mueble-tv-4-caj-fresno.jpg', '2020-01-25', 190, 439, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (7, 1, 'Mesa TV Melamina', 'Material: MELAMINA WENGE/ HG BLANCO Medidas: 173X40X50CM',
        'https://www.alteadesign.com/11783-large_default/mesa-tv-melamina.jpg', '2020-01-25', 210, 489, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (8, 1, 'Mesa De Centro Harvard', 'Medidas: 119.5x59.5x Material: Estructura en Metal y Melamina contrachapada',
        'https://www.alteadesign.com/10058-large_default/mesa-de-centro-harvard-.jpg', '2020-01-25', 194, 458, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (9, 1, 'Mesa Cedro Metal', 'Medidas: 47x42x45cm Material: Metal y Cedro',
        'https://www.alteadesign.com/10308-large_default/mesa-axiliar-de-cedro.jpg', '2020-01-25', 64, 149, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (10, 1, 'Mesa Consola 2C Fresno', 'Medidas: 110x40x78cm Material: Madera',
        'https://www.alteadesign.com/10304-large_default/mesa-consola-2c-fresno.jpg', '2020-01-25', 145, 329, 1);
-- Productos de Comedor
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (11, 2, 'Mesa Puro Plain',
        N'Muebles encantadores de la serie Puro, que impresiona con detalles amorosos y ornamentos artísticamente tallados a mano. El color brillante y natural le da un toque fresco y moderno.',
        'https://www.alteadesign.com/7035-large_default/mesa-puro-plain-160x80cm-.jpg', '2020-01-26', 420, 1179, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (12, 2, 'Mesa De Comedor Melodi', 'Material: Vidrio y Madera Medidas 180(50)x100x76cm',
        'https://www.alteadesign.com/10984-large_default/mesa-de-comedor-melodi.jpg', '2020-01-26', 730, 1699, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (13, 2, 'Silla Velvet Beige',
        N'Color: Beige y negro Material: Poliéster, espuma y acero Medidas: 48 x 59 x 81 cm Peso: 6 Kg',
        'https://www.alteadesign.com/13068-large_default/silla-velvet-beige-48x59x81cm.jpg', '2020-01-26', 75, 149, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (14, 2, 'Silla De Comedor Daniel',
        'Medida 43x50x98 cm Material: Polipiel Colores: Gris Claro, Gris Oscuro y Taupe Dark',
        'https://www.alteadesign.com/9663-large_default/silla-de-comedor-daniel.jpg', '2020-01-26', 64, 129, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (15, 2, N'Taburete Bar Blanco',
        N'Color: Blanco. Material: PU, nogal y acero. Medidas: Ø38,5x63cm.',
        'https://www.alteadesign.com/13061-large_default/taburete-bar-rdo-blanco-o385x63cm.jpg', '2020-01-26', 81, 149,
        1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (16, 2, 'Aparador Bajo X Factory', 'Medidas del producto Ancho: 160 cm Largo: 40 cm Alto: 56 cm',
        'https://www.alteadesign.com/10881-large_default/aparador-bajo-x-factory-2-puertas.jpg', '2020-01-26', 399,
        1029, 1);
-- Productos de Dormitorio
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (17, 3, 'Cama Karen King Beige', 'Material: tela Medidas: 193x200cm',
        'https://www.alteadesign.com/13239-large_default/cama-karen-queen-gris.jpg', '2020-01-27', 422, 998, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (18, 3, 'Mesa De Noche', 'Materiales: MELAMINA DARK WALNUT  Medidas: 45X39X42CM',
        'https://www.alteadesign.com/11795-large_default/mesa-de-noche.jpg', '2020-01-27', 48, 119, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (19, 3, 'Tocador Fresno Espejo',
        'Color: Beige y dorado Material: Madera, acero y espejo Medidas: 70 x 40 x 124 cm Peso: 15 Kg',
        'https://www.alteadesign.com/13047-large_default/tocador-1-c-fresno-espejo-70x40x124.jpg', '2020-01-27', 140,
        349, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (20, 3, 'Cama Emely King', 'Medidas: 193x200cm Material: Melamina Color: Wengue',
        'https://www.alteadesign.com/10908-large_default/cama-emely-matrimonial.jpg', '2020-01-27', 326, 779, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (21, 3, 'Cama Melbourne Queen', 'Medidas: 152x202x117cm Material: Madera',
        'https://www.alteadesign.com/13309-large_default/cama-melbourne-queen.jpg', '2020-01-27', 505, 1059, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (22, 3, 'Aparador Melamina', 'Materiales: MELAMINA WENGE/ HG BLANCO Medidas: 165X40X78CM',
        'https://www.alteadesign.com/11804-large_default/aparador-melamina.jpg', '2020-01-27', 260, 579, 1);
-- Productos de Oficina
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (23, 4, 'Estanteria Cuadr', 'Material: Madera y metal Medidas: 70 x 15 x 71 cm Peso: 8 Kg',
        'https://www.alteadesign.com/13124-large_default/estanteria-cuadr-mad-met70x15x71cm.jpg', '2020-01-28', 68, 149,
        1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (24, 4, 'Escritorio Melamina', '180X70X76cm',
        'https://www.alteadesign.com/6227-large_default/escritorio-lorenzo.jpg', '2020-01-28', 320, 559, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (25, 4, 'Silla Onyx Gris', 'Silla ejecutiva asientotela , respaldo malla , brazos ajustable, base negra Nylon',
        'https://www.alteadesign.com/13210-large_default/silla-onyx-verde.jpg', '2020-01-28', 430, 699, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (26, 4, 'Brooklyn Nature Escritorio', '110x40cm',
        'https://www.alteadesign.com/11459-large_default/brooklyn-nature-escritorio-laptop-110x40cm.jpg', '2020-01-28',
        400, 919, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (27, 4, N'Estantería Zick Zack',
        N'Esta unidad de estante original muestra que descomponer las formas convencionales puede ser irresistible con sus esquinas y bordes, Zick Zack le da a su habitación un carácter individual',
        'https://www.alteadesign.com/6386-large_default/estanteria-authentico-zick-zack.jpg', '2020-01-28', 390, 795,
        1);
-- Productos de Exterior
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (28, 5, 'Mesa De Comedor Teak Exterior', 'Medidas: 220x92cm Material: Lisbon',
        'https://www.alteadesign.com/13363-large_default/mesa-teak-.jpg', '2020-01-29', 795, 1519, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (29, 5, 'Silla Lounge Dala', N'Medidas: 96x97x78cm Material: Aluminio y Ratán',
        'https://www.alteadesign.com/10569-large_default/silla-lounge-dala.jpg', '2020-01-29', 420, 859, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (30, 5, 'Silla Alu Exterior', N'Metarial: Aluminio Color: Carbón',
        'https://www.alteadesign.com/13358-large_default/silla-alu-exterior.jpg', '2020-01-29', 78, 129, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (31, 5, 'Estanteria De Plantas', 'Medidas: 60x40x140cm Material: Madera',
        'https://www.alteadesign.com/8713-large_default/estanteria-plantas-madera.jpg', '2020-01-29', 55, 139, 1);
INSERT INTO [dbo].Product(idProduct, idCategory, name, description, photo, manufacturingDate, productionCost, finalCost,
                          enable)
VALUES (32, 5, 'Silla Exterior Texas', 'Medidas: 60x59x75cm Material: Aluminio',
        'https://www.alteadesign.com/10398-large_default/silla-exterior-texas.jpg', '2020-01-29', 168, 379, 1);


-- Subsidiary

INSERT INTO Subsidiary (idSubsidiary, name, address, provincia)
VALUES (1, 'Sucursal Cartago', geography::Point(9.876913, -83.903645, 4326), 'Cartago')


-----------


USE [Workshop]
GO

INSERT INTO [dbo].[Product]
( [idProduct]
, [idCategory]
, [name]
, [description]
, [photo]
, [manufacturingDate]
, [productionCost]
, [finalCost]
, [enable])
VALUES (6, 3, 'Cama Individual', 'Cama de 1x1.5 metros con acabado de yipson',
        'https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/b0a55a6bc5da505f12fc291d1ff66806/4/2/4201010620.jpg',
        '2018-01-06', 275,
        325, 1),
       (7, 4, 'Silla de escritorio Raptor', 'Silla de oficina ortopédica para posicion de espalda',
        'https://media.nidux.net/pull/800/599/3190/93759_product_5b282ed5dd3aealt%20%20silla-oficina-elegante-moderna-cuero-negro.jpg',
        '2020-02-26', 175,
        250, 1),
       (8, 4, 'Escritorio de madera', 'Escritorio con madera de pino y acabados en marmol',
        'https://i.pinimg.com/564x/f7/ca/52/f7ca52a3002207bf1b0f42028e38a5a0.jpg', '2017-08-06', 750,
        1075, 1),
       (9, 5, 'Trampolin de exterior', 'Trampolin 5x5 metros para niños',
        'https://images-na.ssl-images-amazon.com/images/I/61bBT06psFL._AC_SX425_.jpg', '2019-07-06', 368,
        500, 1)
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------


USE [Workshop]
GO

INSERT INTO [dbo].[Subsidiary]
( [idSubsidiary]
, [name]
, [address]
, [provincia])
VALUES (1, 'FurniTEC Cartago', geography::Point(0.000237, 5.000084, 4326), 'Cartago'),
       (2, 'FurniTEC San Jose', geography::Point(5.000754, 0.000069, 4326), 'San Jose'),
       (3, 'FurniTEC Alajuela', geography::Point(10.000575, 5.000294, 4326), 'Alajuela')
GO


-----------------------------------------------------------------------------------------------------------------------------------------------


USE [Workshop]
GO

INSERT INTO [dbo].[Stock]
( [idStock]
, [idProduct]
, [idSubsidiary]
, [quantity])
VALUES (1, 1, 1, 32),
       (2, 2, 1, 15),
       (3, 3, 1, 16),
       (4, 4, 1, 12),
       (5, 5, 1, 3),
       (6, 6, 1, 14),
       (7, 7, 1, 17),
       (8, 8, 1, 2),
       (9, 9, 1, 22),
       (10, 10, 1, 13),
       (11, 11, 1, 32),
       (12, 12, 1, 16),
       (13, 13, 1, 18),
       (14, 14, 1, 39),
       (15, 15, 1, 12),
       (16, 16, 1, 1),
       (17, 17, 1, 14),
       (18, 18, 1, 32),
       (19, 19, 1, 36),
       (20, 20, 1, 14),
       (21, 21, 1, 14),
       (22, 22, 1, 12),
       (23, 23, 1, 32),
       (24, 24, 1, 0),
       (25, 25, 1, 23),
       (26, 26, 1, 54),
       (27, 27, 1, 0),
       (28, 28, 1, 12),
       (29, 29, 1, 5),
       (30, 30, 1, 9),
       (31, 31, 1, 9),
       (32, 32, 1, 2)
GO
INSERT INTO [dbo].[Stock]
( [idStock]
, [idProduct]
, [idSubsidiary]
, [quantity])
VALUES (33, 1, 2, 32),
       (34, 2, 2, 15),
       (35, 3, 2, 16),
       (36, 4, 2, 12),
       (37, 5, 2, 3),
       (38, 6, 2, 14),
       (39, 7, 2, 17),
       (40, 8, 2, 2),
       (41, 9, 2, 22),
       (42, 10, 2, 13),
       (43, 11, 2, 32),
       (44, 12, 2, 16),
       (45, 13, 2, 18),
       (46, 14, 2, 39),
       (47, 15, 2, 12),
       (48, 16, 2, 1),
       (49, 17, 2, 14),
       (50, 18, 2, 32),
       (51, 19, 2, 36),
       (52, 20, 2, 14),
       (53, 21, 2, 14),
       (54, 22, 2, 12),
       (55, 23, 2, 32),
       (56, 24, 2, 0),
       (57, 25, 2, 23),
       (58, 26, 2, 54),
       (59, 27, 2, 0),
       (60, 28, 2, 12),
       (61, 29, 2, 5),
       (62, 30, 2, 9),
       (63, 31, 2, 9),
       (64, 32, 2, 2)
GO
INSERT INTO [dbo].[Stock]
( [idStock]
, [idProduct]
, [idSubsidiary]
, [quantity])
VALUES (65, 1, 3, 32),
       (66, 2, 3, 15),
       (67, 3, 3, 16),
       (68, 4, 3, 12),
       (69, 5, 3, 3),
       (70, 6, 3, 14),
       (71, 7, 3, 17),
       (72, 8, 3, 2),
       (73, 9, 3, 22),
       (74, 10, 3, 13),
       (75, 11, 3, 32),
       (76, 12, 3, 16),
       (77, 13, 3, 18),
       (78, 14, 3, 39),
       (79, 15, 3, 12),
       (80, 16, 3, 1),
       (81, 17, 3, 14),
       (82, 18, 3, 32),
       (83, 19, 3, 36),
       (84, 20, 3, 14),
       (85, 21, 3, 14),
       (86, 22, 3, 12),
       (87, 23, 3, 32),
       (88, 24, 3, 0),
       (89, 25, 3, 23),
       (90, 26, 3, 54),
       (91, 27, 3, 0),
       (92, 28, 3, 12),
       (93, 29, 3, 5),
       (94, 30, 3, 9),
       (95, 31, 3, 9),
       (96, 32, 3, 2)
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO [dbo].[ContactType]
( [idContactType]
, [name]
, [description]
, [enable])
VALUES (1, 'Numero telefonico', 'Contacto via llamada y whatsapp', 1),
       (2, 'Correo electronico', 'Contacto via correo electronico', 1),
       (3, 'Instagram', 'Contacto via instagram', 1)

-------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO [dbo].[SubsidiaryContact]
( [idSubsidiaryContact]
, [idSubsidiary]
, [idTypeContact]
, [contact]
, [enable])
VALUES (1, 1, 1, '70708989', 1),
       (2, 1, 2, 'furcartago@gmail.com', 1),
       (3, 1, 3, 'FurTEC_CAR', 1),
       (4, 2, 1, '70769989', 1),
       (5, 2, 2, 'fursj@gmail.com', 1),
       (6, 3, 1, '70148989', 1),
       (7, 3, 2, 'furalj@gmail.com', 1),
       (8, 3, 3, 'FurTEC_ALJ', 1)
GO

--------------------------------------------------------------------------------------------------------------------------------------------------

USE [Workshop]
GO

INSERT INTO [dbo].[Employee]
( [idEmployee]
, [idSubsidiary]
, [user]
, [photo])
VALUES (1, 1, 4, 'https://www.trecebits.com/wp-content/uploads/2019/02/Persona-1-445x445.jpg'),
       (2, 1, 6, 'https://laboratoriosniam.com/wp-content/uploads/2018/07/michael-dam-258165-unsplash_WEB2.jpg'),
       (3, 2, 8, 'https://laboratoriosniam.com/wp-content/uploads/2018/07/personas-felices-tiempoparasimismos.jpg'),
       (4, 2, 10, 'https://laboratoriosniam.com/wp-content/uploads/2018/07/personas-felices-quimica.jpg'),
       (5, 3, 12, 'https://www.trecebits.com/wp-content/uploads/2019/02/Persona-1-445x445.jpg'),
       (6, 3, 14, 'https://www.trecebits.com/wp-content/uploads/2019/02/Persona-1-445x445.jpg')
GO
--------------------------------------------------------------------------------------------------------------------------------------------------

USE [Workshop]
GO

INSERT INTO [dbo].[Job]
( [idJob]
, [name]
, [description]
, [enable])
VALUES (1, 'Gerente General', 'Gerente general de tienda', 1),
       (2, 'Vendedor', 'Vendedor de zona', 1),
       (3, 'Repartidor', 'Mensajeria delivery', 1),
       (5, 'Mantenimiento', 'Servicio de mantenimiento a muebles', 1)

GO


USE [Workshop]
GO


INSERT INTO [dbo].[Contract]
( [idContract]
, [idEmployee]
, [idJob]
, [file]
, [baseSalary]
, [admissionDate])
VALUES (1, 1, 1, 'Contract', 2500, '2017-02-03'),
       (2, 2, 1, 'Contract', 2500, '2017-02-03'),
       (3, 3, 2, 'Contract', 2500, '2017-02-03'),
       (4, 4, 3, 'Contract', 2500, '2017-02-03'),
       (5, 5, 1, 'Contract', 2500, '2017-02-03'),
       (6, 6, 2, 'Contract', 2500, '2017-02-03')
GO

----------------------------

-- Empleados
EXEC create_account
     @p_name = 'Juan',
     @p_lastname = 'Brenes',
     @p_birthdate = '1980-8-15',
     @p_address= 'Tejar',
     @p_email='jbrenes@gmail.com',
     @p_username = 'jbrenes',
     @p_password = 'jbrenes';
EXEC create_account
     @p_name = 'Pablo',
     @p_lastname = 'Martinez',
     @p_birthdate = '1980-8-16',
     @p_address= 'San Rafael',
     @p_email='pmartinez@gmail.com',
     @p_username = 'pmartinez',
     @p_password = 'pmartinez';
EXEC create_account
     @p_name = 'Maria',
     @p_lastname = 'Rojas',
     @p_birthdate = '1980-8-14',
     @p_address= 'San Pedro',
     @p_email='mrojas@gmail.com',
     @p_username = 'mrojas',
     @p_password = 'mrojas';
EXEC create_account
     @p_name = 'Alexander',
     @p_lastname = 'Campos',
     @p_birthdate = '1980-8-15',
     @p_address= 'Sabana',
     @p_email='acampos@gmail.com',
     @p_username = 'acampos',
     @p_password = 'acampos';
EXEC create_account
     @p_name = 'Danilo',
     @p_lastname = 'Lopez',
     @p_birthdate = '1980-8-18',
     @p_address= 'Palmares',
     @p_email='dlopez@gmail.com',
     @p_username = 'dlopez',
     @p_password = 'dlopez';
EXEC create_account
     @p_name = 'Maribel',
     @p_lastname = 'Ulloa',
     @p_birthdate = '1980-8-15',
     @p_address= 'Alajuela',
     @p_email='mulloa@gmail.com',
     @p_username = 'mulloa',
     @p_password = 'mulloa';


-- Usuarios
EXEC create_account
     @p_name = 'Gustavo',
     @p_lastname = 'Torres',
     @p_birthdate = '1980-8-16',
     @p_address= 'Tejar',
     @p_email='gtorres@gmail.com',
     @p_username = 'gtorres',
     @p_password = 'gtorres';
EXEC create_account
     @p_name = 'Siany',
     @p_lastname = 'Hidalgo',
     @p_birthdate = '1980-8-16',
     @p_address= 'San Rafael',
     @p_email='shidalgo@gmail.com',
     @p_username = 'shidalgo',
     @p_password = 'shidalgo';
EXEC create_account
     @p_name = 'Joseph',
     @p_lastname = 'Salas',
     @p_birthdate = '1980-8-14',
     @p_address= 'San Pedro',
     @p_email='jsalas@gmail.com',
     @p_username = 'jsalas',
     @p_password = 'jsalas';
EXEC create_account
     @p_name = 'Paulo',
     @p_lastname = 'Zuniga',
     @p_birthdate = '1980-8-15',
     @p_address= 'Sabana',
     @p_email='pzuniga@gmail.com',
     @p_username = 'pzuniga',
     @p_password = 'pzuniga';
EXEC create_account
     @p_name = 'Jefferson',
     @p_lastname = 'Lezcano',
     @p_birthdate = '1980-8-18',
     @p_address= 'Palmares',
     @p_email='jlezcano@gmail.com',
     @p_username = 'jlezcano',
     @p_password = 'jlezcano';
EXEC create_account
     @p_name = 'Julia',
     @p_lastname = 'Quesada',
     @p_birthdate = '1980-8-15',
     @p_address= 'Alajuela',
     @p_email='jquesada@gmail.com',
     @p_username = 'jquesada',
     @p_password = 'jquesada';




---------------------------

EXEC RegisterPurchase @user = 12,
     @subsidiary= 3,
     @products = '27:2_28:1_12:1',
     @coupon= '3.5',
     @idEmployee = 2,
     @delivery = 1;

EXEC RegisterPayment @amount = 1530,
     @idPaymentMethod= 1,
     @idSubsidiary = 3;