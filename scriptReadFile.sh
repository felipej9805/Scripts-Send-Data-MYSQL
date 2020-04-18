#!/bin/bash
IFS=$'\n'

for i in `cat /home/ubuntu/Desktop/pdg/datos.txt`
    do
    #IDPACKET
    bloqueidpacket=`echo $i | awk -F"  " '{print $1}'`
    valoridpacket=`echo $bloqueidpacket | awk -F":" '{print $2}'`

    #FECHA
    bloquefecha=`echo $i | awk -F"  " '{print $2}'`
    valorfecha=`echo $bloquefecha | awk -F":" '{print $2}'`

    #TIEMPO
    bloquetiempo=`echo $i | awk -F"  " '{print $3}'`
    valortiempo=`echo $bloquetiempo | awk -F":" '{print $2}'`

    #LATITUD
    bloquelatitud=`echo $i | awk -F"  " '{print $4}'`
    valorlatitud=`echo $bloquelatitud | awk -F":" '{print $2}'`

    #LONGITUD
    bloquelongitud=`echo $i | awk -F"  " '{print $5}'`
    valorlongitud=`echo $bloquelongitud | awk -F":" '{print $2}'`

    #VELOCIDAD
    bloquevelocidad=`echo $i | awk -F"  " '{print $6}'`
    valorvelocidad=`echo $bloquevelocidad | awk -F":" '{print $2}'`

    #ALTITUD
    bloquealtitud=`echo $i | awk -F"  " '{print $7}'`
    valoraltitud=`echo $bloquealtitud | awk -F":" '{print $2}'`

    #QUERY SQL
    mysql -u root -ppassword -D prueba -h localhost -e "INSERT INTO info (idpacket, fecha, 
    tiempo, latitud, longitud, 
    velocidad, altitud) 
    VALUES ('$valoridpacket', '$valorfecha', '$valortiempo', '$valorlatitud', 
    '$valorlongitud', '$valorvelocidad', '$valoraltitud'); " > /dev/null 2>&1

    done
