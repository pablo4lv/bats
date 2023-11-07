@echo off
setlocal enabledelayedexpansion

netsh interface ipv4 show interfaces

set /p "interfaz=Ingrese el nombre de la interfaz a editar: "

netsh interface ipv4 set address "!interfaz!" source=dhcp

netsh interface ipv4 set dnsservers "!interfaz!" source=dhcp

ipconfig /all

pause

endlocal