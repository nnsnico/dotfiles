Installation
============

#. Install powerline_

   #. ``pip3 install powerline-status``

   #. ``cp -r $(pip3 show powerline-status | grep Location | awk '{print $2}')/powerline/config_file ~/.config/powerline``

#. Add symbolic link

   - ``ln -s ~/dotfiles/tmux/.tmux.conf``

   - ``ln -s ~/.config/powerline/themes/powerline.json ~/dotfiles/tmux/powerline.json``

.. _powerline: https://github.com/powerline/powerline
