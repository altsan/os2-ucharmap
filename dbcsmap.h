#define INCL_DOSERRORS
#define INCL_DOSMISC
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

// Convert a pair of bytes to a UniChar
#define BYTES2UNICHAR( bFirst, bSecond ) \
    (( bFirst << 8 ) | bSecond )

// See if byte flag from UlsQueryUconvObject() indicates a valid leading byte
#define ISLEADINGBYTE( bVal ) \
    (( bVal > 1 && bVal < 5 ) ? TRUE : FALSE )

// ----------------------------------------------------------------------------
// TYPEDEFS

typedef struct _Global_Data {
    HAB         hab;                                // anchor-block handle
    HMQ         hmq;                                // main message queue
    HINI        hIni;                               // program INI file
    CHAR        szFont[ FACESIZE ],                 // current character font
                fSecondary[ 256 ],                  // secondary-byte flags
                szGlyph[ 256 ][ CHARSTRING_MAXZ ];  // current character values
    ULONG       ulCP;                               // selected codepage
    ATOM        cfUniText;                          // text/unicode clipboard format
    BOOL        fCopyUCS;                           // copy Unicode format?
    UniChar     *psuCopied,                         // clipboard contents
                suGlyph[ 256 ];                     // current Unicode values
    UconvObject uconv1207,                          // conversion object for UPF-8
                uconvCP;                            // conversion object for selected codepage
} DCMGLOBAL, *PDCMGLOBAL;

// Control data for the glyph preview window
typedef struct _Preview_Data {
    CHAR        szText[ CHARSTRING_MAXZ ];          // MBCS character to display
    ULONG       ulCP;                               // selected codepage
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
void             DrawVSItem( HWND hwnd, HPS hps, RECTL rclItem, USHORT usRow, USHORT usCol );
MRESULT EXPENTRY PreviewWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 );
MRESULT EXPENTRY ClipWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 );
void             DrawNice3DBorder( HPS hps, RECTL rcl );
ULONG            DrawWrappedText( HPS hps, PPOINTL pptPos, RECTL rcl, FONTMETRICS fm, PCBTEXTATTRS pAttrs, UniChar *psuText );
void             SetClipTextAttrs( HPS hps, PSZ pszFont, LONG lDPI );
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
MRESULT EXPENTRY AboutDlgProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 );

