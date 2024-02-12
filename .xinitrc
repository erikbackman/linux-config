setxkbmap se
xset m 20/10 4
#hsetroot -solid "#282c34"
hsetroot -solid "#181818"
sxhkd -c /home/ebn/.config/sxhkd/sxhkdrc &
dunst &
picom &

exec ewm
