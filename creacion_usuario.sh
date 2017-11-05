#!/bin/bash

clear

fichero="usuario_ejemplo.ldif"
ruta="ou=People,dc=lopez,dc=gonzalonazareno,dc=org"
grupo="2000"
clave="clave del administrador de LDAP"

read -p "Introduce un nombre de usuario sin tildes: " nombre
read -p "Introduce los dos apellidos: " apellido
read -p "Introduce nombre real completo y apellidos: " nombreapellido
read -p "Introduce tu nombre de pila: " pila
read -p "Introduce tu correo electronico: " correo


