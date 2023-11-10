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

Para verificar as opções possíveis para ```[nome_do_mapa_do_teclado]``` você pode utilizar o seguinte comando: 

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

O Arch Linux possui uma ferramenta denominada **iwctl** para facilitar o estabelecimento de uma conexão wi-fi via terminal. Ela apresenta um prompt de comando interativo que permite a entrada de comandos e a obtenção de informações para facilitar este processo. Para começar, digite ```iwctl``` e pressione a tecla ```ENTER```. A partir desse momento você estará no prompt interativo do **iwctl**. O primeiro comando a executar é este:

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

## Particionamento

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

