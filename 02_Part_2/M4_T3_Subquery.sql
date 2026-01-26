/* 
TREBALLEM SOBRE LA Database Biblioteca

1)Quin és el nom de l'empleat (o dels empleats) i la seva posició, amb el mínim any de contractació?

2) Mostra el nom de la categoria i el nom del llibre (o llibres), dels llibres amb l'any de publicació més recent de cada categoria.

3) Mostra els llibres que tenen més còpies que la mitjana del nombre de còpies dels llibres de la seva categoria.

4) Quin és el nom del llibre i del seu autor, del llibre que té un import més gran en multes (comptant la suma de totes les multes de cada llibre)?
 */;

 -- 1)Quin és el nom de l'empleat (o dels empleats) i la seva posició, amb el mínim any de contractació?
;

SELECT 
    empleados.nombre,
    empleados.apellido,
    empleados.posicion
FROM 
    empleados
WHERE 
    empleados.año_contratacion = (
    SELECT MIN(empleados.año_contratacion)
    FROM empleados
    )   
;

-- 2) Mostra el nom de la categoria i el nom del llibre (o llibres), dels llibres amb l'any de publicació més recent de cada categoria.
;

SELECT categorias.nombre, libros.titulo, libros.año_publicacion
FROM libros
JOIN categorias ON libros.categoria_id = categorias.categoria_id
JOIN (
    SELECT libros.categoria_id, MAX (libros.año_publicacion) AS max_año_pub
    FROM libros
    GROUP BY libros.categoria_id
    ) AS max_año_cat
ON libros.categoria_id = max_año_cat.categoria_id
WHERE libros.año_publicacion = max_año_cat.max_año_pub
ORDER BY categorias.nombre
;

-- 3) Mostra els llibres que tenen més còpies que la mitjana del nombre de còpies dels llibres de la seva categoria.
;

SELECT  categorias.nombre AS nombre_categoria,
        libros.titulo AS nombre_libro,
        libros.cantidad_copias AS copias_libro,
        avg_categoria.avg_cat AS media_copias_categoria     
FROM libros
JOIN categorias ON libros.categoria_id = categorias.categoria_id
JOIN (
    SELECT libros.categoria_id, AVG (libros.cantidad_copias) AS avg_cat
    FROM libros
    GROUP BY libros.categoria_id
    ) AS avg_categoria
ON libros.categoria_id = avg_categoria.categoria_id
WHERE libros.cantidad_copias > avg_categoria.avg_cat
ORDER BY    nombre_categoria,
            copias_libro,
            nombre_libro
;

-- 4) Quin és el nom del llibre i del seu autor, del llibre que té un import més gran en multes (comptant la suma de totes les multes de cada llibre)?
;

SELECT  libros.titulo,
        autores.nombre,
        multas_libro.sum_multas
        
FROM libros
JOIN autores ON libros.autor_id = autores.autor_id
JOIN (
    SELECT prestamos.libro_id, SUM (multas.importe) AS sum_multas
    FROM prestamos
    JOIN multas ON prestamos.prestamo_id = multas.prestamo_id
    GROUP BY prestamos.libro_id
    ) AS multas_libro
ON libros.libro_id = multas_libro.libro_id



ORDER BY multas_libro.sum_multas DESC
LIMIT 1
;

