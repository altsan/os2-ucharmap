#define INCL_DOSERRORS
#define INCL_DOSMISC
#define INCL_DOSNLS
#define INCL_DOSRESOURCES
#define INCL_GPI
#define INCL_WIN
#include <os2.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <uconv.h>
#include <unidef.h>
#include "resource.h"

// ----------------------------------------------------------------------------
// CONSTANTS

#define SZ_VERSION              "1.62"
#define SZ_COPYRIGHT            "2005, 2020"

#define HELP_FILE               "dbcsmap.hlp"
#define INI_FILE                "dbcsmap.ini"

// min. size of the program window
#define US_MIN_WIDTH            333
#define US_MIN_HEIGHT           195

// Maximum string length...
#define SZRES_MAXZ              256     // ...of a generic string resource
#define CHARSTRING_MAXZ         5       // ...of a multibyte glyph string
#define CPNAME_MAXZ             12      // ...of a ULS codepage name
#define CPSPEC_MAXZ             32      // ...of a ULS codepage specifier
#define CPDESC_MAXZ             128     // ...of a codepage description in the GUI

// Profile (INI) file entries
#define PRF_APP_POSITION        "Position"
#define PRF_KEY_LEFT            "Left"
#define PRF_KEY_BOTTOM          "Bottom"
#define PRF_KEY_WIDTH           "Width"
#define PRF_KEY_HEIGHT          "Height"

#define PRF_APP_SETTINGS        "Settings"
#define PRF_KEY_CODEPAGE        "Codepage"
#define PRF_KEY_WARD            "Ward"
#define PRF_KEY_FONT            "Font"
#define PRF_KEY_UNICLIP         "CopyUni"

// The Unicode UCS-2 codepage
#define UNICODE                 1200

// Codepage 1207 is used for drawing Unicode text under Presentation Manager
#define PM_UNICODE              1207

// Special ward value indicating single-byte characters
#define NO_LEAD_BYTE            0xFFFF

// Custom colours
#define CCLR_BASELINE           0xE0E0E0

// custom messages for glyph preview window
#define UPW_SETGLYPH          ( WM_USER + 101 )
#define UPW_QUERYGLYPH        ( WM_USER + 102 )
#define UPW_SETCP             ( WM_USER + 103 )

// custom messages for clipboard preview window
#define CPW_SETTEXT           ( WM_USER + 110 )
#define CPW_SBUPDATE          ( WM_USER + 111 )


// ----------------------------------------------------------------------------
// MACROS

// Handy message box for errors and debug messages
#define ErrorPopup( text ) \
    WinMessageBox( HWND_DESKTOP, HWND_DESKTOP, text, "Error", 0, MB_OK | MB_ERROR )

// Is this one of our explicitly supported multi-byte codepages?
#define IS_DBCS_CODEPAGE( cp ) \
    ((( cp == 932 ) || ( cp == 934 ) || ( cp == 936 )  || ( cp == 942 ) || \
      ( cp == 943 ) || ( cp == 944 ) || ( cp == 946 )  || ( cp == 948 ) || \
      ( cp == 949 ) || ( cp == 950 ) || ( cp == 1381 ) || ( cp == 1386 ))? 1 : 0 )

// Convert a pair of bytes to a UniChar
#define BYTES2UNICHAR( bFirst, bSecond ) \
    (( bFirst << 8 ) | bSecond )

// See if byte flag from UlsQueryUconvObject() indicates a valid leading byte
#define ISLEADINGBYTE( bVal ) \
    (( bVal > 1 && bVal < 5 ) ? TRUE : FALSE )


/* The following macros are used to identify characters that require special
 * width-calculation logic in fixed-width fonts.  This is a workaround for
 * a bug in GPI's positioning calculations.
 */

// Characters which should be treated as double-width in a dedicated CJK font
#define IS_CJK_DOUBLEWIDTH( c ) (((( c >= 0x0400 ) && ( c <= 0x044F )) || \
                                   ( c == 0x00A8 ) || ( c == 0x00B4 )  || \
                                  (( c >= 0x2010 ) && ( c <= 0x203B )) || \
                                  (( c >= 0x2100 ) && ( c <= 0xA6FF )) || \
                                  (( c >= 0xAC00 ) && ( c <= 0xFF5F )))? 1: 0 )

// Characters which should be treated as double-width in a normal fixed-width font
#define IS_DOUBLEWIDTH( c )     (((( c >= 0x1100 ) && ( c <= 0x11FF )) || \
                                  (( c >= 0x2E80 ) && ( c <= 0xA4CF )) || \
                                  (( c >= 0xAC00 ) && ( c <= 0xD7AF )) || \
                                  (( c >= 0xF900 ) && ( c <= 0xFAFF )) || \
                                  (( c >= 0xFE30 ) && ( c <= 0xFE4F )) || \
                                  (( c >= 0xFF00 ) && ( c <= 0xFF5F )))? 1: 0 )

// Special characters which are classified as displayable but have zero width
#define IS_ZEROWIDTH( c )       (((( c >= 0x200B ) && ( c <= 0x200F )))? 1: 0 )


// ----------------------------------------------------------------------------
// TYPEDEFS

typedef struct _Global_Data {
    HAB         hab;                                // anchor-block handle
    HMQ         hmq;                                // main message queue
    HINI        hIni;                               // program INI file
    CHAR        szFont[ FACESIZE ],                 // current character font
                fPrimary[ 256 ],                    // leading-byte flags
                fSecondary[ 256 ],                  // secondary-byte flags
                szGlyph[ 256 ][ CHARSTRING_MAXZ ];  // current character values
    ULONG       ulCP;                               // selected codepage
    USHORT      usWard;                             // selected ward
    ATOM        cfUniText;                          // text/unicode clipboard format
    BOOL        fCopyUCS;                           // copy Unicode format?
    UniChar    *psuCopied,                          // clipboard contents
                suGlyph[ 256 ];                     // current Unicode values
    UconvObject uconv1207,                          // conversion object for UPF-8
                uconvCP;                            // conversion object for selected codepage
} DCMGLOBAL, *PDCMGLOBAL;

// Control data for the glyph preview window
typedef struct _Preview_Data {
    CHAR        szText[ CHARSTRING_MAXZ ];          // MBCS character to display
    ULONG       ulCP;                               // selected codepage
    UniChar     ucUCS;                              // UCS-2 value of selected character
} GLYPRCDATA, *PGLYPRCDATA;

// Information used for tracking displayed scrollable text in clipboard viewer
typedef struct _Scrolled_Text_Info {
    ULONG       ulLines,                            // total number of lines of text required
                ulHeight,                           // number of lines that can be displayed
                ulOffset,                           // scroll position (line offset from top)
                ulLineHeight;                       // height of a line of text (fm.lMaxAscender)
} CBTEXTATTRS, *PCBTEXTATTRS;

// Control data for the clipboard contents window
typedef struct _Clipboard_Data {
    UniChar     *psuDisplay;                        // clipboard text to display (UCS-2)
    HWND        hwndSB;                             // scrollbar handle
    RECTL       rclView;                            // viewport (displayable text) rectangle
    BOOL        fScrollBar;                         // is scrollbar visible?
    CBTEXTATTRS textState;                          // current state of text
    LONG        lDPI;                               // current (vertical) font DPI
} CBVIEWDATA, *PCBVIEWDATA;


// ----------------------------------------------------------------------------
// FUNCTIONS

MRESULT EXPENTRY MainWndProc( HWND, ULONG, MPARAM, MPARAM );
BOOL             IsDisabledCell( BYTE ucCell, PDCMGLOBAL pGlobal );
void             DrawVSItem( HWND hwnd, HPS hps, RECTL rclItem, USHORT usRow, USHORT usCol );
MRESULT EXPENTRY PreviewWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 );
MRESULT EXPENTRY ClipWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 );
void             DrawNice3DBorder( HPS hps, RECTL rcl );
ULONG            DrawWrappedText( HPS hps, PPOINTL pptPos, RECTL rcl, FONTMETRICS fm, PCBTEXTATTRS pAttrs, UniChar *psuText );
void             SetClipTextAttrs( HPS hps, PSZ pszFont, LONG lDPI );
void             AddCodepage( HAB hab, HWND hwnd, ULONG ulID, USHORT usCP );
void             WindowSetup( HWND hwnd );
void             CentreWindow( HWND hwnd );
void             LocateProfile( PSZ pszProfile );
void             LoadIniData( PVOID pszData, HINI hIni, PSZ pszApp, PSZ pszKey );
void             SaveSettings( HWND hwnd );
BOOL             ChangeCodepage( HWND hwnd, ULONG ulCP );
void             PopulateCharMap( HWND hwnd, USHORT bOffset );
void             SelectCharacter( HWND hwnd, USHORT usRow, USHORT usCol );
void             SelectSampleFont( HWND hwnd );
void             UpdateSampleFont( HWND hwnd, CHAR szFontName[] );
void             CopyToClipboard( HWND hwnd, USHORT usCol, USHORT usRow );
void             DeleteFromClipboard( HWND hwnd );
void             UpdateClipboard( HWND hwnd, PDCMGLOBAL pGlobal );
void             UpdateWindowSize( HWND hwnd, SHORT usW, SHORT usH );
LONG             FixedCharWidth( UniChar uc, FONTMETRICS fm );
void             GetCodepagePath( PSZ pszCPath, USHORT cb );
BOOL             CodepageIsInstalled( PSZ pszPath, ULONG ulCP );
MRESULT EXPENTRY AboutDlgProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 );

