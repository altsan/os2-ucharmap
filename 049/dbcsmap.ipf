:userdoc.

.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=100.Erweiterte Zeichentabelle
:p.Erweiterte Zeichentabelle ist ein erweitertes Zeichentabellenprogramm fÅr OS/2.
Zu seinen Funktionen gehîren&colon.
:ul compact.
:li.Unicode-ZeichenunterstÅtzung (Grundlegende mehrsprachige Ebene)
:li.UnterstÅtzung fÅr die aktuell aktive System-Codepage.
:li.UnterstÅtzung fÅr zusÑtzliche Multibyte-Kodierungen, einschlie·lich
gÑngiger ostasiatischer (CJK) OS/2-Codepages.
:li.Duales Zwischenablageformat, das sowohl nativen Unicode (von vielen
OS/2-Anwendungen erkannt) als auch Codepage-codierten Klartext unterstÅtzt.
:eul.

:p.Erweiterte Zeichentabelle organisiert alle Zeichen gemÑ· ihrer
zugewiesenen Nummern innerhalb der ausgewÑhlten Kodierung (Unicode oder
Codepage). Einzelbyte-Codepages unterstÅtzen 256 Zeichen, die alle im
Zeichenraster angezeigt werden.

:p.Multibyte-Codepages sowie Unicode (UCS-2) sind in Gruppen von 256
Zeichenwerten unterteilt, die durch eine Nummer namens
:hp1.fÅhrendes Byte:ehp1. identifiziert werden. Wenn Sie das fÅhrende Byte
auswÑhlen, werden alle Zeichen in der entsprechenden Gruppe im Raster angezeigt.
:nt.Obwohl jede Gruppierung 256 Zeichen:hp1.werte:ehp1. enthÑlt, werden nicht
alle dieser Werte von einer bestimmten Codepage notwendigerweise tatsÑchlichen
Zeichen zugewiesen. Werte, die keine gÅltigen Zeichen darstellen, werden als
leere graue Quadrate angezeigt.:ent.

:p.:hp7.Bedienelemente:ehp7.
:p.Die Bedienelemente auf der linken Seite des Fensters umfassen&colon.

:dl break=all.
:dt.Kodierung
:dd.Mit dem Steuerelement "Kodierung" kînnen Sie die anzuzeigende
Zeichenkodierung auswÑhlen. Mit dem Selektor "FÅhrendes Byte" kînnen Sie das
gewÅnschte fÅhrende Byte angeben (in hexadezimaler Notation dargestellt). Der
Bereich der verfÅgbaren fÅhrenden Bytewerte kann je nach Kodierung variieren.
:p.Ostasiatische Multibyte-Codepages enthalten bestimmte Einzelbyte-Zeichen,
die kein fÅhrendes Byte verwenden. FÅr diese Codepages ist der fÅhrende
Byte-Wert :hp2."--":ehp2. verfÅgbar. Wenn Sie diesen Wert auswÑhlen, werden alle
Einzelbyte-Zeichen fÅr diese Codepage angezeigt.

:dt.AusgewÑhltes Zeichen
:dd.In diesem Bereich wird ein vergrî·ertes Bild des aktuell ausgewÑhlten
Zeichens (sofern vorhanden) angezeigt. Die entsprechenden Bytewerte werden
direkt darunter angezeigt (sowohl im Hexadezimal- als auch im Dezimalformat).
Bei Nicht-Unicode-Codepages wird, falls das betreffende Zeichen einen
entsprechenden Unicode-Wert (UCS-2) hat, dieser Wert ebenfalls angezeigt (mit
dem PrÑfix &osq.U+&csq.).

:dt.Kopierte Zeichen
:dd.Bietet Steuerelemente zum Verwalten von in die Zwischenablage kopierten
Zeichen. Weitere Informationen finden Sie unter
:link reftype=hd res=400.Zeichen kopieren:elink.
:edl.

:p.
:p.:hp7.Weitere Informationen:ehp7.
:ul compact.
:li.:link reftype=hd res=200.Schriftarten auswÑhlen:elink.
:li.:link reftype=hd res=300.UnterstÅtzte Codepages:elink.
:li.:link reftype=hd res=400.Zeichen kopieren:elink.
:li.:link reftype=hd res=500.EinfÅgen von Zeichen in andere Anwendungen:elink.
:eul.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=200.Schriftarten
:p.Sie kînnen die fÅr die Zeichenanzeige verwendete Schriftart Åber das MenÅ
"Optionen" Ñndern. FÅr optimale Ergebnisse sollten Sie eine Konturschriftart
(TrueType oder Type 1) verwenden.

:p.Um Unicode-Zeichen richtig anzuzeigen, mÅssen Sie eine Schriftart verwenden,
die Unicode-Kodierung unterstÅtzt. Nicht-Unicode-CJK-Schriftarten fÅr
Japanisch, Koreanisch oder Chinesisch kînnen verwendet werden, es ist jedoch
unwahrscheinlich, dass Zeichen unter Kodierungen (einschlie·lich Unicode)
korrekt angezeigt werden, die nicht fÅr die Kodierung vorgesehen sind.

:p.Beginnend mit Warp Server fÅr E-Business verfÅgt OS/2 Åber mehrere sofort
einsatzbereite Unicode-Schriftarten&colon.
:dl break=all.
:dt.Times New Roman WT J
.br
Times New Roman WT K
.br
Times New Roman WT TC
.br
Times New Roman WT TT
:dd.Eine proportionale Serifenschrift, auch erhÑltlich unter dem Namen "Times
New Roman MT 30". (Die chinesischen Schriftstile der vier verschiedenen
Versionen sind fÅr kulturelle Unterschiede zwischen Japanisch, Koreanisch,
vereinfachtem Chinesisch und traditionellem Chinesisch optimiert. Zum grî·ten
Teil ist jedoch jede von ihnen fÅr den allgemeinen Gebrauch geeignet.)
:dt.Monotype Sans Duospace WT J
.br
Monotype Sans Duospace WT K
.br
Monotype Sans Duospace WT TC
.br
Monotype Sans Duospace WT TT
:dd.Eine nichtproportionale, serifenlose Schriftart (auf die gleiche Weise wie
oben fÅr das jeweilige Gebietsschema optimiert).
:edl.

:p.FÅr frÅhere OS/2-Versionen ist "Times New Roman MT 30" als Teil des
Java 1.1.8-Runtime-Pakets von IBM verfÅgbar (Unicode-Schriftversion).

:p.Sie kînnen umfassende Unicode-Schriftarten auch aus anderen Quellen beziehen.
Einige hÑufig vorkommende sind&colon.
:dl break=all.
:dt.Arial Unicode MS
:dd.Diese Schriftart ist in den neuesten Versionen von Microsoft Office
enthalten und wird unter Windows installiert, wenn bestimmte Sprachoptionen
ausgewÑhlt sind. Sie kann unter OS/2 installiert werden, indem Sie die Datei
ARIALUNI.TTF herunterladen und auf die Åbliche Weise installieren. (Eine
gÅltige Lizenz fÅr Microsoft Office ist erforderlich.)
:dt.Bitstream Cyberbit
:dd.Eine proportionale Serifenschrift mit umfassender UnterstÅtzung fÅr viele
Sprachen. Sie ist verfÅgbar unter
http&colon.//ftp.netscape.com/pub/communicator/extras/fonts/windows/Cyberbit.ZIP und
fÅr die nichtkommerzielle Nutzung kostenlos.
:dt.Code 2000
:dd.Dies ist eine proportionale Serifenschriftart mit UnterstÅtzung fÅr eine
Vielzahl von Sprachen und ZeichensÑtzen. Es handelt sich um preisgÅnstige
Shareware, die unter http&colon.//www.code2000.net erhÑltlich ist.
:dt.Droid Sans Combined
:dd.Dies ist eine modifizierte Version der Schriftart Droid Sans von Google,
die die ZeichenunterstÅtzung mehrerer sprachspezifischer Versionen kombiniert.
Sie ist auf verschiedenen OS/2-Dateiseiten verfÅgbar, darunter Hobbes&colon.
http&colon.//hobbes.nmsu.edu/h-search.php?key=droidfont&amp.pushbutton=Search
:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=300.UnterstÅtzte Kodierungen
:p.Mit der erweiterte Zeichentabelle kînnen Sie aus den folgenden Kodierungen
auswÑhlen. (Im Gegensatz zu Unicode wird jede Kodierung durch ihre
OS/2-Codepage-Nummer identifiziert.)

:p.(Einige ostasiatische Kodierungen sind mîglicherweise nicht auf allen
Systemen verfÅgbar, je nachdem, welche Optionen bei der Installation von
OS/2 ausgewÑhlt wurden.)

:dl break=all.

:dt.System-Codepage
:dd.Jede der aktuell konfigurierten System-Codepages (bis zu zwei) wird als
Option angeboten, es sei denn, sie sind mit einer der anderen unten aufgefÅhrten
Kodierungen identisch. Die tatsÑchlichen Codepage-Nummern (die je nach
Systemkonfiguration variieren) werden in der Beschreibung angezeigt.

:dt.942 (Japan SJIS-1978)
:dd.Dies ist eine Ñltere Version der Shift-JIS-Kodierung (siehe Codepage 943
unten), die auf dem Standard JIS-X-0208-1978 und nicht auf dem neueren Standard
von 1990 basiert.

:dt.943 (Japan SJIS-1990)
:dd.Dies ist die PC Shift-JIS-Kodierung fÅr japanischen Text, die auf dem
offiziellen Zeichensatzstandard JIS-X-0208-1990 (mit
IBM/NEC/Microsoft-Erweiterungen) basiert. Sie wird als &osq.native&csq.
japanische Kodierung unter OS/2 und Windows verwendet und manchmal auch als
:hp1.Windows-31J:ehp1.-Kodierung bezeichnet. Beachten Sie, dass Codepage 943
alternativ als Codepage 932 bezeichnet wird; die beiden sind gleichwertig.

:dt.944 (Korea SAA)
:dd.Dies ist eine Ñltere IBM-Kodierung fÅr Koreanisch, die aus
KompatibilitÑtsgrÅnden mit Ñlteren Systemen bereitgestellt wird. Die
Wansung-Kodierung (siehe Codepage 949 unten) wird hÑufiger fÅr koreanischen
Text verwendet. Diese Codepage ist nicht auf allen Systemen verfÅgbar.

:dt.946 (China SAA)
:dd.Dies ist eine Ñltere IBM-Kodierung fÅr vereinfachtes Chinesisch, die aus
KompatibilitÑtsgrÅnden mit Ñlteren Systemen bereitgestellt wird. GB- und/oder
GBK-Kodierungen (siehe Codepages 1381 und 1386 unten) werden hÑufiger fÅr
vereinfachten chinesischen Text verwendet. Diese Codepage ist nicht auf allen
Systemen verfÅgbar.

:dt.948 (Taiwan SAA)
:dd.Dies ist eine Implementierung des traditionellen chinesischen
Zeichensatzes CNS-11643 (mit IBM-Erweiterungen). Er wird hauptsÑchlich aus
KompatibilitÑtsgrÅnden bereitgestellt, da fÅr traditionellen chinesischen Text
hÑufiger die BIG-5-Kodierung (siehe Codepage 950 unten) verwendet wird. Die
UnterstÅtzung fÅr diese Codepage ist nicht auf allen Systemen installiert.

:dt.949 (Korea KS-Code)
:dd.Dies ist die IBM-Implementierung des koreanischen
Wansung-Zeichensatzstandards. Sie umfasst den KSC-5601 EUC-Codesatz 1 sowie
IBM MBCS-PC-Erweiterungen.

:nt.Die OS/2-Version der Codepage 949 unterstÅtzt nur den grundlegenden
Wansung-Zeichensatz (plus die IBM-Erweiterungen). Es ist eine
Ersatz-Codepage-Tabelle verfÅgbar, die Codepage 949 aktualisiert, um die MS
Unified Hangul Code-Kodierung ("Erweitertes Wansung") zu unterstÅtzen.
:p.Um die aktualisierte Codepage-Tabelle zu installieren, laden Sie
http&colon.//www.borgendale.com/tools/ulstools.zip herunter, extrahieren Sie die
aktualisierte IBM949-Codepage-Tabelle aus dem Archiv und kopieren Sie sie Åber
die vorhandene Version unter \LANGUAGE\CODEPAGE auf Ihrem Boot-Laufwerk.
:ent.

:dt.950 (Taiwan BIG-5)
:dd.Dies ist die BIG-5-Kodierung fÅr traditionellen chinesischen Text (wie er
in Hongkong und Taiwan verwendet wird). Es ist die Standard-Codepage, die von
traditionellen chinesischen DBCS-Versionen von OS/2 verwendet wird.

:dt.1381 (China GB)
:dd.Dies ist die IBM MBCS-PC-Implementierung des GB-2312-Zeichensatzstandards
fÅr vereinfachten chinesischen Text (wie er in der Volksrepublik China verwendet
wird). Sie wird hauptsÑchlich aus KompatibilitÑtsgrÅnden bereitgestellt, da die
GBK-Kodierung (siehe Codepage 1386 unten) sie weitgehend abgelîst hat.

:dt.1386 (China GBK)
:dd.Dies ist die IBM MBCS-PC-Implementierung des GBK-Zeichensatzstandards fÅr
vereinfachten chinesischen Text. Es handelt sich um die Standardcodepage, die
von vereinfachten chinesischen DBCS-Versionen von OS/2 verwendet wird, und
entspricht ungefÑhr der Windows-Codepage 936.

:dt.Unicode (Plane 0)
:dd.Unicode ist eine &osq.universelle&csq. Textkodierung, die sich schnell zum
dominierenden Standard fÅr die Darstellung mehrsprachiger Texte entwickelt.
:p.OS/2 und daher auch dieses Programm unterstÅtzen nur Ebene 0 von Unicode,
die sogenannte :hp1.Grundlegende mehrsprachige Ebene:ehp1.. Trotzdem werden
Zehntausende von Zeichen unterstÅtzt, die nahezu alle heute weltweit verwendeten
Schriftsysteme darstellen.
:p.Erweiterte Zeichentabelle stellt Unicode-Zeichen im Codepage-Selektor
gemÑ· 2-Byte-Werten des Universal Character Set (UCS-2) dar. (Wenn sie jedoch
als einfacher Text in die Zwischenablage kopiert werden, werden sie im
UTF-8-Format gespeichert. Weitere Informationen finden Sie unter
:link reftype=hd res=400.Zeichen kopieren:elink.)
:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=400.Zeichen kopieren
:p.Ein Zeichen kann entweder durch einen Doppelklick in der Zeichentabelle oder
durch Markieren und anschlie·ende Auswahl von "HinzufÅgen" in die Zwischenablage
kopiert werden.

:p.Das erste Zeichen, das auf diese Weise nach dem ôffnen der erweiterten
Zeichentabelle kopiert wird, ersetzt den vorherigen Inhalt der Zwischenablage
(sofern vorhanden). Alle nachfolgenden Zeichen, die Sie kopieren, werden jedoch
an die zuvor kopierten angehÑngt. Die erweiterte Zeichentabelle merkt sich zuvor
kopierte Zeichen. Selbst wenn Sie also den Inhalt der Zwischenablage mit einem
anderen Programm lîschen oder ersetzen, werden die mit der erweiterten
Zeichentabelle kopierten Zeichen beim nÑchsten Kopieren eines Zeichens in die
Zwischenablage zurÅckgeschrieben. (Oder alternativ, wenn Sie im MenÅ
"Bearbeiten" die Option "Alles erneut kopieren" auswÑhlen.) Diese "gemerkten"
Zeichen werden auch als "Zwischenablagepuffer" bezeichnet und im
Zwischenablagefenster angezeigt.

:p.Die SchaltflÑche "Lîschen" lîscht den aktuellen Inhalt der Zwischenablage,
einschlie·lich aller zuvor mit der erweiterten Zeichentabelle kopierten Zeichen.
Die SchaltflÑche "Lîschen" lîscht nur das letzte Zeichen aus dem
Zwischenablagepuffer.

:p.Wenn ein Zeichen kopiert wird, wird der Roh-Doppelbyte-Wert dieses Zeichens
(wie unter dem Glyphenvorschaufenster angezeigt) im Nur-Text-Format in die
Zwischenablage eingefÅgt &endash. :hp1.au·er:ehp1. im Fall von Unicode-Zeichen,
die stattdessen als ein- bis drei Byte gro·e UTF-8-Werte gespeichert werden (da
die meisten Anwendungen nicht in der Lage sind, Roh-UCS-Bytewerte als Nur-Text
zu verarbeiten).

:p.Wenn Sie jedoch eine neue Codepage auswÑhlen, wÑhrend sich noch Zeichen in
der Zwischenablage befinden, werden diese Zeichen in ihre équivalente unter der
neuen Codepage konvertiert. Dies bedeutet, dass sich die Bytewerte zuvor
kopierter Zeichen Ñndern kînnen (in die entsprechenden Werte unter der neuen
Codepage). Wenn ein Zeichen in der neuen Codepage nicht vorhanden ist, wird es
durch ein generisches Ersatzzeichen ersetzt.

:p.DarÅber hinaus werden alle kopierten Zeichen auch im benutzerdefinierten
Format "Text/Unicode" (Unicode UCS-2) in die Zwischenablage eingefÅgt, wenn die
Option "Unicode kopieren" aktiviert ist (was standardmÑ·ig der Fall ist).
Anwendungen, die dieses Zwischenablageformat unterstÅtzen (wie die
Mozilla-Produktfamilie), ziehen es beim EinfÅgen im Allgemeinen, wenn
mîglich, dem einfachen Textformat vor.

:p.Wenn Ihnen das verwirrend erscheint, sehen Sie sich das folgende Beispiel an.

:p.
:p.:hp5.Kopierbeispiel:ehp5.
:p.Angenommen, Sie haben Codepage 943 (Japan SJIS-1990) ausgewÑhlt und kopieren
das Zeichen 0x82E2 (japanisches Hiragana-Zeichen &osq.YA&csq.).
:p.:artwork name='943_82e2.bmp' align=center.
:p.Durch das Kopieren dieses Zeichens wird die Bytefolge 0x82E2 im
Nur-Text-Format in die Zwischenablage eingefÅgt und der entsprechende
Unicode-Wert fÅr dasselbe Zeichen (U+3084) wird im Text/Unicode-Format (UCS-2)
in die Zwischenablage eingefÅgt.
:p.An dieser Stelle enthÑlt die Zwischenablage&colon.
:xmp.
    Textformat (CF_TEXT)&colon.     0x82E2 (Codepage-943-Wert fÅr YA Hiragana)
    Text/Unicode-Format&colon.      U+3084 (UCS-2-Wert fÅr YA Hiragana)
:exmp.
:p.Wenn Sie dann die ausgewÑhlte Codepage in Unicode Ñndern, wÑhrend sich dieses
Zeichen noch in der Zwischenablage befindet, konvertiert Erweiterte
Zeichentabelle es in den entsprechenden UTF-8-Wert fÅr japanisches &osq.YA&csq.
Hiragana. (Der Text/Unicode-Wert fÅr das Zeichen bleibt unverÑndert, da er
codepage-unabhÑngig ist.) Die Zwischenablage enthÑlt nun&colon.
:xmp.
    Textformat (CF_TEXT)&colon.     0xE38284 (UTF-8-Wert fÅr YA-Hiragana)
    Text/Unicode-Format&colon.      U+3084   (UCS-2-Wert fÅr YA Hiragana)
:exmp.
:p.Zum Schluss Ñndern Sie die ausgewÑhlte Codepage erneut, diesmal auf 949
(Korea KS-Code). Das Zeichen wird, wenn es sich noch in der Zwischenablage
befindet, erneut in den entsprechenden Wert fÅr diese neue Codepage
konvertiert&colon.
:xmp.
    Textformat (CF_TEXT)&colon.     0xAAE4 (Codepage-949-Wert fÅr YA Hiragana)
    Text/Unicode-Format&colon.      U+3084 (UCS-2-Wert fÅr YA Hiragana)
:exmp.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=500.EinfÅgen von Zeichen
:p.Wenn Sie kopierte Zeichen in eine andere Anwendung einfÅgen, wird der
Text/Unicode-Wert eingefÅgt, wenn (und nur wenn) die betreffende Anwendung dies
unterstÅtzt; andernfalls wird nur der reine Textwert eingefÅgt.

:p.EingefÅgte Zeichen werden entsprechend den Mîglichkeiten der Zielanwendung
angezeigt. Sofern die Anwendung nicht direkt Unicode zur Textdarstellung
verwendet (was relativ selten vorkommt), bedeutet dies im Allgemeinen, dass sie
mit der Codepage und Schriftart dargestellt werden, die in der Anwendung aktuell
aktiv sind. Wenn die Codepage/Schriftart-Kombination die eingefÅgten Zeichen
nicht anzeigen kann, werden sie nicht korrekt angezeigt.

:p.Wenn Sie beispielsweise das Zeichen 0x82E2 (japanisches &osq.YA&csq.
Hiragana) aus der Codepage 943 (Japan SJIS-1990) in Erweiterte Zeichentabelle
kopiert haben, wird beim Versuch, es in eine Anwendung einzufÅgen, die das
Text/Unicode-Zwischenablageformat nicht unterstÅtzt, der Zeichenwert 0x82E2
unverÑndert eingefÅgt. Dies wird in der Zielanwendung nur dann als &osq.YA&csq.
Hiragana-Zeichen angezeigt, wenn diese Anwendung die Codepage 943 (oder eine
kompatible Codepage wie 932) zur Anzeige verwendet, :hp1.und:ehp1. eine
Schriftart, die dieses Zeichen enthÑlt.


.* :h1 x=left y=bottom width=100% height=100% res=600.HÑufige Probleme
.* :p.
.* :dl.
.* :dt.
.* :dd.
.* :edl.


.* ----------------------------------------------------------------------------
:h1 res=990 name=license
    x=left y=bottom width=100% height=100%.Lizenz
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
