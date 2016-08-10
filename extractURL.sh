:
# FUN FUN FUN FUN

PN=`basename "$0"`
VER='1.3'

egrep -i '<a[ 	]+href[ 	]*=[ 	]*"?[^">]*"?.*>' "$@" |
    sed -e 's|.*<[aA][ 	][ 	]*[hH][rR][eE][fF][ 	]*=[ 	]*"*\([^">][^">]*\)"*[^>]*>.*|\1|g'