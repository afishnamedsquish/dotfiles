New Linux Setup
---------------

* Install applications

	sudo apt-get install chromium-browser xclip git curl zsh ack-grep tmux
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep 

* Git identity

    git config --global user.email ben@vtdesignworks.com
    git config --global user.name Ben Glassman

* Generate ssh key

	mkdir ~/.ssh
	chmod 700 ~/.ssh
	ssh-keygen -t rsa

* Install oh-my-zsh

	curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

* Install dotfiles	

	git clone git@github.com:benglass/dotfiles.git
    git submodule update --init
	rm ~/.bashrc
	rm ~/.zshrc
	sh dotfiles/install.sh
	chsh -s /bin/zsh $USER

* Set solarized as color scheme

    https://gist.github.com/gmodarelli/5942850

* Set caps lock to control

    sudoedit /etc/default/keyboard

        edit the line with XKBOPTONS to include ctrl:nocaps (options separated by comma)
        XKBOPTIONS="ctrl:nocaps"

    sudo dpkg-reconfigure keyboard-configuration

    The above only seems to work if you are using gnome, so once I started using xmonad it doesnt work and I created
        ~/.xinitrc
    and added
        # Remap caps lock
        xmodmap ~/.Xmodmap

* Install xmonad with xmobar and launcher

    sudo apt-get install gnome-panel xmonad xmobar suckless-tools

* Install php/composer

    # php5
    sudo add-apt-repository ppa:ondrej/php5
    sudo apt-get update && sudo apt-get install php5 php5-{cli,dev,mysql,sqlite,json,intl,imagick,gd,curl,xdebug}

    # composer
    cd ~ && curl -sS https://getcomposer.org/installer | php && chmod u+x ~/composer.phar && sudo mv ~/composer.phar /usr/local/bin/composer

* Install skype

    sudo dpkg --add-architecture i386
    sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    sudo apt-get update && sudo apt-get install skype
