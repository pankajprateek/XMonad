# This script is taken from https://raw.github.com/multiphrenic/dotfiles/master/makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles/                    # dotfiles directory; must end with /
olddir=~/dotfiles/old/             # old dotfiles backup directory; must end with /
files="Xdefaults arbtt/categorize.cfg asoundrc bash_logout bash_profile bashrc config/mpd/mpd.conf config/systemd/user/emacs.service emacs emacs.d fehbg gitconfig i3/config xinitrc xmobarrc xmobarrc.up xmonad/README xmonad/xmonad.hs zprofile zsh_profile zshenv zshrc"
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for f in $files
do
    # echo `realpath $f` | sed "s|^$dir||"
    if [ $f != symlinks.sh ] && [ $f != old ]; then
	# temp=`echo $f | sed 's|/|@|g' | sed 's|^\([^@]*\)@.*$|\1|p'`
	# echo $temp
	# echo `realpath $temp | sed "s|$f$||"`
	#mkdir -pv $directory
        echo "Moving $f to $olddir"
        mv -v ~/.$f $olddir
        echo "Creating symlink to $f in home directory at ~/.$f."
        ln -sv $dir/$f ~/.$f
	echo
    fi
done
