# SQL Reference Guide

## Estructura Básica de Consultas

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1
LIMIT 10;
```

## Operadores Comunes

### Comparación
- `=` Igual
- `!=` o `<>` No igual
- `>` Mayor que
- `<` Menor que
- `>=` Mayor o igual
- `<=` Menor o igual

### Lógicos
- `AND` Ambas condiciones verdaderas
- `OR` Al menos una condición verdadera
- `NOT` Niega una condición

## Funciones de Agregación

```sql
COUNT(*)        -- Contar filas
SUM(column)     -- Suma
AVG(column)     -- Promedio
MIN(column)     -- Mínimo
MAX(column)     -- Máximo
```

## JOINS

```sql
-- INNER JOIN: Solo registros coincidentes
SELECT * FROM table1 INNER JOIN table2 ON table1.id = table2.id;

-- LEFT JOIN: Todos de table1 + coincidentes de table2
SELECT * FROM table1 LEFT JOIN table2 ON table1.id = table2.id;

-- RIGHT JOIN: Coincidentes de table1 + todos de table2
SELECT * FROM table1 RIGHT JOIN table2 ON table1.id = table2.id;

-- FULL JOIN: Todos de ambas tablas
SELECT * FROM table1 FULL JOIN table2 ON table1.id = table2.id;
```

## GROUP BY y HAVING

```sql
SELECT column, COUNT(*) as count
FROM table_name
GROUP BY column
HAVING COUNT(*) > 5;
```

## Subconsultas

```sql
SELECT * FROM table1
WHERE id IN (SELECT id FROM table2 WHERE condition);
```

---

Añade más referencias según avances en el curso.
