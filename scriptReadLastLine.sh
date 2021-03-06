#!/bin/bash
IFS=$'\n'
#Linea que se encarga de conectarse al gateway y traer el archivo de los datos
#OJO el punto significa la ruta actual, donde me encuentro en este momento.
#sshpass -p "dragino" scp root@10.130.1.1:/root/datos/datos.txt /home/ubuntu/Desktop/pdg/datos.txt
sshpass -p "dragino" scp root@10.130.1.1:/root/datos/datos.txt .

#Esta linea crea un archivo con los datos de la tabla
#mysql -u root -ppassword -N -D prueba -h localhost -e "SELECT * FROM info" > tablaMysql.txt

linea=$( tail -n 1 datos.txt )
if [ "$linea" == "" ]; then
    echo "Archivo del gateway sin datos todavia"
else

    #IDPACKET
    bloqueidpacket=`echo $linea | awk -F"  " '{print $1}'`
    valoridpacket=`echo $bloqueidpacket | awk -F":" '{print $2}'`

    #FECHA
    bloquefecha=`echo $linea | awk -F"  " '{print $2}'`
    valorfecha=`echo $bloquefecha | awk -F":" '{print $2}'`

    #TIEMPO
    bloquetiempo=`echo $linea | awk -F"  " '{print $3}'`
    valortiempo=`echo $bloquetiempo | awk -F":" '{print $2}'`

    #LATITUD
    bloquelatitud=`echo $linea | awk -F"  " '{print $4}'`
    valorlatitud=`echo $bloquelatitud | awk -F":" '{print $2}'`

    #LONGITUD
    bloquelongitud=`echo $linea | awk -F"  " '{print $5}'`
    valorlongitud=`echo $bloquelongitud | awk -F":" '{print $2}'`

    #VELOCIDAD
    bloquevelocidad=`echo $linea | awk -F"  " '{print $6}'`
    valorvelocidad=`echo $bloquevelocidad | awk -F":" '{print $2}'`

    #ALTITUD
    bloquealtitud=`echo $linea | awk -F"  " '{print $7}'`
    valoraltitud=`echo $bloquealtitud | awk -F":" '{print $2}'`

    #QUERY SQL QUE SE ENCARGA DE AGREGAR LA ULTIMA LINEA DEL ARCHIVO
    mysql -u root -ppassword -D prueba -h localhost -e "INSERT INTO info (idpacket, fecha, 
    tiempo, latitud, longitud, 
    velocidad, altitud) 
    VALUES ('$valoridpacket', '$valorfecha', '$valortiempo', '$valorlatitud', 
    '$valorlongitud', '$valorvelocidad', '$valoraltitud'); " 
    echo "Enviado"

fi
