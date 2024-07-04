&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ПороверкаСоединенияч(Команда)
	ПолучитПороверкаСоединенияч();
КонецПроцедуры    


&НаСервере
Функция ПолучитПороверкаСоединенияч()  
	пр_Модуль = пр_Общий.ИсполняемыйМодуль("пр_Общий", пр_НастройкиПовтИсп.ТекущийПользователь()); 
	Ст = пр_Модуль.ПолучитьСтруктуруАдресаИнформационнойБазы();
КонецФункции

&НаКлиенте
Процедура УправлениеОбменом(Команда)
	
	//Путь = КаталогХраненияТекущейОбработки() + "\Модули\оду_УправлениеОбменом.epf";
	Путь = КаталогХраненияТекущейОбработки() + "\Модули\оду_УправлениеОбменомОтбор.epf";
	//Путь = "\\192.168.100.11\core-sync\Разработка1С\Модули\оду_УправлениеОбменом_Универсальный.epf"; 
	пр_Клиент.ОткрытьФормуВнешнейОбработки(Путь, "Форма",,,,,,,,"оду_УправлениеОбменом");
	//пр_Клиент.ОткрытьИсполняемуюФорму("оду_УправлениеОбменом", "Форма",,,,,,,,,"оду_УправлениеОбменом");
	
КонецПроцедуры

&НаСервере
Функция КаталогХраненияТекущейОбработки()
	
	ЭтаОбработка = РеквизитФормыВЗначение("Объект");
	ПолныйПутьКОбработке =  ЭтаОбработка.ИспользуемоеИмяФайла;
	КаталогХраненияТекущейОбработки = КаталогФайла(ПолныйПутьКОбработке);
	
	Возврат КаталогХраненияТекущейОбработки;
	
КонецФункции 

Функция КаталогФайла(ПолныйПутьФайла, НомерВхождения = 1)
	
	КаталогФайла = Лев(ПолныйПутьФайла, СтрНайти(ПолныйПутьФайла, "\", НаправлениеПоиска.СКонца,, НомерВхождения) - 1);
	Возврат	КаталогФайла;
	
КонецФункции 


&НаКлиенте
Процедура СверкаЯдроТТ(Команда)
	СверкаЯдроТТНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура СверкаЯдроТТНаСервере()
	Путь = "\\192.168.100.11\core-sync\Разработка1С\UOD\ПроизвольныеЗапросы\НачальнаяСверкаОбъектовОбмена_Я_ТТ.epf";
	пр_Клиент.ОткрытьФормуВнешнейОбработки(Путь, "Форма",,,,,,,,"НачальнаяСверкаОбъектовОбмена");
КонецПроцедуры

