# Proyecto_Final_Curso_Data_Engineering
Proyecto final del Curso de Data Egineering 2024 - Cívica

# Capa Bronze 

## Fuente de los datos

La ingesta de las tablas a la base de datos se ha realizado de forma manual mediante la interfaz de Snowflake. Cabe mencionar que, en algunas tablas, Snowflake ha renombrado de forma automática ciertas columnas para sustituir los espacios por guiones.

La información se obtuvo de la plataforma Kaggle a excepción de la tabla de agencias, que ha sido generada manualmente a partir de una tabla obtenida de una web relacionada. Todas las tablas se han insertado en formato CSV estructurado.

![Bronze](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/908caf2d-c43a-4840-9d01-191b0fe0ba36)

# Capa Silver

## Bases

- Renombrado de columnas
- Descarte de columnas
- Transformaciones puntuales concretas

![DAG_bases](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/d1d1d29a-5c85-42b5-9ecc-6e9c6895d114)

## Snapshot

El objetivo de la snapshot es historificar la información de los cochetes, ya que contienen muchos parámetros que pueden cambiar con los diferentes modelos, e interesa mantener un registro de cómo eran antes del momento actual de la consulta.

*Nota: la dimensión que deriva de esta snapshot no mantiene el histórico para asegurar la unicidad de cada registro en la misma.*

## Stages

En este punto del proceso, surgen entidades nuevas que terminarán derivando en dimensiones. Además, el grueso del procesado de los datos se ha realizado en esta altura de la capa Silver. Entre otras, que se mencionan al final de la explicación del modelado, se han realizado las siguientes transformaciones:

- Ajuste de formato de las direcciones mediante macro propia, mencionada más adelante
- Generación de claves primarias mediante la función *generate_surrogate_key* del paquete *dbt_utils*
- *Casteos* que implican algún tipo de formateo de cadenas de caracteres
- Separación de las tablas originales

![DAG_stgs](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/3410a2b5-4712-4c56-aa4b-72a0ec8ac6f8)

#### Macro para formatear las direcciones

El formato original de las direcciones es uno de los siguientes: 

- {Dirección, Lugar, Estado (para EU), País}
- {Dirección, Lugar, País}
- {Lugar, País}

![Macro](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/c87f4283-7169-4a44-ae12-d1676c9dca73)

## Intermediate

En esta capa, algunos de los *stgs* debían combinarse para poder formar la tabla de hechos al final del modelo. Esto se debe a que la granularidad de la misma está a dos niveles distintos: grano astronauta (más fino) y grano misión (más grueso). Esta capa existe para poder obtener la tabla final de forma adecuada.

![DAG_int](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/1fae9032-d353-49a6-beec-a9ca0f717d54)

# Capa Gold

## Core y marts

En esta capa, el modelo toma su forma final. De las capas Stages e Intermediate, surgen lo que finalmente son las dimensiones del modelo y la tabla de hechos final, las cuales se pueden ver en el DAG más adelante. Por otra parte, En el directorio /core de la capa Gold, se encuentran las dimensiones de uso común. Entre ellas, la de estado de cohete o la de tiempo. Esta última se ha generado mediante el paquete *dbt_date*, que genera una tabla con información a diferente granularidad entre una fecha y otra.

![DAG](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/73a30e56-a058-4c84-a0bc-89cfdd4f0b3a)

# Documentación y Tests

## Tests

En cuanto a la parte de *testing*, he aplicado tests genéricos para comprobar que las claves primarias cumplen ciertos requisitos mínimos y que se cumple la integridad relacional entre la tabla de hechos y las dimensiones. No he requerido ningún test unitario. 

Por otra parte, he empleado el paquete *dbt_project_evaluator*, que realiza ciertas comprobaciones de buenas prácticas mediante la creación de modelos propios que lanzan determinadas consultas a Snowflake.

![build](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/01d9d730-e361-40ce-b952-87775bcd240b)

## Documentación

Para documentar el proyecto, he añadido descripciones a cada uno de los campos de las tablas del modelo en los archivos de configuración (ficheros .yml). En caso de los campos que pueden contener varios valores, he empleado un fichero en formado Markdown (.md) para crear sus especificaciones.

![Doc_md](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/47c53052-66ea-459f-b611-22fbe03c8057)

#### Resultado en la documentación de DBT (dbt docs generate)

![Doc_md_res](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/fdf69feb-1e79-45b0-b4e0-56b1d5b7703f)

## Creación de los ficheros de configuración

Para crear los ficheros de configuración de los modelos, he empleado el paquete *codegen*, que permite automatizar el proceso y agilizar así el trabajo. Las descripciones y los tests deben ser añadidos manualmente. En el fichero de la siguiente imagen, basta con compilar cada fragmento para obtener el resultado deseado en consola.

![Code_gen](https://github.com/ArturoAcf/Proyecto_Final_Curso_Data_Engineering/assets/93375380/a1dd051e-b175-4808-a877-f5249cf94047)

# Comprobaciones finales

## Modelo incremental

https://www.youtube.com/watch?v=7qAHw_PU6Fk&ab_channel=ArturoAc

## Snapshot

https://www.youtube.com/watch?v=BEce1CWOkCc&ab_channel=ArturoAc
