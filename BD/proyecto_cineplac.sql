-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-11-2018 a las 02:27:59
-- Versión del servidor: 10.1.25-MariaDB
-- Versión de PHP: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_cineplac`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bajaCliente` (IN `_dniCliente` INT)  BEGIN
UPDATE clientes
SET
	estado_cliente = 0
WHERE
	dni_cliente = _dniCliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bajaGeneroPeliculas` (IN `_codigoGP` INT)  BEGIN
	UPDATE generos_peliculas
    SET
    	estado = 0
     WHERE
     	cod_generopelicula = _codigoGP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bajaPeliculas` (IN `_codPelicula` INT)  BEGIN
	UPDATE peliculas
    SET
    	estado = 0
     WHERE
     	cod_pelicula = _codPelicula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bajaReservaciones` (IN `_codReservacion` INT, `_fechaHora` DATETIME, `_importeTotal` DECIMAL(18,2))  BEGIN
	UPDATE reservaciones
    SET
    	estado = 0
     WHERE
     	cod_reservacion = _codReservacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_bajaUsuario` (IN `_codUser` INT)  BEGIN
	UPDATE usuarios
    SET
    	estado_user = 0
     WHERE
     	cod_user = _codUser;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cargarGeneros` ()  NO SQL
BEGIN
	SELECT * FROM generos_peliculas WHERE estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarCliente` (IN `_dniCliente` CHAR(8), IN `_nombreCliente` VARCHAR(100), IN `_apellidosCliente` VARCHAR(100))  BEGIN

INSERT INTO clientes(cod_cliente, dni_cliente, nombre_cliente, apellidos_cliente, estado_cliente) VALUES(null, _dniCliente, _nombreCliente, _apellidosCliente, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarDetalleReservacion` (IN `_codReservacion` INT, IN `_codCliente` INT, IN `_codPelicula` INT, IN `_cantidad` INT, IN `_subTotal` DOUBLE)  BEGIN
	INSERT INTO detalle_reservaciones VALUES(_codReservacion, _codCliente, _codPelicula, _cantidad, _subTotal);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarGeneroPeliculas` (IN `_nombreGP` VARCHAR(100), IN `_descripcionGP` VARCHAR(300))  BEGIN
	INSERT INTO generos_peliculas VALUES(null, _nombreGP, _descripcionGP, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarPeliculas` (IN `_nombre` VARCHAR(200), IN `_duracion` TIME, IN `_descripcion` VARCHAR(500), IN `_stock` INT, IN `_codigo_generoPelicula` INT, IN `_precio` DOUBLE)  BEGIN
	INSERT INTO peliculas VALUES(null, _nombre, _duracion, _descripcion, _stock, _codigo_generoPelicula, _precio, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarReservaciones` (IN `_fechaHora` VARCHAR(20), IN `_importeTotal` DOUBLE(20,5))  BEGIN
	INSERT INTO reservaciones VALUES(null, _fechaHora, _importeTotal, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertarUsuario` (IN `_dniUser` CHAR(8), IN `_passwordUser` VARCHAR(100), IN `_perfilUser` VARCHAR(50), IN `_codCliente` INT)  BEGIN
	INSERT INTO usuarios VALUES(null, _dniUser, _passwordUser, _perfilUser, _codCliente, 1 );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_logueo` (IN `_usuario` CHAR(8), IN `_password` VARCHAR(100))  BEGIN
	SELECT dni_user, perfil FROM usuarios WHERE dni_user = _usuario and password_user = _password and estado_user = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_modificarCliente` (IN `_codCliente` INT, `_dniCliente` CHAR(8), `_nombreCliente` VARCHAR(100), `_apellidosCliente` VARCHAR(100))  BEGIN

UPDATE clientes
SET
	dni_Cliente = _dniCliente,
    nombre_cliente = _nombreCliente,
    apellidos_cliente = _apellidosCliente
WHERE
	cod_cliente = _codCliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_modificarGeneroPeliculas` (IN `_codigoGP` INT, `_nombreGP` VARCHAR(100), `_descripcionGP` VARCHAR(300))  BEGIN
	UPDATE generos_peliculas
    SET
    	nombre_gp = _nombreGP,
        descripcion_gp = _descripcionGP
     WHERE
     	cod_generopelicula = _codigoGP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_modificarPeliculas` (IN `_codPelicula` INT, `_nombre` VARCHAR(200), `_duracion` TIME, `_descripcion` VARCHAR(500), `_Stock` INT, `_precio` DECIMAL(18,2), `_codigo_generoPelicula` INT)  BEGIN
	UPDATE peliculas
    SET
    	nombre = _nombre,
        duracion = _duracion,
        descripcion = _descripcion,
        stock = _Stock,
        cod_generopelicula = _codigo_generoPelicula,
        precio = _precio
     WHERE
     	cod_pelicula = _codPelicula;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_modificarReservaciones` (IN `_codReservacion` INT, `_fechaHora` DATETIME, `_importeTotal` DECIMAL(18,2))  BEGIN
	UPDATE reservaciones
    SET
    	fecha_hora = _fechaHora,
        importe_total = _importeTotal
     WHERE
     	cod_reservacion = _codReservacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_modificarUsuario` (IN `_codUser` INT, `_dniUser` CHAR(8), `_passwordUser` VARCHAR(100), `_perfilUser` VARCHAR(50), `_codCliente` INT)  BEGIN
	UPDATE usuarios
    SET
    	dni_user = _dniUser,
        password_user = _passwordUser,
        perfil = _perfilUser,
        cod_cliente = _codCliente
     WHERE
     	cod_user = _codUser;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostarDatosCliente` ()  BEGIN
	SELECT * FROM clientes WHERE estado_cliente = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostarDatosUsuarios` ()  BEGIN
	SELECT * FROM usuarios WHERE estado_cliente = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarDatosGeneroPeliculas` (IN `_codigoGP` INT)  BEGIN
	SELECT * FROM generos_peliculas WHERE estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrarDatosPeliculas` ()  BEGIN
	SELECT p.cod_pelicula, p.nombre, p.duracion, p.descripcion, p.stock, gp.nombre_gp, p.precio, p.estado FROM peliculas P
    INNER JOIN generos_peliculas gp on p.cod_generopelicula = gp.cod_generopelicula
    WHERE p.estado = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cod_cliente` int(11) NOT NULL,
  `dni_cliente` char(8) NOT NULL,
  `nombre_cliente` varchar(100) NOT NULL,
  `apellidos_cliente` varchar(100) NOT NULL,
  `estado_cliente` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cod_cliente`, `dni_cliente`, `nombre_cliente`, `apellidos_cliente`, `estado_cliente`) VALUES
(1, '12345678', 'Naruto', 'Uzumaki', 1),
(2, '87654321', 'Itachi', 'Uchiha', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_reservaciones`
--

CREATE TABLE `detalle_reservaciones` (
  `cod_reservacion` int(11) NOT NULL,
  `cod_cliente` int(11) NOT NULL,
  `cod_pelicula` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos_peliculas`
--

CREATE TABLE `generos_peliculas` (
  `cod_generopelicula` int(11) NOT NULL,
  `nombre_gp` varchar(100) NOT NULL,
  `descripcion_gp` varchar(300) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `generos_peliculas`
--

INSERT INTO `generos_peliculas` (`cod_generopelicula`, `nombre_gp`, `descripcion_gp`, `estado`) VALUES
(1, 'Accion', 'Este tipo de película son de alta tensión y contienen persecuciones y muchas peleas, además de una dirección que pone énfasis en el movimiento. Incluyen rescates, batallas, escapadas, explosiones', 1),
(2, 'Aventuras', 'Estas películas cuentan historias interesantes y excitantes en contextos normalmente exóticos, y con un contenido similar al de las películas de acción', 1),
(3, 'Comedias', 'Las comedias son películas divertidas, construidas para que el espectador pase un rato divertido y no deje de reír.', 1),
(4, 'Dramaticas', 'Son películas serias, con personajes y situaciones muy realistas, parecidas a la vida cotidiana, que incluyen situaciones tensas y dramáticas, y que pueden acabar mal o no.', 1),
(5, 'Terror', 'Las películas de terror pretenden despertar nuestro miedo con escenas chocantes, tensas y terroríficas, o bien mediante una ambientación y una dirección que producen angustia. Las películas de terror pueden incluir personajes poco realistas.', 1),
(6, 'Ciencia ficcion', 'Giran en torno a situaciones fantásticas y, en muchos casos, futurísticas que pueden incluir o no viajes en el tiempo o tridimensionales.', 1),
(7, 'Musicales', 'Las películas musicales se caracterizan por tener escenas donde los actores bailan coreografías y cantan.', 1),
(8, 'Infantiles', 'Son películas para niños. Suelen incluir personajes mágicos y no no necesariamente son personas. Algunas películas son dibujos animados y contienen animales como personajes. Aunque sean para niños, algunos adultos también disfrutan de ellas.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas`
--

CREATE TABLE `peliculas` (
  `cod_pelicula` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `duracion` time NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `stock` int(11) NOT NULL,
  `cod_generopelicula` int(11) NOT NULL,
  `precio` double NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `peliculas`
--

INSERT INTO `peliculas` (`cod_pelicula`, `nombre`, `duracion`, `descripcion`, `stock`, `cod_generopelicula`, `precio`, `estado`) VALUES
(1, 'Chuky', '02:00:00', 'Pelicula de terror', 20, 5, 9, 1),
(2, 'Caida de la casa blanca', '01:43:00', 'Peliucula de Accion, destruccion d ela casa blanca a manos de terroritsas', 11, 1, 2.4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservaciones`
--

CREATE TABLE `reservaciones` (
  `cod_reservacion` int(11) NOT NULL,
  `fecha_hora` varchar(30) NOT NULL,
  `importe_total` double(20,5) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `cod_user` int(11) NOT NULL,
  `dni_user` char(8) NOT NULL,
  `password_user` varchar(100) NOT NULL,
  `perfil` varchar(50) NOT NULL,
  `cod_cliente` int(11) NOT NULL,
  `estado_user` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`cod_user`, `dni_user`, `password_user`, `perfil`, `cod_cliente`, `estado_user`) VALUES
(1, '12345678', 'admin1234', 'Administrador', 1, 1),
(2, '87654321', 'itachi1234', 'Cliente', 2, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cod_cliente`);

--
-- Indices de la tabla `detalle_reservaciones`
--
ALTER TABLE `detalle_reservaciones`
  ADD KEY `cod_reservacion` (`cod_reservacion`),
  ADD KEY `cod_cliente` (`cod_cliente`),
  ADD KEY `cod_pelicula` (`cod_pelicula`);

--
-- Indices de la tabla `generos_peliculas`
--
ALTER TABLE `generos_peliculas`
  ADD PRIMARY KEY (`cod_generopelicula`);

--
-- Indices de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD PRIMARY KEY (`cod_pelicula`),
  ADD KEY `cod_generopelicula` (`cod_generopelicula`);

--
-- Indices de la tabla `reservaciones`
--
ALTER TABLE `reservaciones`
  ADD PRIMARY KEY (`cod_reservacion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`cod_user`),
  ADD KEY `cod_cliente` (`cod_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cod_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `generos_peliculas`
--
ALTER TABLE `generos_peliculas`
  MODIFY `cod_generopelicula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  MODIFY `cod_pelicula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `reservaciones`
--
ALTER TABLE `reservaciones`
  MODIFY `cod_reservacion` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `cod_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_reservaciones`
--
ALTER TABLE `detalle_reservaciones`
  ADD CONSTRAINT `detalle_reservaciones_ibfk_1` FOREIGN KEY (`cod_reservacion`) REFERENCES `reservaciones` (`cod_reservacion`),
  ADD CONSTRAINT `detalle_reservaciones_ibfk_2` FOREIGN KEY (`cod_cliente`) REFERENCES `clientes` (`cod_cliente`),
  ADD CONSTRAINT `detalle_reservaciones_ibfk_3` FOREIGN KEY (`cod_pelicula`) REFERENCES `peliculas` (`cod_pelicula`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`cod_cliente`) REFERENCES `clientes` (`cod_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
