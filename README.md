# dotfiles

Personal dotfiles repository

## Install on a new system

See [Acknowledgements](#Acknowledgements) for tutorial source.

* Prior to the installation, create alias for config
  * `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`
* Add `.cfg` to `.gitignore`
  * `echo ".cfg" >> .gitignore`
* Clone dotfiles into a bare repository
  * `git clone --bare <git-repo-url> $HOME/.cfg`
* Define the alias in the current shell scope
  * `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`
* Checkout content from bare repository to `$HOME`
  * `config checkout`
* Step above might fail with a message like:
  * ```
    error: The following untracked working tree files would be overwritten by checkout:
        .bashrc
        .gitignore
    Please move or remove them before you can switch branches.
    Aborting
    ```
* Delete `.bashrc` and `.gitignore`
  * `rm ~/.bashrc ~/.gitignore`
* Re-run checkout
  * `config checkout`
* Set the flag `showUntrackedFiles` to `no` on this specific (local) repo
  * `config config --local status.showUntrackedFiles no`

## Acknowledgements

I followed [DistroTube](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg)'s process for setting up a git bare repository as shown in [Git Bare Repository - A Better Way To Manage Dotfiles](https://youtu.be/tBoLDpTWVOM).
He references [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles) by [Nicola Paolucci](https://www.durdn.com/).
