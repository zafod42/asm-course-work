# Документация к модулю print.asm
## Оглавление

## Документация
### Макросы
	- putchar
		выводит символ из регистра DL

		используемые регистры: AX
		сохраняемые значения: AX
		
	- newline
		переводит курсор на новую строку
		
		используемые регистры: DX, AX
		сохраняемые занчения: DX, AX
	- println
		печатает строку и переводит курсор на новую строку
		
		использует newline и print_str
	- print_str
		выводит строку на экран
		
		используемые регистры: AX
		сохраняемые регистры: AX

	- get_str
		получает строку со стандартного ввода и записывает 
		её в буфер по адресу DS:DX
		буфер должен быть офрмлен так:
			------------------
			|max|?|?|?|?|...
			------------------
		после выполнения макроса значение в буфере становится таким:
			------------------------
			|max|len|с|т|р|о|к|а|...
			------------------------
		
		используемые регистры: AX
		сохраняемые значения: AX

### Процедуры