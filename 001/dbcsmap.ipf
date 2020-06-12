:userdoc.

.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=100.Extended Character Map
:p.Extended Character Map is an advanced character map program for OS/2.
Its features include&colon.
:ul compact.
:li.Unicode (Basic Multilingual Plane) character support
:li.Support for the currently-active system codepage.
:li.Support for additional multi-byte encodings, including common OS/2 East
Asian (CJK) codepages.
:li.Dual clipboard format supporting both native Unicode (recognized by
many OS/2 applications) and codepage-encoded plain text.
:eul.

:p.Extended Character Map organizes all characters according their assigned
numbers within the selected encoding (Unicode or codepage). Single-byte
codepages support 256 characters, which are all displayed in the character
grid.

:p.Multi-byte codepages, as well as Unicode (UCS-2), are subdivided into
groupings of 256 character values identified by a number known as the
:hp1.leading byte:ehp1.. Selecting the leading byte causes all characters
in the corresponding grouping to be displayed in the grid.
:nt.While each grouping contains 256 character :hp1.values:ehp1., not all
of these values are necessarily assigned to actual characters by a given
codepage. Values which do not represent valid characters are shown as
blank grey squares.:ent.

:p.:hp7.Controls:ehp7.
:p.The controls on the left-hand side of the window include&colon.

:dl break=all.
:dt.Encoding
:dd.The "Encoding" control allows you to select the character encoding to
display. The "Leading byte" selector is used to specify the desired leading
byte (shown in hexadecimal notation). The range of available leading byte
values may vary depending on the encoding.
:p.East Asian multi-byte codepages include certain single-byte characters which
do not use a leading byte. The leading byte value :hp2."--":ehp2. is available
for these codepages; selecting this value will show all single-byte characters
for that codepage.

:dt.Selected character
:dd.This area shows an enlarged image of whatever character is currently selected
(if any), with the corresponding byte values shown immediately below (in both
hexadecimal and decimal formats). For non-Unicode codepages, if the character
in question has a corresponding Unicode (UCS-2) value, that value is also shown
(prefixed by &osq.U+&csq.).

:dt.Copied characters
:dd.Provides controls for managing characters copied to the clipboard. See
:link reftype=hd res=400.copying characters:elink. for more information.
:edl.

:p.
:p.:hp7.More Information:ehp7.
:ul compact.
:li.:link reftype=hd res=200.Selecting fonts:elink.
:li.:link reftype=hd res=300.Supported codepages:elink.
:li.:link reftype=hd res=400.Copying characters:elink.
:li.:link reftype=hd res=500.Pasting characters into other applications:elink.
:eul.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=200.Fonts
:p.You can change the font used for character display through the "Options"
menu. For best results, you should use an outline font (TrueType or Type 1).

:p.In order to view Unicode characters properly, you must use a font that
supports Unicode encoding. Non-Unicode CJK fonts for Japanese, Korean, or
Chinese may be used, but are unlikely to correctly display characters under
encodings (including Unicode) other than those for which they are intended.

:p.Starting with Warp Server for e-business, OS/2 has come with several
Unicode fonts available out of the box&colon.
:dl break=all.
:dt.Times New Roman WT J
.br
Times New Roman WT K
.br
Times New Roman WT TC
.br
Times New Roman WT TT
:dd.A proportional serif font, also available under the name "Times New Roman
MT 30". (The four different versions have their Chinese character styles
optimized for cultural variations between Japanese, Korean, Simplified Chinese
and Traditional Chinese, respectively. For the most part, however, any one of
them is suitable for generic use.)
:dt.Monotype Sans Duospace WT J
.br
Monotype Sans Duospace WT K
.br
Monotype Sans Duospace WT TC
.br
Monotype Sans Duospace WT TT
:dd.A monospaced sans-serif font (locale-optimized in the same way as above).
:edl.

:p.For earlier OS/2 versions, "Times New Roman MT 30" is available as part of
the Java 1.1.8 runtime package from IBM (Unicode font version).

:p.You can also get comprehensive Unicode fonts from other sources. Some
commonly-encountered ones include&colon.
:dl break=all.
:dt.Arial Unicode MS
:dd.This font comes with recent versions of Microsoft Office, and is installed
under Windows if certain language options are selected. It can be installed under
OS/2 by obtaining the file ARIALUNI.TTF and installing it in the usual way. (A
valid license for Microsoft Office is required.)
:dt.Bitstream Cyberbit
:dd.A proportional serif font with comprehensive support for many
languages. It is available from
http&colon.//ftp.netscape.com/pub/communicator/extras/fonts/windows/Cyberbit.ZIP
and is free for non-commercial use.
:dt.Code 2000
:dd.This is a proportional serif font with support for a vast range of languages
and character sets. It is inexpensive shareware, available from
http&colon.//www.code2000.net.
:dt.Droid Sans Combined
:dd.This is a modified version of Google's Droid Sans font which combines the
character support from multiple language-specific versions. It is available
from various OS/2 file sites, including Hobbes&colon.
http&colon.//hobbes.nmsu.edu/h-search.php?key=droidfont&amp.pushbutton=Search
:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=300.Supported Encodings
:p.Extended Character Map allows you to select from the following encodings.
(Other than Unicode, each encoding is identified by its OS/2 codepage number.)

:p.(Some East Asian encodings may not be available on all systems, depending
on what options were selected at OS/2 install time.)

:dl break=all.

:dt.System codepage
:dd.Each of the currently configured system codepages (up to two) is provided
as an option, unless they happen to be the same as one of the other encodings
listed below. The actual codepage numbers (which will vary depending on your
system configuration) will be shown in the description.

:dt.942 (Japan SJIS-1978)
:dd.This is an older version of Shift-JIS encoding (see codepage 943, below)
that is based on the JIS-X-0208-1978 standard instead of the more recent 1990
standard.

:dt.943 (Japan SJIS-1990)
:dd.This is the PC Shift-JIS encoding for Japanese text, which is based on the
official JIS-X-0208-1990 character set standard (with IBM/NEC/Microsoft
extensions). It is used as the &osq.native&csq. Japanese encoding under OS/2
and Windows, and is sometimes also called :hp1.Windows-31J:ehp1. encoding. Note
that codepage 943 is alternatively referred to as codepage 932; the two are
equivalent.

:dt.944 (Korea SAA)
:dd.This is an older IBM encoding for Korean, provided for compatibility with
older systems. Wansung encoding (see codepage 949, below) is more commonly
used for Korean text. This codepage is not available on all systems.

:dt.946 (China SAA)
:dd.This is an older IBM encoding for Simplified Chinese, provided for
compatibility with older systems.  GB and/or GBK encoding (see codepages
1381 and 1386, below) are more commonly used for Simplified Chinese text.
This codepage is not available on all systems.

:dt.948 (Taiwan SAA)
:dd.This is an implementation of the CNS-11643 Traditional Chinese character
set (with IBM extensions). It is provided mainly for compatibility purposes,
as BIG-5 encoding (see codepage 950, below) is more commonly used for
Traditional Chinese text. Support for this codepage is not installed on all
systems.

:dt.949 (Korea KS-Code)
:dd.This is the IBM implementation of the Korean Wansung character set
standard. It includes KSC-5601 EUC code set 1 plus IBM MBCS-PC extensions.

:nt.The OS/2 version of codepage 949 only supports the basic Wansung character
set (plus the IBM extensions). There is a replacement codepage table available
which updates codepage 949 to support the MS Unified Hangul Code ("Extended
Wansung") encoding.
:p.To install the updated codepage table, download
http&colon.//www.borgendale.com/tools/ulstools.zip, extract the updated IBM949
codepage table from the archive, and copy it over the existing version under
\LANGUAGE\CODEPAGE on your boot drive.:ent.

:dt.950 (Taiwan BIG-5)
:dd.This is the BIG-5 encoding for Traditional Chinese text (as used in Hong
Kong and Taiwan). It is the default codepage used by Traditional Chinese
DBCS versions of OS/2.

:dt.1381 (China GB)
:dd.This is the IBM MBCS-PC implementation of the GB-2312 character set
standard for Simplified Chinese text (as used in the People's Republic of
China). It is provided mainly for compatibility purposes, as GBK encoding
(see codepage 1386, below) has largely superseded it.

:dt.1386 (China GBK)
:dd.This is the IBM MBCS-PC implementation of the GBK character set standard
for Simplified Chinese text. It is the default codepage used by Simplified
Chinese DBCS versions of OS/2, and is approximately equivalent to Windows
codepage 936.

:dt.Unicode (Plane 0)
:dd.Unicode is a &osq.universal&csq. text encoding that is rapidly becoming
the dominant standard for representing multilingual text.
:p.OS/2, and therefore this program, supports only Plane 0 of Unicode, called
the :hp1.Basic Multilingual Plane:ehp1.. This nonetheless provides support for
tens of thousands of characters representing almost all writing systems in use
around the world today.
:p.Extended Character Map represents Unicode characters in the codepage
selector according to 2-byte Universal Character Set (UCS-2) values.  (When
copied to the clipboard as plain text, however, they are stored in UTF-8
format. See :link reftype=hd res=400.Copying Characters:elink. for details.)
:edl.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=400.Copying Characters
:p.A character can be copied to the clipboard either by double-clicking on
it in the character map, or by highlighting it and then selecting "Add".

:p.The first character copied in this way after you open Extended Character Map
will replace the previous clipboard contents (if any). However, any subsequent
characters that you copy will be appended to those previously copied. Extended
Character Map &osq.remembers&csq. previously-copied characters, so even if you
clear or replace the contents of the clipboard using another program, the
characters you copied using Extended Character Map will be restored to the
clipboard the next time you copy a character. (Or, alternatively, if you
select "Re-copy all" from the "Edit" menu.) These &osq.remembered&csq.
characters are also referred to as the &osq.clipboard buffer&csq., and are
displayed in the clipboard panel.

:p.The "Clear" button erases the current clipboard contents, including any
characters previously copied with Extended Character Map. The "Delete" button
erases only the last character from the clipboard buffer.

:p.When a character is copied, the raw double-byte value of that character (as
shown beneath the glyph preview window) is placed onto the clipboard in plain
text format &endash. :hp1.except:ehp1. in the case of Unicode characters, which
are stored as one-to-three-byte UTF-8 values instead (since most applications
are not capable of processing raw UCS byte values as plain text).

:p.However, if you select a new codepage while characters are still in the
clipboard, those characters will be converted into their equivalents under the
new codepage. This means that the byte values of previously-copied characters
may change (to the appropriate values under the new codepage). If a character
does not exist in the new codepage, it will be replaced with a generic
substitution character.

:p.In addition, all copied characters are also placed on the clipboard in the
custom "text/unicode" format (Unicode UCS-2), if the "Copy Unicode" option is
enabled (as it is by default).  Applications which support this clipboard
format (such as the Mozilla family of products) will generally use it when
pasting, in preference to the plain text format, whenever possible.

:p.If this seems confusing, refer to the example below.

:p.
:p.:hp5.Copying Example:ehp5.
:p.Let's say you have codepage 943 (Japan SJIS-1990) selected, and you copy
the character 0x82E2 (Japanese hiragana character &osq.YA&csq.).
:p.:artwork name='943_82e2.bmp' align=center.
:p.Copying this character causes the byte sequence 0x82E2 to be placed in
the clipboard under the plain text format, and the equivalent Unicode value
for the same character (U+3084) to be placed in the clipboard under the
text/unicode (UCS-2) format.
:p.At this point the clipboard contains&colon.
:xmp.
    Text format (CF_TEXT)&colon.    0x82E2 (codepage 943 value for YA hiragana)
    Text/unicode format&colon.      U+3084 (UCS-2 value for YA hiragana)
:exmp.
:p.If you then change the selected codepage to Unicode with this character
still in the clipboard, Extended Character Map will convert it to the equivalent
UTF-8 value for Japanese &osq.YA&csq. hiragana. (The text/unicode value for the
character remains unchanged, as it is codepage-independent.) The clipboard
now contains&colon.
:xmp.
    Text format (CF_TEXT)&colon.    0xE38284 (UTF-8 value for YA hiragana)
    Text/unicode format&colon.      U+3084   (UCS-2 value for YA hiragana)
:exmp.
:p.Finally, let's say you change the selected codepage again, this time to
949 (Korea KS-Code). The character, if it is still in the clipboard, will
once again be converted to the appropriate value for this new codepage&colon.
:xmp.
    Text format (CF_TEXT)&colon.    0xAAE4 (codepage 949 value for YA hiragana)
    Text/unicode format&colon.      U+3084 (UCS-2 value for YA hiragana)
:exmp.


.* ----------------------------------------------------------------------------
:h1 x=left y=bottom width=100% height=100% res=500.Pasting Characters
:p.When you paste copied characters into another application, the
text/unicode value will be pasted if (and only if) the application in
question supports it; otherwise, only the plain text value will be pasted.

:p.Pasted characters will be displayed according to the capabilities of the
target application. Unless the application uses Unicode directly for
rendering text (which is relatively uncommon), this generally means that
they will be rendered using whatever codepage and font are currently active
in that application. If the codepage/font combination is not capable of
displaying the pasted characters, they will not be displayed correctly.

:p.For example, if you copied character 0x82E2 (Japanese &osq.YA&csq. hiragana)
from codepage 943 (Japan SJIS-1990) in Extended Character Map, attempting to
paste it into an application that does not support the text/unicode clipboard
format will cause the character value 0x82E2 to be pasted verbatim. This will
only appear in the target application as a &osq.YA&csq. hiragana character if
that application is using codepage 943 (or a compatible codepage such as 932)
for display, :hp1.and:ehp1. a font containing that character.


.* :h1 x=left y=bottom width=100% height=100% res=600.Common Problems
.* :p.
.* :dl.
.* :dt.
.* :dd.
.* :edl.


.* ----------------------------------------------------------------------------
:h1 res=990 name=license
    x=left y=bottom width=100% height=100%.License
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
