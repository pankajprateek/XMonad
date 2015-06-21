# This script is taken from https://raw.github.com/multiphrenic/dotfiles/master/makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles/old             # old dotfiles backup directory
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
for f in * 
do 
    if [ $f != makesymlinks.sh ] && [ $f != old ]; then 
        echo "Moving $f to $olddir"
        mv ~/.$f $olddir
        echo "Creating symlink to $f in home directory."
        ln -s $dir/$f ~/.$f
    fi
done
