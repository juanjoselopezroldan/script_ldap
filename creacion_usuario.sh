#!/bin/bash

clear

fichero="usuario_ejemplo.ldif"
ruta="ou=People,dc=lopez,dc=gonzalonazareno,dc=org"
grupo="ID del grupo en la que va ha ser almacenado"
clave="clave del administrador de LDAP"

read -p "Introduce un nombre de usuario sin tildes: " nombre
read -p "Introduce los dos apellidos: " apellido
read -p "Introduce nombre real completo y apellidos: " nombreapellido
read -p "Introduce tu nombre de pila: " pila
read -p "Introduce tu correo electronico: " correo

echo "Introduce una clave: "
var=$(slappasswd -v)

var1=$(echo $apellido | base64)

var2=$(echo $nombreapellido | base64)

uid=$(ldapsearch -xLLL -b "ou=People,dc=lopez,dc=gonzalonazareno,dc=org" "objectClass=inetorgperson" | grep "uidNumber" | cut -d ":" -f 2 | tail -1)

uid=`expr $uid + 1`

mkdir /home/nfs/$nombre
chown $uid:$grupo -R /home/nfs/$nombre

echo "dn: uid=$nombre,$ruta" > $fichero
echo "objectClass: top" >> $fichero
echo "objectClass: posixAccount" >> $fichero
echo "objectClass: inetOrgPerson" >> $fichero
echo "objectClass: person" >> $fichero
echo "cn:: $var2" >> $fichero
echo "uid: $nombre" >> $fichero
echo "uidNumber: $uid" >> $fichero
echo "gidNumber: $grupo" >> $fichero
echo "homeDirectory: /home/nfs/$nombre" >> $fichero
echo "loginShell: /bin/bash" >> $fichero
echo "userPassword: $var" >> $fichero
echo "sn:: $var1" >> $fichero
echo "mail: $correo" >> $fichero
echo "givenName: $pila" >> $fichero

ldapadd -x -D cn=admin,dc=lopez,dc=gonzalonazareno,dc=org -w $clave -f $fichero #> /tmp/null 2>&1


