function MKLINK(){
  f_link=~/`basename $1`
  f_file=$1

  if [ -L $f_link ]; then
    rm $f_link
  fi

  echo make $f_link
  ln -s $f_file $f_link
}

for i in `ls -A $(pwd)/git/.git*`; do
  MKLINK $i
done

