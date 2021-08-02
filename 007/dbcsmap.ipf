:userdoc.

.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=100.Расширенная карта символов
:p.Расширенная карта символов - это программа улучшенного отображения символов
для OS/2.
Включает в себя следующие функции&colon.
:ul compact.
:li.Поддержка символов Unicode (базовая многоязычная плоскость).
:li.Поддержка текущей активной системной кодовой страницы.
:li.Поддержка дополнительных многобайтовых кодировок, включая общие кодовые
страницы OS/2 для Восточной Азии (CJK).
:li.Двойной формат буфера обмена, поддерживающий как собственный (нативный)
Юникод (распознаваемый многими приложениями OS/2), так и обычный текст с
кодировкой кодовой страницы.
:eul.

:p.Расширенная карта символов организует все символы в соответствии с их
назначенными номерами в выбранной кодировке (Unicode или Codepage).
Однобайтовые кодовые страницы поддерживают 256 символов, которые отображаются
в сетке символов.

:p.Многобайтовые кодовые страницы, а также Юникод (UCS-2) подразделяются на
группы из 256 символьных значений, определяемых числом, известным как
:hp1.начальный байт:ehp1.. При выборе ведущего байта в таблице отображаются все
символы в соответствующей группе.
:nt.Хотя каждая группа содержит 256 :hp1.значений:ehp1.символов, не все из этих
значений обязательно присваиваются фактическим символам данной кодовой страницы.
Значения, которые не представляют допустимые символы, отображаются в виде
пустых серых квадратов.:ent.

:p.:hp7.Элементы управления:ehp7.
:p.Элементы управления в левой части окна включают&colon.

:dl break=all.
:dt.Кодировка
:dd.Элемент управления "Кодировка" позволяет выбрать кодировку символов для
отображения. Селектор "Начальный байт" используется для указания желаемого
начального байта (показан в шестнадцатеричной системе счисления). Диапазон
доступных значений начальных байтов может варьироваться в зависимости от
кодировки.
:p.Восточноазиатские многобайтовые кодовые страницы включают некоторые
однобайтовые символы, в которых не используется начальный байт. Для этих
кодовых страниц доступно начальное значение байта :hp2."--":ehp2.; при выборе
этого значения будут показаны все однобайтовые символы для этой кодовой
страницы.

:dt.Выделенный символ
:dd.В этой области отображается увеличенное изображение любого выбранного в
данный момент символа (если таковой имеется) с соответствующими значениями
байтов, показанными непосредственно ниже (как в шестнадцатеричном, так и в
десятичном форматах).  Для кодовых страниц, отличных от Unicode, если
рассматриваемый символ имеет соответствующее значение Unicode (UCS-2), это
значение также отображается (с префиксом &osq.U+&csq.).

:dt.Скопированные символы
:dd.Предоставляет элементы управления для управления символами, скопированными
в буфер обмена. Дополнительные сведения смотрите в разделе
:link reftype=hd res=400.Копирование символов:elink..
:edl.

:p.
:p.:hp7.Больше информации:ehp7.
:ul compact.
:li.:link reftype=hd res=200.Выбор шрифтов:elink.
:li.:link reftype=hd res=300.Поддерживаемые кодовые страницы:elink.
:li.:link reftype=hd res=400.Копирование символов:elink.
:li.:link reftype=hd res=500.Вставка символов в другие приложения:elink.
:eul.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=200.Шрифты
:p.Вы можете изменить шрифт, используемый для отображения символов, через меню
"Параметры". Для достижения наилучших результатов следует использовать
контурный шрифт (TrueType или Type 1).

:p.Для правильного просмотра символов Юникода необходимо использовать шрифт,
поддерживающий кодировку Юникода. Могут использоваться шрифты CJK, отличные от
Юникода, для японского, корейского или китайского языков, но вряд ли они будут
корректно отображать символы в кодировках (включая Юникод), отличных от тех,
для которых они предназначены.

:p.Начиная с Warp Server для e-business, OS/2 поставляется с несколькими
шрифтами Unicode, доступными из коробки&colon.
:dl break=all.
:dt.Times New Roman WT J
.br
Times New Roman WT K
.br
Times New Roman WT TC
.br
Times New Roman WT TT
:dd.Пропорциональный шрифт с засечками, также доступный под названием
"Times New Roman MT 30". (Четыре различные версии имеют свои стили китайских
иероглифов, оптимизированные для культурных различий между японским, корейским,
упрощенным китайским и традиционным китайским языками соответственно. Однако по
большей части любой из них подходит для общего использования.)
:dt.Monotype Sans Duospace WT J
.br
Monotype Sans Duospace WT K
.br
Monotype Sans Duospace WT TC
.br
Monotype Sans Duospace WT TT
:dd.Моноширинный шрифт без засечек (оптимизирован для локали так же, как и
шрифт представленный выше).
:edl.

:p.Для более ранних версий OS/2 "Times New Roman MT 30" доступен как часть
пакета среды выполнения Java 1.1.8 от IBM (версия шрифта Unicode).

:p.Вы также можете получить разнообразные шрифты Unicode из других источников.
Некоторые из часто встречающихся&colon.
:dl break=all.
:dt.Arial Unicode MS
:dd.Этот шрифт поставляется с последними версиями Microsoft Office и
устанавливается под Windows, если выбраны определённые языковые параметры.
Его можно установить под OS/2, получив файл ARIALUNI.TTF и установив его
обычным способом. (Требуется действительная лицензия для Microsoft Office.)
:dt.Bitstream Cyberbit
:dd.Пропорциональный шрифт с засечками с всесторонней поддержкой многих языков.
Он доступен по адресу
http&colon.//ftp.netscape.com/pub/communicator/extras/fonts/windows/Cyberbit.ZIP
и является бесплатным для некоммерческого использования.
:dt.Code 2000
:dd.Это пропорциональный шрифт с засечками с поддержкой широкого спектра языков
и наборов символов. Это недорогое условно-бесплатное программное обеспечение,
доступное по адресу http&colon.//www.code2000.net.
:dt.Droid Sans Combined
:dd.Это модифицированная версия шрифта Google Droid Sans, которая сочетает в
себе поддержку символов из нескольких языковых версий. Он доступен с различных
файловых сайтов OS/2, включая Hobbes&colon.
http&colon.//hobbes.nmsu.edu/h-search.php?key=droidfont&amp.pushbutton=Search
:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=300.Поддерживаемые кодировки
:p.Расширенная карта символов позволяет выбрать одну из следующих кодировок.
(Кроме Юникода, каждая кодировка идентифицируется по номеру кодовой страницы
OS/2.)

:p.(Некоторые восточноазиатские кодировки могут быть доступны не во всех
системах, в зависимости от того, какие параметры были выбраны во время
установки OS/2.)

:dl break=all.

:dt.Системная кодовая страница
:dd.Каждая из настроенных в настоящее время системных кодовых страниц (до двух)
предоставляется в качестве опции, если только они не совпадают с одной из
других кодировок, перечисленных ниже. Фактические номера кодовых страниц
(которые будут варьироваться в зависимости от конфигурации системы) будут
показаны в описании.

:dt.942 (Japan SJIS-1978)
:dd.Это более старая версия кодировки Shift-JIS (см. кодовую страницу 943 ниже),
которая основана на стандарте JIS-X-0208-1978 вместо более позднего стандарта
1990 года.

:dt.943 (Japan SJIS-1990)
:dd.Это кодировка PC Shift-JIS для японского текста, которая основана на
официальном стандарте набора символов JIS-X-0208-1990 (с расширениями
IBM/NEC/Microsoft). Она используется в качестве &osq.родной&csq. (нативной)
японской кодировки в OS/2 и Windows, а иногда также называется кодировкой
:hp1.Windows-31J:ehp1.. Обратите внимание, что кодовая страница 943
альтернативно называется кодовой страницей 932; они эквивалентны.

:dt.944 (Korea SAA)
:dd.Это более старая кодировка IBM для корейского языка, предусмотренная для
совместимости со старыми системами. Кодировка Wansung (см. кодовую страницу 949
ниже) чаще используется для корейского текста. Эта кодовая страница доступна не
во всех системах.

:dt.946 (China SAA)
:dd.Это более старая кодировка IBM для упрощённого китайского языка,
предусмотренная для совместимости со старыми системами.  Кодировка GB и/или
GBK (см. кодовые страницы 1381 и 1386 ниже) чаще всего используется для
упрощённого китайского текста. Эта кодовая страница доступна не во всех
системах.

:dt.948 (Taiwan SAA)
:dd.Это реализация набора символов традиционного китайского языка CNS-11643
(с расширениями IBM). Она предоставляется в основном в целях совместимости,
так как кодировка BIG-5 (см. кодовую страницу 950 ниже) чаще используется для
традиционного китайского текста. Поддержка этой кодовой страницы установлена
не во всех системах.

:dt.949 (Korea KS-Code)
:dd.Это реализация IBM корейского стандарта набора символов Wansung. Она
включает в себя набор кодов KSC5601 EUC 1 плюс расширения IBM MBCS-PC.

:nt.Версия OS/2 кодовой страницы 949 поддерживает только базовый набор символов
Wansung (плюс расширения IBM). Существует таблица кодовых страниц для замены,
которая обновляет кодовую страницу 949 для поддержки кодировки
MS Unified Hangul Code ("Расширенный Вансунг").
:p.Чтобы установить обновлённую таблицу кодовых страниц, скачайте
http&colon.//www.borgendale.com/tools/ulstools.zip, извлеките обновлённую
таблицу кодовых страниц IBM949 из архива и скопируйте её поверх существующей
версии в разделе \LANGUAGE\CODEPAGE на Вашем загрузочном диске.:ent.

:dt.950 (Taiwan BIG-5)
:dd.Это кодировка BIG-5 для традиционного китайского текста (каторый
используется в Гонконге и на Тайване). Это кодовая страница по умолчанию,
используемая традиционными китайскими версиями DBCS OS/2.

:dt.1381 (China GB)
:dd.Это реализация IBM MBCS-PC стандарта набора символов GB2312 для упрощённого
китайского текста (используемого в Китайской Народной Республике). Она
предоставляется в основном в целях совместимости, так как кодировка GBK
(см. кодовую страницу 1386 ниже) в значительной степени заменила его.

:dt.1386 (China GBK)
:dd.Это реализация IBM MBCS-PC стандарта набора символов GBK для упрощённого
китайского текста. Это кодовая страница по умолчанию, используемая упрощёнными
китайскими версиями DBCS OS/2, и примерно эквивалентна кодовой странице
Windows 936.

:dt.Unicode (Plane 0)
:dd.Юникод это &osq.универсальная&csq. кодировка текста, которая быстро
становится доминирующим стандартом для представления многоязычного текста.
:p.OS/2, следовательно и эта программа, поддерживает только плоскость 0 Юникода,
называемую :hp1.Базовой многоязычной плоскостью:ehp1.. Тем не менее, это
обеспечивает поддержку десятков тысяч символов, представляющих почти все
системы письма, используемые сегодня во всём мире.
:p.Расширенная карта символов представляет символы Юникода в селекторе кодовых
страниц в соответствии со значениями 2-байтового универсального набора символов
(UCS-2).  (Однако при копировании в буфер обмена в виде обычного текста они
сохраняются в формате UTF-8. Дополнительные сведения смотрите в разделе
:link reftype=hd res=400.Копирование символов:elink..)
:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=400.Копирование символов
:p.Символ можно скопировать в буфер обмена либо двойным кликом по нему на карте
символов, либо выделив его и выбрав "Добавить".

:p.Первый символ, скопированный таким образом после открытия Расширенной карты
символов, заменит предыдущее содержимое буфера обмена (если таковое имеется).
Однако любые последующие символы, которые Вы скопируете, будут добавлены к
ранее скопированным. Расширенная карта символов &osq.запоминает&csq. ранее
скопированные символы, поэтому, даже если Вы очистите или замените содержимое
буфера обмена с помощью другой программы, символы, скопированные с помощью
Расширенной карты символов, будут восстановлены в буфер обмена при следующем
копировании символа. (Или, в качестве альтернативы, если Вы выберете
"Копировать повторно" в меню "Редактировать".) Эти &osq.запомненные&csq.
символы также относятся к &osq.буферу обмена&csq. и отображаются на панели
буфера обмена.

:p.Кнопка "Очистить" стирает текущее содержимое буфера обмена, включая любые
символы, ранее скопированные с помощью Расширенной карты символов. Кнопка
"Удалить" удаляет только последний символ из буфера обмена.

:p.При копировании символа необработанное двухбайтовое значение этого символа
(как показано под окном предварительного просмотра глифа) помещается в буфер
обмена в текстовом формате &endash. :hp1.за исключением:ehp1. символов Юникода,
которые вместо этого хранятся в виде значений UTF-8 от одного до трёх байтов
(поскольку большинство приложений не способны обрабатывать необработанные
значения байтов UCS в виде обычного текста).

:p.Однако, если Вы выберете новую кодовую страницу, пока символы всё ещё
находятся в буфере обмена, эти символы будут преобразованы в их эквиваленты
под новой кодовой страницей. Это означает, что значения байтов ранее
скопированных символов могут измениться (до соответствующих значений в новой
кодовой странице). Если символ не существует в новой кодовой странице, он будет
заменён общим символом подстановки.

:p.Кроме того, все скопированные символы помещаются в буфер обмена в
пользовательском формате "текст/юникод" (Unicode UCS-2), если включена опция
"Копировать Unicode" (как по умолчанию).  Приложения, поддерживающие этот
формат буфера обмена (например, продукты семейства Mozilla), обычно используют
его при вставке, предпочитая формат обычного текста, когда это возможно.

:p.Если это кажется запутанным, обратитесь к приведенному ниже примеру.

:p.
:p.:hp5.Пример копирования:ehp5.
:p.Допустим, у Вас выбрана кодовая страница 943 (Japan SJIS-1990), и Вы
копируете символ 0x82E2 (японский символ хирагана &osq.YA&csq.).
:p.:artwork name='943_82e2.bmp' align=center.
:p.Копирование этого символа приводит к тому, что последовательность байтов
0x82E2 помещается в буфер обмена в формате обычного текста, а эквивалентное
значение Юникода для того же символа (U+3084) помещается в буфер обмена в
формате текст/юникод (UCS-2).
:p.На этот момент буфер обмена содержит&colon.
:xmp.
    Текстовый формат (CF_TEXT)&colon. 0x82E2 (значение codepage 943 для YA хирагана)
    Текст/юникод формат&colon.        U+3084 (значение UCS-2 для YA хирагана)
:exmp.
:p.Если затем Вы измените выбранную кодовую страницу на Юникод с этим символом,
всё ещё находящимся в буфере обмена, Расширенная карта символов преобразует его
в эквивалентное значение UTF-8 для японской &osq.YA&csq. хираганы. (Значение
текста/юникода для символа остаётся неизменным, так как он не зависит от
кодовой страницы.) Буфер обмена теперь содержит&colon.
:xmp.
    Текстовый формат (CF_TEXT)&colon. 0xE38284 (значение UTF-8 для YA хирагана)
    Текст/юникод формат&colon.        U+3084   (значение UCS-2 для YA хирагана)
:exmp.
:p.Наконец, допустим, Вы снова измените выбранную кодовую страницу, на этот раз
на 949 (Korea KS-Code). Символ, если он всё ещё находится в буфере обмена,
снова будет преобразован в соответствующее значение для этой новой кодовой
страницы&colon.
:xmp.
    Текстовый формат (CF_TEXT)&colon. 0xAAE4 (значение codepage 949 для YA хирагана)
    Текст/юникод формат&colon.        U+3084 (значение UCS-2 для YA хирагана)
:exmp.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=500.Вставка символов
:p.Когда Вы вставляете скопированные символы в другое приложение, значение
текста/юникода будет вставлено, если (и только если) соответствующее приложение
поддерживает его; если нет, объект будет вставлен как обычный текст.

:p.Вставленные символы будут отображаться в соответствии с возможностями
целевого приложения. Если приложение не использует Юникод непосредственно для
отображения текста (что относительно редко), это обычно означает, что они будут
отображаться с использованием кодовой страницы и шрифта, которые в настоящее
время активны в этом приложении. Если комбинация кодовой страницы и шрифта не
позволяет отображать вставленные символы, они будут отображаться неправильно.

:p.Например, если Вы скопировали символ 0x82E2 (японская &osq.YA&csq. хирагана)
из кодовой страницы 943 (Japan SJIS-1990) в Расширенной карте символов, попытка
вставить его в приложение, которое не поддерживает формат буфера обмена
текст/юникод, приведёт к тому, что значение символа 0x82E2 будет вставлено
буквально (как есть).  Это будет отображаться в целевом приложении как символ
&osq.YA&csq. хирагана, только если это приложение использует для отображения
кодовую страницу 943 (или совместимую кодовую страницу, такую как 932) :hp1.и:ehp1.
шрифт, содержащий этот символ.


.* :h1 x=left y=bottom width=100% height=100% res=600.Common Problems
.* :p.
.* :dl.
.* :dt.
.* :dd.
.* :edl.


.* ----------------------------------------------------------------------------
:h1 res=990 name=license
    x=left y=bottom width=100% height=100%.Лицензия
.ce GNU GENERAL PUBLIC LICENSE
.ce Version 2, June 1991

:p.Copyright (C) 1989, 1991 Free Software Foundation, Inc.
.br
59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
:p.Everyone is permitted to copy and distribute verbatim copies of this license
document, but changing it is not allowed.
:p.
.ce Preamble

:p.The licenses for most software are designed to take away your
freedom to share and change it.  By contrast, the GNU General Public
License is intended to guarantee your freedom to share and change free
software--to make sure the software is free for all its users.  This
General Public License applies to most of the Free Software
Foundation's software and to any other program whose authors commit to
using it.  (Some other Free Software Foundation software is covered by
the GNU Library General Public License instead.)  You can apply it to
your programs, too.

:p.When we speak of free software, we are referring to freedom, not
price.  Our General Public Licenses are designed to make sure that you
have the freedom to distribute copies of free software (and charge for
this service if you wish), that you receive source code or can get it
if you want it, that you can change the software or use pieces of it
in new free programs; and that you know you can do these things.

:p.To protect your rights, we need to make restrictions that forbid
anyone to deny you these rights or to ask you to surrender the rights.
These restrictions translate to certain responsibilities for you if you
distribute copies of the software, or if you modify it.

:p.For example, if you distribute copies of such a program, whether
gratis or for a fee, you must give the recipients all the rights that
you have.  You must make sure that they, too, receive or can get the
source code.  And you must show them these terms so they know their
rights.

:p.We protect your rights with two steps&colon. (1) copyright the software, and
(2) offer you this license which gives you legal permission to copy,
distribute and/or modify the software.

:p.Also, for each author's protection and ours, we want to make certain
that everyone understands that there is no warranty for this free
software.  If the software is modified by someone else and passed on, we
want its recipients to know that what they have is not the original, so
that any problems introduced by others will not reflect on the original
authors' reputations.

:p.Finally, any free program is threatened constantly by software
patents.  We wish to avoid the danger that redistributors of a free
program will individually obtain patent licenses, in effect making the
program proprietary.  To prevent this, we have made it clear that any
patent must be licensed for everyone's free use or not licensed at all.

:p.The precise terms and conditions for copying, distribution and
modification follow.

:p.
.ce GNU GENERAL PUBLIC LICENSE
.ce TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

:dl tsize=6 break=none.
:dt.0.
:dd.This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law&colon.
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)  Each licensee is addressed as "you".

:p.Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.  The act of
running the Program is not restricted, and the output from the Program
is covered only if its contents constitute a work based on the
Program (independent of having been made by running the Program).
Whether that is true depends on what the Program does.

:dt.1.
:dd.You may copy and distribute verbatim copies of the Program's
source code as you receive it, in any medium, provided that you
conspicuously and appropriately publish on each copy an appropriate
copyright notice and disclaimer of warranty; keep intact all the
notices that refer to this License and to the absence of any warranty;
and give any other recipients of the Program a copy of this License
along with the Program.

:p.You may charge a fee for the physical act of transferring a copy, and
you may at your option offer warranty protection in exchange for a fee.

:dt.2.
:dd.You may modify your copy or copies of the Program or any portion
of it, thus forming a work based on the Program, and copy and
distribute such modifications or work under the terms of Section 1
above, provided that you also meet all of these conditions&colon.
:dl tsize=3 break=none.
:dt.a)
:dd.You must cause the modified files to carry prominent notices
stating that you changed the files and the date of any change.

:dt.b)
:dd.You must cause any work that you distribute or publish, that in
whole or in part contains or is derived from the Program or any
part thereof, to be licensed as a whole at no charge to all third
parties under the terms of this License.

:dt.c)
:dd.If the modified program normally reads commands interactively
when run, you must cause it, when started running for such
interactive use in the most ordinary way, to print or display an
announcement including an appropriate copyright notice and a
notice that there is no warranty (or else, saying that you provide
a warranty) and that users may redistribute the program under
these conditions, and telling the user how to view a copy of this
License.  (Exception&colon. if the Program itself is interactive but
does not normally print such an announcement, your work based on
the Program is not required to print an announcement.)
:edl.

:p.These requirements apply to the modified work as a whole.  If
identifiable sections of that work are not derived from the Program,
and can be reasonably considered independent and separate works in
themselves, then this License, and its terms, do not apply to those
sections when you distribute them as separate works.  But when you
distribute the same sections as part of a whole which is a work based
on the Program, the distribution of the whole must be on the terms of
this License, whose permissions for other licensees extend to the
entire whole, and thus to each and every part regardless of who wrote it.

:p.Thus, it is not the intent of this section to claim rights or contest
your rights to work written entirely by you; rather, the intent is to
exercise the right to control the distribution of derivative or
collective works based on the Program.

:p.In addition, mere aggregation of another work not based on the Program
with the Program (or with a work based on the Program) on a volume of
a storage or distribution medium does not bring the other work under
the scope of this License.

:dt.3.
:dd.You may copy and distribute the Program (or a work based on it,
under Section 2) in object code or executable form under the terms of
Sections 1 and 2 above provided that you also do one of the following&colon.
:dl tsize=3 break=none.
:dt.a)
:dd.Accompany it with the complete corresponding machine-readable
source code, which must be distributed under the terms of Sections
1 and 2 above on a medium customarily used for software interchange; or,

:dt.b)
:dd.Accompany it with a written offer, valid for at least three
years, to give any third party, for a charge no more than your
cost of physically performing source distribution, a complete
machine-readable copy of the corresponding source code, to be
distributed under the terms of Sections 1 and 2 above on a medium
customarily used for software interchange; or,

:dt.c)
:dd.Accompany it with the information you received as to the offer
to distribute corresponding source code.  (This alternative is
allowed only for noncommercial distribution and only if you
received the program in object code or executable form with such
an offer, in accord with Subsection b above.)
:edl.

:p.The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.  However, as a
special exception, the source code distributed need not include
anything that is normally distributed (in either source or binary
form) with the major components (compiler, kernel, and so on) of the
operating system on which the executable runs, unless that component
itself accompanies the executable.

:p.If distribution of executable or object code is made by offering
access to copy from a designated place, then offering equivalent
access to copy the source code from the same place counts as
distribution of the source code, even though third parties are not
compelled to copy the source along with the object code.

:dt.4.
:dd.You may not copy, modify, sublicense, or distribute the Program
except as expressly provided under this License.  Any attempt
otherwise to copy, modify, sublicense or distribute the Program is
void, and will automatically terminate your rights under this License.
However, parties who have received copies, or rights, from you under
this License will not have their licenses terminated so long as such
parties remain in full compliance.

:dt.5.
:dd.You are not required to accept this License, since you have not
signed it.  However, nothing else grants you permission to modify or
distribute the Program or its derivative works.  These actions are
prohibited by law if you do not accept this License.  Therefore, by
modifying or distributing the Program (or any work based on the
Program), you indicate your acceptance of this License to do so, and
all its terms and conditions for copying, distributing or modifying
the Program or works based on it.

:dt.6.
:dd.Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.

:dt.7.
:dd.If, as a consequence of a court judgment or allegation of patent
infringement or for any other reason (not limited to patent issues),
conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not
excuse you from the conditions of this License.  If you cannot
distribute so as to satisfy simultaneously your obligations under this
License and any other pertinent obligations, then as a consequence you
may not distribute the Program at all.  For example, if a patent
license would not permit royalty-free redistribution of the Program by
all those who receive copies directly or indirectly through you, then
the only way you could satisfy both it and this License would be to
refrain entirely from distribution of the Program.

:p.If any portion of this section is held invalid or unenforceable under
any particular circumstance, the balance of the section is intended to
apply and the section as a whole is intended to apply in other
circumstances.

:p.It is not the purpose of this section to induce you to infringe any
patents or other property right claims or to contest validity of any
such claims; this section has the sole purpose of protecting the
integrity of the free software distribution system, which is
implemented by public license practices.  Many people have made
generous contributions to the wide range of software distributed
through that system in reliance on consistent application of that
system; it is up to the author/donor to decide if he or she is willing
to distribute software through any other system and a licensee cannot
impose that choice.

:p.This section is intended to make thoroughly clear what is believed to
be a consequence of the rest of this License.

:dt.8.
:dd.If the distribution and/or use of the Program is restricted in
certain countries either by patents or by copyrighted interfaces, the
original copyright holder who places the Program under this License
may add an explicit geographical distribution limitation excluding
those countries, so that distribution is permitted only in or among
countries not thus excluded.  In such case, this License incorporates
the limitation as if written in the body of this License.

:dt.9.
:dd.The Free Software Foundation may publish revised and/or new versions
of the General Public License from time to time.  Such new versions will
be similar in spirit to the present version, but may differ in detail to
address new problems or concerns.

:p.Each version is given a distinguishing version number.  If the Program
specifies a version number of this License which applies to it and "any
later version", you have the option of following the terms and conditions
either of that version or of any later version published by the Free
Software Foundation.  If the Program does not specify a version number of
this License, you may choose any version ever published by the Free Software
Foundation.

:dt.10.
:dd.If you wish to incorporate parts of the Program into other free
programs whose distribution conditions are different, write to the author
to ask for permission.  For software which is copyrighted by the Free
Software Foundation, write to the Free Software Foundation; we sometimes
make exceptions for this.  Our decision will be guided by the two goals
of preserving the free status of all derivatives of our free software and
of promoting the sharing and reuse of software generally.
.br
.ce NO WARRANTY

:dt.11.
:dd.BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
REPAIR OR CORRECTION.

:dt.12.
:dd.IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.
:edl.
:p.
.ce END OF TERMS AND CONDITIONS

:p.
.ce How to Apply These Terms to Your New Programs

:p.If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can redistribute and change under these terms.

:p.To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
convey the exclusion of warranty; and each file should have at least
the "copyright" line and a pointer to where the full notice is found.

:xmp.
   &lt.one line to give the program's name and a brief idea of what it does.&gt.
   Copyright (C) 19yy  &lt.name of author&gt.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
:exmp.

:p.Also add information on how to contact you by electronic and paper mail.

:p.If the program is interactive, make it output a short notice like this
when it starts in an interactive mode&colon.

:xmp.
   Gnomovision version 69, Copyright (C) 19yy name of author
   Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type 'show w'.
   This is free software, and you are welcome to redistribute it
   under certain conditions; type 'show c' for details.
:exmp.

:p.The hypothetical commands 'show w' and 'show c' should show the appropriate
parts of the General Public License.  Of course, the commands you use may
be called something other than 'show w' and 'show c'; they could even be
mouse-clicks or menu items--whatever suits your program.

:p.You should also get your employer (if you work as a programmer) or your
school, if any, to sign a "copyright disclaimer" for the program, if
necessary.  Here is a sample; alter the names&colon.

:xmp.
   Yoyodyne, Inc., hereby disclaims all copyright interest in the program
   'Gnomovision' (which makes passes at compilers) written by James Hacker.

   &lt.signature of Ty Coon&gt., 1 April 1989
   Ty Coon, President of Vice
:exmp.

:p.This General Public License does not permit incorporating your program into
proprietary programs.  If your program is a subroutine library, you may
consider it more useful to permit linking proprietary applications with the
library.  If this is what you want to do, use the GNU Library General
Public License instead of this License.

:euserdoc.
