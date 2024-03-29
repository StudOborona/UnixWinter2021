#!/bin/bash
: '
Напишите сценарий, который находил бы корни "квадратного" уравнения, вида: Ax^2 + Bx + C = 0.
Сценарий должен получать коэффициенты уравнения A, B и C, как аргументы командной строки,
и выводить корни. Если корней нет, вывод должен быть пустым.
'

echo "Коэффициент A = $1"
echo "Коэффициент B = $2"
echo "Коэффициент C = $3"

# Назначаем коэффы локальным переменным
a=$1
b=$2
c=$3

# Если кол-во параметров не 3
if [[ $(($#)) -ne 3 ]] ;
  then
     echo "Ошибка: Заданы не все параметры" >&2
     exit 1
fi

# Проверка параметров на число через регулярное выражение
re='^[+-]?[0-9]+([.][0-9]+)?$'
if ! [[ $a =~ $re ]] ; then
   echo "Ошибка: Коэффициент A не является числом" >&2
   exit 1
fi

if ! [[ $b =~ $re ]] ; then
   echo "Ошибка: Коэффициент B не является числом" >&2
   exit 1
fi

if ! [[ $c =~ $re ]] ; then
   echo "Ошибка: Коэффициент C не является числом" >&2
   exit 1
fi


# Формула дискриминанта: b^2 - 4*a*c
D=`echo "scale=2; ($b*$b-4*$a*$c)" | bc -l | awk '{printf "%.2f", $0}'`
echo "D = $D"

echo "Ответ:"
#Если D < 0, то решений нет
if [ $(echo "$D < 0" | bc -l) -eq 1 ] ;
  then
    echo "нет решения"
    exit 0
# Если D = 0, то кол-во решений 1
elif [ $(echo "$D == 0" | bc -l) -eq 1 ] ;
  then
     x1x2=`echo "scale=2; ((-1)*$b/(2*$a))" | bc -l | awk '{printf "%.2f", $0}'`
     echo "x1 = x2 = $x1x2"
     exit 0
# Если D > 0, то кол-во решений 2
else
     x1=`echo "scale=2; ((-1)*$b+sqrt($D))/(2*$a)" | bc -l | awk '{printf "%.2f", $0}'`
     echo "x1 = $x1"
     x2=`echo "scale=2; ((-1)*$b-sqrt($D))/(2*$a)" | bc -l | awk '{printf "%.2f", $0}'`
     echo "x2 = $x2"
     exit 0
fi