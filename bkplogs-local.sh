!#/bin/bash
# SCRIPT DE BACKUP LOCAL PARA LOGS
########################################################

# VARIAVEIS
hoje2=`date +%a --date '1 day ago'`
hoje1=`date +%a`
BKP=/mnt/tmp/
LOG=$BKP/local.log
SUCESSO=0
FALHA=0

echo "$(date) - BACKUP INICIADO"  >> $LOG

# Apaga log anterior
rm -f $BKP/*.log
echo "$(date) - Logs de Backup Anteriores apagados"  >> $LOG

# Compactacao de arquivos
DIR=/var/log/
echo "$(date) - COMPACTANDO $DIR" >> $LOG
tar czvf $BKP/logs-$hoje1.tar.gz $DIR
if [ $? -eq 0 ]
then
    echo "$(date) - $DIR compactado com SUCESSO" >> $LOG
    ((SUCESSO++))
else
    echo "$(date) - FALHA na compactacao de $DIR" >> $LOG
    ((FALHA++))
    echo "$(date) - FALHA na compactacao do $DIR" >> $BKP/falha.log
fi

# REMOVER BKPs ANTERIORES
rm $BKP/*-$hoje2.tar.gz

echo " " >> $LOG
echo "SUCESSO:$SUCESSO" >> $LOG
echo "FALHA:$FALHA" >> $LOG

echo " " >> $LOG

if [ $FALHA -lt 1 ]
then
    echo "$(date) - Copia de seguranca do servico WEB LOCAL COMANDO finalizado com SUCESSO." >> $LOG
else
    echo "$(date) - Ocorreu FALHA em alguma copia de seguranca do servico WEB LOCAL COMANDO." >> $LOG
fi

echo " " >> $LOG

echo "$(date) - Backup local finalizado" >> $LOG
