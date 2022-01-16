#!/bin/bash
: '
Необходимо перенести файлы, имеющие расширения,
переданные в качестве параметра, из каталога data в каталог tabs.
'

#Фильтрация данных
if [[ $(($#)) -ne 1 ]] ; then
     echo "Ошибка: Заданы не все параметры" >&2
     exit 1
fi

#Текущий каталог
current_path=$(pwd)

#Переход в папку data
cd data

#Перемещение всех файлов с указанным расширением в каталог tabs
mv *$1 ../tabs 2>/dev/null

#Переход к начальному пути, откуда запускали скрипт
cd $current_path
