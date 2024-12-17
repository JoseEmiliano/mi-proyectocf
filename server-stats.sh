#!/bin/bash

# Uso total de CPU
echo "Uso total de CPU:"
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"%"}'

# Uso total de memoria
echo -e "\nUso total de memoria:"
free -m | awk 'NR==2{printf "Usada: %sMB (%.2f%%), Libre: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2 }'

# Uso total del disco
echo -e "\nUso total del disco:"
df -h | awk '$NF=="/"{printf "Usado: %d/%dGB (%s)\n", $3,$2,$5}'

# Los 5 procesos principales por uso de CPU
echo -e "\nLos 5 procesos principales por uso de CPU:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# Los 5 procesos principales por uso de memoria
echo -e "\nLos 5 procesos principales por uso de memoria:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Versión del sistema operativo
echo -e "\nVersión del sistema operativo:"
lsb_release -a

# Tiempo de actividad
echo -e "\nTiempo de actividad:"
uptime -p

# Promedio de carga
echo -e "\nPromedio de carga:"
uptime | awk -F'load average:' '{ print $2 }'

# Usuarios registrados
echo -e "\nUsuarios registrados:"
who

# Intentos fallidos de inicio de sesión
echo -e "\nIntentos fallidos de inicio de sesión:"
grep "Failed password" /var/log/auth.log | tail -n 5
