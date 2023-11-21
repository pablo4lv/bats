@echo off

>nul 2>&1 net session || (
    echo Este script debe ejecutarse como administrador.
    pause
    exit /b
)

setlocal enabledelayedexpansion

net user

rem Solicitar nombres de usuarios a eliminar
set "usuarios="
set /p "usuarios=Ingresa los nombres de usuario a borrar separados por un espacio (o deja en blanco para finalizar): "

rem Eliminar los usuarios ingresados
for %%u in (%usuarios%) do (
    net user "%%u" /delete
    if !errorlevel! equ 0 (
        rmdir /s /q "C:\Users\%%u"
        if !errorlevel! equ 0 (
            powershell -Command "Remove-Item -Path ('Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\' + (Get-WmiObject Win32_UserProfile | Where-Object { $_.LocalPath.Split('\\')[-1] -eq '%%u' }).SID) -Force"
            echo El usuario %%u se ha eliminado con éxito.
        ) else (
            echo Error al eliminar el perfil del usuario %%u.
        )
    ) else (
        echo Error al eliminar el usuario %%u.
    )
)

pause
endlocal




