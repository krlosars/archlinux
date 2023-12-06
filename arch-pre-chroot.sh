#!/bin/env bash




# arch-pre-chroot.sh - Script de instalação do Arch Linux que
# antecede a execução do "arch-chroot". Este script deve ser
# executado após estabelecida a conexão com a internet e após
# a execução do script "arch-preinst". Sua função é ajustar
# o fuso horário, atualizar e otimizar a lista de repositórios,
# instalar os pacotes essenciais ("pacstrap"), montar a tabela
# de partições para o novo sistema instalado e fornecer
# informações sobre como acessar o sistema recém-instalado
# utilizando o comando "arch-chroot" a fim de pode prosseguir
# com o processo de instalação do Arch Linux.

# Autor: Carlos A.R.S. < krlosars@gmail.com >

# Histórico: qua 06 dez 2023 19:58:04 -03
#            -> Versão inicial.




# Modifique o fuso horário abaixo caso não esteja no
# horário oficial brasileiro (America/Sao_Paulo).
FUSO_HORARIO="America/Sao_Paulo"




# Somente modifique as linhas abaixo caso tenha absoluta
# certeza do que está fazendo: elas executam as operações
# necessárias à pré-instalação do Arch Linux!




# 01. Ajusta o fuso horário

#timedatectl set-timezone America/São_Paulo
#timedatectl set-ntp true
clear
echo -e "O fuso horário foi ajustado para \033[01;32m${FUSO_HORARIO}\033[00m"
echo -e "data e hora atuais: \033[01;32m$(date)\033[00m\n"




# 02. Atualização e otimização da lista de repositórios

echo -e "Atualizando e otimizando a lista de repositórios...\n"
#pacman -Sy archlinux-keyring
#reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist




# 03. Instalando os pacotes essenciais

echo -e "\nOs pacotes essenciais serão instalados agora!\n"
#pacstrap /mnt linux linux-firmware base base-devel openssh dhcpcd nvim




# 04. Gera a tabela de partições para o sistema instalado

echo -e "\nGerando a tabela de partições para o arquivo \033[01;32m/etc/fstab\033[00m\n\n\n"
#genfstab -U -p /mnt >> /mnt/etc/fstab
#cat /mnt/etc/fstab




# 05. Fornece instruções para execução do chroot

echo -e "\n\n\nPara prosseguir a instalação, execute o comando \033[01;30;47m arch-chroot \033[00m\n\n\n"
