@echo off
setlocal enabledelayedexpansion

net user

rem Solicitar nombres de usuarios a eliminar
set "usuarios="
set /p "usuarios=Ingresa los nombres de usuario a borrar separados por un espacio (o deja en blanco para finalizar): "

rem Eliminar los usuarios ingresados
for %%u in (%usuarios%) do (
    net user %%u /delete
    if !errorlevel! equ 0 (
        echo El usuario %%u se ha eliminado con éxito.
    ) else (
        echo Error al eliminar el usuario %%u.
    )
)

pause

endlocal



