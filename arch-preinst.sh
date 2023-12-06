#!/bin/env bash




# arch-preinst.sh - Script de pré-instalação do Arch Linux
# define o teclado, a fonte e formata as partições para receberem
# a partição de boot (/boot/efi), a partição "swap" e a partição
# raiz, montando as mesmas em sequência. Também fornece instruções
# sobre como estabelecer uma conexão wi-fi usando "iwctl".

# Autor: Carlos A.R.S. < krlosars@gmail.com >

# Histórico: qua 06 dez 2023 18:40:54 -03
#            -> Versão inicial.




# Modifique o modelo de teclado caso não seja o padrão abnt2!
TECLADO="br-abnt2"

# A fonte abaixo melhora a visualização. Comente com um "#"
# no início da linha caso prefira utilizar a fonte padrão.
FONTE="ter-122n"




# Partições: este script considera que será usada uma partição
# para os arquivos de inicialização ("boot"), uma partição para
# a memória de troca ("swap") e uma terceira para a instalação
# do sistema em si (a partição "/", a raiz do sistema). Caso
# seja necessário, você pode modificar as partições abaixo
# definidas de forma que elas sejam compatíveis com a máquina
# onde será realizada a instalação do Arch Linux.
PARTICAO_BOOT="/dev/sda1"
PARTICAO_SWAP="/dev/sda2"
PARTICAO_ROOT="/dev/sda3"




# Somente modifique as linhas abaixo caso tenha absoluta
# certeza do que está fazendo: elas executam as operações
# necessárias à pré-instalação do Arch Linux!




# 01. Configura o teclado

#loadkeys "$TECLADO"
clear
echo -e "O teclado foi ajustado para \033[01;32m$TECLADO\033[00m"




# 02. Ajusta a fonte

#setfont $FONTE
echo -e "A fonte do console foi configurada para \033[01;32m$FONTE\033[00m\n"




# 03. Formata as partições

#mkfs.fat -F32 $PARTICAO_BOOT
echo -e "A partição \033[01;32m${PARTICAO_BOOT}\033[00m foi formatada -> \033[01;32mfat -f32\033[00m"
#mkswap $PARTICAO_SWAP
echo -e "A partição \033[01;32m${PARTICAO_SWAP}\033[00m foi formatada -> \033[01;32mswap\033[00m"
#mkfs.btrfs -f $PARTICAO_ROOT
echo -e "A partição \033[01;32m${PARTICAO_ROOT}\033[00m foi formatada -> \033[01;32mbtrfs\033[00m\n"




# 04. Monta as partições

#mount $PARTICAO_ROOT /mnt
echo -e "A raiz do sistema (\"/\") foi montada na partição \033[01;32m${PARTICAO_ROOT}\033[00m"
#mkdir -p /mnt/boot/efi
#mount $PARTICAO_BOOT /mnt/boot/efi
echo -e "A partição \033[01;32m${PARTICAO_BOOT}\033[00m foi montada para inicialização do sistema em /boot/efi"
#swapon $PARTICAO_SWAP
echo -e "A partição \033[01;32m${PARTICAO_SWAP}\033[00m foi definida para utilização swap\n\n\n"




# 05. Fornece instruções para conexão wi-fi

echo -e "Para estabelecer uma conexão wi-fi utilize o comando \033[01;30;47m iwctl \033[00m\n"
echo -e "  * Dica 1: \033[01;30;47m station wlan0 scan \033[00m -> Faz uma varredura buscando pontos de acesso\n"
echo -e "  * Dica 2: \033[01;30;47m station wlan0 get-networks \033[00m -> Lista os pontos de acesso encontrados\n"
echo -e "  * Dica 3: \033[01;30;47m station wlan0 connect SSID \033[00m -> Conecta ao ponto de acesso \033[01mSSID\033[00m\n"
echo -e "Substitua \033[01mSSID\033[00m pelo nome da sua rede e depois digite a senha!\n\n\n"
