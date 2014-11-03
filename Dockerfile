FROM ubuntu:trusty
MAINTAINER ksondere

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Set up my development softwares
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim tmux git zsh curl fontconfig exuberant-ctags
RUN chsh -s /bin/zsh

# Set up my user
RUN useradd ksondere -u 1000 -s /bin/zsh
RUN mkdir -p /home/ksondere/workspace && chown -R ksondere:ksondere /home/ksondere
USER ksondere

WORKDIR /home/ksondere/workspace
ENV HOME /home/ksondere

# Dotfiles
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
RUN git clone https://github.com/mdouchement/dotfiles.git $HOME/dotfiles

## Powerline fonts
RUN mkdir /home/ksondere/.fonts; \
    cp $HOME/dotfiles/fonts/Sauce_Code_Powerline_Medium.otf $HOME/.fonts/; \
    fc-cache -vf $HOME/.fonts/

COPY /install_dotfiles.sh $HOME/dotfiles/install_dotfiles.sh
RUN $HOME/dotfiles/install_dotfiles.sh

VOLUME /home/ksondere

CMD /bin/zsh
