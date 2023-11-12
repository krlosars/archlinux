# Instalando o Arch Linux

Este é um roteiro simplificado para instalação do **Arch Linux**. Ele pressupõe que você possua alguns **conhecimentos básicos** sobre os seguintes assuntos:

* Efetuar downloads e usar arquivos torrent
* Conferir integridade de arquivos usando SHA256
* Baixar e gravar imagens de instalação
* Lidando com a interface de setup da BIOS
* Efetuar a partida ("boot") a partir de pendrives
* Configurar uma conexão para a internet via terminal
* Efetuar o particionamento de unidades de discos
* Utilização do terminal linux e também shell script
* Utilização de editores de texto para console

Se você não possui ao menos um nível de conhecimento básico sobre os temas acima, possivelmente o Arch Linux não seja a melhor opção para você. Sugiro que utilize uma parte do seu tempo para adquirir alguma familiaridade com estes tópicos antes de tentar fazer sua primeira instalação do Arch Linux.

## Fontes consultadas

* https://wiki.archlinux.org/index.php/Installation_guide_(Portugu%C3%AAs)

* https://www.gnu.org/software/grub/manual/grub/html_node/Installing-GRUB-using-grub_002dinstall.html

* https://diolinux.com.br/sistemas-operacionais/arch-linux/como-instalar-arch-linux-tutorial-iniciantes.html

* https://martins2010.wordpress.com/category/informatica/linux-informatica/arch-linux

* https://gist.github.com/fjpalacios/441f2f6d27f25ee238b9bfcb068865db

## Importante: verificação de compatibilidade EFI

Este guia parte do princípio que você esteja utilizando um computador cuja BIOS seja compatível com o padrão EFI. Para verificar, utilize:

```sh
ls /sys/firmware/efi/efivars
```

Outra forma:

```sh
cat /sys/firmware/efi/fw_platform_size
```

Se o comando retornar 64, então o sistema foi inicializado no modo UEFI e tem um UEFI x64 de 64 bits. Este guia pressupõe que este seja o seu caso.

## Baixando e gravando a imagem ISO para instalação

O arquivo ISO para gerar um pendrive de instalação para o Arch Linux pode ser encontrada no seguinte endereço:

* https://archlinux.org/download

Nessa página há várias opções para download. É importante, também, baixar os Checksums (ao menos o SHA256!) para verificar a integridade da imagem ISO baixada antes de efetuar sua gravação em um pendrive. Após os downloads e a verificação do arquivo ISO, você pode utilizar um aplicativo como o Ventoy ou mesmo usar o terminal para efetuar a gravação:

```sh
dd if=[caminho para a ISO] of=[dispositivo do pendrive] bs=4M status=progress
```

Você deve substituir os dados inseridos em [] acima. No meu caso, ficou assim:

```sh
dd if=archlinux-2023.11.01-x86_64.iso of=/dev/sdb bs=4M status=progress
```

Lembrando que você deve apontar o caminho exato para a imagem ISO, caso não esteja no mesmo diretório para o qual ela foi baixada, e que a identificação do dispositivo pode variar em função do seu computador.

## Efetuando a reinicialização a partir do pendrive

Após concluir as etapas acima, você deverá efetuar a reinicialização do seu computador com o pendrive inserido. Lembre-se de acessar a interface de setup da BIOS para verificar se as configurações que permitem efetuar a partida a partir de um pendrive. Geralmente isso implica em manter a tecla ```DEL``` pressionada após ligar o computador, mas isso pode variar de máquina para máquina.

## Definir o layout do teclado e a fonte de exibição

Após realizar a inicialização (demora um pouquinho) com o pendrive, você receberá algumas mensagens de boas-vindas e informações sobre inicialização da Internet. Antes de efetuar qualquer coisa, no entanto, é necessário configurar o layout do seu teclado para que ele funcione adequadamente. Para isso nós utilizamos o comando **loadkeys** da seguinte forma: 

```sh
loadkeys [nome_do_mapa_do_teclado]
``` 

Para verificar as opções possíveis para `[nome_do_mapa_do_teclado]` você pode utilizar o seguinte comando: 

```sh
ls /usr/share/kbd/keymaps/**/*.map.gz
``` 

Caso você tenha ideia de qual seja o layout do seu teclado, você pode utilizar o comando **grep** para agilizar a pesquisa. Por exemplo... Para um teclado com layout brasileiro:

```sh
ls /usr/share/kbd/keymaps/**/*.map.gz | grep br
```

No meu caso o nome do meu mapa de teclado é **br-abnt2**. Este é o teclado mais comum na maioria dos casos, mas você deverá testar para ver se está tudo ok. O importante é que teclas importantes como "." e "/" estejam funcionando bem. Assumindo que seu teclado seja semelhante ao meu, teríamos o comando da seguinte forma:


```sh
loadkeys br-abnt2
```


Talvez o cedilha e alguns acentos não funcionem direito em um primeiro momento por conta da fonte utilizada por padrão no terminal, mas isso pode ser modificado depois. Uma fonte que costuma ser legal é a Terminus, que oferece uma boa legibilidade. Para utilizá-la em lugar da fonte padrão, utilize:

```sh
setfont ter-124n
```

Esta fonte costuma exibir todos os o cedilha e todos os acentos de forma perfeita, além de possuir um tamanho maior e uma aparência mais legível que a fonte padrão.

## Testando e configurando o acesso à Internet

Se o seu acesso à Internet é cabeado, então possivelmente você já estará conectado. Caso seu acesso seja via wi-fi, será necessário utilizar o aplicativo **iwctl** para efetuar sua conexão. Eu vou explicar isso mais à frente, mas primeiro é necessário verificar se sua interface de rede está ativa e, em estando, se você está conectado à internet ou não. Para verificar o status de sua interface de rede, utilize o comando **ip** desta forma:

```sh
ip link
```

Se tudo estiver ok, você deve receber uma saída semelhante a esta:

```sh
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp2s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 7c:83:34:b9:6b:36 brd ff:ff:ff:ff:ff:ff
3: wlp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DORMANT group default qlen 1000
    link/ether 94:e2:3c:2e:7a:84 brd ff:ff:ff:ff:ff:ff
```

Esta saída varia de computador para computador, mas o importante é que os dispositivos de rede estão listados e ativos. Já para verificar se você está conectado à Internet, iremos utilizar o comando **ping** para tentar enviar e receber pacotes de teste a um site qualquer:

```sh
ping -c 4 google.com
```

Caso você esteja conectado, receberá uma mensagem parecida com esta:

```sh
PING google.com (142.251.135.78) 56(84) bytes de dados.
64 bytes de rio09s07-in-f14.1e100.net (142.251.135.78): icmp_seq=1 ttl=58 tempo=10.5 ms
64 bytes de rio09s07-in-f14.1e100.net (142.251.135.78): icmp_seq=2 ttl=58 tempo=14.6 ms
64 bytes de rio09s07-in-f14.1e100.net (142.251.135.78): icmp_seq=3 ttl=58 tempo=12.8 ms
64 bytes de rio09s07-in-f14.1e100.net (142.251.135.78): icmp_seq=4 ttl=58 tempo=11.6 ms
--- google.com estatísticas de ping ---
4 pacotes transmitidos, 4 recebidos, 0% packet loss, time 3003ms
rtt min/avg/max/mdev = 10.536/12.367/14.575/1.499 ms
```

Se algo semelhante ao exposto acima não for exibido, possivelmente você precisará configurar sua conexão manualmente, a partir do terminal. Para facilitar esta tarefa em conexões wi-fi, o Arch Linux disponibiliza a ferramenta **iwctl**. Vou falar sobre ela a seguir.

### Utilizando a ferramenta iwctl para configurar uma conexão wi-fi

Antes de iniciar o estabelecimento da conexão wi-fi propriamente dita, utilizaremos o comando **rfkill** para verificar se existe algum bloqueio estabelecido para este tipo de conexão. Use:

```sh
rfkill list
```

É possível que você receba uma saída semelhante a esta:

```sh
0: hci0: Bluetooth
	Soft blocked: no
	Hard blocked: no
1: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no
```

Caso algum dos dispositivos esteja bloqueado, você poderá utilizar uma vez mais o comando **rfkill** para desfazer o bloqueio:

```sh
rfkill unblock wifi
```

Feitas estas verificações e ajustes, se necessários, podemos continuar com as ações necessárias ao estabelecimento de uma conexão wi-fi;

O Arch Linux possui uma ferramenta denominada **iwctl** para facilitar o estabelecimento de uma conexão wi-fi via terminal. Ela apresenta um prompt de comando interativo que permite a entrada de comandos e a obtenção de informações para facilitar este processo. Para começar, digite `iwctl` e pressione a tecla `ENTER`. A partir desse momento você estará no prompt interativo do **iwctl**. O primeiro comando a executar é este:

```sh
device list
```

Este comando irá informar o nome do dispositivo a ser utilizado para o estabelecimento de uma conexão wi-fi. Geralmente, é algo como **wlan0**, mas isto também pode variar. Uma vez descoberto o nome do dispositivo, deveremos prosseguir com alguns outros comandos necessários. Nos exemplos abaixo utilizarei **wlan0** como nome do dispositivo: lembre-se de substituí-lo por outro caso necessário.

```sh
station wlan0 scan 
```

O comando acima irá efetuar uma varredura para encontrar os pontos de acesso wi-fi disponíveis. Para listá-los, utilize:

```sh
station wlan0 get-networks
```

Para tentar a conexão a um ponto de acesso, utilize o comando abaixo substituindo **[acesspoint]** pelo nome estabelecido para o seu roteador:

```sh
station wlan0 connect [accesspoint]
```

No meu caso, seria algo como:

```sh
station wlan0 connect minhacasalnx
```

Isto porque **"minhacasalnx"** é o nome do ponto de acesso aqui de casa. Você deverá substituir, como já dito, pelo correspondente à sua rede. Após o comando acima, será solicitado que você digite a senha para acesso à rede. Ela não será exibida enquanto você digita, então é necessário que proceda com calma e atenção. Após digitar a senha, pressione a tecla **ENTER** para confirmar. Se tudo correr bem, sua conexão à Internet através de sua rede wi-fi acaba de ser realizada. Basta apenas digitar o comando para sair do prompt interativo da ferramenta **iwctl**:

```sh
quit
```


existe ainda a opção de conexão usando um modem de internet móvel, e neste caso seria usada um utilitário denominado **mmcli**. Como não possuo experiência nem com este tipo de modem e nem com o utilitário em questão, prefiro não tecer outros comentários a respeito.

## Verificando e ajustando o horário no relógio do sistema

Para verificar, use:

```sh
timedatectl status
```

Você terá uma saída _"semelhante"_ a esta:

```sh
               Local time: sex 2023-11-10 20:26:06 -03
           Universal time: sex 2023-11-10 23:26:06 UTC
                 RTC time: sex 2023-11-10 23:26:06
                Time zone: America/Sao_Paulo (-03, -0300)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

Digo _"semelhante"_ porque, neste ponto da instalação, possivelmente o horário e o fuso horário estarão diferentes da saída acima. Para verificar possíveis fusos horários, utilize use o comando abaixo:

```sh
timedatectl list-timezones
```

Uma dica importante! O fuso horário padrão para a maior parte do Brasil é identificado, na saída do comando acima, como **"America/Sao_Paulo"**. Assim sendo, precisaremos utilizar os comandos abaixo para ajustar o fuso horário e o relógio do sistema:

```sh
timedatectl set-timezone America/São_Paulo
timedatectl set-ntp true 
```

O segundo comando, na realidade, atualiza o relógio do sistema após a redefinição do fuso horário feita pelo comando anterior.

## Particionamento, formatação e montagem

Você pode utilizar o comando **fdisk** para obter informações sobre sua(s) unidade(s) de disco:

```sh
fdisk -l 
```

A resposta irá variar de máquina para máquina. No meu PC, que utiliza uma unidade **SSD** de 128G, a saída foi esta:

```sh
Disk /dev/sda: 119,24 GiB, 128035676160 bytes, 250069680 sectors
Disk model: 128GB SSD       
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A3587901-5F9E-45AA-96FB-C413E713CC33

Device       Start       End   Sectors   Size Type
/dev/sda1     2048   1230847   1228800   600M EFI System
/dev/sda2  1230848   3327999   2097152     1G Linux filesystem
/dev/sda3  3328000 250068991 246740992 117,7G Linux filesystem


Disk /dev/zram0: 7,52 GiB, 8079278080 bytes, 1972480 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
```

O comando **lsblk** também pode ser utilizado, inclusive para verificar se existem partições montadas no momento. Use:

```sh
lsblk
```

Eis a saída que obtive em minha máquina atual:

```sh
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0 119,2G  0 disk 
├─sda1   8:1    0   600M  0 part /boot/efi
├─sda2   8:2    0     1G  0 part /boot
└─sda3   8:3    0 117,7G  0 part /home
                                 /
zram0  252:0    0   7,5G  0 disk [SWAP]
```

A sua saída, da mesma forma que citado em relação ao comando **fdisk** anterior, também será diferente. No momento da instalação do Arch Linux é possível que nenhuma partição esteja montada ainda, inclusive.

A partir daqui, você deverá efetuar o particionamento de sua unidade de disco utilizando a o prompt interativo oferecido pelo comando **fdisk** ou utilizando a ferramenta **cfdisk** que permite fazer este trabalho de uma forma mais simples:

```sh
cfdisk [dispositivo]
```

Onde **[dispositivo]** é a unidade que você deseja particionar. No meu caso, o comando completo ficaria assim:

```sh
cfdisk /dev/sda
```

Se você nunca realizou a instalação do Arch Linux antes, ou se não conhece nada sobre particionamento de unidades, esta é a hora de parar e estudar sobre o assunto, posto que você corre o risco de perder todos os dados que existam em sua unidade e/ou particionar a unidade de forma indevida e, com isso, inviabilizar a instalação ou atualização do Arch Linux.

Caso resolva prosseguir, seguem algumas dicas referentes às partições:

* Você deve criar uma partição específica para os arquivos que farão a inicialização do sistema. Esta partição terá seu ponto de montagem em ```/mnt/boot/efi``` e deve possuir, no mínimo, 300M segundo a página de instalação o Arch Linux. No entanto esta página fala da possibilidade de instalação de outros Kernels do Linux, recomendando, neste caso, um mínimo de 1GiB. Eu aconselho esta segunda opção. Esta partição deve ser definida como **EFI SYSTEM** quando particionada pela ferramenta **cfdisk**

* Você pode optar por criar uma partição reservada para memória de troca (SWAP). Esta área permanecerá ociosa até que ela seja requerida pelo sistema operacional a fim de prover uma maior capacidade de processamento para apoiar a memória RAM existente no computador. Meu computador possui 8GiB de RAM e eu utilizo apenas poucas aplicações e bem leves. Não é necessário para mim, mas pode ser para você. Uma dica, caso pretenda utilizar uma partição SWAP, é reservar no mínimo 1GiB para a mesma. Se possível, ao menos metade da capacidade da memória RAM instalada é outra opção, e ainda melhor. Isso vai depender da capacidade de disco que você pode e deseja utilizar para a partição SWAP. Outro ponto importante é que ela precisa ser definida como sendo do tipo **Linux Swap** quando de sua configuração na ferramenta **cfdisk**.

* Você vai precisar também criar ao menos uma partição para conter os arquivos que compõem o Arch Linux e os arquivos do(s) usuário(s). Há pessoas que gostam de criar uma partição em separado para os arquivos do(s) usuário(s). Há outros até que criam outras partições. Não irei abordar isso aqui embora já tenha usado este esquema de particionamento. O importante é que você não se esqueça de definir estas partições como do tipo **"Linux Filesystem"** na ferramenta **cfdisk** quando de sua configuração.

### Formatação

Após o particionamento das unidades, podemos começar a formatação das mesmas. Para simplificar, vou utilizar como exemplo uma unidade denominada **sda** que foi particionada em três partes:

* **sda1** será a partição destinada a conter os arquivos para inicialização do sistema.
* **sda2** será a partição destinada à memória de troca (SWAP).
* **sda3** irá conter os arquivos do usuário e a instalação do Arch Linux em si.

A primeira unidade a ser formatada é a _"partição de boot"_, ou seja, aquela destinada a conter os arquivos para inicialização do sistema. Seguindo o disposto no exemplo acima, iremos ter o seguinte comando:

```sh
mkfs.fat -F32 /dev/sda1
```

Em seguida, iremos formatar a partição SWAP. Você pode pular este passo caso não tenha definido uma partição para utilizar como memória de troca. Caso tenha optado por utilizá-la, use:

```sh
mkswap /dev/sda2
swapon /dev/sda2
```

O segundo comando é necessário para informar ao instalador que ele deverá utilizar a partição ```/dev/sda2``` como área destinada à memória de troca. É o equivalente ao processo de montagem das outras partições, que veremos a seguir.

Por último, vamos formatar a partição que irá conter os arquivos do usuário e também todos os arquivos que compõem o Arch Linux:

```sh
mkfs.ext4 -f /dev/sda3
```

Uma outra opção, mais moderna e com mais recursos, é a utilização do sistema de arquivos **btrfs**. Neste caso, o comando seria:

```sh
mkfs.btrfs -f /dev/sda3
```

Aconselho a segunda opção caso você tenha conhecimentos sobre como utilizar os recursos que o sistema **btrfs** disponibiliza ou tenha interesse em aprender sobre os mesmos. Caso não tenha interesse em se aprofundar no assunto, o sistema de arquivos **ext4** é uma ótima opção, inclusive recomendada como padrão na página que fala sobre a instalação do Arch Linux no site oficial.

### Montagem dos Sistemas de Arquivos

Após o particionamento e a formatação das partições é hora de realizar a montagem dos sistemas de arquivos. Iremos começar pela partição principal, que irá receber os arquivos que compõem o Arch Linux e os arquivos do(s) usuário(s):

```sh
mount /dev/sda3 /mnt
```

Importante lembrar que estou usando `/dev/sda3` porque estou seguindo o exemplo que foi explicado anteriormente. Você deve substituir `/dev/sda3` pelo que seja adequado à sua máquina e ao esquema de particionamento que definiu.

Agora que colocamos a partição principal em seu devido lugar, iremos criar um diretório na mesma onde iremos montar a partição que contém os arquivos de inicialização do sistema:

```sh
mkdir -P /mnt/boot/efi
```

Feito isso, vamos montar a _"partição de boot"_ neste diretório:

```sh
mount /dev/sda1 /mnt/boot/efi
```

Nossas partições estão montadas e prontas para receberem a instalação dos arquivos. Importante lembrar que, caso você tenha optado por usar uma partição destinada à memória de troca (SWAP), o procedimento equivalente já foi realizado quando do momento de sua formatação conforme descrito anteriormente. Se quiser, você pode utilizar o comando **lsblk** já descrito acima para verificar o resultado final do seu processo de particionamento, formatação e montagem.

## Aviso importante antes da instalação do Arch Linux

Os próximos passos envolverão a utilização do comando **reflector** para atualizar a lista de repositórios e o download e instalação dos arquivos do Arch Linux em si. Algumas vezes têm sido relatada a ocorrência desta mensagem de erro: **"invalid or corrupted package (PGP signature)"**. Caso isto ocorra, em algum momento, use:

```sh
pacman -Sy archlinux-keyring 
```

Eu sinceramente recomendo utilizar este comando mesmo antes de iniciar os processos que virão a seguir, como forma de se antecipar a eventuais problemas.

## Atualização e otimização da lista de repositórios

A fim de atualizarmos a lista de repositórios e obtermos o download a partir das cinco fontes com melhor desempenho no momento da instalação podemos utilizar os seguintes comandos:

```sh
pacman -Sy
pacman -S reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```

Há outras opções para otimização, como a seleção de um ou mais países para filtragem. Você pode consultar tais opções utilizando a ajuda do comando **reflector**, embora a forma descrita acima costume produzir bons resultados.

## Instalando os pacotes essenciais

Utilize o comando abaixo para efetuar a instalação dos pacotes essenciais que nos permitirão, posteriormente, efetuar um _"chroot"_, que é o acesso inicial ao sistema que instalaremos:

```sh
pacstrap /mnt linux linux-firmware base base-devel openssh dhcpcd vim
```

Você pode substituir o editor  **"vim"** na lista acima por outro editor com que esteja acostumado a trabalhar no terminal, tal como nano, micro, neovim, helix, etc. O importante é que seja um editor de modo texto, ou seja, para terminal, uma vez que ainda não teremos, neste primeiro momento, uma interfaca gráfica disponível.

## Gerando a tabela de partições

O arquivo **fstab** é responsável por informar ao sistema operacional sobre a forma como utilizamos nossas partições para organizar nosso sistema de arquivos. Para criá-lo, iremos usar este comando:

```sh
genfstab -U -p /mnt >> /mnt/etc/fstab
```

Após a criação do arquivo **fstab** você pode conferir se está tudo de acordo com o que definiu usando o comando abaixo:

```sh
cat /mnt/etc/fstab
```

Dica: você pode usar a saída do comando **lsblk** para verificar se o sistema de arquivos constante no arquivo **fstab** está de acordo com suas definições quando do processo de particionamento, formatação e montagem.

## Efetuando o "chroot" e as configurações iniciais

Uma vez que instalamos os pacotes essenciais e criamos o arquivo **fstab** contendo a tabela de partições, podemos utilizar o comando **arch-chroot** para acessar nosso sistema recém instalado e iniciar as configurações iniciais:

```sh
arch-chroot /mnt
```

### Localização: idioma, teclado e fuso horário

Uma vez que acessamos o novo sistema, iremos fazer sua localização, ou seja, iremos definir o idioma, forma de exibição de datas, moedas, etc. Para isto iremos editar o arquivo `/etc/locale.gen`. Você vai procurar uma linha contendo o seguinte texto:

```
# pt_BR.UTF-8 UTF-8
```

Após localizar a linha, remova o símbolo **"#"** e o espaço presentes no início da linha, a fim de que ela fique deste jeito:

```
pt_BR.UTF-8 UTF-8
```

Salve as alterações e feche o arquivo. Na sequência, use o comando abaixo para gerar os arquivos de localização do sistema:

```sh
locale-gen
```

Após a geração dos arquivos, precisaremos editar o arquivo xxx. Supondo que você esteja utilizando o editor de texto **"vim"** seria algo como:

```sh
vim /etc/locale.conf
```

Este arquivo possivelmente estará vazio. Preencha o mesmo com o seguinte conteúdo:

```
LANG=pt_BR.UTF-8
LANGUAGE=pt_BR
LC_ALL=C
```


#### Definindo o layout do teclado

Uma outra coisa importante é definir o layout do seu teclado de forma permanente no sistema recém-instalado. Vamos fazer isso alterando o arquivo `/etc/vconsole.conf` para que o mesmo tenha este conteúdo:

```
KEYMAP=br-abnt2
```

Lembre-se que a definição para o arquivo acima é válida apenas para teclados que possuam o layout **"br-abnt2"**. Se o seu teclado tem um layout diferente, será necessário adequar a definição acima no arquivo `/etc/vconsole.conf`. Também já expliquei sobre questões relativas a layout de teclados no início deste guia.

#### Ajuste do fuso horário

Vamos agora ajustar o fuso horário de forma permanente no sistema. Lembre-se que estou usando **"America/Sao_Paulo"** por ser o fuso horário padrão para a maior parte do Brasil, mas pode ser que em sua cidade seja outro. Já expliquei no início do guia tudo o que havia para ser dito sobre esta questão. Vamos aos comandos necessários:

```sh
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
```

Após executar os comandos acima, utilize o comando **date** para verificar se a data e hora do sistema estão atualizadas da forma correta.

## Configuração de rede

Primeiramente precisamos alterar o conteúdo do arquivo `/etc/hostname` para que ele armazene o nome com o qual você pretende identificar seu computador na sua rede doméstica. Há várias formas de fazer isso, e uma delas é editando o arquivo com seu editor de texto e incluindo o nome da sua máquina. Irei mostrar a seguir outras duas formas de fazer isso. Vou usar o nome **"makkumba"** (sem as aspas) como exemplo. A primeira forma é essa:

```sh
echo makumba >> /etc/hostname
```

Mas você também pode usar:

```sh
hostnamectl set-hostname makkumba
```

Sinta-se à vontade para usar qualquer um dos métodos: o resultado será o mesmo! O importante é que você utilize o mesmo nome em outro arquivo que vamos editar, o arquivo `/etc/hosts`. No meu caso, este arquivo ficaria assim:

```
127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 makkumba.localdomain makkumba
```

Você deve substituir as duas ocorrências de **makkumba** na terceira linha pelo mesmo nome que utilizou para definir sua máquina na rede a partir do arquivo `/etc/hostname`. Este é um ponto importante e que requer atenção.

## Instalação de pacotes complementares

Há vários outros pacotes que são úteis para prover recursos que você irá precisar para poder utilizar o Arch Linux após sua instalação. Alguns desses, tenha certeza, podem mesmo ser considerado como imprescindíveis. São pacotes relativamente pequenos e muito úteis: não deixe de instalar! Para isso, você vai usar o comando **pacman** seguido da lista de pacotes a instalar. Eu vou dividir em vários comandos para facilitar a leitura, mas você pode utilizar um único comando para instalar todos os pacotes da lista:

```sh
pacman -S dosfstools os-prober mtools networkmanager network-manager-applet
pacman -S wpa_supplicant wireless_tools iw iwd lynx dialog sudo
pacman -S grub efibootmgr fuse2 lzop libisoburn tk man-pages-pt_br
pacman -S intel-ucode git reflector lshw unzip htop wget
pacman -S pulseaudio alsa-utils alsa-plugins pavucontrol xdg-user-dirs
```

## Habilitação dos serviços de rede

É necessário que os serviços de rede sejam habilitados para serem iniciados automaticamente a partir da primeira reinicialização do sistema. Para isso, é necessário utilizar os seguintes comandos:

```sh
systemctl enable sshd
systemctl enable dhcpcd
systemctl enable NetworkManager
```

## Instalação do inicializador (GRUB)

Antes de começar, é preciso criar a imagem de pré-instalação do **GRUB**:

```sh
mkinitcpio -P
```

Após a geração da imagem, podemos instalar os arquivos:

```sh
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
```

Um detalhe é que você pode substituir o valor de **bootloader-id** por algo diferente de "arch", mas isso é totalmente desnecessário e pode até criar problemas. Agora precisamos finalizar a instalação do **GRUB** usando o comando abaixo:

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

## Definindo a senha do administrador ("root")

A senha para o administrador do sistema pode e deve ser modificada no momento da instalação inicial para que você possa fazer login ou utilizar privilégios de administrador quando necessário. Para isso, use o comando abaixo:

```sh
passwd
```

Após pressionar a tecla **ENTER**, o sistema solicitará que você entre com uma senha e em seguida digite a mesma senha para confirmação. Importante: a senha não será exibida durante a digitação.

## Adicionando uma conta de usuário

Não devemos utilizar o Arch Linux como usuário **"root"** (administrador) por questões de segurança. Em alguns momentos, no entanto, pode ser que você precise realizar algumas tarefas que requerem privilégios de administrador do sistema. A solução para isso é criar uma conta de usuário comum que possui acesso a tais privilégios apenas em momentos específicos onde estes são necessários. Para criar uma conta de usuário como essa, use o comando abaixo:

```sh
useradd -m -g users -G wheel,storage,power,audio krlao
```

Substitua **"krlao"** no comando acima pelo nome de usuário que você pretende usar para esta conta. Na sequência, iremos definir uma senha para esta conta. O processo será o mesmo que utilizamos para definir a senha do administrador. A única diferença será que utilizaremos o nome do usuário após o comando **passwd**:

```sh
passwd krlao
```

Uma vez mais é necessário que você substitua **"krlao"** pelo nome designado para a conta que está criando. Você pode criar contas com senhas iniciais para outras pessoas que utilizem o seu computador repetindo o processo acima. Após efetuarem o login, elas poderão redefinir suas senhas da mesma forma que você definiu a senha para o administrador, ou seja, usando o comando **passwd** sem especificar o nome de usuário.

### Conta de usuário sem acesso a privilégios administrativos

Criar uma conta de usuário que não tenha acesso a ações que requerem privilégios de administrador é simples e bastante útil caso você compartilhe seu computador com outras pessoas. Basta não incluir esse usuário no grupo **"wheel"**. Assim sendo, o comando para a criação da conta deste usuário ficaria assim:

```sh
useradd -m -g users -G storage,power,audio zearruela
```

Obviamente você deve substituir **"zearruela"** no comando acima pelo nome do usuário para o qual você deseja criar uma conta sem acesso a privilégios administrativos.

## Atribuindo permissões administrativas a um grupo de usuários

Para que usuários pertencentes ao grupo **"wheel"** possam ter acesso a privilégios de administração do sistema é necessário editar um arquivo especial. Para tal, é necessário este comando:

```sh
EDITOR=vim visudo
```

Se você estiver utilizando outro editor que não seja o **"vim"**, tal como o nano, neovim ou helix, por exemplo, você terá de modificar o comando a fim de indicar o nome do seu editor, como nos exemplos abaixo:

```sh
EDITOR=nano visudo
EDITOR=nvim visudo
EDITOR=helix visudo
```

Após abrir o arquivo para edição, vá até o final do mesmo. Próximo ao final há duas linhas para as quais eu gostaria de chamar sua atenção:

```
%wheel ALL=(ALL) NOPASSWD: ALL
```

e esta:

```
%wheel ALL=(ALL) ALL
```

Para descomentar qualquer uma das duas linhas é necessário remover o **"%"** inicial das mesmas. A primeira linha permite que usuários com acesso a privilégios de usuário executem ações que necessitem de tais permissões sem digitar senha alguma após terem efetuado seu login. A segunda opção, que é considerada **mais segura** (e é o padrão da maioria das distribuições) exige que estes usuários digitem suas senhas antes de executar qualquer ação administrativa. **Apenas uma das duas opções pode ser escolhida,** é importante ter isso em mente. Recomendo fortemente a segunda opção mesmo que você seja o único usuário do seu computador.

## Finalizando a instalação

Após finalizados todos os ajustes iniciais no sistema recém-instalado é necessário sair do mesmo a fim de desmontar todas as partições instaladas e reinicializar o computador. Para isso, execute a sequência de comandos abaixo, caso você não tenha criado uma partição SWAP:

```sh
exit
umount -R /mnt
systemctl power-off
```

Caso tenha criado uma partição destinada à memória de troca (SWAP), será necessário adicionar um comando extra:

```sh
exit
umount -R /mnt
swapoff /dev/sda2
systemctl power-off
```

**IMPORTANTE:** substitua `/dev/sda2` no comando acima pela partição que você definiu como partição SWAP, caso outra partição tenha sido definida para tal.


## Reinicializando

Após os comandos acima o seu computador será desligado. Aguarde alguns momentos e o religue novamente. Se tudo correr bem, em alguns instantes você será apresentado a uma tela de login no terminal, solicitando seu nome de usuário e senha. Utilize a conta que você definiu para seu usuário: não utilize a conta de administrador!

## Instalando o gerenciador Yay

Se você já leu algo sobre Arch Linux, deve ter ouvido falar de um repositório especial chamado **AUR** que contém contribuições de membros da comunidade de desenvolvimento da distribuição. O Acesso a estes pacotes não é realizado usando o comando **pacman**, mas através de outros gerenciadores de pacotes. Eu escolhi o **YAY** por vários motivos:

* Simplicidade: os comandos são os mesmos que o do **pacman**. Se você sabe usar o **pacman**, então automaticamente você sabe utilizar o ***YAY**.

* Estabilidade: é um projeto antigo e com uma enorme base de usuários, isso garante que eventuais problemas tenham uma menor chance de ocorrer e, uma vez que ocorram, tenham uma detecção e correção mais rápidas.

* Instalação: requer poucas dependências e sua instalação é bem simples, como veremos abaixo.

Você não deve utilizar a conta do administrador do sistema ("root") para instalar o **YAY**, mas irá precisar de uma conta de usuário com acesso a privilégios administrativos. Para instalar o **YAY**, utilize os comandos abaixo:

```sh
mkdir Sources
cd Sources
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Após a conclusão da instalação você pode sair do diretório **sources** e excluí-lo:

```sh
cd ..
rm -rf sources
```

Para fazer um teste, e para que você tenha um primeiro contato com o **YAY** vamos instalar um pequeno _applet_ que é extremamente útil: o **PulseAudio applet**. Ele será capaz de prover um ícone para controle do som assim que você estiver usando uma interface gráfica que tenha suporte ao recurso de _systray_, tal como o Gnome, KDE ou XFCE. Para instalar o **PulseAudio applet** utilize os comandos abaixo:

```sh
yay -S pa-applet-git
```

Fique atento ao processo de instalação porque o **YAY** pode requerer alguma ação sua ao longo do mesmo.

## Alguns outros recursos interessantes

Antes de passarmos à instalação de uma interface gráfica propriamente dita, vou citar alguns recursos úteis que você pode ou não vir a utilizar em função do tipo de computador que utiliza.

### Recursos para gerenciamento de conexões Bluetooth

O suporte para gerenciamento a conexão de dispositivos Bluetooth pode ser obtido através da instalação dos seguintes pacotes:

```sh
sudo pacman -S bluez bluez-utils blueman
```

Para que estes recursos estejam disponíveis a cada nova inicialização do sistema, utilize o comando abaixo:

```sh
sudo systemctl enable bluetooth
```

### Economia de bateria para laptops

Este serviço é inútil para quem utiliza um desktop, como eu, mas certamente é bem útil para quem utiliza um notebook. Pode ser o seu caso. Use estes comandos para instalar este recurso e para habilitá-lo quando da inicialização de seu notebook:

```sh
sudo pacman -S tlp tlp-rdw powertop acpi
sudo systemctl enable tlp
sudo systemctl enable tlp-sleep
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
```

### Implementando o SSD TRIM

> TRIM é um comando para a interface ATA (Advanced Technology Attachment). Quando o sistema operacional precisa dizer que o SSD está apagando arquivos e que essas páginas de arquivo precisam ser disponibilizadas para novas informações, o TRIM oferece essa funcionalidade. Em combinação com a Coleta de lixo, o TRIM funciona para limpar e organizar seu SSD, fazendo com que ele fique mais eficiente e prolongando sua vida útil.

Fonte: https://www.kingston.com/br/blog/pc-performance/ssd-garbage-collection-trim-explained

Este recurso é útil apenas para quem utiliza drives SSD como eu. Para implementá-lo e inicializá-lo, utilize:

```sh
sudo systemctl enable fstrim.timer
```

## Fim

O objetivo deste guia era apresentar a instalação básica do Arch Linux. Se você leu tudo o que foi colocado até aqui, talvez já esteja pronto para efetuar sua instalação e melhorá-la como quiser, com a instalação de um servidor gráfico como o Xorg ou Wayland, usando gerenciadores de janelas como o i3 ou Openbox ou mesmo instalando um ambiente desktop completo como o Gnome, KDE ou XFCE. Há muitos tutoriais que poderão ajudá-lo neste sentido. Há outros muito bons também, alguns elencados no início deste guia, bem como vídeos no YOUTUBE em relação ao Arch Linux, sua instalação e etc. Acho que dei minha pequena contribuição. Boa sorte!
