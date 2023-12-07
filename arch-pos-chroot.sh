#!/bin/env bash




# arch-pos-chroot.sh - Script de instalação do Arch Linux para
# execução após o "arch-chroot". Este script deve ser
# executado após estabelecida a conexão com a internet e após
# a execução do script "arch-pre-chroot". Sua função é efetar
# todas as ações necessárias para concluir a instalação básica
# do Arch Linux, incluindo a criação de uma conta de usuário
# com permissões administrativas mediante a utilização
# do comando "sudo".

# Autor: Carlos A.R.S. < krlosars@gmail.com >

# Histórico: qua 06 dez 2023 21:58:30 -03
#            -> Versão inicial.




# Modifique o modelo de teclado caso não seja o padrão abnt2!
TECLADO="br-abnt2"




# Modifique o fuso horário abaixo caso não esteja no
# horário oficial brasileiro (America/Sao_Paulo).
FUSO_HORARIO="America/Sao_Paulo"




# Define o nome que a máquina terá na rede ("HOSTNAME").
MAQUINA="makkumba"




# Defina o nome para a conta de usuário
USUARIO="krlao"




# Somente modifique as linhas abaixo caso tenha absoluta
# certeza do que está fazendo: elas executam as operações
# necessárias à pré-instalação do Arch Linux!




# 01. Ajusta o arquivo /etc/locale.gen para gerar a tabela
# de localização para o idioma português (pt_BR.UTF-8), gera
# a tabela de localização do sistema, cria os arquivos que
# contém as configurações do idioma e layout de teclado.

sed -i "s/^#pt_BR.UTF-8/pt_BR.UTF-8/" /etc/locale.gen
clear
echo -e "Iniciando a geração da localização do sistema para \033[01;32mpt_BR.UTF-8\033[00m\n"
locale-gen
echo -e "\nCriando o arquivo \033[01;32m/etc/locale.conf\033[00m"
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "LANGUAGE=pt_BR" >> /etc/locale.conf
echo "LC_ALL=C" >> /etc/locale.conf
echo -e "Criando o arquivo \033[01;32m/etc/vconsole.conf\033[00m"
echo "KEYMAP=$TECLADO" >> /etc/vconsole.conf




# 02. Ajuste do fuso horário

echo -e "\nAjustando fuso horário para \033[01;32m${FUSO_HORARIO}\033[00m"
ln -sf /usr/share/zoneinfo/$FUSO_HORARIO /etc/localtime
hwclock --systohc
echo -e "data e hora atuais: \033[01;32m$(date)\033[00m\n"




# 03. Criando os arquivos para configuração da rede

echo -e "Definindo o HOSTNAME como \033[01;32m${MAQUINA}\033[00m"
echo $MAQUINA >> /etc/hostname
echo -e "Criando o arquivo \033[01;32m/etc/hosts\033[00m\n"
echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.0.1 $MAQUINA.localdomain $MAQUINA" >> /etc/hosts




# 04. Instalando pacotes complementares

echo -e "Iniciando a instalação de pacotes complementares... \n"
pacman -S dosfstools os-prober mtools networkmanager network-manager-applet \
    wpa_supplicant wireless_tools iw iwd lynx dialog sudo \
    grub efibootmgr fuse2 lzop libisoburn tk man-pages-pt_br \
    intel-ucode git reflector lshw unzip htop wget \
    pulseaudio alsa-utils alsa-plugins pavucontrol xdg-user-dirs



# 05. Habilitando os serviços de rede

echo -e "\nHabilitando serviços de rede...\n"
systemctl enable sshd
systemctl enable dhcpcd
systemctl enable NetworkManager




# 06. Instalando o gerenciador de boot (GRUB)

echo -e "\nEfetuando a instalação do gerenciador de boot (GRUB)...\n"
mkinitcpio -P
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg




# 07. Definindo a senha do administador (ROOT)
echo -e "\nInforme a senha do administrador (root) e repita para confirmar\n"
passwd




# 08. Criando uma conta de usuário
echo -e "\nDefina uma senha para o usuário $USUARIO e repita para confirmar\n"
useradd -m -g users -G wheel,storage,power,audio $USUARIO
passwd $USUARIO
echo -e "\nAtribuindo permissões administrativas para o usuário $USUARIO"
sed -i "s/#%wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/" /etc/sudoers




# 09. Finalizando
echo -e "\n\n\nPara finalizar a instalação, utilize os comandos abaixo:\n"
echo -e "- exit"
echo -e "- umount -R /mnt"
echo -e "- swapoff /dev/sda2"
echo -e "- systemctl power-off\n\n\n"
