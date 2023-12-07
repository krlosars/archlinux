# Relação de pacotes da instalação

Este arquivo contém todos os pacotes da minha instalação do Arch Linux, realizada em 08 de julho de 2023. Os primeiros pacotes, obviamente, constituem
a base do sistema propriamente ditos, e foram instalados como "root". Todos os demais foram instalados após o primeiro boot da máquina, como usuário
com privilégios administrativos. A última parte do arquivo contém algumas sugestões sobre _"Language Server Providers"_ (LSPs) instalados a partir de
pacotes do Arch Linux. É possível instalar a maioria deles -- e muitos outros! -- usando o próprio plugin de LSPs do VIM, o **"vim-lsp"**.

## Pacotes instalados como Root

* pacman -S linux linux-firmware base base-devel terminus-font vim
* pacman -S openssh dhcpcd dosfstools os-prober mtools networkmanager network-manager-applet wpa_supplicant wireless_tools lynx dialog
* pacman -S intel-ucode grub efibootmgr fuse3 lzop libisoburn tk
* pacman -S git reflector lshw unzip htop wget pulseaudio alsa-utils alsa-plugins pavucontrol xdg-user-dirs man-pages-pt_br
* pacman -S bluez bluez-utils blueman
* pacman -S mdcat

## Instalação do Yay

O **Yay** é o instalador de pacotes do repositório "Aur" do Arch Linux. Ele foi o primeiro recurso que instalei como usuário e sua instalação
é realizada usando os comandos abaixo:

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Não conheço outra forma para instalar o Yay. Após a instalação do mesmo, e para fins de teste, instalei o _"applet"_ de controle de volume
do Pulse Audio, que permitirá controlar o volume do som de todas as aplicações usando as teclas de controle de volume ou mesmo o mouse. Para
instalar o _"applet"_ eu usei o seguinte comando, como usuário com privilégios administrativos:

```bash
yay -S pa-applet-git
```

Após a instalação do _"applet"_ de controle de volume do Pulse Audio foram instalados os demais pacotes. Antes disso, porém, eu usei um bash script
de minha autoria para baixar e instalar a fonte que utilizarei no ambiente gráfico.

## Pacotes Instalados como usuário

Algumas vezes eu adicionei dependências opcionais para os pacotes instalados porque julguei úteis para complementar funcionalidades dos mesmos.
Geralmente, nestes casos, o pacote principal é o primeiro na linha de comando, sendo seguido pelas dependências opcionais. Você pode não instalar
essas dependências, mas eu aconselho que o faça porque pode ser que alguns dos aplicativos instalados percam parte de sua funcionalidade ou apresentem
problemas se você tentar acessar todas as funcionalidades que oferecem. Ademais, todos estes pacotes, incluindo suas dependências, ocupam um espaço
relativamente pequeno no disco, bem menos de 10 gigas!

* ~~NÃO --> ~Gerador de prompt escrito em Rust -> sudo pacman -S starship~~
* Melhoria para a saída do comando **"less"** -> sudo pacman -S lesspipe
* ~~NÃO --> ~Gerador de cores para os comandos "ls" e "lsd" -> sudo pacman -S vivid~~
* PARCIAL -> Ferramentas para manipular arquivos compactados -> sudo pacman -S atool zip ~~lha p7zip unrar~~
* Ferramentas importantes para lidar com arquivos -> sudo pacman -S xdg-utils perl-file-mimeinfo perl-net-dbus perl-x11-protocol perl-lwp-protocol-https
* Completamento automático na linha de comando -> sudo pacman -S bash-completion
* Tradutor de idiomas para a linha de comando: sudo pacman -S translate-shell aspell aspell-pt rlwrap
* Substituto para o comando **"ls"** com diversas funcionalidades -> sudo pacman -S lsd
* Idem acima, mas para o comando **"cat"** -> sudo pacman -S bat
* ~~NÃO --> Servidor de Música -> sudo pacman -S mpd mpc~~
* Aplicativo utilizado para efetuar o "auto start" de alguns programas -> sudo pacman -S dex
* Servidor Gráfico (Xorg) -> sudo pacman -S xf86-video-intel xorg-server xorg-apps xorg-xinit xorg-xev xsel xclip ttf-font
* Fontes: sudo pacman -S terminus-font ttf-victor-mono-nerd otf-firamono-nerd otf-fira-sans
* Temas e _"engines"_ GTK -> sudo ~~pacman -S sassc gtk-engines gtk-engine-murrine~~ gnome-themes-extra papirus-icon-theme
* Ferramentas gráficas -> sudo pacman -S feh libheif libid3tag libjxl libspectre libwebp openjpeg2 jpegexiforient imagemagick libraw libwmf libzip ocl-icd djvulibre
* Compositor gráfico para o Xorg -> sudo pacman -S picom
* ~~NÃO --> ~Adiciona interface gráfica (GTK) ao editor VIM -> sudo pacman -S gvim~~
* ~~NÃO --> Visualizador de imagens, também com interface GTK -> sudo pacman -S pqiv~~
* ~~NÃO --> Leitor de documentos PDF, também com interface GTK -> sudo pacman -S zathura zathura-pdf-poppler~~
* Emulador de Terminal para o ambiente gráfico -> sudo pacman -S alacritty
* Fonte utilizada pelo Alacritty: sudo pacman -Sy otf-firamono-nerd

## Uma pequena pausa

Após a instalação dos pacotes acima, fiz uma pausa para compilar e instalar a versão modificada do **DWM** que eu criei. Aproveitei também para
instalar as versões modificadas do **Dmenu**, que é uma dependência do mesmo, e do emulador de terminais **"St"**, que uso como emulador alternativo
ao **Alacritty** em algumas situações bem específicas. Esta versões que utilizo do **Dmenu** e do emulador **"St"** também foram modificadas com a aplicação
de vários _"patches"_. A ideia com essa pausa na instalação era poder dar partida no ambiente gráfico e utilizar certas facilidades oferecidas pelo
**Alacritty** (como _"copiar e colar"_, por exemplo) para prosseguir com a instalação dos demais pacotes.

## Prosseguindo com a instalação de mais pacotes

* ~~Gerenciador de Arquivos -> sudo pacman -S ranger ffmpegthumbnailer highlight libcaca mediainfo odt2txt perl-image-exiftool perl-archive-zip python-chardet transmission-cli ueberzug~~
* Gerenciador de Arquivos com interface GTK -> sudo pacman -S pcmanfm-gtk3 xarchiver unarj unrar 
* Navegador para internet -> yay -S google-chrome
* Gerenciador de pacotes JScript que é dependência de várias aplicações -> sudo pacman -S npm
* _"Daemon"_ para notificações -> sudo pacman -S dunst
* ~Visualizador para arquivos _Markdown_ (".md") -> sudo pacman -S glow  ------- ou e também! ------- sudo pacman -S mdcat (já instalado como root)~
* Dependência do pacote i3lock-color -> sudo pacman -S xcb-util-xrm
* Aplicativo usado para "travar" a tela -> yay -S i3lock-color
* Verifica por erros em bash scripts (dependência do bash-language-server) -> sudo pacman -S shellcheck
* Player Multimídia: vídeo, Youtube, etc. -> sudo pacman -S mpv yt-dlp rtmpdump atomicparsley aria2 python-mutagen python-pycryptodomex python-websockets
* Editor de imagens -> sudo pacman -S gimp
* Editor de gráficos vetoriais -> sudo pacman -S inkscape
* Aplicativo para imprimir a tela (printscreen) -> sudo pacman -S maim xdotool
* Editor de texto alternativo ao vim com melhor suporte para LSPs -> sudo pacman -S helix
* Cliente para tldr (alternativa às "man pages") -> sudo pacman -S tealdeer
* Neovim: alternativa ao VIM com novos recursos -> sudo pacman -S neovim 
* Dependências para instalçação do AstroNvim -> sudo pacman -S xclip xsel tree-sitter tree-sitter-cli ripgrep lazygit gdu fzf the_silver_searcher lua-language-server

## Linguagens & LSPs

* Lua -> sudo pacman -S lua luajit luarocks
* Bash -> sudo pacman -S bash-language-server npm shellcheck
* Markdown -> sudo pacman -S marksman -------- ou! ---------- pacman -S vscode-markdown-languageserver
* C -> sudo clang openmp llvm lldb
* Go -> sudo pacman -S gopls delve debuginfod elfutils go-tools revive

* Python -> sudo pacman -S python-pip python-lsprotocol python-lsp-server python-mccabe python-pycodestyle python-pydocstyle python-pyflakes python-pylint python-rope autopep8 flake8 yapf python-whatthepatch python-appdirs python-sphinx python-tabulate
* RUBY -> sudo pacman -S ruby ruby-irb ruby-rdoc ruby-docs
* LSP para RUBY -> gem install solargraph
* CLI para RUBY (melhor que o irb instalado acima) -> gem install pry
* Toml -> sudo pacman -S taplo
* CSS -> sudo pacman -S vscode-css-languageserver
* HTML -> sudo pacman -S vscode-html-languageserver
* JSCRIPT -> sudo pacman -S typescript-language-server
* Typescript -> sudo pacman -S typescript-language-server
* JSON -> sudo pacman -S vscode-json-languageserver
