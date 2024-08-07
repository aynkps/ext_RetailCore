
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы_Список

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура СписокПередУдалением(Элемент, Отказ)  
	СписокФайловКУдалению.Очистить();	
	МассивВыбранных = Элементы.Список.ВыделенныеСтроки;
	Для каждого ИдентификаторСтроки Из МассивВыбранных Цикл
		ТекДанные = Элементы.Список.ДанныеСтроки(ИдентификаторСтроки);
		Если ЗначениеЗаполнено(ТекДанные.ИмяФайлаОбмена) Тогда
			СписокФайловКУдалению.Добавить(ТекДанные.ИмяФайлаОбмена);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура СписокПослеУдаления(Элемент)
	Для каждого ИмяФайлаОбмена Из СписокФайловКУдалению Цикл
		УдалитьФайлыАсинх(ИмяФайлаОбмена);	
	КонецЦикла;
	СписокФайловКУдалению.Очистить();	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы   

&НаКлиенте
Процедура ВыполнитьРегламентОбмена(Команда)
	
	ВыполнитьРегламентОбменаНаСервере(); 
	
КонецПроцедуры

&НаКлиенте
Процедура СбросПовторногоИспользования(Команда)
	ОбновитьПовторноИспользуемыеЗначения();	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеОбменом(Команда)
	пр_Клиент.ОткрытьИсполняемуюФорму("оду_УправлениеОбменом", "Форма",,,,,,,,,"оду_УправлениеОбменом");
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыделенныхСтрок(Команда)
	
	//Путь = КаталогХраненияТекущейОбработки() + "\Модули\оду_УправлениеОбменом.epf";
	////Путь = "\\192.168.100.11\core-sync\Разработка1С\Модули\оду_УправлениеОбменом_Универсальный.epf"; 
	//пр_Клиент.ОткрытьФормуВнешнейОбработки(Путь, "ФормаСпискаСостоянийОбмена",,,,,,,,"оду_УправлениеОбменом");
	////пр_Клиент.ОткрытьИсполняемуюФорму("оду_УправлениеОбменом", "Форма",,,,,,,,,"оду_УправлениеОбменом");
	ОписОповещФормы = Новый ОписаниеОповещения( "ПослеЗакрытияФормыОбработкиВыделенныхСтрок", ЭтаФорма); //ЭтаФорма, ЭтотОбъект
	
	ОткрытьФорму("ВнешняяОбработка.оду_УправлениеОбменом.Форма.ФормаОбработкиВыделенныхСтрок",,,,,, ОписОповещФормы);
	
КонецПроцедуры



&НаКлиенте
//Какие параметры могут передаваться:
//ПараметрыЗакрытия, СтандартныеРеквизиты, ФормаРедактированияСтроки, СтруктураПараметров, ВыполняемоеОповещение, Результат, ИсточникВыбора 
Процедура ПослеЗакрытияФормыОбработкиВыделенныхСтрок(ПараметрыВыбора, Параметры) Экспорт
	
	Если ПараметрыВыбора = Неопределено Тогда     
		Возврат;
	КонецЕсли; 

	МассивЗаписей = Новый Массив;
	ТабличнаяЧасть = Элементы.Список;
	ВыделенныеСтроки = ТабличнаяЧасть.ВыделенныеСтроки;
	
	Для Каждого ИдентификаторСтроки Из ВыделенныеСтроки Цикл
		
		ТекДанные = ТабличнаяЧасть.ДанныеСтроки(ИдентификаторСтроки);
		СтруктураОтбора = Новый Структура("ИДОбъекта, ИДБазыИсточник, ИДБазыПриемник");
		ЗаполнитьЗначенияСвойств(СтруктураОтбора, ТекДанные);
		МассивЗаписей.Добавить(СтруктураОтбора);
		
	КонецЦикла;		
	
	Если МассивЗаписей.Количество() > 0  Тогда
		ИзменитьЗаписиВыделенныхСтрок(МассивЗаписей, ПараметрыВыбора);	
	КонецЕсли;
	
КонецПроцедуры  

&НаСервере
Процедура ИзменитьЗаписиВыделенныхСтрок(МассивЗаписей, ПараметрыВыбора) 
	
	Для каждого СтруктураОтбора Из МассивЗаписей Цикл
		Запись = РегистрыСведений.оду_СостояниеОбъектовОбмена.СоздатьМенеджерЗаписи();	
		ЗаполнитьЗначенияСвойств(Запись, СтруктураОтбора);
		Запись.Прочитать();
		Если Запись.Выбран() Тогда
			ЗаполнитьЗапись(Запись, ПараметрыВыбора);	
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры   

&НаСервере
Процедура ЗаполнитьЗапись(Запись, ПараметрыВыбора)
	
	ЕстьИзменение = Ложь;
	Для каждого КлючЗначение Из ПараметрыВыбора Цикл 
		
		Значение = КлючЗначение.Значение;
		
		Если КлючЗначение.Ключ = "ИмяФайлаОбмена" ИЛИ ЗначениеЗаполнено(Значение) Тогда
			
			Если Запись[КлючЗначение.Ключ] <> Значение Тогда
				Запись[КлючЗначение.Ключ] = Значение;		
				ЕстьИзменение = Истина;
			КонецЕсли;	
			
		КонецЕсли;	
	
	КонецЦикла; 
	
	Если ЕстьИзменение = Истина Тогда
		
		//Запись.ОбменДанными.Загрузка = Истина;
		Запись.Записать();	
	
	КонецЕсли;
	
КонецПроцедуры





#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ВыполнитьРегламентОбменаНаСервере()
	
	Модуль = пр_НастройкиПовтИсп.ИсполняемыйМодуль("оду_Общий", пр_НастройкиПовтИсп.ТекущийПользователь()); 
	//НомерВыполнения = ?(ЗначениеЗаполнено(РежимОбмена), 1, 0);
	//Модуль.ВыполнитьОбменВФоне(РежимОбмена, НомерВыполнения, Истина); 
	Модуль.ВыполнитьОбменВФоне(РежимОбмена, 2, Истина); 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункцииБСП

#КонецОбласти 
