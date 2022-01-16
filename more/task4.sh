#!/bin/bash
: '
Написать скрипт, который из /etc/passwd выведет
название командного интерпретатора для пользователя,
имя которого передано скрипту в качестве параметра.
'

# Если кол-во переданных параметров не 1
if [[ $(($#)) -ne 1 ]] ; then
    echo "Ошибка: Необходимо передать параметр в виде имени пользователя" >&2
    exit 1
fi

#Пользователь, которого будем искать
user_name=$1
#Расположение файла
file_path="/etc/passwd"

#Строка с пользователем
full_str=$(cat $file_path | grep $user_name)

#Если строка пустая - пользователя нет
if [ "$full_str" = "" ]; then
    echo "Пользователя $user_name не существует в $file_path"

#Если пользователь существует - выводим его командный интерпретатор
else
    home_dir=$(echo $full_str | awk '{split($0,a,":"); print a[7]}')
    echo "Пользователь $user_name, командный интерпретатор $home_dir"
fi

