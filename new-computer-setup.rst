New Linux Setup
---------------

* Install applications

	sudo apt-get install chromium-browser xclip git curl zsh ack-grep
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep 

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

