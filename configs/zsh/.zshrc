# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/zsh/"
source $ZSH/oh-my-zsh.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# TEMI BELLI: af-magic

#################
# CONFIGURATION #
#################

# special keys emacs
bindkey -e

### UPDATE ###
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7    # (days)

HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000


### PLUGINS ###
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # aliases & autocompletion
    git
    aliases
    alias-finder
    archlinux
    common-aliases
    docker
    docker-compose
    encode64
    gcloud
    helm
    history
    isodate
    kubectl
    minikube
    mvn
    pip
    python
    spring
    systemadmin
    systemd
    terraform

    # utilities
    compleat
    catimg
    command-not-found
    chucknorris
    copybuffer

    dirhistory
    dircycle

    extract
    fancy-ctrl-z

    gitfast
    jsontoolts

    man
    safe-paste
    sudo
    thefuck
    theme
    z
    zsh-interactive-cd

    # format and style
    colored-man-pages
    colorize
    emojy
    rand-quote

    # app info
    branch
    kubectx
    kube-ps1
    virtualenv
)

### colorize settings ###
ZSH_COLORIZE_STYLE="colorful"
# set nuber of colors
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

######################
# ZSH AUTOCOMPLETION #
######################
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/stev/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{cyan}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="%F{cyan}waiting...%f"

##################
# AUTOCOMPLETION #
##################
###########
# SOURCES #
###########
source ~/.config/zsh/alias
source ~/.config/zsh/functions
source ~/.config/zsh/bayo.zsh-theme

####################
# UNUSED OH-MY-ZSH #
####################

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
