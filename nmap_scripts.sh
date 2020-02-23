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
	echo -e "9) Escaneo de scripts SMB"
	echo -e "10) Escaneo de scripts HTTP"
	echo -e "11) Escaneo de <SELECCIONA PUERTOS>"
	read opcion_nmap
}

function archivo_existente(){

	echo -e "Test"

}

function totalScan(){
	echo -e "Has elegido el escaneo total"
	echo -e "Dime la direccion IP>>"
	read ip_direccion
	echo -e "Deseas guardar el archivo en el directorio: (si/no)" && pwd 
	read respuesta
	if [ "$respuesta" == "si" ]; then
	sleep 1
	echo -e "Como se llamará el archivo? "
	read nombre_archivo
	if [ -f $nombre_archivo ]; then
		echo -e "El archivo ya existe! deseas sobreescribirlo? (si/no)"
		read respuesta_archivo_existente
		if [ "$respuesta_archivo_existente" == "si" ]; then 
			echo -e "Creando escaneo TOTAL y guardando con el nombre: " $nombre_archivo
			nmap -sC -sV -Pn $ip_direccion >> $nombre_archivo
				if [ -f $nombre_archivo ]; then
					echo -e "Escaneo completado"
				else
					echo -e "Escaneo no completado"
				exit 
				fi 
		elif [ "$respuesta_archivo_existente" == "no" ]; then
			echo -e "Dime un nuevo nombre para el archivo: "
			read nombre_archivo 

	elif [ "$respuesta" == "no" ]; then
		echo -e "Guardando en otro directorio."
		exit 
	fi 

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

			*) exit
			;;
		esac
	done
else
	echo -e "${redColour} Es necesario correr el programa con el usuario root${endColour}"	

fi

		

















