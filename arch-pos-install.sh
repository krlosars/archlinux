#!/bin/env bash




# arch-pos-install.sh - Script de pós-instalação do Arch Linux
# para execução como usuário com permissões administrativas
# após a instalação básica do Arch Linux provida pelos scripts
# anteriores (arch-preinstall, arch-pre-chroot e arch-pos-chroot).
# Este script deve ser executado após estabelecida a conexão com
# a internet. Caso a internet não esteja ok, utilize a ferramenta
# "nmtui" para reativar a conexão. A função deste script
# é complementar a instalação básica do Arch Linux provendo
# recursos mínimos para utilizar o sistema em modo gráfico
# (Xorg). Ele não provê a instalação de um Window Manager
# ou de ambientes de desktop como KDE, Gnome o XFCE, mas
# implementa muitas das ferramentas que eles necessitam,
# além de outras que são valiosas para o uso no console
# linux ou em emuladores de terminal.

# Autor: Carlos A.R.S. < krlosars@gmail.com >

# Histórico: qua 06 dez 2023 21:58:30 -03
#            -> Versão inicial.




# Comente a linha abaixo com um "#" no início caso não
# disponha de dispositivos para conexão BlueTooth em seu
# computador.
BLUETOOTH="sim"




# Comente a linha abaixo caso não tenha instalado
# o Arch Linux em um notebook.
#NOTEBOOK="sim"




# Comente a linha abaixo caso vc não tenha instalado
# o Arch Linux em uma unidade de disco do tipo SSD.
SSD="sim"




# Defina o nome para a conta de usuário
USUARIO="krlao"




# Somente modifique as linhas abaixo caso tenha absoluta
# certeza do que está fazendo: elas executam as operações
# necessárias à pré-instalação do Arch Linux!




# Instalação da fonte Terminus
clear
echo -e "\033[01m(SUDO)\033[00m -> Instalando a fonte \033[01mTerminus\033[00m para melhor visualização em modo console...\n"
#sudo install terminus-font
echo -e "\nAjustando a fonte do console linux\n"
#setfont ter-122n




# 01. Implementa recursos para gerenciamento de conexões BlueTooth

if [ "$BLUETOOTH" = "sim" ];
then
    echo -e "\033[01m(SUDO)\033[00m -> Instalando pacotes para gerenciar conexões BlueTooth...\n"
    #sudo pacman -S bluez bluez-utils blueman
    echo -e "\n\033[01m(SUDO)\033[00m -> Ativando gerenciamento de conexões BlueTooth...\n"
    #sudo systemctl enable bluetooth
else
    echo -e "Suporte para gerenciamento de conexões BlueTooth não instalado.\n"
fi




# 02. Suporte para gerenciamento de energia em Notebooks

if [ "$NOTEBOOK" = "sim" ];
then
    echo -e "\033[01m(SUDO)\033[00m -> Instalando pacotes para gerenciamento de energia em Notebooks...\n"
    #sudo pacman -S tlp tlp-rdw powertop acpi
    echo -e "\n\033[01m(SUDO)\033[00m -> Ativando gerenciamento de energia para Notebooks...\n"
    #sudo systemctl enable tlp
    #sudo systemctl enable tlp-sleep
    #sudo systemctl mask systemd-rfkill.service
    #sudo systemctl mask systemd-rfkill.socket
else
    echo -e "\nSuporte a gerenciamento de energia para Notebooks não instalado.\n"
fi




# 03. Suporte a unidade de discos SSD

if [ "$SSD" = "sim" ];
then
    echo -e "\n\033[01m(SUDO)\033[00m -> Ativando suporte a unidades de disco SSD...\n"
    #sudo systemctl enable fstrim.timer
else
    echo -e "\nSuporte a unidades de disco SSD não instalado.\n"
fi




# 04. Instalando o gerenciador de pacotes YAY (repositório AUR)

echo -e "\nIniciando a instalação do gerenciador de pacotes \033[01mYay\033[00m (AUR)."
echo -e "Fique atento: você será solicitado a interagir durante o processo"
echo -e "de instalação do Yay e do aplicativo \033[01mpa-applet\033[00m, que será instalado"
echo -e "em seguida.\n"
#mkdir Sources
#cd Sources
#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si
#cd ..
#rm -rf sources




# 05. Instalando o applet do Pulse Audio (pa-applet) para controle de volume

echo -e "\nIniciando a instalação do \033[01mpa-applet\033[00m. Fique atento: você"
echo -e "será solicitado a interagir durante a instalação!\n"
#yay -S pa-applet-git




# 06. Instalando pacotes complementares

echo -e "\n\033[01m(SUDO)\033[00m -> Iniciando a instalação de pacotes complementares... \n"
#sudo pacman -Sy lesspipe atool zip xdg-utils perl-file-mimeinfo perl-net-dbus \
    #    perl-x11-protocol perl-lwp-protocol-https bash-completion translate-shell \
    #    aspell aspell-pt rlwrap lsd bat dex xf86-video-intel xorg-server xorg-apps \
    #    xorg-xinit xorg-xev xsel xclip ttf-font ttf-victor-mono-nerd \
    #    otf-firamono-nerd otf-fira-sans gnome-themes-extra papirus-icon-theme \
    #    feh libheif libid3tag libjxl libspectre libwebp openjpeg2 jpegexiforient \
    #    imagemagick libraw libwmf libzip ocl-icd djvulibre picom alacritty dunst \
    #    npm tree-sitter tree-sitter-cli ripgrep lazygit gdu fzf the_silver_searcher \
    #    lua-language-server
echo -e "\n\n\n"
