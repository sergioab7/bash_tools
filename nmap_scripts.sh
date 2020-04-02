#!/bin/bash

#by xaxxjs
#diferentes scripts para el escaneo de alguna máquina.


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function menu(){

	clear && echo -e "${yellowColour}Selecciona la opcion que quieras:${endColour}"
	echo -e "---------------------------------------------------------------------"
	echo -e "1) Escaneo TOTAL"
	echo -e "2) Escaneo standard"
	echo -e "3) Escaneo de versiones, vulnerabilidades y SO"
	echo -e "4) Escaneo de todos los puertos sin firewalls"
	echo -e "5) Escaneo UDP "
	echo -e "6) Escaneo TCP "
	echo -e "7) Escaneo de toda la red"
	echo -e "8) Escaneo de scripts vulnerables"
	echo -e "9) Mostrar scripts nmap (por categoria)"
	read opcion_nmap
}

function totalScan(){
	echo -e "Has elegido el escaneo total"
	echo -e "Dime la direccion IP>>"
	read ip_direccion
	echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd 
	read respuesta
	if [ $respuesta == "si" ]; then
	sleep 1
	echo -e "Como se llamará el archivo? "
	read nombre_archivo
		if [ -f $nombre_archivo ]; then
			echo -e "El archivo ya existe! deseas sobreescribirlo? (si/no)"
			read respuesta_archivo_existente
			if [ "$respuesta_archivo_existente" == "si" ]; then 
				echo -e "Creando escaneo TOTAL y guardando con el nombre: " $nombre_archivo
				nmap -sC -sV -Pn $ip_direccion > $nombre_archivo
				echo -e "Escaneo completado. Escaneo guardado en: $nombre_archivo"
			fi
			if [ "$respuesta_archivo_existente" == "no" ]; then
				echo -e "Dime un nuevo nombre para el archivo: "
				read nombre_archivo 
			fi
		fi
	fi 

	echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
	sleep 1 
	echo -e "Ejecutando script..."
	sleep 1
	nmap -sC -sV -Pn $ip_direccion >> $nombre_archivo
	if [ -f "$nombre_archivo" ]; then
		echo -e "Escaneo no completado"
	else
		echo -e "Escaneo completado"
		exit 	
	fi 
}

function standarScan(){
	clear
	echo -e "${purpleColour} Standard Scan ${endColour}"
	echo -e "IP>>"
	read dire_IP
	echo -e "Direccion IP establecida: $dire_IP"
	echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd
	read respuesta 
	if [ $respuesta == "si" ]; then
	sleep 1
	echo -e "Como se llamará el archivo? "
	read nombre_archivo 
		if [ -f $nombre_archivo ]; then 
		echo -e "El archivo ya existe. Deseas sobreescribirlo? (si/no)" 
		read respuesta_de_archivo
			if [ "$respuesta_de_archivo" == "si" ]; then 
				echo -e "Creando escaneo ESTANDARD y guardando con el nombre: $nombre_archivo"
				nmap -sS $dire_IP > $nombre_archivo
				echo -e "Escaneo completado y guardado en: $nombre_archivo"
			fi 
			if [ "$respuesta_de_archivo" == "no" ];then 
				echo -e "Nuevo nombre para el archivo: "
				echo -e "next"
			fi
		fi
	fi

	echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
	sleep 1
	echo -e "Ejecutando script... "
	sleep 1
	nmap -sS $dire_IP > $nombre_archivo
	if [ -f "$nombre_archivo" ]; then
		echo -e "Escaneo no completado"
	else
		echo -e "Escaneo completado"
		exit 	
	fi 

}

function versionesScan(){
	clear
	echo -e "${purpleColour}Escaneo de versiones/vulnerabilidades/SO${endColour}"
	echo -e "Direccion IP>>"
	read dire_IP
	echo -e "Direccion IP establecida: $dire_IP"
	sleep 2

	echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd
	read respuesta 
	if [ $respuesta == "si" ]; then
	sleep 1
	echo -e "Como se llamará el archivo? "
	read nombre_archivo 
		if [ -f $nombre_archivo ]; then 
		echo -e "El archivo ya existe. Deseas sobreescribirlo? (si/no)" 
		read respuesta_de_archivo
			if [ "$respuesta_de_archivo" == "si" ]; then 
				echo -e "Creando escaneo ESTANDARD y guardando con el nombre: $nombre_archivo"
				nmap -sS $dire_IP > $nombre_archivo
				echo -e "Escaneo completado y guardado en: $nombre_archivo"
			fi 
			if [ "$respuesta_de_archivo" == "no" ];then 
				echo -e "Nuevo nombre para el archivo: "
				echo -e "next"
			fi
		fi
	fi

	echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
	sleep 1
	echo -e "Ejecutando script... "
	sleep 1
	nmap -sV -sC -sO -A $dire_IP > $nombre_archivo

	if [ -f "$nombre_archivo" ]; then
		echo -e "Escaneo no completado"
	else
		echo -e "Escaneo completado"
		exit 	
	fi 

	
}

function ScriptsNmap(){
	clear
	echo -e "${purpleColour}Mostrar todos los scripts de nmap${endColour}"
	sleep 1
	echo -e "1. Mostrar todos"
	echo -e "2. Mostrar servicios ftp"
	echo -e "3. Mostrar servicios smb"
	echo -e "4. Mostrar servicios ssh"
	echo -e "5. Mostrar servicios http"
	echo -e "6. Mostrar servicios mysql"
	echo -e "7. Buscar tu propio servicio."
	read servicio_mostrar 

	if [ $servicio_mostrar -eq "1" ]; then 
		clear
		echo -e "${redColour} Opcion seleccionada: TODOS ${endColour}"
		echo -e "Ejecutando script..."
		sleep 1
		for i in $(locate "*.nse"); do echo "Script: " $i; done
		sleep 4
		exit
	fi

	if [ $servicio_mostrar -eq "2" ]; then 
		clear
		echo -e "${redColour} Opcion seleccionada: ftp ${endColour}"
		echo -e "Ejecutando script..."
		sleep 1
		for i in $(locate "*.nse" | grep ftp); do echo "Script: " $i; done
		sleep 4
		exit
	fi

	if [ $servicio_mostrar -eq "3" ]; then 
		clear
		echo -e "${redColour} Opcion seleccionada: smb ${endColour}"
		echo -e "Ejecutando script..."
		sleep 1
		for i in $(locate "*.nse" | grep smb); do echo "Script: " $i; done
		sleep 4
		exit
	fi

	if [ $servicio_mostrar -eq "4" ]; then 
		clear
		echo -e "${redColour} Opcion seleccionada: ssh ${endColour}"
		echo -e "Ejecutando script..."
		sleep 1
		for i in $(locate "*.nse" | grep ssh); do echo "Script: " $i; done
		sleep 4
		exit
	fi

	if [ $servicio_mostrar -eq "5" ]; then 
		clear
		echo -e "${redColour} Opcion seleccionada: http ${endColour}"
		echo -e "Ejecutando script..."
		sleep 1
		for i in $(locate "*.nse" | grep http); do echo "Script: " $i; done
		sleep 4
		exit
	fi

	if [ $servicio_mostrar -eq "6" ]; then 
		clear
		echo -e "${redColour} Opcion seleccionada: mysql ${endColour}"
		echo -e "Ejecutando script..."
		sleep 1
		for i in $(locate "*.nse" | grep mysql); do echo "Script: " $i; done
		sleep 4
	fi

	if [ $servicio_mostrar -eq "7" ]; then 
		clear
		echo -e "${blueColour}Selecciona el servicio que quieres: ${endColour}"
		read mostrar_servicio_usuario
		for i in $(locate "*.nse" | grep $mostrar_servicio_usuario); do echo "Script: " $i; done
		sleep 2
	fi
}

function UDPScan(){
	clear
	echo -e "${purpleColour} UDP Scan${endColour}"
	echo -e "IP>>"
	read dire_IP
	echo -e "Direccion IP establecida: $dire_IP"
	echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd
	read respuesta 
	if [ $respuesta == "si" ]; then
	sleep 1
	echo -e "Como se llamará el archivo? "
	read nombre_archivo 
		if [ -f $nombre_archivo ]; then 
		echo -e "El archivo ya existe. Deseas sobreescribirlo? (si/no)" 
		read respuesta_de_archivo
			if [ "$respuesta_de_archivo" == "si" ]; then 
				echo -e "Creando escaneo UDP y guardando con el nombre: $nombre_archivo"
				nmap -sS $dire_IP > $nombre_archivo
				echo -e "Escaneo completado y guardado en: $nombre_archivo"
			fi 
			if [ "$respuesta_de_archivo" == "no" ];then 
				echo -e "Nuevo nombre para el archivo: "
				echo -e "next"
			fi
		fi
	fi
	echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
	sleep 1
	echo -e "Ejecutando script... "
	sleep 1
	nmap -sU $dire_IP > $nombre_archivo
	if [ -f "$nombre_archivo" ]; then
		echo -e "Escaneo no completado"
	else
		echo -e "Escaneo completado"
		exit 	
	fi 
}

function TCPScan(){
	clear
	echo -e "${purpleColour} TCP Scan ${endColour}"
	echo -e "IP>>"
	read dire_IP
	echo -e "Direccion IP establecida: $dire_IP"
	echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd
	read respuesta 
	if [ $respuesta == "si" ]; then
	sleep 1
	echo -e "Como se llamará el archivo? "
	read nombre_archivo 
		if [ -f $nombre_archivo ]; then 
		echo -e "El archivo ya existe. Deseas sobreescribirlo? (si/no)" 
		read respuesta_de_archivo
			if [ "$respuesta_de_archivo" == "si" ]; then 
				echo -e "Creando escaneo TCP y guardando con el nombre: $nombre_archivo"
				nmap -sS $dire_IP > $nombre_archivo
				echo -e "Escaneo completado y guardado en: $nombre_archivo"
			fi 
			if [ "$respuesta_de_archivo" == "no" ];then 
				echo -e "Nuevo nombre para el archivo: "
				echo -e "next"
			fi
		fi
	fi
	echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
	sleep 1
	echo -e "Ejecutando script... "
	sleep 1
	nmap -sU $dire_IP > $nombre_archivo
	if [ -f "$nombre_archivo" ]; then
		echo -e "Escaneo no completado"
	else
		echo -e "Escaneo completado"
		exit 	
	fi 

}

function AllScan(){

	clear
		echo -e "${purpleColour} Escaneo de toda la red ${endColour}"
		echo -e "IP>>"
		read dire_IP
		echo -e "Direccion IP establecida: $dire_IP"
		echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd
		read respuesta 
		if [ $respuesta == "si" ]; then
		sleep 1
		echo -e "Como se llamará el archivo? "
		read nombre_archivo 
			if [ -f $nombre_archivo ]; then 
			echo -e "El archivo ya existe. Deseas sobreescribirlo? (si/no)" 
			read respuesta_de_archivo
				if [ "$respuesta_de_archivo" == "si" ]; then 
					echo -e "Creando escaneo de toda la red y guardando con el nombre: $nombre_archivo"
					nmap -p- -sC -sV -Pn $dire_IP > $nombre_archivo
					echo -e "Escaneo completado y guardado en: $nombre_archivo"
				fi 
				if [ "$respuesta_de_archivo" == "no" ];then 
					echo -e "Nuevo nombre para el archivo: "
					echo -e "next"
				fi
			fi
		fi
		echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
		sleep 1
		echo -e "Ejecutando script... "
		sleep 1
		nmap -sU $dire_IP > $nombre_archivo
		if [ -f "$nombre_archivo" ]; then
			echo -e "Escaneo no completado"
		else
			echo -e "Escaneo completado"
			exit 	
		fi 

}

function ScriptsVuln(){
	clear
		echo -e "${purpleColour} Scripts vulnerables ${endColour}"
		echo -e "IP>>"
		read dire_IP
		echo -e "Direccion IP establecida: $dire_IP"
		echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd
		read respuesta 
		if [ $respuesta == "si" ]; then
		sleep 1
		echo -e "Como se llamará el archivo? "
		read nombre_archivo 
			if [ -f $nombre_archivo ]; then 
			echo -e "El archivo ya existe. Deseas sobreescribirlo? (si/no)" 
			read respuesta_de_archivo
				if [ "$respuesta_de_archivo" == "si" ]; then 
					echo -e "Creando escaneo de scripts vulnerables y guardando con el nombre: $nombre_archivo"
					nmap -sC -sV -Pn $dire_IP > $nombre_archivo
					echo -e "Escaneo completado y guardado en: $nombre_archivo"
				fi 
				if [ "$respuesta_de_archivo" == "no" ];then 
					echo -e "Nuevo nombre para el archivo: "
					echo -e "next"
				fi
			fi
		fi
		echo -e "Creando un nuevo archivo llamado: $nombre_archivo"
		sleep 1
		echo -e "Ejecutando script... "
		sleep 1
		nmap -sU $dire_IP > $nombre_archivo
		if [ -f "$nombre_archivo" ]; then
			echo -e "Escaneo no completado"
		else
			echo -e "Escaneo completado"
			exit 	
		fi 

}

if [ "$(id -u)" -eq "0" ]; then
	clear
	echo -e "${redColour}Aviso: Debes estar conectado con el usuario root para un correcto funcionamiento${endColour}"
	
	while true; do
		menu
		
		case $opcion_nmap in
			1) totalScan
			;;

			2) standarScan
			;;

			3) versionesScan
			;;

			4) firewallScan
			;;

			5) UDPScan
			;;

			6) TCPScan
			;;

			7) AllScan
			;;

			8) ScriptsVuln
			;;

			9) ScriptsNmap
			;;

			*) exit
			;;
		esac
	done
else
	echo -e "${redColour} Es necesario correr el programa con el usuario root${endColour}"	

fi

		