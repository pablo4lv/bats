@echo off
setlocal enabledelayedexpansion

netsh interface ipv4 show interfaces

set /p "interfaz=Ingrese el nombre de la interfaz a editar: "
set /p "ip=Ingrese el numero de ip sin el ultimo numero: "
set /p "caja=Ingrese el numero de caja: "

netsh interface ipv4 set address "!interfaz!" static !ip!.!caja! 255.255.255.0 gateway=!ip!.254 

netsh interface ipv4 set dns "!interfaz!" static "10.50.9.50"

netsh interface ipv4 add dns "!interfaz!" "10.50.9.51" index=2

ipconfig /all

pause

endlocal