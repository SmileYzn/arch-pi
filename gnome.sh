#!/bin/bash

# Texto
NEGRITO=$(tput bold)
REGULAR=$(tput sgr0)

# Divisor
DIVISOR=$(printf '=%.0s' {1..70})

# Cores
VERMELHO="\e[31m"
VERDE="\e[32m"
AMARELO="\e[33m"
MAGENTA="\e[35m"
CIANO="\e[36m"
NORMAL="\e[0m"

# Ambiente
DE=$(gnome-shell --version)

# Usuário padrão (UID 1000)
USUARIO=$(id -nu 1000)

clear

# Mensagem inicial
echo -e $DIVISOR
echo -e "${NEGRITO}${CIANO}Arch Linux pós instalação: ${VERDE}${DE}${NORMAL}"
echo -e $DIVISOR

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
  echo -e "${VERMELHO}${NEGRITO}Esse script NÃO deve ser executado como ${USER}${REGULAR}${NORMAL}"
exit
fi

# Verificar ambiente do cinnamon
if [[ $DE != "GNOME"* ]]; then
  echo -e "${VERMELHO}${NEGRITO}Ambiente ${VERDE}GNOME Shell${VERMELHO} não instalado.${REGULAR}${NORMAL}"
exit
fi

# Atualizar sistema
echo -en "${NEGRITO}${VERDE}Atualizar o sistema? (sim / não): ${REGULAR}${NORMAL}"
read -p "" opcao
echo -e $DIVISOR
if [[ $opcao -eq "sim" || $opcao -eq "s" ]]; then
  sudo pacman -Syyu --needed --noconfirm
  echo -e ""
else
  echo -e "${VERMELHO}${NEGRITO}Atualização não executada, saindo do script.${REGULAR}${NORMAL}"
exit
fi

# Array de tarefas
TAREFA=(
  "Pacotes base do Arch"
  "XDG Desktop"
  "Bluetooth, CUPS"
  "Xorg Apps, Wayland e XWayland"
  "Sistema de arquivos e Rede"
  "Fontes adicionais"
  "Adwaita Resources"
  "GNOME Shell Extensions, Tweaks"
  "Extras do Nautilus"
  "Firefox"
  "Thunderbird"
  "LibreOffice (Fresh)"
  "Evince, Loupe, Peek"
  "Extras do GNOME"
  "Yet Another Yogurt (YAY)"
  "Limpeza de pacotes"
  "Criar grupo 'autologin'"
  "Instalar Colloid Theme"
)

# Executar
executar()
{
  if [ "$1" -ge 0 ] && [ "$1" -le 17 ]; then
    echo -e "${VERDE}${1}${NORMAL} ${TAREFA[${1}]}"
    echo -e $DIVISOR
  fi

  case $1 in
    0)
      sudo pacman -S --needed --noconfirm 7zip base-devel bash-completion fastfetch ffmpegthumbnailer git man power-profiles-daemon reflector system-config-printer unzip unrar xz zip
    ;;
    1)
      # Pacotes XDG Desktop e User Dirs
      sudo pacman -S --needed --noconfirm xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gnome xdg-utils
      
      # Abrir pasta do usuário atual
      cd /home/$USUARIO

      # Criar pastas
      mkdir Desktop Downloads Modelos Rede Documentos Músicas Imagens Vídeos

      # Atualizar pastas
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

      # Remover pastas antigas
      rm -rf Documents Music Pictures Public Templates Videos
    ;;
    2)
      # Instalar serviços
      sudo pacman -S --needed --noconfirm bluez cups

      # Habilitar via systemctl
      sudo systemctl enable bluetooth cups
    ;;
    3)
      sudo pacman -S --needed --noconfirm xorg-apps xorg-xwayland numlockx wayland
    ;;
    4)
      sudo pacman -S --needed --noconfirm cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd
    ;;
    5)
      # Pacotes de fonte
      sudo pacman -S --needed --noconfirm adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family

      # Atualizar cache
      sudo fc-cache -f -v
    ;;
    6)
      sudo pacman -S --needed --noconfirm adwaita-cursors adwaita-fonts adwaita-icon-theme adwaita-icon-theme-legacy
    ;;
    7)
      sudo pacman -S --needed --noconfirm gnome-shell-extensions gnome-tweaks
    ;;
    8)
      sudo pacman -S --needed --noconfirm nautilus-image-converter nautilus-share seahorse-nautilus sushi
    ;;
    9)
      sudo pacman -S --needed --noconfirm firefox firefox-i18n-pt-br
    ;;
    10)
      sudo pacman -S --needed --noconfirm thunderbird thunderbird-i18n-pt-br
    ;;
    11)
      sudo pacman -S --needed --noconfirm libreoffice-fresh libreoffice-fresh-pt-br
    ;;
    12)
      sudo pacman -S --needed --noconfirm evince loupe peek
    ;;
    13)
      sudo pacman -S --needed --noconfirm baobab dconf-editor file-roller gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-disk-utility gnome-font-viewer gnome-online-accounts gnome-screenshot gnome-system-monitor seahorse totem
    ;;
    14)
      # Instalar o pacote YAY no modo binário
      git clone https://aur.archlinux.org/yay-bin.git
      cd yay-bin
      makepkg -si --needed --noconfirm
      cd ..
      rm -rf yay-bin
    ;;
    15)
        # Limpar pacotes
        sudo pacman -R engrampa htop vim vim-runtime

        # Limpar pacotes
        sudo pacman -Rcs $(pacman -Qdtq)
    ;;
    16)
        # Adicionar grupo autologin
        sudo groupadd -r autologin

        # Adicionar o usuário ao grupo
        sudo gpasswd autologin -a ${USUARIO}
    ;;
    17)
      # Abrir pasta do usuário
      cd /home/$USUARIO

      # Clonar Colloid gtk theme e Colloid icon theme
      git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
      git clone https://github.com/vinceliuice/Colloid-icon-theme.git

      # Instalar GTK
      cd /home/$USUARIO/Colloid-gtk-theme
      sudo ./install.sh --tweaks rimless
      ./install.sh --tweaks rimless
      ./install.sh --tweaks rimless -c dark -l fixed
      
      # Instalar ícones
      cd /home/$USUARIO/Colloid-icon-theme
      sudo ./install.sh

      # Instalar cursor
      cd /home/$USUARIO/Colloid-icon-theme/cursors
      sudo ./install.sh
    ;;
    *)
      echo -e "${VERMELHO}Opção '$1' não encontrada.${NORMAL}"
    ;;
  esac
}

# Menu Inicial
mostrarMenu()
{
  clear
  echo -e $DIVISOR
  echo -e "${NEGRITO}${CIANO}Arch Linux pós instalação: ${VERDE}${DE}${NORMAL}"
  echo -e $DIVISOR
  echo -e "${MAGENTA}Opções de pós instalação${NORMAL}"
  echo -e $DIVISOR

  for ((i=0; i < ${#TAREFA[@]}; i++)); do
    echo -e "${VERDE}${i}.${NORMAL} ${TAREFA[${i}]}"
  done

  echo -e $DIVISOR
  echo -e "${MAGENTA}Digite um número ou os números (Exemplo: 0 3 9 11)${NORMAL}"
  echo -e "${MAGENTA}Digite ${AZUL}'todos'${MAGENTA} para executar tudo${NORMAL}"
  echo -e "${MAGENTA}Digite ${AZUL}'sair'${MAGENTA} para sair${NORMAL}"
  echo -e $DIVISOR
  echo -en "${VERDE}${NEGRITO}Digite as opções: ${NORMAL}"
}

# Loop
while true; do
  
  # Menu inicial
  mostrarMenu

  # Ler opcoes em array
  read -a opcoes

  # Loop das opções selecionadas
  for opcao in "${opcoes[@]}"; do
    # Executar opção específica
    if [ "$opcao" -ge 0 ] && [ "$opcao" -le 17 ]; then
      clear
      echo -e $DIVISOR
      executar $opcao
      echo -e $DIVISOR
      read -p "${NEGRITO}${TAREFA[${opcao}]} executado.${REGULAR}"
    # Todas opções
    elif [[ $opcao == "todos" ]]; then
      clear
      for ((i=0; i < ${#TAREFA[@]}; i++)); do
        executar $i
      done
      echo -e $DIVISOR
      read -p "${NEGRITO}Passos executados com sucesso.${REGULAR}"
    # Sair do script se for outra coisa
    elif [[ $opcao == "sair" ]]; then
      clear
      echo -e "${NEGRITO}${CIANO}Saindo do script, até logo.${NORMAL}${REGULAR}"
      exit
    else
      clear
      echo -e "${NEGRITO}${VERMELHO}Opção '${opcao}' não encontrada.${NORMAL}${REGULAR}"
      read -p ""
    fi
  done
done
