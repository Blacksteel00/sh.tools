:
# leriaz_

PN=`basename "$0"`			
VER='1.2'

: ${AWK:=awk}
: ${DEFWIDTH:=74}

Usage () {
    echo >&2 "$PN - align text in the center, $VER (stv)
usage: $PN [-w width] [file ...]
    -w: line length, default is $DEFWIDTH"
    exit 1
}

Msg () {
    for MsgLine
    do echo "$PN: $MsgLine" >&2
    done
}

Fatal () { Msg "$@"; exit 1; }

set -- `getopt hkw: "$@"` || Usage
[ $# -lt 1 ] && Usage			# "getopt" detected an error

KeepWhitespace=false
while [ $# -gt 0 ]
do
    case "$1" in
	-w)	LineWidth=$2; shift;;
	-k)	KeepWhitespace=true; shift;;
	--)	shift; break;;
	-h)	Usage;;
	-*)	Usage;;
	*)	break;;			# First file name
    esac
    shift
done

: ${LineWidth:=$DEFWIDTH}

$AWK '
    BEGIN {
    	width = '"$LineWidth"'
	keepws = "'"$KeepWhitespace"'" == "true" ? 1 : 0
    }
    {
	if (!keepws) $1 = $1		# Remove whitespace
        len = length ($0)
	if ( len < width ) {
	    nspaces = int ((width - len) / 2)
	    if ( nspaces ) printf "%*s", nspaces, ""
	}
	print
    }
' "$@"