# COPY MODELS TO GLASS
#
# copies models/ directory (.blend, materials, etc.) 
# to or from ../glass unity repo
#
# @flags:
#	-s (sub_dir) - if included, only copys sub directory specified; otherwise copies all of models/
#	-f if included, copies from unity glass; otherwise copy is to ../glass
#
set -e

unity_dir="../glass/Assets/models"
local_dir="models"
sub_dir=""
from_unity=0

function copy {
	if([ "$from_unity" = 1 ]); then
		echo "copying from ${unity_dir}/${sub_dir} to ${local_dir}/"
		cp -r "${unity_dir}/${sub_dir}" "${local_dir}/"
	else
		echo "copying from ${local_dir}/${sub_dir} to ${unity_dir}/"
		cp -r "${local_dir}/${sub_dir}" "${unity_dir}/"
	fi
}

while getopts "s:f" opt; do
	case $opt in
		s)
			sub_dir=$OPTARG
			;;
		f)
			from_unity=1
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