#!/usr/bin/env bash
###########
#
# Push terminfo for urxvt to remote box

HOST="$1"
#BASHRC=$(cat ~/.bashrc-remote)

echo "Install public key as well?"
read KEY

if [[ $KEY == "y" || $KEY == "yes" ]]
then
	ssh-copy-id $HOST
fi

scp /usr/share/terminfo/r/rxvt-unicode-256color ~/.bashrc-remote $HOST:/tmp/

ssh $HOST 'mkdir -p .terminfo/r && mv /tmp/rxvt-unicode-256color .terminfo/r/ \
		&& mv /tmp/.bashrc-remote .bashrc-remote \
		&& echo "source .bashrc-remote" >> .bashrc '
