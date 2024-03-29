#!/bin/bash
: '
Напишите скрипт, который считает кол-во измененных в течении
последних 3 дней файлов из каталога, переданного как параметр и выводит на экран.
'

#Переданный каталог в виде параметра
LOCALE_DIR=$1

#Проверка на существование каталога
if [ -d $LOCALE_DIR ] 
then
    echo "Каталог $LOCALE_DIR существует."

    #Кол-во измененных в течении последних 3 дней файлов из каталога
    RESULT=$(find $LOCALE_DIR -mtime -3 -print | wc -l)
    #Вывод на экран
    echo "Кол-во измененных в течении последних 3 дней файлов из каталога $LOCALE_DIR = $RESULT"
    exit 0
else
    echo "Ошибка: Каталога $LOCALE_DIR не существует" >&2
    exit 1
fi