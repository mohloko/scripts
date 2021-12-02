#!/bin/bash
#
#

if test -d /dados/samba
then
echo ""
else
echo "Diretorio $dominio NAO Existe"
echo "Criando o Diretorio"
mkdir /dados/samba
echo "Diretorio Criado. Execute novamente o script $0 "
fi

echo "Script Para cadastro de usuarios Para Samba4: "
echo ""
#echo -n "Digite o Nome do Usuario que sera Cadastrado: "
#read -e LOGIN

if [ -z $1 ]
then
        echo "Favor passar o nome do usuario: bash. add_user_samba.sh usuario"
        exit 0
else
        LOGIN=$1
fi

id=`wbinfo -i "$LOGIN" | cut -d: -f3`
samba-tool user list > /tmp/.users.tmp
grep -w $LOGIN /tmp/.users.tmp
if [ $? -eq "0" ]
        then
                echo "Usuario ja cadastrado, vamos alterar a senha para $LOGIN: "
                SENHA=`tr -dc 0-9 < /dev/urandom | head -c 4`
                samba-tool user setpassword $LOGIN --newpassword=IPO.$SENHA
                samba-tool user setexpiry $LOGIN --noexpiry
                echo "A senha do usuario $LOGIN sera: IPO.$SENHA"
                exit 0
                #samba-tool user setpassword $LOGIN --newpassword=$altera --must-change-at-next-login
                if [ ! -e /dados/samba/$LOGIN ]
                then
                        mkdir -p /dados/samba/$LOGIN
                        mkdir -p /dados/samba/$LOGIN/Scanner
                        chown $id:users /dados/samba/$LOGIN
                        chown $id:users /dados/samba/$LOGIN/Scanner
                        chmod -R 700 /dados/samba/$LOGIN
                        chmod -R 700 /dados/samba/$LOGIN/Scanner
                        rm /tmp/.users.tmp
                        exit 0
                else
                        chown $id:users /dados/samba/$LOGIN
            chmod 700 /dados/samba/$LOGIN
                        if [ ! -e /dados/samba/$LOGIN/Scanner ]
                                then
                                mkdir -p /dados/samba/$LOGIN/Scanner
                                        chown $id:users /dados/samba/$LOGIN/Scanner
                                        chmod 700 /dados/samba/$LOGIN/Scanner
                        fi
                        rm /tmp/.users.tmp
                        exit 0
                fi
        else

                #echo -n "Digite a senha para o usuario $LOGIN EX:(Teste.1234):  "
                #read -e SENHA
                #samba-tool user create $LOGIN Teste.1234 --must-change-at-next-login --home-directory="\\\\192.168.0.240\\dados\\samba\\$LOGIN" --home-drive=Y: --script-path="logon.bat"
                #SENHA=`echo $LOGIN |cut -c1,2,3,4`
                SENHA2=`tr -dc 0-9 < /dev/urandom | head -c 4`
                echo "A senha do usuario $LOGIN sera: IPO.$SENHA2"
                samba-tool user create $LOGIN IPO.$SENHA2 --home-directory="\\\\192.168.0.240\\dados\\samba" --home-drive=Y: --script-path="logon.bat"
                samba-tool user setexpiry $LOGIN --noexpiry
                id=`wbinfo -i "$LOGIN" | cut -d: -f3`
                mkdir -p /dados/samba/$LOGIN
                mkdir -p /dados/samba/$LOGIN/Scanner
                chown $id:users /dados/samba/$LOGIN
                chown $id:users /dados/samba/$LOGIN/Scanner
                chmod 700 /dados/samba/$LOGIN
                chmod 700 /dados/samba/$LOGIN/Scanner
                rm /tmp/.users.tmp
fi
