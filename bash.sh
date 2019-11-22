bashrc

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias usage='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias ls="ls --color"

# Powerline
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi

# Linux Lite Custom Terminal
LLVER=$(awk '{print}' /etc/llver)

echo -e "Welcome to $LLVER ${USER}"
echo " "
date "+%A %d %B %Y, %T"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
echo "Support - https://www.linuxliteos.com/forums/ (Right click, Open Link)"
echo " "
export CATALINA_HOME=/opt/tomcat


profile

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
GTK_MODULES="$GTK_MODULES:canberra-gtk-module"
export GTK_MODULES

export PKG_CONFIG_PATH=/usr/local/share/pkgconfig
export ORACLE_HOME=/usr/lib/oracle/19.3/client64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib:$ORACLE_HOME

export OCI_HOME=/usr/lib/oracle/19.3/client64/lib
export OCI_LIB_DIR=$ORACLE_HOME/lib
export OCI_INC_DIR=/usr/include/oracle/19.3/client64
export OCI_INCLUDE_DIR=/usr/include/oracle/19.3/client64
export OCI_VERSION=12

export PATH=$PATH:$ORACLE_HOME/bin
export C_INCLUDE_PATH=/usr/include:/usr/include/oracle/19.3/client64:/usr/local/include

export SMFDESCARGA=/app/data/iSGL/webservices/data_smf/recibido/
export SMFASIGNACION=/app/data/iSGL/webservices/data_smf/asignaciones/
export CONFIG_PATH_ESPECIFICAS=/app/data/iSGL/batch_process/isgl/programas/config_files/config_isgl_descarga_smf.xml
export ISGL_BATCH_PROGRAM=/app/data/iSGL/batch_process/isgl/programas/ISGL_BATCH.jar
export CONFIG_PATH_DESCARGA_SGC=/app/data/iSGL/batch_process/isgl/programas/config_files/config_isgl_descarga_sgc.xml
export CONFIG_PATH_SMF_ISGL=/app/data/iSGL/batch_process/isgl/programas/config_files/config_isgl_carga_smf.xml