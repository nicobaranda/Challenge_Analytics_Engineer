-- CREATE DATABASE Ecommerce

CREATE TABLE [Category] (
  [Category_ID] int,
  [Nombre] varchar(100),
  [Descripcion] varchar(100),
  [Categoria_Raiz] varchar(100),
  [Fecha_Creacion] date,
  [Estado] varchar(100),
  PRIMARY KEY ([Category_ID])
);

CREATE TABLE [Item] (
  [Item_ID] int,
  [Category_ID] int,
  [Nombre] varchar(100),
  [Descripcion] varchar(100),
  [Precio] float,
  [Condicion] varchar(100),
  [Estado] varchar(100),
  [Fecha_Creacion] date,
  [Fecha_Baja] date,
  PRIMARY KEY ([Item_ID])
);

CREATE TABLE [Customer] (
  [Customer_ID] int,
  [Nombre] varchar(100),
  [Apellido] varchar(100),
  [Email] varchar(100),
  [Telefono] int,
  [Direccion] varchar(100),
  [Sexo] varchar(100),
  [Fecha_Nacimiento] date,
  [Ciudad] varchar(100),
  [Fecha_Creacion] date,
  PRIMARY KEY ([Customer_ID])
);

CREATE TABLE [Orders] (
  [Order_ID] int,
  [Customer_ID] int,
  [Item_ID] int,
  [Fecha_Orden] datetime,
  [Precio] float,
  PRIMARY KEY ([Order_ID])
);

CREATE TABLE [Item_Activo] (
  [Item_ID] int,
  [Nombre] varchar(100),
  [Precio] float,
  [Estado] varchar(100),
  PRIMARY KEY ([Item_ID])
);