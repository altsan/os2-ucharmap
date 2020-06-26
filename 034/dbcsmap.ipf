:userdoc.

.nameit symbol='nomsolo' text='Mapa de caracteres extendido'
.nameit symbol='Nomprog' text='El &nomsolo.'
.nameit symbol='nomprog' text='el &nomsolo.'
.nameit Symbol='leadbyte' text='byte inicial'
.nameit Symbol='leadbytes' text='bytes iniciales'
.nameit Symbol='leadbyteUI' text='Byte inicial'

.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=100.&nomsolo.

&Nomprog. es un programa de mapa de caracteres avanzado para OS/2. Sus
funciones incluyen:

:ul compact.
:li.Soporte de caracteres Unicode (plano multilingÅe b†sico).
:li.Soporte para la p†gina de c¢digos activa en el sistema actualmente.
:li.Soporte para codificaciones multi-byte adicionales, incluidas las p†ginas
de c¢digos de OS/2 para Asia oriental (CJK).
:li.Formato dual de portapapeles (†rea com£n), con soporte nativo de Unicode
(reconocido por muchas aplicaciones de OS/2) adem†s de texto simple codificado
seg£n p†ginas de c¢digos.
:eul.

:p.&Nomprog. organiza todos los caracteres de acuerdo con los n£meros que
tienen asignados en la codificaci¢n seleccionada actualmente (Unicode o una
p†gina de c¢digos). Las p†ginas de c¢digos de byte £nico soportan 256
caracteres, todos los cuales se muestran en la matriz de caracteres.

:p.Las p†ginas de c¢digos multi-byte, as° como Unicode (UCS-2), se subdividen
en agrupaciones de 256 valores de caracteres identificados mediante un n£mero
que denominaremos :hp1.&leadbyte.:ehp1.. Seleccionar el &leadbyte. hace que
todos los caracteres en la agrupaci¢n se muestren en la matriz.

:nt.Aunque cada agrupaci¢n contiene 256 :hp1.valores:ehp1. de caracteres, no
todos estos valores est†n necesariamente asignados a verdaderos caracteres en
una p†gina de c¢digos. Los valores que no representan caracteres v†lidos se
muestran como cuadrados grises en blanco.:ent.

:p.:hp7.Controles:ehp7.

:p.Los controles en la izquierda de la ventana incluyen:

:dl break=all.
:dt.Codificaci¢n
:dd.Permite seleccionar la codificaci¢n de caracteres que se va a mostrar. El
selector Æ&leadbyteUI.Ø se utiliza para especificar el &leadbyte. deseado
(mostrado en notaci¢n hexadecimal). El rango de &leadbytes. disponibles puede
variar dependiendo de la codificaci¢n.

:p.Las p†ginas de c¢digos multi-byte de Asia oriental incluyen ciertos
caracteres de byte £nico que no usan un &leadbyte. Para estas p†ginas de
c¢digos est† disponible el valor de &leadbyte. Æ:hp2.--:ehp2.Ø; seleccionarlo
a§adir† todos los caracteres de byte £nico de esa p†gina de c¢digos.

:dt.Car†cter seleccionado

:dd.Muestra una imagen ampliada del car†cter que estÇ seleccionado actualmente
(si alguno lo est†), con los correspondientes valores de byte mostrados
inmediatamente debajo (tanto en formato decimal como hexadecimal). Para las
p†ginas de c¢digos no Unicode, si el car†cter en cuesti¢n tiene un valor
Unicode (UCS-2) correspondiente, Çste tambiÇn se muestra (con el prefijo ÆU+Ø).

:dt.Caracteres copiados
:dd.Proporciona controles para manejar los caracteres copiados al portapapeles
o †rea com£n. Consulte :link reftype=hd res=400.copiar caracteres:elink. para
m†s informaci¢n.
:edl.

:p.

:p.:hp7.M†s informaci¢n:ehp7.

:ul compact.
:li.:link reftype=hd res=200.Seleccionar fuentes:elink.
:li.:link reftype=hd res=300.P†ginas de c¢digos soportadas:elink.
:li.:link reftype=hd res=400.Copiar caracteres:elink.
:li.:link reftype=hd res=500.Pegar caracteres en otras aplicaciones:elink.
:eul.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=200.Fuentes

Puede cambiar la fuente utilizada para mostrar los caracteres desde el men£
ÆOpcionesØ. Para un resultado ¢ptimo, deber°a usar una fuente de contorno
(TrueType o Tipo 1).

:p.Para ver caracteres Unicode correctamente, debe utilizar una fuente que
soporte la codificaci¢n Unicode. Se puede utilizar las fuentes CJK no Unicode
para el chino, japonÇs o coreano, pero es improbable que muestren correctamente
los caracteres de codificaciones (Unicode incluida) distintas a aquellas para
las que fueron proyectadas.

:p.Empezando por Warp Server for e-business, OS/2 ha incorporado de serie
varias fuentes Unicode:

:dl break=all.
:dt.Times New Roman WT J
.br
Times New Roman WT K
.br
Times New Roman WT TC
.br
Times New Roman WT TT

:dd.Una fuente proporcional con remates, tambiÇn disponible bajo el nombre
ÆTimes New Roman MT 30Ø. (Las cuatro versiones diferentes tienen estilos para
los caracteres chinos optimizados para las variaciones culturales entre el
japonÇs, coreano, chino simplificado y chino tradicional, respectivamente. En
su mayor parte, sin embargo, cualquiera de ellas es adecuada para uso
genÇrico.)

:dt.Monotype Sans Duospace WT J
.br
Monotype Sans Duospace WT K
.br
Monotype Sans Duospace WT TC
.br
Monotype Sans Duospace WT TT
:dd.Una fuente monoespaciada de palo seco (con perfiles nacionales optimizados
igual que la anterior).

:edl.

:p.Para las versiones anteriores de OS/2, ÆTimes New Roman MT 30Ø est†
disponible como parte del paquete del entorno de ejecuci¢n de Java 1.1.8 de IBM
(versi¢n con fuente Unicode).

:p.TambiÇn puede vd. obtener fuentes Unicode completas de otras fuentes.
Algunas utilizadas com£nmente incluyen:

:dl break=all.
:dt.Arial Unicode MS

:dd.Viene con versiones recientes de Microsoft Office, y se instala en Windows
si se seleccionan ciertas opciones de idiomas. Se puede instalar en OS/2
obteniendo el archivo ARIALUNI.TTF e instal†ndolo de la forma habitual. (Se
necesita una licencia v†lida de Microsoft Office.)

:dt.Bitstream Cyberbit

:dd.Una fuente proporcional con remates con soporte completo de muchos idiomas.
Est† disponible en
http&colon.//ftp.netscape.com/pub/communicator/extras/fonts/windows/Cyberbit.ZIP
y es gratuita para su uso no comercial.

:dt.Code 2000

:dd.Fuente proporcional con remates con soporte para un amplio abanico de
idiomas y conjuntos de caracteres. Es shareware, disponible por poco dinero en
http&colon.//www.code2000.net.

:dt.Droid Sans Combined

:dd.Una versi¢n modificada de la fuente de Google Droid Sans que combina el
soporte de caracteres de varias versiones para idiomas espec°ficos. Est†
disponible en varias fuentes de archivos para OS/2, incluido Hobbes&colon.
http&colon.//hobbes.nmsu.edu/h-search.php?key=droidfont&amp.pushbutton=Search

:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=300.Codificaciones soportadas

&Nomprog. le permite seleccionar entre las siguientes codificaciones. (Aparte
de Unicode, cada codificaci¢n se identifica mediante su n£mero de p†gina de
c¢digos de OS/2.)

:p.(Algunas codificaciones de Asia oriental pueden no estar disponibles en
todos los sistemas, dependiendo de quÇ opciones se seleccionaran en el momento
de instalar OS/2.)

:dl break=all.

:dt.P†gina de c¢digos del sistema.
:dd.Se ofrece como opci¢n la p†gina de c¢digos activa actualmente en el sistema
(a no ser que sea una de las otras codificaciones listadas m†s abajo). Su
n£mero de p†gina de c¢digos concreto (que se muestra en la lista) variar†
dependiendo de la configuraci¢n de su sistema.

:dt.942 (SJIS-1978 de Jap¢n)
:dd.Es una versi¢n m†s antigua de la codificaci¢n Shift-JIS (consulte p†gina de
c¢digos 943, m†s abajo) que se basa en el est†ndar JIS-X-0208-1978 en vez del
m†s reciente de 1990.

:dt.943 (SJIS-1990 de Jap¢n)
:dd.Es la codificaci¢n de PC Shift-JIS para texto japonÇs, que se basa en el
est†ndar oficial de conjuntos de caracteres JIS-X-0208-1990 (con extensiones de
IBM/NEC/Microsoft). Se usa como codificaci¢n ÆnativaØ japonesa bajo OS/2 y
Windows, y a veces tambiÇn se la llama codificaci¢n :hp1.Windows-31J:ehp1..
Note que alternativamente se llama p†gina de c¢digos 932 a la 943; las dos
denominaciones son equivalentes.

:dt.944 (SAA de Corea)
:dd.Es una codificaci¢n antigua de IBM para el coreano, suministrada para
compatibilidad con sistemas antiguos. La codificaci¢n Wansung (consulte p†gina
de c¢digos 949, m†s abajo) se utiliza m†s com£nmente para el texto coreano.
Esta p†gina de c¢digos no est† disponible en todos los sistemas.

:dt.946 (SAA de China)
:dd.Es una codificaci¢n antigua de IBM para el chino simplificado, suministrada
para compatibilidad con sistemas antiguos. Las codificaciones GB y/o GBK
(consulte p†ginas de c¢digos 1381 y 1386, m†s abajo) se utilizan com£nmente
para el texto en chino simplificado. Esta p†gina de c¢digos no est† disponible
en todos los sistemas.

:dt.948 (SAA de Taiw†n)
:dd.Es una implementaci¢n del conjunto de caracteres CNS-11643 del chino
tradicional (con extensiones de IBM). Se suministra principalmente por
compatibilidad con sistemas antiguos, ya que la codificaci¢n BIG-5 (consulte
p†gina de c¢digos 950, m†s abajo) se utiliza m†s com£nmente para el texto en
chino simplificado. Esta p†gina de c¢digos no est† disponible en todos los
sistemas.

:dt.949 (KS-Code de Corea)
:dd.Es la implementaci¢n de IBM del est†ndar Wansung del conjunto de caracteres
del coreano. Incluye el conjunto de c¢digos 1 de KSC-5601 EUC m†s las
extensiones MBCS-PC de IBM.

:nt.La versi¢n de OS/2 de la p†gina de c¢digos 949 s¢lo soporta el conjunto
de caracteres Wansung b†sico (m†s las extensiones de IBM). Hay disponible una
p†gina de c¢digos sustituta que actualiza la 949 para cubrir la codificaci¢n
C¢digo Hangul Unificado MS (ÆWansung extendidoØ).

:p.Para instalar la tabla actualizada de la p†gina de c¢digos, descargue
http&colon.//www.borgendale.com/tools/ulstools.zip, extraiga del archivador la
tabla actualizada de la p†gina de c¢digos IBM949 y c¢piela sobre la versi¢n
preexistente en \LANGUAGE\CODEPAGE en su unidad de arranque.:ent.

:dt.950 (BIG-5 de Taiw†n)
:dd.Es la codificaci¢n BIG-5 para el texto en chino tradicional (como se usa en
Hong Kong y Taiw†n). Es la p†gina de c¢digos por omisi¢n utilizada por las
versiones DBCS de OS/2 en chino tradicional.

:dt.1381 (GB de China) :dd.Es la implementaci¢n MBCS-PC de IBM del est†ndar
GB-2312 del conjunto de caracteres para el texto en chino simplificado (como se
usa en la Rep£blica Popular China). Se suministra principalmente por razones de
compatibilidad, ya que la codificaci¢n GBK (consulte p†gina de c¢digos 1386,
m†s abajo) la ha sustituido en gran medida.

:dt.1386 (China GBK)
:dd.Es la implementaci¢n MBCS-PC de IBM del est†ndar GBK del conjunto de
caracteres para el texto en chino simplificado. Es la p†gina de c¢digos por
omisi¢n utilizada por las versiones DBCS de OS/2 en chino simplificado, y
aproximadamente equivalente a la p†gina de c¢digos 936 de Windows.

:dt.Unicode (Plano 0)
:dd.Unicode es una codificaci¢n de texto ÆuniversalØ que se est† convirtiendo
r†pidamente en el est†ndar dominante para representar texto multilingÅe.

:p.OS/2 y, por tanto, este programa s¢lo soportan el Plano 0 de Unicode,
denominado el :hp1.plano multilingÅe b†sico:ehp1.. Sin embargo, esto
proporciona soporte para decenas de miles de caracteres, representando casi
todos los sistemas de escritura en uso en el mundo actualmente.

:p.&Nomprog. representa los caracteres Unicode del selector de p†ginas de
c¢digos de acuerdo con los valores UCS-2 (universal character set, conjunto
universal de caracteres) de 2 bytes. (Al copiarlos al portapapeles como texto
simple, sin embargo, se almacenan en formato UTF-8. Consulte :link reftype=hd
res=400.Copiar caracteres:elink. para los detalles.)

:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=400.Copiar caracteres

Un car†cter puede copiarse al portapapeles mediante una doble pulsaci¢n del
rat¢n sobre el mismo en el mapa de caracteres, o seleccion†ndolo y pulsando
ÆA§adirØ.

:p.El primer car†cter copiado de esta forma tras abrir &nomprog. sustituir† el
contenido previo del portapapeles (si lo hay). Sin embargo, cualesquiera
caracteres copiados a continuaci¢n se le anexar†n. &Nomprog. ÆrecuerdaØ los
caracteres copiados previamente, as° que incluso si vac°a el portapapeles o
sustituye su contenido usando otro programa, los caracteres que vd. copiara
usando &nomprog. volver†n a llenar el portapapeles la pr¢xima vez que copie un
car†cter. (O alternativamente, si selecciona ÆRepetir copiarØ en el men£
ÆEditarØ.) Estos caracteres ÆrecordadosØ constituyen un Æalmacenamiento
intermedio del portapapelesØ y se muestran en el panel del portapapeles.

:p.El bot¢n ÆVaciarØ borra el contenido actual del portapapeles, incluidos
cualesquiera caracteres copiados previamente con &nomprog.. El bot¢n ÆSuprimirØ
s¢lo borra el £ltimo car†cter del almacenamiento intermedio del portapapeles.

:p.Cuando se copia un car†cter, su valor de doble byte sin procesar (tal como
se muestra bajo la ventana de vista previa del glifo) se coloca en el
portapapeles como texto simple, :hp1.excepto:ehp1. en el caso de los caracteres
Unicode, que en su lugar se almacenan como valores UTF-8 de entre uno y tres
bytes (puesto que la mayor°a de aplicaciones no son capaces de procesar como
texto simple los valores de bytes UCS sin procesar).

:p.Sin embargo, si selecciona una nueva p†gina de c¢digos mientras a£n hay
caracteres en el portapapeles, estos caracteres se convertir†n a sus
equivalentes en la nueva p†gina de c¢digos. Esto significa que los valores de
byte de los caracteres previamente copiados pueden cambiar (a los valores
apropiados seg£n la nueva p†gina de c¢digos). Si un car†cter no existe en la
nueva p†gina de c¢digos, ser† reemplazado por un car†cter de sustituci¢n
genÇrico.

:p.Adem†s, todos los caracteres copiados tambiÇn se colocan en el portapapeles
en el formato propio Ætext/unicodeØ (Unicode UCS-2) si se habilita la opci¢n
ÆCopiar como UnicodeØ (como lo est† por omisi¢n). Las aplicaciones que soportan
este formato de portapapeles (tal como la familia de productos Mozilla) lo usan
generalmente al pegar, con preferencia sobre el formato de texto simple,
siempre que es posible.

:p.Si esto parece confuso, rem°tase al ejemplo m†s abajo.

:p.
:p.:hp5.Ejemplo de copia:ehp5.

:p.Digamos que ha seleccionado la p†gina de c¢digos 943 (SJIS-1990 de Jap¢n) y
copia el car†cter 0x82E2 (car†cter japonÇs ÆIAØ [o ÆYAØ, en representaci¢n
latina Hepburn o ÆromajiØ] del silabario hiragana).

:p.:artwork name='943_82e2.bmp' align=center.

:p.Copiar este car†cter hace que se coloque en el portapapeles la secuencia de
bytes 0x82E2 en formato de texto simple y el valor equivalente en Unicode para
el mismo car†cter (U+3084) en el portapapeles en formato Ætext/unicodeØ
(UCS-2).

:p.En este momento el portapapeles contiene:

:xmp.
    Formato texto (CF_TEXT):    0x82E2 (valor en p.c. 943 de ÆIAØ en hiragana)
    Formato Ætext/unicodeØ:     U+3084 (valor UCS-2 de ÆIAØ en hiragana)
:exmp.

:p.Si cambia vd. entonces la p†gina de c¢digos seleccionada a Unicode con este
car†cter a£n en el portapeles, &nomprog. lo convertir† al valor UTF-8
equivalente para ÆIAØ en el hiragana del japonÇs. (El valor text/unicode del
car†cter contin£a sin cambios, ya que no depende de p†ginas de c¢digos.) Ahora
el portapapeles contiene:

:xmp.
    Formato texto (CF_TEXT):    0xE38284 (valor UTF-8 de ÆIAØ en hiragana)
    Formato Ætext/unicodeØ:     U+3084   (valor UCS-2 de ÆIAØ en hiragana)
:exmp.

:p.Por £ltimo, digamos que vuelve a cambiar la p†gina de c¢digos seleccionada,
esta vez a 949 (KS-Code de Corea). El car†cter, si a£n sigue en el
portapapeles, se convertir† una vez m†s al valor apropiado seg£n esta nueva
p†gina de caracteres:

:xmp.
    Formato texto (CF_TEXT):    0xAAE4 (valor en p.c. 949 de ÆIAØ en hiragana)
    Formato Ætext/unicodeØ:     U+3084 (valor UCS-2 de ÆIAØ en hiragana)
:exmp.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=500.Pegar caracteres

Si pega en otra aplicaci¢n caracteres copiados, ser† el valor Ætext/unicodeØ el
que se pegue si (y s¢lo si) la aplicaci¢n en cuesti¢n lo soporta; de otro modo,
s¢lo se pegar† el valor de texto simple.

:p.Los caracteres pegados se mostrar†n de acuerdo con las capacidades de la
aplicaci¢n objetivo. A no ser que la aplicaci¢n use Unicode directamente para
representar el texto (lo cual es relativamente infrecuente), generalmente esto
significa que se mostrar†n usando cualesquiera fuente y p†gina de c¢digos estÇn
activas en esa aplicaci¢n. Si la combinaci¢n fuente + p†gina de c¢digos no es
capaz de mostrar los caracteres copiados, no se ver†n correctamente.

:p.Por ejemplo, si copiase el car†cter 0x82E2 (ÆIAØ hiragana del japonÇs) de la
p†gina de c¢digos 943 (SJIS-1990 de Jap¢n) en &nomprog., intentando pegarlo en
una aplicaci¢n que no soporta el formato Ætext/unicodeØ del portapapeles har†
que se pegue el valor de car†cter 0x82E2 tal cual. êste s¢lo aparecer† en la
aplicaci¢n objetivo como el caracter hiragana ÆIAØ si la aplicaci¢n est† usando
la p†gina de c¢digos 943 (u otra compatible como la 932) para mostrar texto,
:hp1.y tambiÇn:ehp1. una fuente que contenga ese car†cter.


.* :h1 x=left y=bottom width=100% height=100% res=600.Problemas comunes
.* :p.
.* :dl.
.* :dt.
.* :dd.
.* :edl.


.* ----------------------------------------------------------------------------
:h1 res=990 name=license
    x=left y=bottom width=100% height=100%.Licencia

Nota para usuarios hispanohablantes:

:p.La Fundaci¢n de Software Libre (FSF) no aprueba el uso oficial de
traducciones de sus licencias debido a los costes de verificaci¢n, as° como
para prevenir posibles responsabilidades legales derivadas del uso de
traducciones sin verificar.

:p.Para su comodidad, y de forma legalmente no vinculante, encontrar† aqu° un
enlace a la licencia GPLv2 en su idioma. Puede leer una versi¢n en espa§ol del
siguiente texto en http&colon.//www.sidar.org/legal/2003/gpl.html

:p.êsta es la GPLv2 legalmente vinculante en el inglÇs original:

:p.
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

:lm margin=4.
:font facename='System Monospaced' size=13x1.
:p.&lt.one line to give the program's name and a brief idea of what it does.&gt.
.br
Copyright (C) 19yy  &lt.name of author&gt.

:p.This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

:p.This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

:p.You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA  02111-1307  USA
:font facename=default.
:lm margin=1.

:p.Also add information on how to contact you by electronic and paper mail.

:p.If the program is interactive, make it output a short notice like this
when it starts in an interactive mode&colon.

:lm margin=4.
:font facename='System Monospaced' size=13x1.
:p.Gnomovision version 69, Copyright ∏ 19yy name of author
.br
Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type 'show w'.
.br
This is free software, and you are welcome to redistribute it
under certain conditions; type 'show c' for details.
:font facename=default.
:lm margin=1.

:p.The hypothetical commands 'show w' and 'show c' should show the appropriate
parts of the General Public License.  Of course, the commands you use may
be called something other than 'show w' and 'show c'; they could even be
mouse-clicks or menu items--whatever suits your program.

:p.You should also get your employer (if you work as a programmer) or your
school, if any, to sign a "copyright disclaimer" for the program, if
necessary.  Here is a sample; alter the names&colon.

:lm margin=4.
:font facename='System Monospaced' size=13x1.
:p.Yoyodyne, Inc., hereby disclaims all copyright interest in the program
.br
'Gnomovision' (which makes passes at compilers) written by James Hacker.

:p.&lt.signature of Ty Coon&gt., 1 April 1989
.br
Ty Coon, President of Vice :font
facename=default. :lm margin=1.

:p.This General Public License does not permit incorporating your program into
proprietary programs.  If your program is a subroutine library, you may
consider it more useful to permit linking proprietary applications with the
library.  If this is what you want to do, use the GNU Library General
Public License instead of this License.

:euserdoc.
