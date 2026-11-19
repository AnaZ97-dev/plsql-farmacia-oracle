/********************************
 * SALIDA POR PANTALLA
 ********************************/

SET SERVEROUTPUT ON;

/**************
 * APARTADO A
 **************/
 
 CREATE OR REPLACE PROCEDURE listar_compras_cliente (p_cod_cliente IN CLIENTE.Codigo%TYPE) AS
    -- Declaración de variables y cursor.
    v_existe NUMBER;
    v_ventas NUMBER;
    
    CURSOR c_compras IS
        SELECT m.Codigo, m.nombre, m.pvp, d.unidades
        FROM VENTA v
        JOIN DETALLE d ON v.id_venta = d.id_venta
        JOIN MEDICAMENTO m ON d.Codigo_medicamento = m.Codigo
        WHERE v.Codigo_cliente = p_cod_cliente
        ORDER BY m.Codigo;

    r_compra c_compras%ROWTYPE;

BEGIN
    -- Se comprueba si el cliente existe.
    SELECT COUNT(*) INTO v_existe FROM CLIENTE WHERE Codigo = p_cod_cliente;
    
    IF v_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('El cliente no está dado de alta.');
    ELSE
        -- Se comrpueba si tiene compras.
        SELECT COUNT(*) INTO v_ventas FROM VENTA WHERE Codigo_cliente = p_cod_cliente;
        
        IF v_ventas = 0 THEN
            DBMS_OUTPUT.PUT_LINE('El cliente no ha realizado ninguna venta.');
        ELSE
            -- Cabecera.
            DBMS_OUTPUT.PUT_LINE('El cliente con código: ' || p_cod_cliente || ' ha comprado los siguientes medicamentos: ');
            DBMS_OUTPUT.PUT_LINE(RPAD('CÓDIGO', 10) || RPAD('NOMBRE', 30) || LPAD('PRECIO', 10) || LPAD('UNIDADES', 15));
            DBMS_OUTPUT.PUT_LINE(RPAD('-', 65, '-'));
            
            OPEN c_compras;
            FETCH c_compras INTO r_compra;
            
            WHILE c_compras%FOUND LOOP
                DBMS_OUTPUT.PUT_LINE(
                    RPAD(r_compra.Codigo, 10) ||
                    RPAD(r_compra.nombre, 30) ||
                    LPAD(REPLACE(TO_CHAR(r_compra.pvp, '990.99'), '.', ','), 10) || 
                    LPAD(r_compra.unidades, 15)
                );
                FETCH c_compras INTO r_compra;
            END LOOP;
            
            CLOSE c_compras;
        END IF;
    END IF;
END;
/

-- Caso 1: Cliente que no existe.
EXEC listar_compras_cliente(9999);

-- Caso 2: Cliente que existe pero no tiene ventas.
EXEC listar_compras_cliente(1017);

-- Caso 3: Cliente con ventas.
EXEC listar_compras_cliente(1009);


/**************
 * APARTADO B
 **************/
 
 CREATE OR REPLACE PROCEDURE actualizar_salario_emp (p_cod_emp IN EMPLEADO.cod_empleado%TYPE) IS
    v_nombre EMPLEADO.nombre%TYPE;
    v_salario EMPLEADO.salarioBase%TYPE;
    v_num_ventas NUMBER;
    v_porcentaje NUMBER;
    v_incremento DECIMAL(10,2);
    v_nuevo_salario EMPLEADO.salarioBase%TYPE;
BEGIN
    -- Se obtienen los datos del empleado y se cuentan sus ventas.
    -- Se usa LEFT JOIN por si el empleado no tiene ventas (devolverá 0).
    SELECT e.nombre, e.salarioBase, COUNT(v.id_venta)
    INTO v_nombre, v_salario, v_num_ventas
    FROM EMPLEADO e
    LEFT JOIN VENTA v ON e.cod_empleado = v.cod_empleado
    WHERE e.cod_empleado = p_cod_emp
    GROUP BY e.nombre, e.salarioBase;

    -- Se determina el porcentaje según los tramos pedidos.
    IF v_num_ventas < 5 THEN
        v_porcentaje := 5;
    ELSIF v_num_ventas >= 5 AND v_num_ventas <= 10 THEN
        v_porcentaje := 10;
    ELSE
        v_porcentaje := 15;
    END IF;

    -- Cálculos.
    v_incremento := v_salario * (v_porcentaje / 100);
    v_nuevo_salario := v_salario + v_incremento;

    -- Se actualiza el salario en la base de datos.
    UPDATE EMPLEADO
    SET salarioBase = v_nuevo_salario
    WHERE cod_empleado = p_cod_emp;

    -- Se muestran los resultados.
    DBMS_OUTPUT.PUT_LINE('Nombre Empleado: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Salario Base: ' || v_salario);
    DBMS_OUTPUT.PUT_LINE('Ventas realizadas: ' || v_num_ventas);
    DBMS_OUTPUT.PUT_LINE('Porcentaje % incremento salario: ' || v_porcentaje || '%');
    DBMS_OUTPUT.PUT_LINE('Salario Base actualizado: ' || v_nuevo_salario);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: El empleado no existe.');
END;
/

-- Prueba con un empleado.
EXEC actualizar_salario_emp(5);

-- Prueba con otro empleado distinto.
EXEC actualizar_salario_emp(7);

/**************
 * APARTADO C
 **************/
 
CREATE OR REPLACE FUNCTION gasto_cliente (p_nombre_cliente IN VARCHAR2) 
RETURN NUMBER AS
    v_count NUMBER;
    v_total NUMBER := 0;
    v_cod_cliente CLIENTE.Codigo%TYPE;
BEGIN
    -- Se cuenta cuantos clientes se llaman exactamente asi
    SELECT COUNT(*) INTO v_count
    FROM CLIENTE
    WHERE nombre = p_nombre_cliente;

    -- Se controlan las casuisticas de la tarea
    IF v_count = 0 THEN
        RETURN -1; -- No hay ningun cliente con ese nombre
    ELSIF v_count > 1 THEN
        RETURN -2; -- Hay mas de un cliente con ese nombre
    ELSE
        -- Si solo hay 1 cliente, se obtiene su codigo
        SELECT Codigo INTO v_cod_cliente
        FROM CLIENTE
        WHERE nombre = p_nombre_cliente;

        -- Se calcula la suma del gasto con NVL para evitar nulos
        SELECT NVL(SUM(d.unidades * m.pvp), 0)
        INTO v_total
        FROM VENTA v
        JOIN DETALLE d ON v.id_venta = d.id_venta
        JOIN MEDICAMENTO m ON d.Codigo_medicamento = m.Codigo
        WHERE v.Codigo_cliente = v_cod_cliente;

        RETURN v_total;
    END IF;
END;
/

-- Probar la función en una consulta SELECT global.
SELECT 
    codigo AS "CODIGO", 
    nombre AS "NOMBRE", 
    REPLACE(TO_CHAR(gasto_cliente(nombre), '999990D99'), '.', ',') AS "IMPORTE_TOTAL(NOMBRE)"
FROM CLIENTE;

/**************
 * APARTADO D
 **************/

CREATE OR REPLACE TRIGGER actualizar_stock_trg
AFTER INSERT ON DETALLE
FOR EACH ROW
DECLARE
    v_stock_actual NUMBER;
    v_nombre_med VARCHAR2(100);
BEGIN
    -- Se actualiza el stock restando las unidades que se acaban de insertar.
    UPDATE MEDICAMENTO
    SET stock = stock - :NEW.unidades
    WHERE Codigo = :NEW.Codigo_medicamento;

    -- Se obtiene el nuevo stock y el nombre del medicamento para comprobar si hay que lanzar el aviso.
    SELECT stock, nombre INTO v_stock_actual, v_nombre_med
    FROM MEDICAMENTO
    WHERE Codigo = :NEW.Codigo_medicamento;

    -- Si quedan menos de 5 unidades, se muestra el aviso.
    IF v_stock_actual < 5 THEN
        DBMS_OUTPUT.PUT_LINE('AVISO: Quedan menos de 5 unidades del medicamento ''' || v_nombre_med || ''', debería reponer.');
    END IF;
END;
/

-- Primero, se consulta el stock de un medicamento para saber cómo está.
SELECT Codigo, nombre, stock FROM MEDICAMENTO WHERE Codigo = 313;

-- Se inserta una nueva venta de prueba.
INSERT INTO VENTA (id_venta, fecha_hora, cod_empleado, Codigo_cliente) 
VALUES (999, SYSDATE, 1, 1001);

-- Se inserta un detalle que baje el stock del 313 a menos de 5.
INSERT INTO DETALLE (id_venta, Codigo_medicamento, unidades) 
VALUES (999, 313, 47);

-- En el momento de la ejecución del INSERT en detalle, saltará el aviso del DBMS_OUTPUT.
-- Se comprueba que ha bajado el stock.
SELECT Codigo, nombre, stock FROM MEDICAMENTO WHERE Codigo = 313;
 