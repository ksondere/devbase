FROM ubuntu:trusty
MAINTAINER mdouchement

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Set up my development softwares
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim tmux git zsh curl fontconfig exuberant-ctags

# Set up my user
RUN useradd mdouchement -u 1000 -s /bin/zsh

RUN mkdir -p /home/mdouchement/workspace
WORKDIR /home/mdouchement/workspace
ENV HOME /home/mdouchement

# Dotfiles
RUN chsh -s /bin/zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
RUN rm $HOME/.profile
RUN git clone https://github.com/mdouchement/dotfiles.git $HOME/dotfiles

## Powerline fonts
RUN mkdir /home/mdouchement/.fonts; \
    cp $HOME/dotfiles/fonts/Sauce_Code_Powerline_Medium.otf $HOME/.fonts/; \
    fc-cache -vf $HOME/.fonts/

COPY /install_dotfiles.sh $HOME/dotfiles/install_dotfiles.sh
RUN $HOME/dotfiles/install_dotfiles.sh

VOLUME /home/mdouchement
USER mdouchement

CMD /bin/zsh
