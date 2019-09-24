EXTENDED CHARACTER MAP FOR OS/2
  Version 1.6 (released 2018-04-06)

  Extended Character Map for OS/2 (previously known as Double Byte Character
  Map) is a character map program that is designed to support characters from
  both single- and multi-byte encodings.  It supports both Unicode (Plane 0)
  text, plus a number of specific East Asian codepages, in addition to the
  current system codepage.

  Conventional OS/2 character map programs support only single-byte characters,
  which is generally sufficient for Western languages, but suddenly becomes
  inadequate when you need access to the vast Unicode character set, or writing
  systems like Chinese, Japanese, or Korean (collectively known as 'CJK').
  Extended Character Map is designed to fill in this gap.

  Extended Character Map does not require your system codepage(s) to be set to
  any particular value.  It should be fully-functional on any language version
  of OS/2.


REQUIREMENTS:

  Extended Character Map should work on OS/2 Warp 4 and higher, or OS/2 Warp 3
  with the latest FixPaks installed.  IBM APAR PJ31908 for PMMERGE.DLL
  (applicable to Warp 4 and up) is strongly recommended due to a codepage
  switching bug in earlier versions (see below under "Bugs/Limitations").

  To be able to view any of the DBCS codepages other than Unicode, the OS/2
  translation table for that codepage must be installed.  Recent versions of
  OS/2 install the more commonly-used ones by default, but not certain rarely-
  used legacy 'SAA' encodings.  (Codepages which are not installed will not be
  available in the GUI. They can be installed from the OS/2 install CD by
  unzipping \OS2IMAGE\FI\FONT\xxCODEPG.ZIP into the \LANGUAGE\CODEPAGE
  directory on your boot drive; no reboot is needed.)

  You must have a font installed which contains the characters you want to see.
  So you need either a Unicode font with comprehensive CJK support (which is
  recommended), or else specific fonts for Korean, Chinese, and/or Japanese, in
  order to be able to view those respective character sets.  By default,
  Extended Character Map will attempt to use the Unicode font "Times New Roman
  MT 30", which should be present on most OS/2 systems.  (Under Warp 4 and Warp
  3, this may require you to install IBM Java 1.1.8, which includes this font.)

  Since WSeB, OS/2 comes with several other Unicode fonts capable of displaying
  many double-byte characters.  "Times New Roman WT xx" is a proportional serif
  font, and "Monotype Sans Duospace WT xx" is a monospaced sans-serif font.
  You can also get comprehensive Unicode fonts from other sources; commonly-
  encountered ones include "Bitstream Cyberbit" and "Arial Unicode MS".

  Obviously, whatever application you paste the character into must be capable
  of displaying characters in the selected DBCS codepage, and should be using
  a font containing that character.

  Refer to the program help for more information.


INSTALLATION

  Copy DBCSMAP.EXE to any directory, and either run it from there or create a
  program object for it.  Copy DBCSMAP.HLP to a directory on your HELP path.

  NOTE: if you want to use the Korean codepage 949 with this program, you may
  wish to obtain the updated codepage 949 available from Ken Borgendale's OS/2
  Internationalization website (http://www.borgendale.com/uls.htm).  This is
  entirely optional; Korean text will still be usable without this update, but
  full support for the MS Extended Wansung encoding will be unavailable.


USAGE

  When you run DBCSMAP.EXE, you will see a 256-cell character grid on the right
  side of the window, and a set of controls on the left.  These are described in
  detail in the program help; to summarize briefly:

  * The "Encoding" panel allows you to select the codepage (character encoding);
    use the "Leading byte" selector to view double-byte characters beginning
    with the specified (hexadecimal) byte value.  The range of available leading
    bytes varies depending on the current codepage.

  * The "Selected character" panel shows an enlarged image of whatever character
    is currently selected (if any), with the byte values corresponding to that
    character shown immediately below (in both hexadecimal and decimal formats).
    (If the character is coloured dark blue instead of black, it indicates that
    it had to be rescaled down slightly in order to fit into the preview panel.)

  * The "Copied characters" panel provides some clipboard controls, including a
    preview of the current clipboard buffer contents.

  You can change the font used for character display through the "Options" menu.


Copying and Pasting Characters

  The first time you copy a character to the clipboard after starting Extended
  Character Map, any previous clipboard contents will be replaced.  However,
  Extended Character Map remembers characters that have already been copied
  since it was started, and appends newly-copied characters onto the previous
  ones.  The "Clear" button erases the current clipboard contents; the "Delete"
  button erases only the last character.

  (Note that if you use an external program to clear or replace the clipboard
  contents while Extended Character Map is running, any characters previously
  copied with Extended Character Map will reappear the next time you copy a
  character, unless you use the "Clear" button as well.)

  Each character is copied as a raw multi-byte value representing its semantic
  value in the currently-selected codepage (if it exists); if the option is
  enabled, they are also copied as Unicode UCS-2 values in a format supported
  by Mozilla and OpenOffice.org (2.4 and up).  See the program help for
  detailed information (including examples).

  When you paste copied characters into another application, they will be
  rendered according to whatever codepage and font that application is using.
  (If these aren't capable of displaying the characters, you will most likely
  see only meaningless gibberish).

  Rich Walsh's "CPPal" utility (available on Hobbes) is very handy for forcibly
  setting a PM application's codepage on the fly.  Be warned, though, that some
  PM controls (especially MLEs) don't handle switching from an SBCS to a DBCS
  codepage like this very well.


NOTE FOR FREETYPE/2 USERS

  If you use recent versions (1.20 and later) of the FreeType/2 replacement
  TrueType font driver, you should make sure that the "force Unicode encoding"
  option is enabled.

  These versions of FreeType/2 implement some special logic to try and work
  around some problems with CJK character handling under DBCS versions of
  OS/2.  As a side effect, however, many non-ASCII characters may not display
  correctly (or at all) if either:
   - the current font is not using Unicode encoding.
   - the current process codepage is DBCS (e.g. 932, 949), and you are
     attempting to view characters from a different codepage (e.g. Unicode).

  In addition, these versions typically disable Unicode encoding entirely if
  the font has fewer than 3,072 glyphs.  This may also result in non-ASCII
  (or at least non-UGL) glyphs failing to display.

  Forcing FreeType/2 to always use Unicode should eliminate these problems
  for the most part.

  Note that the above does not apply to version 1.10 from Michal Necasek
  (although his last release may also disable Unicode encoding for fonts with
  fewer than 2,048 glyphs).


BUGS/LIMITATIONS

  * You cannot currently select a bitmap font for display.

  * If you select a non-Unicode font with a specific CJK encoding (e.g. PMJPN,
    PMKOR, BIG5, etc.) then characters will only display correctly under the
    corresponding codepage.  Also, the characters will not display at all in
    the clipboard viewer, which always uses Unicode for display.  Unicode
    characters will only display correctly if you use a Unicode font (which
    is recommended).

  * The clipboard preview panel supports a maximum of 256 characters.  More
    characters can in principle be copied, but only the first 256 will be
    shown.

  * If you do not have a version of PMMERGE.DLL with BLDLEVEL 14.106 or
    higher, you may be affected by a bug in Presentation Manager's Unicode
    font support.  Specifically, after running Extended Character Map (or any
    other program which changes the message-queue codepage internally) a large
    number of times, non-ASCII characters will suddenly cease to be displayed
    properly throughout the system.  If this problem occurs, only rebooting
    will resolve it.

    This is caused by a bug in PMMERGE.DLL which seems to be triggered by using
    Unicode fonts specifically.  There are two solutions that I am aware of:
      - As mentioned, install IBM APAR PJ31908, which provides a fix; this is
        recommended.
      - Alternatively, enabling DBCSMAP to use the Innotek Font Engine (tested
        with v2.60) apparently circumvents enough of PM's normal code to render
        it immune.  (This does have the side effect of slightly slowing down
        rendering, but on modern systems it should be barely noticeable.)  You
        can do this (if the Font Engine is installed) by opening the OS/2
        Registry Editor and adding a new key called "dbcsmap.exe" under
        "HKEY_LOCAL_MACHINE\SOFTWARE\InnoTek\InnoTek Font Engine\Applications".
        Under that key, add a new DWORD value called "Enabled", and set its
        value to 0x00000001 (1 decimal).


TODO

  * Find a workaround for clipboard viewer text display and non-Unicode fonts.
  * Only show the clipboard viewer scrollbar when needed.
  * Enable character lookup from clipboard text.
  * (Possibly) Support bitmap fonts.


HISTORY

  1.6 (2018-04-06)
   * Major improvements to facilitate use as a general character map program,
     in particular support for single-byte characters.
   * The current system codepage is now selectable.
   * Fixed character alignment problem with monospaced fonts.
   * Don't show codepages which aren't actually installed.
   * Added China SAA (946) as a supported codepage, if installed.
   * Show the baseline in the preview panel.
   * Always show Unicode codepoint for valid Unicode characters, even in
     other codepages.
   * Layout adjustments for better compatibility with low screen resolutions.
   * Updated help file to reflect changes.
   * Executable now includes BLDLEVEL signature.

  1.52 (2017-03-11)
   * Renamed program to 'Extended Character Map', as the old name was rather
     misleading (this program supports Unicode rather than simply DBCS text).
   * Updated the help to reflect name change and also update some of the
     information.
   * Try to reduce the references to 'codepage' in favour of 'encoding',
     except where technically important.

  1.51 (2011-06-24)
   * Improvements to scrolling and wrapping behaviour in the clipboard viewer.
   * Font size in clipboard viewer now correctly calculated according to DPI.
   * Current font italic/non-italic style should now be reflected in the initial
     selection when the font dialog is opened.

  1.5 (2011-02-26)
   * Enabled scrolling in the clipboard viewer control.
   * Added "Edit" menu.
   * Added command to re-copy all characters in the clipboard viewer to the
     actual clipboard (e.g. in case they were removed by some other program).
   * Current font weight should now be reflected in the initial selection when
     the font dialog is opened.

  1.4 (2010-02-20)
   * New clipboard viewer control.
   * Renamed 'Copy' button to 'Add' in order to clarify its behaviour with
     respect to the (now-visible) clipboard buffer.
   * Added 'Delete' button to delete one character from the clipboard (the
     Backspace key now also does this).
   * Changed program icon.
   * Some other minor GUI tweaks.

  1.3 (2007-05-19)
   * Tweaked glyph sizing & positioning logic within preview panel.
   * Various fixes & improvements to font selection logic.  Selection of bitmap
     fonts is now disabled entirely.
   * Fixed loading of default help panel.

  1.21 (2007-03-28)
   * A failure to switch codepages no longer causes the program to exit.

  1.2 (2007-03-22)
   * Invalid secondary-byte values for the CJK codepages are now identified;
     the corresponding character cells are shaded in grey.
   * Various DBCSMAP settings (including window size/position, font, and the
     current codepage selections) are now saved.
   * Some minor cosmetic tweaks.

  1.1 (2007-03-15)
   * The individual CJK codepages now render text directly, instead of
     converting it into Unicode first.  This should allow non-Unicode CJK
     fonts to display correctly under their own codepages.
   * Now using UniQueryUconvObject() instead of DosQueryDBCSEnv() to identify
     valid leading-byte values.  This fixes the "garbled text" problem that
     some earlier versions had with codepage 949.

  1.0 (2007-02-24)
   * Some more (very minor) code cleanup.
   * Implemented online help.

  0.9 (2007-02-08)
   * Massive internal code cleanup and optimization.
   * Rewrote codepage logic to use Unicode conversion APIs instead of
     WinSetCp().  This MAY reduce the frequency of the "codepage switching"
     bug, although it won't eliminate it entirely.
   * Glyphs should now be correctly centred in their cells.
   * Major improvements to font sizing logic.  Should now look good on most,
     if not all, resolutions.
   * Fixed bug with control resizing when restoring from minimized state.
   * Implemented the hooks for online help (but no actual help file yet)...
   * Removed most English language dependencies from code (for potential
     future internationalization support).
   * "Clear" button now disables/enables itself when appropriate (I hope).
   * Fixed the program icon appearance for low resolutions.

  0.8 (2007-02-04)
   * Data is now also copied to the clipboard under the "text/unicode" format.

  0.7 (2007-02-01)
   * Multiple characters can now be copied at once.
   * Unicode is now rendered using UPF-8 (a.k.a. "PM Unicode", codepage 1207).
     This remedies previous problem with slow Unicode text rendering.
   * Replaced the glyph preview window with a custom control that avoids bugs
     in static text control.
   * Now overriding PM valueset text rendering in character grid control (i.e.
     owner draw) to fix display bugs with Unicode text.
   * Restored "style" selector to font dialog.
   * Significant internal code cleanup.

  0.6 (2007-01-03)
   * Added codepage 1208 (UTF-8).
   * F3 now exits the program.
   * A few other improvements here and there.

  0.5 (2006-04-02)
   * Double-clicking on a character now copies it to the clipboard.
   * The window is now dynamically resizeable.
   * 'Clipping' problem on high-DPI resolutions fixed.
   * The font size used in the character map control is now set dynamically
     according to the current window size.

  0.4 (2005-09-16)
   * First public release.


NOTICES

  Extended Character Map for OS/2
  (C) 2005-2019 Alex Taylor

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
