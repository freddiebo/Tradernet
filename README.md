# Tradernet

Реализовать основную таблицу выведения котировок (один экран), данные обновляются в реальном времени.   
Подписка на котировки по сокетам.  
Аналогично приложению https://apps.apple.com/app/id1178912301 или мобильной версии сайта https://tradernet.ru/terminal/mobile/quotes.  
Авторизация не требуется.  
1. Сокет для получения данных по котировкам _сервер wss.tradernet.ru_  
emit на подписку *realtimeQuotes* например, *["quotes", ["SBER", "AAPL.SPB"]]*  
_Описание структуры ответа указано здесь https://tradernet.ru/tradernet-api/quotes-get-changes_
    
2. Использовать фиксированный список бумаг с идентификаторами:
> SP500.IDX,AAPL.US,RSTI,GAZP,MRKZ,RUAL,HYDR,MRKS,SBER,FEES,TGKA,VTBR,AN H.US,VICL.US,BURG.US,NBL.US,YETI.US,WSFS.US,NIO.US,DXC.US,MIC.US,HSBC.US ,EXPN.EU,GSK.EU,SHP.EU,MAN.EU,DB1.EU,MUV2.EU,TATE.EU,KGF.EU,MGGT.EU,SG GD.EU
3. Логотипы компаний не требуются(_добавить по желанию_). 
4. Данные используемые в верстке:
- Тикер
- Изменение в процентах относительно цены закрытия предыдущей торговой сессии
- Биржа последней сделки
- Название бумаги
- Цена последней сделки
- (Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии)
5. Значение с положительным значением имеет зеленый шрифт, с отрицательным – красный.
6. Подсветка идет зеленым при изменении значения в положительную сторону, красным при изменении значения в отрицательную сторону.
