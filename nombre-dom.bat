@echo off
setlocal

set /p "nuevo_nombre=Ingrese el nuevo nombre del equipo: "

netdom renamecomputer %COMPUTERNAME% /NewName:%nuevo_nombre% /Force

powershell -Command "$username = Read-Host -Prompt 'Ingrese el nombre de usuario'; $password = Read-Host -Prompt 'Ingrese la contraseña' -AsSecureString; $credential = New-Object System.Management.Automation.PSCredential($username, $password); Start-Process cmd -ArgumentList '/C netdom join %COMPUTERNAME% /domain:redpagos.local /UserD:' + $credential.UserName + ' /PasswordD:' + ($credential.GetNetworkCredential().Password) -Verb RunAs"

if %errorlevel% equ 0 (
    echo El equipo se ha unido al dominio redpagos.local con éxito.
) else (
    echo Error al unir el equipo al dominio.
)

shutdown /r /t 5 /f /d p:0:0 /c "Reiniciando para aplicar cambios de nombre y unión al dominio."

endlocal
