#!/bin/bash
echo "Запуск скрипта!!"
copy_with_unique_name() {
	local src=$1
	local dst=$2
	local name=$(basename "$src")
	local base="${name%.*}"
	local extension="${name##*.}"
	local k=1

	while [ -e "$dst/$base($k).$extension" ]
	do
        	k=$((k + 1))
	done

	cp "$src" "$dst/$base($k).$extension"
}

read -p "Входная директория: " fdir
read -p "Выходная директория: " sdir

echo "(1) Список файликов в $fdir:"
for f in "$fdir"/*
do
	if [ -f "$f" ]
	then
		echo "$(basename "$f")"
	fi
done

echo "(2) Список директорий в $fdir:"
for dir in "$fdir"/* 
do
	if [ -d "$dir" ]
	then
		echo "$(basename "$dir")"
	fi
done

echo "(3) Список всех файликов, вложенных в $fdir:"
find "$fdir" -type f


spisok=$(find "$fdir" -type f)
for f in $spisok
do
	if [ -f "$f" ]
	then
		name=$(basename "$f")
        	if [ -e "$sdir/$name" ]
		then
            		copy_with_unique_name "$f" "$sdir"
        	else
            		cp "$f" "$sdir"
        	fi
    	fi
done

echo "Проверка! Список файликов в $sdir:"
ls $sdir
echo "Конец скрипта!! Хорошего дня! :)"
