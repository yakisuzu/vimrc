function MKLINK(){
  f_link=~/`basename $1`
  f_file=$1

  if [ -L $f_link ]; then
    rm $f_link
  fi

  echo make $f_link
  ln -s $f_file $f_link

  unset f_link
  unset f_file
}

for i in `ls -A $(pwd)/git/.gitconfig`; do
  MKLINK $i
done
unset MKLINK

for k in `ls -A $(pwd)/git/.gitconfig_*`; do
  f_link=~/`basename $k`
  if [ -e $f_link ]; then
    echo exits $f_link
  else
    echo cp $f_link
    cp $k $f_link
  fi

  unset f_link
done
