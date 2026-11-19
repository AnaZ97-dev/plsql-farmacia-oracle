Programación PL/SQL: Procedimientos, Funciones y Triggers (Oracle)
Proyecto de desarrollo de lógica de negocio directamente en la base de datos utilizando PL/SQL sobre un esquema relacional de una farmacia (Oracle Database).

Tecnologías y Herramientas
Motor de Base de Datos: Oracle Database 21c Express Edition (XE)
Herramienta de gestión: Oracle SQL Developer
Lenguaje: SQL y PL/SQL

Funcionalidades y Conceptos Aplicados
El script Zafra_Vallejo_Ana_BD_Tarea6.sql incluye la creación de objetos de programación avanzada:

1.Procedimientos Almacenados (Procedures):
listar_compras_cliente: Recorre las compras de un cliente usando Cursores Explícitos y formatea la salida por pantalla con RPAD y LPAD.
actualizar_salario_emp: Utiliza estructuras de control condicionales (IF-ELSIF-ELSE) para calcular un incremento salarial basado en el número de ventas del empleado, aplicando un UPDATE automático. Incluye manejo de excepciones (NO_DATA_FOUND).

2.Funciones (Functions):
gasto_cliente: Recibe el nombre de un cliente y devuelve su gasto total. Controla casos de error devolviendo -1 (no existe) o -2 (nombre duplicado). Se integra en una consulta SELECT global.

3.Disparadores (Triggers):
actualizar_stock_trg: Trigger de tipo AFTER INSERT en la tabla DETALLE. Actualiza automáticamente el stock del medicamento tras una venta y emite un aviso (DBMS_OUTPUT) si el stock cae por debajo de 5 unidades.

Cómo ejecutar el script
Abre Oracle SQL Developer y conéctate a tu base de datos (asegúrate de tener el esquema de Farmacia creado, ya que el script asume que las tablas existen).
Abre el archivo Zafra_Vallejo_Ana_BD_Tarea6.sql.
Importante: Ejecuta primero la sentencia SET SERVEROUTPUT ON; para poder ver los mensajes de la consola.
Ejecuta todo el script con el botón de "Run Script" (F5).
Los resultados de los DBMS_OUTPUT.PUT_LINE se verán en la pestaña "Script Output" de SQL Developer.
