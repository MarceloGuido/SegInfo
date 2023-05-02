#!/bin/bash
# SCRIPT DE BACKUP REMOTO PARA LOGS
#########################################

# VARIAVEIS
HOJE=`date +%a`
ONTEM=`date +%a --date '1 day ago'`
BKPDIR=/backup/
BKPLOG=$BKPDIR/remoto.log
USER=raquel ### Alterar para o usuario utilizado no backup
IP_SERVER=192.168.0.10 ### Alterar para o IP do cliente
PORTA_SSH=2223 ### Alterar para a porta SSH do cliente
BKP_DIR_SRV=/mnt/tmp

# EXCLUI LOG DE BKP ANTERIOR
rm -f $BKPDIR/*.log

# ARQUIVOS
scp -P $PORTA_SSH -p $USER@$IP_SERVER:$BKP_DIR_SRV/* $BKPDIR
if [ $? -eq 0 ]
then
    echo "$(date) - Copia de seguranca dos logs do servidor $IP_SERVER finalizado com SUCESSO." >> $BKPLOG
else
    echo "=====> $(date) - FALHA na copia de seguranca dos logs do servidor $IP_SERVER. <=====" >> $BKPLOG
fi
