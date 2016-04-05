#!/bin/bash

# small function to print the help message
usage()
{
cat << EOF
Usage: iconGen [options...] <source file> <destination folder>

Notice, the source image should be in png format, and should be square.

Options
 -a     Generate Android icons
 -d     Generate miscellaneous Android icons
 -h     Show this message
 -i     Generate iOS app icons
 -o     Generate miscellaneous iOS icons 
 -s     Generate iOS App Store icons
EOF
}

# make sure they passed in the source and destination
if [[ -z $2 ]] || [[ -z $3 ]]; then
	usage
	exit 1
fi

SRC=$2
DEST=$3

A=
D=
I=
O=
S=
COUNTER=0

# parse options
while getopts "adhios" OPT
do
	case $OPT in
		a)
			A=true
			;;
		d)
			D=true
			;;
		h)
			usage
			exit 1
			;;
		i)
			I=true
			;;
		o)
			O=true
			;;
		s)
			S=true
			;;
		*)
			usage
			exit 1
			;;
	esac
done

echo "Working..."
# remove possibly pre-existing folder
rm -rf ${DEST}
mkdir ${DEST}

# sizes for Android icons
if test "$A" == true; then
	mkdir "${DEST}/Android"
	mkdir "${DEST}/Android/ldpi"
	sips --resampleWidth 36   "${SRC}" --out "${DEST}/Android/ldpi/ic_launcher.png" > /dev/null
	mkdir "${DEST}/Android/mdpi"
	sips --resampleWidth 48   "${SRC}" --out "${DEST}/Android/mdpi/ic_launcher.png" > /dev/null
	mkdir "${DEST}/Android/hdpi"
	sips --resampleWidth 72   "${SRC}" --out "${DEST}/Android/hdpi/ic_launcher.png" > /dev/null
	mkdir "${DEST}/Android/xhdpi"
	sips --resampleWidth 96   "${SRC}" --out "${DEST}/Android/xhdpi/ic_launcher.png" > /dev/null
	mkdir "${DEST}/Android/xxhdpi"
	sips --resampleWidth 144  "${SRC}" --out "${DEST}/Android/xxhdpi/ic_launcher.png" > /dev/null
	mkdir "${DEST}/Android/xxxhdpi"
 	sips --resampleWidth 192  "${SRC}" --out "${DEST}/Android/xxxhdpi/ic_launcher.png" > /dev/null
	COUNTER=$((COUNTER + 6))
fi

# miscellaneous sizes for Android icons
if test "$D" == true; then
	sips --resampleWidth 100  "${SRC}" --out "${DEST}/notification_icon_lg.png" > /dev/null
	COUNTER=$((COUNTER + 1))
fi

# sizes for iOS icons
if test "$I" == true; then
	mkdir "${DEST}/iOS"
	sips --resampleWidth 57    "${SRC}" --out "${DEST}/iOS/Icon.png" > /dev/null
	sips --resampleWidth 114   "${SRC}" --out "${DEST}/iOS/Icon@2x.png" > /dev/null
	sips --resampleWidth 171   "${SRC}" --out "${DEST}/iOS/Icon@3x.png" > /dev/null
	
	sips --resampleWidth 120   "${SRC}" --out "${DEST}/iOS/Icon-60@2x.png" > /dev/null
	sips --resampleWidth 180   "${SRC}" --out "${DEST}/iOS/Icon-60@3x.png" > /dev/null
	
	sips --resampleWidth 72    "${SRC}" --out "${DEST}/iOS/Icon-72.png" > /dev/null
	sips --resampleWidth 144   "${SRC}" --out "${DEST}/iOS/Icon-72@2x.png" > /dev/null
	
	sips --resampleWidth 76    "${SRC}" --out "${DEST}/iOS/Icon-76.png" > /dev/null
	sips --resampleWidth 152   "${SRC}" --out "${DEST}/iOS/Icon-76@2x.png" > /dev/null
	
	sips --resampleWidth 167   "${SRC}" --out "${DEST}/iOS/Icon-Pro.png" > /dev/null
	COUNTER=$((COUNTER + 10))
fi

# sizes for misc iOS icons
if test "$O" == true; then
	mkdir "${DEST}/misc_iOS"
	sips --resampleWidth 29    "${SRC}" --out "${DEST}/misc_iOS/Icon-Small.png" > /dev/null
	sips --resampleWidth 58    "${SRC}" --out "${DEST}/misc_iOS/Icon-Small@2x.png" > /dev/null
	sips --resampleWidth 87    "${SRC}" --out "${DEST}/misc_iOS/Icon-Small@3x.png" > /dev/null
	
	sips --resampleWidth 40    "${SRC}" --out "${DEST}/misc_iOS/Icon-Small-40.png" > /dev/null
	sips --resampleWidth 80    "${SRC}" --out "${DEST}/misc_iOS/Icon-Small-40@2x.png" > /dev/null
	sips --resampleWidth 120   "${SRC}" --out "${DEST}/misc_iOS/Icon-Small-40@3x.png" > /dev/null
	
	sips --resampleWidth 50    "${SRC}" --out "${DEST}/misc_iOS/Icon-Small-50.png" > /dev/null
	sips --resampleWidth 100   "${SRC}" --out "${DEST}/misc_iOS/Icon-Small-50@2x.png" > /dev/null
	COUNTER=$((COUNTER + 8))
fi

# sizes for iOS App Store, etc
if test "$S" == true; then
	mkdir "${DEST}/iOS_store"
	sips --resampleWidth 512  "${SRC}" --out "${DEST}/iOS_store/iTunesArtwork" > /dev/null
	sips --resampleWidth 1024 "${SRC}" --out "${DEST}/iOS_store/iTunesArtwork@2x" > /dev/null
	COUNTER=$((COUNTER + 2))
fi

echo "Conversion complete, generated $COUNTER icons in ${DEST} folder."
