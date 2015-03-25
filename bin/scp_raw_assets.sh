# SCP RAW ASSETS
#
# copies raw_assets directory (psds, source images, etc.) 
# to or from dreamhost via scp. 
#
# @flags:
#	-f if included, copies from dreamhost to local; otherwise copy is from local to dreamhost
#
set -e

server="phds@franck.dreamhost.com"
path="/home/phds/raw_assets/glass/"
local_dir="raw_assets/"
from_server=0

function copy {
	if([ "$from_server" = 1 ]); then
		echo "copying from ${server}:${path} to ${local_dir}"
		scp -r "${server}:${path}" "${local_dir}"
	else
		echo "copying from ${local_dir} to ${server}:${path}"
		scp -r "${local_dir}" "${server}:${path}"
	fi
}

while getopts "f" opt; do
	case $opt in
		f)
			from_server=1
			;;
	    \?)
	    	printf "\nERROR: INVALID OPTION: -$OPTARG\n" >&2
	    	exit 1
	    	;;
	    :)
	    	printf "\nERROR: OPTION -$OPTARG REQUIRES AN ARGUMENT\n" >&2
	    	exit 1
	    	;;
  esac
done

copy

exit 0