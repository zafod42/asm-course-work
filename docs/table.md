# Список используемых макросов и документация к ним
## Макросы
- ```pause``` 
- ```exit```

## Документация
### Макросы
	- pause:
		выводит сообщение "Any key to continue..."
		
		исп: ax, dx
		сохр: ax, dx
	- exit:
		макрос выхода из программы с кодом 0
		
		исп: ax
		сохр: все
	- debug_box:
		выводит небольшую коробочку вида
			===
			| |
			===
		но с использованием символов из расширенной ascii таблицы
		
		внутри используется putchar
		исп: dx
		сохр: dx

	- ~draw_top~ 
		выводит на экран заголовок таблицы
		таблица содержит колонки:
			1. number - 2 символа
			2. surname(ФИО) - 20 символов
			3. student_id(credit_id в программе) - 9 символов
			4. credit(зачёт/незачёт) - 7 символов
			5. date - 10 символов
		[==|===================|=========|========|==========]
		Общая длинна заголовка - 2 + 20 + 9 + 7 + 10 + 
					 + 4(на разделители) + 2(на рамку) =
					= 54
		
		исп: dx, cx
		сохр: все
	- draw_table
		выводит на экран таблицу с заголовком из draw_top
		каждой строке таблицы содержится соответсвующее столбцу значение?
		каждая ячейка рисуется с помощью процедуры draw_cell
		
		исп: dx, cx
		сохр: никакие
		

### Процедуры
	- draw_top(в будущем)
		выводит на экран заголовок таблицы
                таблица содержит колонки: 
                        1. number - 2 символа
                        2. surname(ФИО) - 20 символов
                        3. student_id(credit_id в программе) - 9 символов
                        4. credit(зачёт/незачёт) - 7 символов
                        5. date - 10 символов
                [==|===================|=========|========|==========]
                Общая длинна заголовка - 2 + 20 + 9 + 7 + 10 + 
                                         + 4(на разделители) + 2(на рамку) =
                                        = 54 
	- draw_cell 
		inputs:	
			CX - длина ячейки (соответсвует столбцу таблицы)
			DX - строка которую надо записать в таблицу
		выводит на экран ячейку таблицы, а внутри помещает строку
		переданную через параметр DX
		
		draw_cell считает количество пробелов, которыми надо дополнить 
		строку DX, чтобы она заполняла ячейку. Количество пробелов считается
		как CX - len(строка из dx)
		
		после чего записывает ячейки таблицы так , что
		строка получается в следующем формате:
			
			xx|Фамилия И. О.       |133713371| зачёт |01.09.1942|
		
		То есть после каждой ячейки выводится vertical_line


