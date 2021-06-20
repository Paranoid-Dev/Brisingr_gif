#!/bin/bash

mkdir output
cd output

curl https://static.wikia.nocookie.net/inheritance/images/d/dc/Brisingr.svg > brisingr.svg
ffmpeg -i brisingr.svg -vf scale=720:1170 brisingr.png
magick convert brisingr.png -fill "#000000" +opaque none blackbrisingr.png

ffmpeg -i $(youtube-dl -f 313 --get-url https://youtu.be/AWKzr6n0ea0) -ss 00:00:10 -t 00:00:05 -c:v copy -c:a copy 4kfire.mp4
ffmpeg -i 4kfire.mp4 -vf "crop=720:1170:1560:255" -c:a copy 720p_fire.mp4
ffmpeg -i 720p_fire.mp4 frame%04d.png

for g in frame*
do
  magick composite -compose dstin blackbrisingr.png $g inter-$g
done

magick convert inter* -transparent black final-$g

gifski -W 720 -o Brisingr.gif final*

rm *.png *.svg *.mp4