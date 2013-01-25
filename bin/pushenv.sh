#!/usr/bin/env bash
###########
# Push key, terminfo, bashrc, etc to remote box if not already present
#
#

# Install key if not already present
KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAuUb4VaH/K2F1HqvgPeljbWsrHVD5Xd1LQ4kDVy+wNYDYpUHroDpLhArTs4TtNjG0hIAbz9T/QfT8bT+vvo1cAg7DNu44BVECtlbwExG0q/A77V/IdEl8rh5DLh8iGdFNVzdazKTs9SP9vMAQ3UMcQg2erz0jgXmFIIf6SiNbARQJrbtW7RPVjFVEF2/pJeSRykhxxNy2Zdlc9pYFZKA/+5NagdxVwbINMnHVefw80p5wksrR+feAmv7LjJBuudbEXssdbbYiDeR2gfWPxmTVNdUF6eainUhAbYhyNjgOoSjyuLzY952Z01MW/Wf+ZXX4oCB2FG7jPfwuSC+1cxYxEw=="
CMD="if [[ ! -f ~/.ssh/authorized_keys ]] then; mkdir ~/.ssh && echo $KEY >> ~/.ssh/authorized_keys && \
      chmod 700 ~/.ssh && chmod 600 ~/.ssh/*; fi;"

# Push bashrc if not already present

# Perform operations
ssh $1 -c "$METACMD"
