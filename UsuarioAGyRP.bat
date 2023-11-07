@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script debe ejecutarse como administrador.
    pause
    exit /b
) 

net user
echo -------------------------------------------------------------------------------
echo.

set /p "actual=Ingresa el usuario a modificar: "
set /p "nuevo=Numero de agencia a configurar: "
set/p "rp=Ingresa la nueva contraseña del usuario redpagos: "

wmic useraccount where "Name='!actual!'" rename "AG!nuevo!"

if !errorlevel! equ 0 (
	net user "AG!nuevo!" /fullname:"AG!nuevo!" /comment:"AG!nuevo!"
	net user "AG!nuevo!" "!nuevo!"

	if !errorlevel! equ 0 (
        	echo El usuario, contraseña, nombre completo y descripcion se cambiaron a !nuevo! correctamente.
	) else (
        	echo Error al cambiar el nombre completo y la descripción.
    	)
) else (
	echo Error al cambiar el nombre de usuario.
)

net user redpagos !rp!

ren "C:\Users\!actual!" "AG!nuevo!"

rem Falta editar el registro\\


pause

endlocal