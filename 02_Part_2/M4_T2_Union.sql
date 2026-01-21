/* 
1) Carrega el CSV de nens i el CSV de nenes i crea una taula per cadascuna d'aquestes dades.

2) Fes una "union" de les dues taules.

3) Fes una "union all" de les mateixes taules i explica les diferències.

 */;

 -- 2) Fes una "union" de les dues taules.
 ;

 SELECT *
 FROM nenes
 UNION
 SELECT *
 FROM nens
 ORDER BY VEGADES DESC
 ;


-- 3) Fes una "union all" de les mateixes taules i explica les diferències.
;

 SELECT *
 FROM nenes
 UNION ALL
 SELECT *
 FROM nens
 ORDER BY VEGADES DESC
 ;

 /* La diferencia es que UNION ALL incluye todos los registros de las dos tablas en la UNION de la QUERY
 mientras que UNION no añade los registros con duplicado de la segunda parte de la QUERY.
 En este caso kai - 200
  */