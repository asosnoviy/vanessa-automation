﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюШагСПараметром(Парам01)","ЯВыполняюШагСПараметром","Когда я выполняю шаг с параметром 1");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПолучаюВПроцедуруПараметрТипа(Парам01)","ЯПолучаюВПроцедуруПараметрТипа","Тогда я получаю в процедуру параметр типа ""Число""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ИЭтотПараметрЯвляетсяПустойДатой()","ИЭтотПараметрЯвляетсяПустойДатой","Тогда И этот параметр является пустой датой");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЭтоЗначениеВВидеСтрокиРавно(Парам01)","ЭтоЗначениеВВидеСтрокиРавно","И это значение в виде строки равно ""0.1""");

	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры


&НаКлиенте
//я выполняю шаг с параметром 1
//@ЯВыполняюШагСПараметром(Парам01)
Процедура ЯВыполняюШагСПараметром(Параметр) Экспорт
	ПереданныйТип = ТипЗнч(Параметр);
	Контекст.Вставить("ПереданныйТип",ПереданныйТип);
	Контекст.Вставить("ПереданныйПараметр",Параметр);
КонецПроцедуры

&НаКлиенте
//я получаю в процедуру параметр типа "Число"
//@ЯПолучаюВПроцедуруПараметрТипа(Парам01)
Процедура ЯПолучаюВПроцедуруПараметрТипа(ИмяТипа) Экспорт
	ПереданныйТип = Контекст.ПереданныйТип;
	Ванесса.ПроверитьРавенство(ПереданныйТип,Тип(ИмяТипа),"Был предан параметр нужного типа.");
	
	ЗначениеПараметра     = Строка(Контекст.ПереданныйПараметр);
	ПредставлениеАпостроф = "__&Апостроф__";
	
	
	Если Найти(ЗначениеПараметра,ПредставлениеАпостроф) > 0 Тогда
		ВызватьИсключение "Не верно обработаны параметры содержащие апостроф вариант1";
	КонецЕсли;	 
	Если Найти(ЗначениеПараметра,"\'") > 0 Тогда
		ВызватьИсключение "Не верно обработаны параметры содержащие апостроф вариант2";
	КонецЕсли;	 
	
КонецПроцедуры

//окончание текста модуля

&НаКлиенте
//Тогда И этот параметр является пустой датой
//@ИЭтотПараметрЯвляетсяПустойДатой()
Процедура ИЭтотПараметрЯвляетсяПустойДатой() Экспорт
	Ванесса.ПроверитьРавенство(Контекст.ПереданныйПараметр,'00010101',"Должная быть пустая дата");
КонецПроцедуры

&НаКлиенте
//И это значение в виде строки равно "0.1"
//@ЭтоЗначениеВВидеСтрокиРавно()
Процедура ЭтоЗначениеВВидеСтрокиРавно(Стр) Экспорт
	Если Строка(Контекст.ПереданныйПараметр) <> Стр Тогда
		ВызватьИсключение "Строка(Контекст.ПереданныйПараметр)=" + Строка(Контекст.ПереданныйПараметр) + ", а ожидали " + Стр;
	КонецЕсли;	 
КонецПроцедуры
