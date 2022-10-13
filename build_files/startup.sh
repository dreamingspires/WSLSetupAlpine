#!/bin/ash
echo 'Welcome to the Dreaming Spires Alpine initialisation program! Please enter your details below'
read -p 'Username: ' uservar
adduser $uservar -G wheel
wslpath="$1""\\rootfs"

echo "PS1='\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /home/$uservar/.profile
echo "export POETRY_HOME=/etc/poetry" >> /home/$uservar/.profile
echo "export PATH=/etc/poetry/bin:\$PATH" >> /home/$uservar/.profile
echo "[user]" > /etc/wsl.conf
echo "default=$uservar" >> /etc/wsl.conf
echo
su $uservar -c "git config --global core.editor \"nano\""

read -p 'Github user email: ' githubemail
su $uservar -c "git config --global user.email \"$githubemail\""
read -p 'Github user name: ' githubname
su $uservar -c "git config --global user.name \"$githubname\""

su $uservar -c "ssh-keygen -t ed25519 -C \"$githubemail\" -f /home/$uservar/.ssh/id_ed25519 -N \"\" -q"
cat /home/$uservar/.ssh/id_ed25519.pub
echo "To be placed at: https://github.com/settings/keys"
read -p "Put the ssh key above into your github under SSH and GPG keys in settings (enter to continue)"
echo
