#!/bin/bash
#
# Cores
VERMELHO="\e[31m"
VERDE="\e[32m"
AMARELO="\e[33m"
AZUL="\e[34m"
MAGENTA="\e[35m"
CIANO="\e[36m"
NORMAL="\e[0m"
NEGRITO=$(tput bold)
REGULAR=$(tput sgr0)
DIVISOR=$(printf '=%.0s' {1..50})
#
# Configuraçãoes
PASSO=1
USUARIO=$(id -nu 1000)
DE=$(cinnamon --version)
#
# Verificar acesso ROOT
if [[ $EUID -eq 0 ]]; then
    clear
    echo -e "${NEGRITO}${VERMELHO}ATENÇÃO: Esse script NÃO deve ser executado como ${USER}.${NORMAL}"
    exit 1
fi
#
# Verificar instalação do cinnamon
if [[ $DE != "Cinnamon"* ]]; then
    clear
    echo -e "${NEGRITO}${VERMELHO}ATENÇÃO: Ambiente ${VERDE}Cinnamion Desktop ${VERMELHO}não instalado.${NORMAL}"
    exit 1
fi
#
# Introdução ao script
clear
echo -e $DIVISOR
echo -e "${NEGRITO}${MAGENTA}Arch Linux Pós Instalação: ${VERDE}${DE}${NORMAL}"
echo -e $DIVISOR
echo -e "${NEGRITO}${VERMELHO}OS PASSOS A SEGUIR DEVEM TER SIDO REALIZADOS:${NORMAL}"
echo -e $DIVISOR
echo -e "${VERDE}1. ${NORMAL}A instalação do Arch ocorreu com sucesso."
echo -e "${VERDE}2. ${NORMAL}O ambiente instalado foi: ${VERDE}${DE}."
echo -e "${VERDE}2. ${NORMAL}O ${VERDE}LightDM Slick Greeter${NORMAL} foi instalado."
echo -e "${VERDE}3. ${NORMAL}Foi configurado um usuário padrão (UID 1000)."
echo -e "${VERDE}4. ${NORMAL}Ler atentamente a cada passo do script."
echo -e "${VERDE}5. ${NORMAL}Cada passo pode ser aceito com ${VERDE}${NEGRITO}sim${REGULAR}${NORMAL} ou recusado com ${VERMELHO}${NEGRITO}não${REGULAR}."
echo -e $DIVISOR
#
# Continuar com script
read -p "ATENÇÃO: Continuar com o script?: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "não" || "$resposta" == "n" ]]; then
    clear
    echo -e "${AMARELO}Saindo do script sem nenhuma alteração no sistema, até breve.${NORMAL}"
    exit 1
else
    cd /home/${USUARIO}
    echo -e "${AMARELO}Agora vamos atualizar seu sistema, confirme no prompt a seguir.${NORMAL}"
    sudo pacman -Syyu --needed --noconfirm
    clear
fi
#
# Pacotes de compactação
read -p "${PASSO}. Compactar / Descompactar: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando pacotes"
    sudo pacman -S --needed --noconfirm unzip zip unrar 7zip xz
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Pacotes adicionais do sistema Arch
read -p "${PASSO}. Pacotes adicionais do sistema Arch: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando pacotes base"
    sudo pacman -S --needed --noconfirm base-devel bash-completion blueman fastfetch ffmpegthumbnailer git man power-profiles-daemon reflector system-config-printer
    echo -e "${CIANO}${PASSO}.2${NORMAL} - Instalando pacotes XDG Desktop"
    sudo pacman -S --needed --noconfirm xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-xapp xdg-utils
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Serviços
read -p "${PASSO}. Serviços Bluetooth, CUPS, Toucheeg e Speech Dispatcher: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando pacotes de serviços"
    sudo pacman -S --needed --noconfirm bluez cups touchegg speech-dispatcher
    echo -e "${CIANO}${PASSO}.2${NORMAL} - Habilitando serviços"
    sudo systemctl enable bluetooth cups touchegg speech-dispatcherd
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Xorg, Wayland e XWayland
read -p "${PASSO}. Xorg, Wayland e XWayland: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando pacotes"
    sudo pacman -S --needed --noconfirm numlockx xorg-apps wayland xorg-xwayland labwc
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Sistema de arquivos, compartilhamento e rede
read -p "${PASSO}. Sistema de arquivos, compartilhamento e rede: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando pacotes"
    sudo pacman -S --needed --noconfirm cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Fontes adicionais
read -p "${PASSO}. Noto Fonts, Fira Sans, Ubuntu, Adobe Source, Roboto: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando fontes"
    sudo pacman -S --needed --noconfirm adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Adwaita
read -p "${PASSO}. Adwaita Resources: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando resources Adwaita"
    sudo pacman -S --needed --noconfirm adwaita-cursors adwaita-fonts adwaita-icon-theme adwaita-icon-theme-legacy
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Cinnamon
read -p "${PASSO}. Extras do Cinnamon: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando Extras do ${DE}"
    sudo pacman -S --needed --noconfirm cinnamon cinnamon-control-center cinnamon-desktop cinnamon-menus cinnamon-screensaver cinnamon-session cinnamon-translations
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Nemo
read -p "${PASSO}. Extras do Nemo: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando extras do Nemo"
    sudo pacman -S --needed --noconfirm nemo nemo-audio-tab nemo-emblems nemo-fileroller nemo-image-converter nemo-pastebin nemo-preview nemo-seahorse nemo-share
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Firefox
read -p "${PASSO}. Firefox: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando Firefox"
    sudo pacman -S --needed --noconfirm firefox firefox-i18n-pt-br
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Drawing, gThumb, Peek
read -p "${PASSO}. Drawing, gThumb, Peek: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando Drawing, gThumb, Peek"
    sudo pacman -S --needed --noconfirm drawing peek gthumb
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Instalar Libreoffice (FRESH)
read -p "${PASSO}. Instalar Libreoffice (FRESH): " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando Libreoffice"
    sudo pacman -S --needed --noconfirm libreoffice-fresh libreoffice-fresh-pt-br
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Extras do GNOME
read -p "${PASSO}. Extras do GNOME: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando extras do GNOME"
    sudo pacman -S --needed --noconfirm baobab dconf-editor file-roller gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-disk-utility gnome-font-viewer gnome-online-accounts gnome-screenshot gnome-system-monitor mpv seahorse
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Extras do Cinnamon
read -p "${PASSO}. Extras do ${DE} (XAPPS): " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Extras do ${DE} (XAPPS)"
    sudo pacman -S --needed --noconfirm xapp xed xreader
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Yet Another Yogurt (YAY)
read -p "${PASSO}. Yet Another Yogurt (YAY): " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando Yet Another Yogurt (YAY)"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --needed --noconfirm
    cd ..
    rm -rf yay-bin
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Outros pacotes do AUR
read -p "${PASSO}. Pacotes disponíveis apenas no Arch User Repository: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Instalando pacotes extras do AUR"
    yay -S --needed --noconfirm bulky gnome-online-accounts-gtk lightdm-settings
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Remover: vim, htop (E executar limpeza?)
read -p "${PASSO}. Remover: vim, htopm engrampa e limpar pacotes: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Removendo e limpando"
    sudo pacman -R engrampa htop vim vim-runtime
    sudo pacman -Rcs $(pacman -Qdtq)
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Criar e configurar grupo autologin para
read -p "${PASSO}. Criar e configurar grupo autologin para ${USUARIO}: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Adicionando grupos"
    sudo groupadd -r autologin
    sudo gpasswd autologin -a eu
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Configurar user-dirs.dirs
read -p "${PASSO}. Configurar user-dirs.dirs: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Criando pastas do usuário."
    mkdir Desktop Downloads Modelos Rede Documentos Músicas Imagens Vídeos
    echo -e "${CIANO}${PASSO}.2${NORMAL} - Atualizando XDG User Dirs."
    xdg-user-dirs-update
    xdg-user-dirs-update --force --set DESKTOP /home/$USUARIO/Desktop
    xdg-user-dirs-update --force --set DOWNLOAD /home/$USUARIO/Downloads
    xdg-user-dirs-update --force --set TEMPLATES /home/$USUARIO/Modelos
    xdg-user-dirs-update --force --set PUBLICSHARE /home/$USUARIO/Rede
    xdg-user-dirs-update --force --set DOCUMENTS /home/$USUARIO/Documentos
    xdg-user-dirs-update --force --set MUSIC /home/$USUARIO/Músicas
    xdg-user-dirs-update --force --set PICTURES /home/$USUARIO/Imagens
    xdg-user-dirs-update --force --set VIDEOS /home/$USUARIO/Vídeos
    xdg-user-dirs-update
    echo -e "${CIANO}${PASSO}.3${NORMAL} - Removendo pastas antigas."
    rm -rf Documents Music Pictures Public Templates Videos
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Instalar Fluent GTK Theme e Fluent Icons
read -p "${PASSO}. Instalar Fluent GTK Theme e Fluent Icon Theme: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Clonando Fluent GTK Theme"
    cd /home/${USUARIO}
    git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
    echo -e "${CIANO}${PASSO}.2${NORMAL} - Instalando Fluent GTK Theme"
    cd Fluent-gtk-theme
    sudo ./install.sh -i arch -s standard --tweaks solid
    ./install.sh -i arch -s standard --tweaks solid
    ./install.sh -i arch -s standard --tweaks solid -c dark -l
    cd /home/${USUARIO}
    rm -rf Fluent-gtk-theme

    echo -e "${CIANO}${PASSO}.3${NORMAL} - Clonando Fluent Icon Theme"
    cd /home/${USUARIO}
    git clone https://github.com/vinceliuice/Fluent-icon-theme.git
    echo -e "${CIANO}${PASSO}.4${NORMAL} - Instalando Fluent Icon Theme"
    cd Fluent-icon-theme
    sudo ./install.sh
    cd cursors
    sudo ./install.sh
    cd /home/${USUARIO}
    rm -rf Fluent-icon-theme
fi
PASSO=$((PASSO+1))
echo -e $DIVISOR
#
# Setar Fluent GTK Theme e Fluent Icon Theme
read -p "${PASSO}. Setar Fluent GTK Theme e Fluent Icon Theme: " resposta
resposta=$(echo "$resposta" | tr '[:upper:]' '[:lower:]')
if [[ "$resposta" == "sim" || "$resposta" == "s" ]]; then
    clear
    echo -e "${CIANO}${PASSO}.1${NORMAL} - Ajustando tema para ${AZUL}Fluent Dark${NORMAL}"
    gsettings set org.cinnamon.theme name "Fluent-Dark"

    gsettings set org.cinnamon.desktop.interface gtk-theme "Fluent-Dark"
    gsettings set org.cinnamon.desktop.interface icon-theme "Fluent-dark"
    gsettings set org.cinnamon.desktop.interface cursor-theme "Fluent-dark-cursors"

    gsettings set org.gnome.desktop.interface gtk-theme "Fluent-Dark"
    gsettings set org.gnome.desktop.interface icon-theme "Fluent-dark"
    gsettings set org.gnome.desktop.interface cursor-theme "Fluent-dark-cursors"
    gsettings set org.gnome.desktop.wm.preferences theme "Fluent-Dark"
fi
#
# Fim do script
echo -e $DIVISOR
echo -e "${VERDE}Arch Linux Pós Instalação Finalizado com sucesso.${NORMAL}"
echo -e $DIVISOR
#
exit 0
