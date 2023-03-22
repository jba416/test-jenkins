CID=$( git rev-parse HEAD )
git show --stat=1000
echo "Files and folders:"
git show --stat=1000 | egrep '((.*/)*.+.tf)'
path=$(git show --stat=1000 | egrep '((.*/)*.+.tf)')
proj_folders=$(echo "$paths" | xargs -L 1 dirname)
json=$( echo -n "[" ; git show --stat=1000 | egrep '((.*/)*.+.tf)' | echo "$proj_folders" | sort -u | ( c=""; while read line; do echo -n "$c\"$line\""; c=","; done ) ; echo "]" )
if [ "$?" == "0" -a "$json" != "[]" ]; then
 echo "::set-output name=value::$json"
else
 echo "Failed to find updates in folders"
 exit 1
fi


