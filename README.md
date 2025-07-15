# Arch Linux Post Install Scripts

Esse repositório contém alguns scripts pós instalação para cada ambiente desktop escolhido no <b>arch install script</b>.<br>
Cada pacote foi escolhido da melhor forma que se integra ao ambiente desktop alvo, e cada passo do script é opcional.<br>

Esse script jamais deve ser executado como super usuário, quando necessário será exigido o uso da senha do <b>root</b>.<br>
Todo script será executado dentro da pasta <code>HOME</code> do usuário criado na instalação do Arch (UID 1000).<br>
Antes do processo passo a passo, será feita uma atualização completa do sistema <code>sudo pacman -Syyu</code>

### Os pacotes serão instalados via pacman com os parâmetros:
- <code>sudo</code> Instalar como <b>root</b> é obrigatório para cada passo;
- <code>--needed</code> Instalar somente os pacotes que não foram instalados durante a instalação do Arch;
- <code>--noconfirm</code> Não pede confirmação caso haja necessidade;

###

## Atualmente o repositório contém os seguintes scripts:

<b>Cinnamon 6.4.X</b>
<details>
  <summary>Clique para expandir</summary>
  
  ## Passos do script para Cinnamon Desktop
  1. Pacotes de compactadores / descompactadores: unzip zip unrar 7zip xz;
  2. Pacotes adicionais: base-devel bash-completion blueman fastfetch ffmpegthumbnailer git man power-profiles-daemon reflector system-config-printer;
  3. Serviços: bluez (Bluetooth) cups touchegg speech-dispatcher;
  4. Pacotes Xorg e Wayland;
  5. CIFS Utils, NTFS 3G, GVFS e exFAT;
  6. Fontes Noto Fonts, Fira Sans Fonts, Fira Code, Adobe Source Fonts, Ubuntu Fonts, Roboto;
  7. Adwaita Icons, Adwaita Fonts, Adwaita Themes;
  8. Todos os pacotes do cinnamon;
  9. Pacotes e plucins do NEMO;
  10. Firefox (pt-br);
  12. Libreoffice (pt-br);
  13. Thunderbird (pt-br);
  14. Drawing (Paint), Peek (Captura de tela) e gThumb (Visualizador de imagens);
  15. Aplicativos GNOME: Calculator, Characres, Calendar, File Roller, Disk Utility, Font Viewer, Screenshots, MPV, Seahorse;
  16. Cinnamon XAPPS: xed, xreader, xapp framework;
  17. Yet Another Yogurt (YAY Package manager para o Arch User Repository);
  18. Pacotes encontrados no AUR: lightdm-settings, bulky renamer, GNOME Online Accounts GTK
  19. Remove os pacotes que não são necesários ou duplicados: VIM, HTOP, Engrampa
  20. Configura o grupo autologin para o usuário ID 1000 (Que foi especificado no archinstall script);
  21. Configura as pastas do usuário como: Vídeos, Músicas, Imagens, Rede e outras (Usando pt-BR);
  22. Instala Fluent GTK + Fluent Icon theme;
  23. Ajusta o Fluent GTK + Fluent Icon theme;
</details>



Fique avontade para contribuir e melhorar essa lista de pacotes 🙏
