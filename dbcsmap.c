#include "dbcsmap.h"

/* ------------------------------------------------------------------------- *
 * Main program (including initialization, message loop, and final cleanup)  *
 * ------------------------------------------------------------------------- */
int main( int argc, char *argv[] )
{
    DCMGLOBAL global = {0};
    HAB       hab;                          // anchor block handle
    HMQ       hmq;                          // message queue handle
    HWND      hwndFrame,                    // window handle
              hwndAccel,                    // acceleration table
              hwndHelp;                     // help instance
    QMSG      qmsg;                         // message queue
    HATOMTBL  hSATbl;                       // handle to system atom table
    HELPINIT  helpInit;                     // help init structure
    CHAR      szRes[ SZRES_MAXZ ],          // buffer for string resources
              szError[ SZRES_MAXZ ] = "Error";
    BOOL      fInitFailure = FALSE;
    ULONG     ulrc;


    hab = WinInitialize( 0 );
    if ( hab == NULLHANDLE ) {
        sprintf( szError, "WinInitialize() failed.");
        fInitFailure = TRUE;
    }

    if ( ! fInitFailure ) {
        hmq = WinCreateMsgQueue( hab, 0 );
        if ( hmq == NULLHANDLE ) {
            sprintf( szError, "Unable to create message queue:\nWinGetLastError() = 0x%X\n", WinGetLastError(hab) );
            fInitFailure = TRUE;
        }
    }

    if ( ! fInitFailure ) {

        global.hab       = hab;
        global.hmq       = hmq;
        global.fCopyUCS  = TRUE;
        global.uconvCP   = NULL;
        global.psuCopied = (UniChar *) malloc( sizeof(UniChar) );
        if (global.psuCopied) global.psuCopied[ 0 ] = 0;
        strcpy( global.szFont, "Times New Roman MT 30");

        // ULS conversion object for Unicode/UCS <-> internal Unicode processing format
        ulrc = UniCreateUconvObject( (UniChar *)L"IBM-1207@path=no,map=display", &(global.uconv1207) );
        if ( ulrc != ULS_SUCCESS ) global.uconv1207 = NULL;

        // Make sure the Unicode clipboard format is registered
        hSATbl = WinQuerySystemAtomTable();
        global.cfUniText = WinAddAtom( hSATbl, "text/unicode");

        // Create custom controls & load the main dialog window
        WinRegisterClass( hab, "GlyphPreview",  PreviewWndProc, CS_SIZEREDRAW, sizeof(PGLYPRCDATA) );
        WinRegisterClass( hab, "ClipboardView", ClipWndProc,    CS_SIZEREDRAW, sizeof(PCBVIEWDATA) );
        hwndFrame = WinLoadDlg( HWND_DESKTOP, HWND_DESKTOP,
                                MainWndProc, 0, ID_MAINPROGRAM, &global );
        if ( hwndFrame == NULLHANDLE ) {
            sprintf( szError, "Failed to load dialog resource:\nWinGetLastError() = 0x%X\n", WinGetLastError(hab) );
            fInitFailure = TRUE;
        }
    }

    if ( fInitFailure ) {
        WinMessageBox( HWND_DESKTOP, HWND_DESKTOP, szError, "Program Initialization Error", 0, MB_CANCEL | MB_ERROR );
    } else {

        // Initialize acceleration table
        hwndAccel = WinLoadAccelTable( hab, 0, ID_MAINPROGRAM );
        WinSetAccelTable( hab, hwndAccel, hwndFrame );

        // Initialize online help
        if ( ! WinLoadString( hab, 0, IDS_HELP_TITLE, SZRES_MAXZ-1, szRes ))
            sprintf( szRes, "Help");

        helpInit.cb                       = sizeof( HELPINIT );
        helpInit.pszTutorialName          = NULL;
        helpInit.phtHelpTable             = (PHELPTABLE) MAKELONG( ID_MAINPROGRAM, 0xFFFF );
        helpInit.hmodHelpTableModule      = 0;
        helpInit.hmodAccelActionBarModule = 0;
        helpInit.fShowPanelId             = 0;
        helpInit.idAccelTable             = 0;
        helpInit.idActionBar              = 0;
        helpInit.pszHelpWindowTitle       = szRes;
        helpInit.pszHelpLibraryName       = HELP_FILE;

        hwndHelp = WinCreateHelpInstance( hab, &helpInit );
        WinAssociateHelpInstance( hwndHelp, hwndFrame );

        // Now run the main program message loop
        while ( WinGetMsg( hab, &qmsg, 0, 0, 0 )) WinDispatchMsg( hab, &qmsg );

        SaveSettings( hwndFrame );
    }

    // Clean up and exit
    free( global.psuCopied );
    if ( global.uconv1207 != NULL ) UniFreeUconvObject( global.uconv1207 );
    if ( global.uconvCP   != NULL ) UniFreeUconvObject( global.uconvCP   );
    WinDeleteAtom( hSATbl, global.cfUniText );
    WinDestroyWindow( hwndFrame );
    WinDestroyMsgQueue( hmq );
    WinTerminate( hab );

    return ( 0 );
}


/* ------------------------------------------------------------------------- *
 * Window procedure for the main program dialog.                             *
 * ------------------------------------------------------------------------- */
MRESULT EXPENTRY MainWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
    static PDCMGLOBAL pGlobal;
    PSWP        pswp,
                pswpOld;
    POWNERITEM  pownit;
    ULONG       ulVal;
    USHORT      usRow, usCol;
    SHORT       sRc,
                sMIA;
    UCHAR       szError[ SZRES_MAXZ + 8 ],
                szRes[ SZRES_MAXZ ],
                szBuf[ 3 ],
                szCPDesc[ CPDESC_MAXZ ];


    switch( msg ) {

        case WM_INITDLG:
            // Save the global data to a window word
            pGlobal = (PDCMGLOBAL) mp2;
            WinSetWindowPtr( hwnd, 0, pGlobal );

            WindowSetup( hwnd );
            WinShowWindow( hwnd, TRUE );
            return (MRESULT) FALSE;


        case WM_COMMAND:
            switch( SHORT1FROMMP( mp1 )) {

                case ID_COPY:
                    ulVal = (ULONG) WinSendDlgItemMsg( hwnd, IDD_CHARMAP, VM_QUERYSELECTEDITEM, MPVOID, MPVOID );
                    CopyToClipboard( hwnd, SHORT1FROMMP(ulVal), SHORT2FROMMP(ulVal) );
                    break;

                case ID_DELETE:
                    DeleteFromClipboard( hwnd );
                    break;

                case ID_CLEAR:
                    if ( WinOpenClipbrd( pGlobal->hab )) {
                        WinEmptyClipbrd( pGlobal->hab );
                        WinCloseClipbrd( pGlobal->hab );
                    }
                    free( pGlobal->psuCopied );
                    pGlobal->psuCopied = (UniChar *) malloc( sizeof(UniChar) );
                    if (pGlobal->psuCopied) pGlobal->psuCopied[ 0 ] = 0;
                    WinEnableWindow( WinWindowFromID(hwnd, ID_CLEAR), FALSE );
                    WinEnableWindow( WinWindowFromID(hwnd, ID_DELETE), FALSE );
                    WinSendDlgItemMsg( hwnd, IDD_CLIPBOARD, CPW_SETTEXT, MPFROMP(""), MPFROMP(L"") );
                    break;

                case ID_RECOPY:
                    UpdateClipboard( hwnd, pGlobal );
                    break;

                case ID_FONT:
                    SelectSampleFont( hwnd );
                    break;

                case ID_UCS:
                    pGlobal->fCopyUCS = !(pGlobal->fCopyUCS);
                    sMIA = pGlobal->fCopyUCS ? MIA_CHECKED : 0;
                    WinSendDlgItemMsg( hwnd, FID_MENU, MM_SETITEMATTR,
                                       MPFROM2SHORT( ID_UCS, TRUE ),
                                       MPFROM2SHORT( MIA_CHECKED, sMIA ));
                    break;

                case ID_ABOUT:                  // Product information dialog
                    WinDlgBox( HWND_DESKTOP, hwnd, (PFNWP) AboutDlgProc, 0, IDD_ABOUT, NULL );
                    break;

                case ID_QUIT:                   // Exit the program
                    WinPostMsg( hwnd, WM_CLOSE, 0, 0 );
                    return (MRESULT) 0;

                default: break;

            } // end WM_COMMAND messages
            return (MRESULT) 0;


        case WM_CONTROL:
            switch( SHORT1FROMMP( mp1 )) {

                case IDD_CODEPAGE:
                    if ( SHORT2FROMMP( mp1 ) == CBN_LBSELECT) {
                        sRc = (SHORT) WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_QUERYSELECTION,
                                                         MPFROMSHORT( LIT_FIRST ), MPFROMLONG( 0 ));
                        if ( sRc != LIT_NONE ) {
                            // Get the selected codepage number
                            WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_QUERYITEMTEXT,
                                               MPFROM2SHORT( sRc, 256 ), MPFROMP( szCPDesc ));
                            // (if it doesn't start with a number, it must be "Unicode")
                            if ( sscanf( szCPDesc, "%u", &ulVal ) < 1 ) ulVal = UNICODE;
                            // Now change to the selected codepage
                            if ( ! ChangeCodepage( hwnd, ulVal )) {
                                if ( ! WinLoadString( pGlobal->hab, 0,
                                                      IDS_ERROR_CHANGECP, SZRES_MAXZ-1, szRes ))
                                {
                                    sprintf( szRes, "Unable to set codepage %d.");
                                }
                                sprintf( szError, szRes, ulVal );
                                ErrorPopup( szError );
                                //WinPostMsg( hwnd, WM_CLOSE, 0, 0 );
                            }
                        }
                    }
                    return (MRESULT) 0;

                case IDD_OFFSET:
                    if ( SHORT2FROMMP( mp1 ) == CBN_LBSELECT) {
                        sRc = (SHORT) WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_QUERYSELECTION,
                                                         MPFROMSHORT(LIT_FIRST), MPVOID      );
                        if ( sRc != LIT_NONE ) {
                            WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_QUERYITEMTEXT,
                                               MPFROM2SHORT( sRc, 3 ), MPFROMP( szBuf ));
                            if ( sscanf( szBuf, "%02X", &ulVal ) < 1 ) ulVal = NO_LEAD_BYTE;
                            pGlobal->usWard = (USHORT) ulVal;
                            PopulateCharMap( hwnd, ulVal );
                        }
                    }
                    return (MRESULT) 0;

                case IDD_CHARMAP:
                    switch ( SHORT2FROMMP( mp1 )) {
                        case VN_SELECT:
                            usRow = SHORT1FROMMP( mp2 );
                            usCol = SHORT2FROMMP( mp2 );
                            SelectCharacter( hwnd, usRow, usCol );
                            break;
                        case VN_ENTER:
                            CopyToClipboard( hwnd, SHORT1FROMMP(mp2), SHORT2FROMMP(mp2) );
                            break;
                    }
                    return (MRESULT) 0;

            } // end WM_CONTROL messages
            break;


        case WM_DRAWITEM:
            switch( SHORT1FROMMP( mp1 )) {

                case IDD_CHARMAP:
                    // Repaint a cell in the valueset (ownerdraw)
                    pownit = (POWNERITEM) mp2;
                    if ( pownit->idItem == VDA_ITEM ) {
                        usRow = SHORT1FROMMP( pownit->hItem );
                        usCol = SHORT2FROMMP( pownit->hItem );
                        DrawVSItem( hwnd, pownit->hps, pownit->rclItem, usRow, usCol );
                        return (MRESULT) TRUE;
                    }
                    break;

                default: break;
            } // end WM_DRAWITEM messages
            return (MRESULT) FALSE;


        case WM_MINMAXFRAME:
            pswp = (PSWP) mp1;
            if ( pswp->fl & SWP_MINIMIZE ) {
                WinShowWindow( WinWindowFromID(hwnd, IDD_GBCLIP),  FALSE );
                WinShowWindow( WinWindowFromID(hwnd, ID_CLEAR),    FALSE );
                WinShowWindow( WinWindowFromID(hwnd, ID_DELETE),   FALSE );
                WinShowWindow( WinWindowFromID(hwnd, ID_COPY),     FALSE );
            } else if ( pswp->fl & SWP_RESTORE ) {
                WinShowWindow( WinWindowFromID(hwnd, IDD_GBCLIP),  TRUE );
                WinShowWindow( WinWindowFromID(hwnd, ID_CLEAR),    TRUE );
                WinShowWindow( WinWindowFromID(hwnd, ID_DELETE),   TRUE );
                WinShowWindow( WinWindowFromID(hwnd, ID_COPY),     TRUE );
            }
            break;


        case WM_SIZE:
            UpdateWindowSize( hwnd, SHORT1FROMMP(mp2), SHORT2FROMMP(mp2) );
            break;


        case WM_WINDOWPOSCHANGED:
            pswp = PVOIDFROMMP( mp1 );
            pswpOld = pswp + 1;
            // WinDefDlgProc doesn't dispatch WM_SIZE, so we do it here.
            if ( pswp->fl & SWP_SIZE ) {
                WinSendMsg( hwnd, WM_SIZE, MPFROM2SHORT(pswpOld->cx,pswpOld->cy), MPFROM2SHORT(pswp->cx,pswp->cy) );
            }
            break;


        case WM_CLOSE:
            WinPostMsg( hwnd, WM_QUIT, 0, 0 );
            return (MRESULT) 0;


    } /* end event handlers */

    return WinDefDlgProc( hwnd, msg, mp1, mp2 );
}


/* ------------------------------------------------------------------------- *
 * IsDisabledCell                                                            *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   BYTE       ucCell : Cell number (0-255)                                 *
 *   PDCMGLOBAL pGlobal: Pointer to global data struct                       *
 *                                                                           *
 * RETURNS: BOOL                                                             *
 * ------------------------------------------------------------------------- */
BOOL IsDisabledCell( BYTE ucCell, PDCMGLOBAL pGlobal )
{
    BOOL fDisable = FALSE;

    // Only applies to DBCS codepages
    if ( ! IS_DBCS_CODEPAGE( pGlobal->ulCP )) return fDisable;

    // Single-byte character
    if ( pGlobal->usWard == NO_LEAD_BYTE ) {
        if (( ISLEADINGBYTE( pGlobal->fPrimary[ ucCell ])) ||
            ( pGlobal->fPrimary[ ucCell ] == 255 ))
                fDisable = TRUE;
    }
    // Double-byte character ward but not a valid secondary byte
    else if ( !pGlobal->fSecondary[ ucCell ])
        fDisable = TRUE;

    return fDisable;
}


/* ------------------------------------------------------------------------- *
 * DrawVSItem                                                                *
 *                                                                           *
 * Ownerdraw logic for painting a text cell in the valueset.  (We have to    *
 * draw the cell contents ourselves, because the default valueset control    *
 * processing doesn't render codepage 1207 text properly.)                   *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd    : Handle of the main application window.                   *
 *   HPS hps      : Presentation space returned by WM_DRAWITEM.              *
 *   RECTL rclItem: Bounds of the current valueset cell.                     *
 *   USHORT usRow : Row number (1-16) of the current valueset cell.          *
 *   USHORT usCol : Column number (1-16) of the current valueset cell.       *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void DrawVSItem( HWND hwnd, HPS hps, RECTL rclItem, USHORT usRow, USHORT usCol )
{
    PDCMGLOBAL  pGlobal;                // global data
    FATTRS      fontAttrs;              // current font attributes
    FONTMETRICS fm;                     // current font metrics
    SIZEF       sfChSize;               // character-box size
    POINTL      ptl;                    // current position
    RECTL       rclClip;                // clipping rectangle
    LONG        lCW, lCH;               // width, height of cell
    BYTE        ucCell;                 // current cell index (0-255)
    CHAR        szFont[ FACESIZE + 4 ]; // current font presparam
    PCH         pchGlyph;               // multi-byte text of glyph to draw
    PSZ         pszFontName;            // name of font in use

    // Draw the cell background and border
    WinFillRect( hps, &rclItem, SYSCLR_WINDOW );
    GpiSetColor( hps, SYSCLR_WINDOWFRAME );
    ptl.x  = rclItem.xLeft;
    ptl.y  = rclItem.yBottom;
    GpiMove( hps, &ptl );
    ptl.x = rclItem.xRight - 1;
    ptl.y = rclItem.yTop - 1;
    GpiBox( hps, DRO_OUTLINE, &ptl, 0L, 0L );

    // Get the current glyph value
    pGlobal  = WinQueryWindowPtr( hwnd, 0 );
    ucCell   = (usRow-1)*16 + (usCol-1);
    pchGlyph = (PCH) pGlobal->szGlyph[ ucCell ];

    if ( IsDisabledCell( ucCell, pGlobal )) {
        ptl.x = rclItem.xLeft + 1;
        ptl.y = rclItem.yBottom + 1;
        GpiMove( hps, &ptl );
        ptl.x = rclItem.xRight - 2;
        ptl.y = rclItem.yTop - 2;
        GpiSetColor( hps, SYSCLR_DIALOGBACKGROUND );
        GpiBox( hps, DRO_FILL, &ptl, 0L, 0L );
        return;
    }

    // Set the font and charset attributes
    WinQueryPresParam( WinWindowFromID(hwnd, IDD_CHARMAP),
                       PP_FONTNAMESIZE, 0, NULL, sizeof(szFont), szFont, QPF_NOINHERIT );
    pszFontName = strchr( szFont, '.') + 1;
    memset( &fontAttrs, 0, sizeof( FATTRS ));
    fontAttrs.usRecordLength = sizeof( FATTRS );
    fontAttrs.usCodePage     = ( pGlobal->ulCP == UNICODE ) ? PM_UNICODE: pGlobal->ulCP;
    fontAttrs.fsType         = FATTR_TYPE_MBCS;
    fontAttrs.fsFontUse      = FATTR_FONTUSE_NOMIX;
    strcpy( fontAttrs.szFacename, pszFontName );
    if (( GpiCreateLogFont( hps, NULL, 1L, &fontAttrs )) == GPI_ERROR ) return;
    GpiSetCharSet( hps, 1L );

    // Set the font size
    lCW = rclItem.xRight - rclItem.xLeft;
    lCH = rclItem.yTop - rclItem.yBottom;
    sfChSize.cx = (lCW < lCH) ? MAKEFIXED( (lCW / 2) + 3, 0 ) : MAKEFIXED( (lCH / 2) + 3, 0 );
    sfChSize.cy = sfChSize.cx;
    GpiSetCharBox( hps, &sfChSize );

    // Centre the glyph in the cell
    GpiQueryFontMetrics( hps, sizeof(FONTMETRICS), &fm );
    ptl.x = rclItem.xLeft + ( lCW / 2 );
    ptl.y = rclItem.yBottom + (( lCH - fm.lXHeight ) / 2 );
    if ( fm.fsType & FM_TYPE_FIXED ) {
        ptl.x -= FixedCharWidth( pGlobal->suGlyph[ ucCell ], fm ) / 2;
        GpiSetTextAlignment( hps, TA_LEFT, TA_BASE );
    }
    else
        GpiSetTextAlignment( hps, TA_CENTER, TA_BASE );

    // Now draw the glyph
    GpiSetColor( hps, SYSCLR_WINDOWTEXT );
    rclClip.xLeft   = rclItem.xLeft + 1;
    rclClip.yBottom = rclItem.yBottom + 1;
    rclClip.xRight  = rclItem.xRight - 1;
    rclClip.yTop    = rclItem.yTop - 1;

    GpiCharStringPosAt( hps, &ptl, &rclClip, CHS_CLIP,
                        strlen(pchGlyph), pchGlyph, NULL );

}


/* ------------------------------------------------------------------------- *
 * Window procedure for the glyph-preview control.                           *
 * ------------------------------------------------------------------------- */
MRESULT EXPENTRY PreviewWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
    PGLYPRCDATA pgpd;
    HPS         hps;
    RECTL       rcl,                    // preview window area
                rclClip;                // glyph clipping region
    POINTL      ptl,
                aptl[ TXTBOX_COUNT ];   // used to query glyph size
    FATTRS      fontAttrs;              // current font attributes
    FONTMETRICS fm;                     // current font metrics
    SIZEF       sfChSize;               // character cell size
    CHAR        szFont[ FACESIZE + 4 ]; // current font name
    LONG        lClr,                   // colour to use when drawing glyph
                alTable[ 1 ],           // new index colours to define
                lBaseline,              // baseline position from font metrics
                lRW,                    // width of display rectangle
                lRH,                    // height of display rectangle
                lGW;                    // width of current glyph
    PSZ         pszFontName;


    switch( msg ) {

        case WM_CREATE:
            // set the control data
            if ( !( pgpd = (PGLYPRCDATA) malloc( sizeof(GLYPRCDATA) ))) return (MRESULT) TRUE;
            memset( pgpd, 0, sizeof(GLYPRCDATA) );
            WinSetWindowPtr( hwnd, 0, pgpd );
            break;

        case WM_PAINT:
            pgpd = WinQueryWindowPtr( hwnd, 0 );
            hps = WinBeginPaint( hwnd, NULLHANDLE, NULLHANDLE );
            alTable[0] = CCLR_BASELINE;
            GpiCreateLogColorTable( hps, LCOL_RESET, LCOLF_CONSECRGB, 16, 1, alTable );

            WinQueryWindowRect( hwnd, &rcl );
            WinFillRect( hps, &rcl, SYSCLR_WINDOW );
            DrawNice3DBorder( hps, rcl );

            if ( pgpd->szText[0] == 0 ) return (MRESULT) 0;

            // define the actual display area inside the borders
            rclClip.xLeft   = rcl.xLeft + 2;
            rclClip.yBottom = rcl.yBottom + 2;
            rclClip.xRight  = rcl.xRight - 3;
            rclClip.yTop    = rcl.yTop - 3;
            lRW = rclClip.xRight - rclClip.xLeft;
            lRH = rclClip.yTop - rclClip.yBottom;

            // now draw the glyph
            WinQueryPresParam( hwnd, PP_FONTNAMESIZE, 0, NULL, sizeof(szFont), szFont, QPF_NOINHERIT );
            pszFontName = strchr( szFont, '.') + 1;
            memset( &fontAttrs, 0, sizeof( FATTRS ));
            fontAttrs.usRecordLength = sizeof( FATTRS );
            fontAttrs.usCodePage     = ( pgpd->ulCP == UNICODE ) ? PM_UNICODE: pgpd->ulCP;
            fontAttrs.fsType         = FATTR_TYPE_MBCS;
            fontAttrs.fsFontUse      = FATTR_FONTUSE_NOMIX;
            strcpy( fontAttrs.szFacename, pszFontName );
            if (( GpiCreateLogFont( hps, NULL, 1L, &fontAttrs )) == GPI_ERROR ) break;

            sfChSize.cx = (rclClip.xRight < rclClip.yTop) ?
                          MAKEFIXED( (rclClip.xRight/3)*2, 0 ) : MAKEFIXED( (rclClip.yTop/3)*2, 0 );
            sfChSize.cy = sfChSize.cx;
            GpiSetCharBox( hps, &sfChSize );
            GpiSetCharSet( hps, 1L );
            lClr = SYSCLR_WINDOWTEXT;

            // some very wide glyphs might not fit into our character cell...
            GpiQueryFontMetrics( hps, sizeof(FONTMETRICS), &fm );
            GpiQueryTextBox( hps, strlen(pgpd->szText), pgpd->szText, TXTBOX_COUNT, aptl );
            lGW = aptl[TXTBOX_BOTTOMRIGHT].x - aptl[TXTBOX_BOTTOMLEFT].x;
            if ( lGW > lRW ) {
                sfChSize.cx = MAKEFIXED( (fm.lEmInc*lRW)/lGW, 0 );
                sfChSize.cy = sfChSize.cx;
                GpiSetCharBox( hps, &sfChSize );
                GpiQueryFontMetrics( hps, sizeof(FONTMETRICS), &fm );
                lClr = CLR_DARKBLUE;
            }

            // Draw the baseline (offset from the centre of the display area)...
            lBaseline = rclClip.yTop - fm.lMaxAscender;
            // ... but never draw it above 1/3 height
            ptl.y = min( (lRH /2 ) - (lBaseline / 2), rclClip.yTop / 3 );
            ptl.x = rclClip.xLeft;
            GpiMove( hps, &ptl );
            ptl.x = rclClip.xRight;
            GpiSetColor( hps, 16 );
            GpiLine( hps, &ptl );

            // now centre the glyph and display it
            ptl.x = rcl.xRight / 2;
            if (( pgpd->ulCP == UNICODE ) && ( fm.fsType & FM_TYPE_FIXED )) {
                ptl.x -= FixedCharWidth( pgpd->ucUCS, fm ) / 2;
                GpiSetTextAlignment( hps, TA_LEFT, TA_BASE );
            }
            else
                GpiSetTextAlignment( hps, TA_CENTER, TA_BASE );
            GpiSetColor( hps, lClr );
            GpiCharStringPosAt( hps, &ptl, &rclClip, CHS_CLIP,
                                strlen(pgpd->szText), (PCH) pgpd->szText, NULL );

            WinEndPaint( hps );
            return (MRESULT) 0;

        case UPW_QUERYGLYPH:
            pgpd = WinQueryWindowPtr( hwnd, 0 );
            strncpy( (PSZ) mp1, pgpd->szText, sizeof(pgpd->szText)-1 );
            mp2 = MPFROMSHORT( pgpd->ucUCS );
            return (MRESULT) TRUE;

        case UPW_SETGLYPH:
            pgpd = WinQueryWindowPtr( hwnd, 0 );
            strncpy( pgpd->szText, (PSZ) mp1, sizeof(pgpd->szText)-1 );
            pgpd->ucUCS = (UniChar) SHORT1FROMMP( mp2 );
            WinInvalidateRect( hwnd, NULL, FALSE );
            return (MRESULT) TRUE;

        case UPW_SETCP:
            pgpd = WinQueryWindowPtr( hwnd, 0 );
            pgpd->ulCP = (ULONG) mp1;
            return (MRESULT) TRUE;

        case WM_PRESPARAMCHANGED:
            switch ( (ULONG) mp1 ) {
                case PP_FONTNAMESIZE:
                    WinInvalidateRect(hwnd, NULL, FALSE);
                default: break;
            }
            break;

        case WM_DESTROY:
            if (( pgpd = WinQueryWindowPtr( hwnd, 0 )) != NULL )
                free( pgpd );
            break;
    }

    return ( WinDefWindowProc( hwnd, msg, mp1, mp2 ));
}


/* ------------------------------------------------------------------------- *
 * Window procedure for the clipboard-preview control.                       *
 * ------------------------------------------------------------------------- */
MRESULT EXPENTRY ClipWndProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
    PCBVIEWDATA pdata;                  // control data
    HPS         hps;                    // presentation space
    HDC         hdc;                    // device-context handle
    RECTL       rcl;                    // window area
    POINTL      ptl;                    // used for positioning
    FONTMETRICS fm;                     // current font metrics
    CHAR        szFont[ FACESIZE + 4 ]; // current font name
    LONG        lSBX, lSBY,             // scrollbar position
                lSBCX, lSBCY,           // scrollbar size
                lInc,                   // size of scrollbar change
                lMargin;                // margin to allow around clipping area
    SHORT       sMax;                   // scrollbar maximum range
    SWP         swp;                    // used to query control size


    switch( msg ) {

        case WM_CREATE:
            // set the control data
            if ( !( pdata = (PCBVIEWDATA) malloc( sizeof(CBVIEWDATA) )))
                return (MRESULT) TRUE;
            memset( pdata, 0, sizeof(CBVIEWDATA) );
            WinSetWindowPtr( hwnd, 0, pdata );

            hdc = WinOpenWindowDC( hwnd );
            if ( ! DevQueryCaps( hdc, CAPS_VERTICAL_FONT_RES, 1,
                                 &(pdata->lDPI) ) || !(pdata->lDPI) )
                pdata->lDPI = 120;

            // create the scrollbar
            WinQueryWindowPos( hwnd, &swp );
            lSBCX = 16;
            lSBCY = swp.cy - 4;
            lSBX  = swp.cx - lSBCX - 2;
            lSBY  = 2;
            pdata->hwndSB = WinCreateWindow( hwnd, WC_SCROLLBAR, NULL,
                                             SBS_VERT | SBS_AUTOTRACK | WS_VISIBLE,
                                             lSBX, lSBY, lSBCX, lSBCY,
                                             hwnd, HWND_TOP, IDD_CLIPSCROLL, NULL, NULL );
            pdata->fScrollBar = FALSE;
            pdata->textState.ulOffset = 0;
            WinSendMsg( pdata->hwndSB, SBM_SETTHUMBSIZE, MPFROM2SHORT( 1, 1 ), 0 );
            WinSendMsg( pdata->hwndSB, SBM_SETSCROLLBAR, 0, MPFROM2SHORT( 0, 1 ));
            break;


        case WM_PAINT:
            pdata = WinQueryWindowPtr( hwnd, 0 );
            hps = WinBeginPaint( hwnd, NULLHANDLE, NULLHANDLE );
            WinQueryWindowRect( hwnd, &rcl );
            WinQueryWindowPos( pdata->hwndSB, &swp );
            DrawNice3DBorder( hps, rcl );
            // adjust our painting region to accomodate the scrollbar and borders
            rcl.xLeft   += 2;
            rcl.xRight  -= (swp.cx + 2);
            rcl.yBottom += 2;
            rcl.yTop    -= 2;
            WinFillRect( hps, &rcl, SYSCLR_WINDOW );

            if ( !pdata->psuDisplay ) return (MRESULT) 0;

            // now position and display the text
            WinQueryPresParam( hwnd, PP_FONTNAMESIZE, 0, NULL,
                               sizeof(szFont), szFont, QPF_NOINHERIT );
            SetClipTextAttrs( hps, szFont, pdata->lDPI );
            GpiQueryFontMetrics( hps, sizeof(FONTMETRICS), &fm );
            ptl.x = pdata->rclView.xLeft;
            ptl.y = pdata->rclView.yTop - pdata->textState.ulLineHeight;
            GpiSetColor( hps, SYSCLR_WINDOWTEXT );
            // This seems to skew the character positions used by Gpi(Query)CharStringPos(At)
            //  - GpiSetTextAlignment( hps, TA_LEFT, TA_BASE );
            DrawWrappedText( hps, &ptl, pdata->rclView, fm,
                             &(pdata->textState), pdata->psuDisplay );
            WinEndPaint( hps );
            // tell the scrollbar to update
            WinSendMsg( hwnd, CPW_SBUPDATE, 0, 0 );

            return (MRESULT) 0;


        // Update control text and invalidate the viewport
        case CPW_SETTEXT:
            pdata = WinQueryWindowPtr( hwnd, 0 );
            if ( pdata->psuDisplay ) free( pdata->psuDisplay );
            if ( mp2 && (pdata->psuDisplay = calloc( UniStrlen((UniChar *)mp2)+1, sizeof(UniChar) )))
                UniStrcpy( pdata->psuDisplay, (UniChar *) mp2 );
            rcl = pdata->rclView;
            WinInvalidateRect( hwnd, &rcl, FALSE );
            return (MRESULT) TRUE;


        // Recalculate the scrollbar settings
        case CPW_SBUPDATE:
            pdata = WinQueryWindowPtr( hwnd, 0 );
            if ( pdata->textState.ulLines <= pdata->textState.ulHeight ) {
                pdata->fScrollBar = FALSE;
                pdata->textState.ulOffset = 0;
                //WinShowWindow( pdata->hwndSB, pdata->fScrollBar );
                WinSendMsg( pdata->hwndSB, SBM_SETTHUMBSIZE, MPFROM2SHORT( 1, 1 ), 0 );
                WinSendMsg( pdata->hwndSB, SBM_SETSCROLLBAR, 0, MPFROM2SHORT( 0, 1 ));
            }
            else {
                if ( !pdata->fScrollBar ) {
                    pdata->fScrollBar = TRUE;
                    //WinShowWindow( pdata->hwndSB, pdata->fScrollBar );
                }
                sMax = max( 0, (LONG)( pdata->textState.ulLines - pdata->textState.ulHeight ));
                WinSendMsg( pdata->hwndSB, SBM_SETTHUMBSIZE,
                            MPFROM2SHORT( pdata->textState.ulHeight, pdata->textState.ulLines ), 0 );
                WinSendMsg( pdata->hwndSB, SBM_SETSCROLLBAR,
                            MPFROMSHORT( pdata->textState.ulOffset ),
                            MPFROM2SHORT( 0, sMax ));
            }
            return (MRESULT) TRUE;


        case WM_VSCROLL:
            pdata = WinQueryWindowPtr( hwnd, 0 );
            if ( pdata->textState.ulLines < pdata->textState.ulHeight )
                break;
            switch ( SHORT2FROMMP( mp2 )) {
                case SB_LINEUP:
                    lInc = -1;
                    break;
                case SB_LINEDOWN:
                    lInc = 1;
                    break;
                case SB_PAGEUP:
                    lInc = min( (LONG)(-(pdata->textState.ulHeight)) + 1, -1 );
                    break;
                case SB_PAGEDOWN:
                    lInc = max( pdata->textState.ulHeight-1, 1 );
                    break;
                case SB_SLIDERPOSITION:
                case SB_SLIDERTRACK:
                    lInc = SHORT1FROMMP( mp2 ) - pdata->textState.ulOffset;
                    break;
                default:
                    return WinDefWindowProc( hwnd, msg, mp1, mp2 );
            }
            sMax = max( 0, (LONG)( pdata->textState.ulLines - pdata->textState.ulHeight ));
            if ((LONG)( pdata->textState.ulOffset + lInc ) < 0 )
                lInc = -pdata->textState.ulOffset;
            else if (( pdata->textState.ulOffset + lInc ) > sMax )
                lInc = sMax - pdata->textState.ulOffset;
            pdata->textState.ulOffset += lInc;
            if ( lInc ) {
                rcl = pdata->rclView;
//              WinScrollWindow( hwnd, 0, lInc * pdata->textState.ulLineHeight, &rcl, &rcl, NULLHANDLE, NULL, SW_INVALIDATERGN );
                WinSendMsg( pdata->hwndSB, SBM_SETPOS, MPFROM2SHORT( pdata->textState.ulOffset, 0 ), 0 );
                WinInvalidateRect( hwnd, &rcl, FALSE );
            }
            break;


        case WM_PRESPARAMCHANGED:
            switch ( (ULONG) mp1 ) {

                case PP_FONTNAMESIZE:
                    // Update the font-dependent dimensions
                    pdata = WinQueryWindowPtr( hwnd, 0 );
                    hps = WinBeginPaint( hwnd, NULLHANDLE, NULLHANDLE );
                    WinQueryPresParam( hwnd, PP_FONTNAMESIZE, 0, NULL,
                                       sizeof(szFont), szFont, QPF_NOINHERIT );
                    SetClipTextAttrs( hps, szFont, pdata->lDPI );
                    GpiQueryFontMetrics( hps, sizeof(FONTMETRICS), &fm );
                    WinEndPaint( hps );
                    WinQueryWindowPos( pdata->hwndSB, &swp );
                    WinQueryWindowRect( hwnd, &rcl );
                    lMargin = fm.lAveCharWidth / 2;
                    pdata->rclView.xLeft   = rcl.xLeft + 4 + lMargin;
                    pdata->rclView.yBottom = rcl.yBottom + 4 + fm.lExternalLeading;
                    pdata->rclView.xRight  = rcl.xRight - lMargin - 4 - swp.cx;
                    pdata->rclView.yTop    = rcl.yTop - 5 - fm.lExternalLeading;
                    pdata->textState.ulLineHeight = fm.lMaxAscender;
                    pdata->textState.ulHeight     = ( pdata->rclView.yTop - pdata->rclView.yBottom ) / fm.lMaxAscender;
                    WinInvalidateRect( hwnd, NULL, FALSE );
                    break;
            }
            break;


        case WM_DESTROY:
            if (( pdata = WinQueryWindowPtr( hwnd, 0 )) != NULL ) {
                if ( pdata->psuDisplay ) free( pdata->psuDisplay );
                free( pdata );
            }
            break;
    }

    return ( WinDefWindowProc( hwnd, msg, mp1, mp2 ));
}


/* ------------------------------------------------------------------------- *
 * SetClipTextAttrs                                                          *
 *                                                                           *
 * Set the text and font attributes of the clipboard preview window.         *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HPS  hps    : Handle of the control's presentation space.               *
 *   PSZ  pszFont: The name of the current font in use.                      *
 *   LONG lDPI   : Current system font DPI                                   *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void SetClipTextAttrs( HPS hps, PSZ pszFont, LONG lDPI )
{
    FATTRS fontAttrs;           // current font attributes
    PSZ    pszFontName;         // name of the current font without the pt-size
    SIZEF  sfChSize;            // character cell size
    float  fScale;              // pts -> pels scaling factor

    pszFontName = strchr( pszFont, '.') + 1;
    if ( !pszFontName )
        pszFontName = pszFont;

    // Set the current font and text size
    memset( &fontAttrs, 0, sizeof( FATTRS ));
    fontAttrs.usRecordLength = sizeof( FATTRS );
    fontAttrs.usCodePage     = UNICODE;
    fontAttrs.fsType         = FATTR_TYPE_MBCS;
    fontAttrs.fsFontUse      = FATTR_FONTUSE_NOMIX;
    strcpy( fontAttrs.szFacename, pszFontName );
    if (( GpiCreateLogFont( hps, NULL, 1L, &fontAttrs )) != GPI_ERROR ) {
        fScale = ( (double) lDPI / 72 );
        sfChSize.cx = MAKEFIXED(( 10 * fScale ), 0 );
        sfChSize.cy = sfChSize.cx;
        GpiSetCharBox( hps, &sfChSize );
        GpiSetCharSet( hps, 1L );
    }
}


/* ------------------------------------------------------------------------- *
 * DrawNice3DBorder                                                          *
 *                                                                           *
 * Draw an attractive MLE-style 3D border around a control.                  *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HPS hps  : Handle of the control's presentation space.                  *
 *   RECTL rcl: Rectangle defining the boundaries of the control.            *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void DrawNice3DBorder( HPS hps, RECTL rcl )
{
    POINTL ptl;

    GpiSetColor( hps, SYSCLR_BUTTONLIGHT );
    ptl.x = rcl.xLeft;
    ptl.y = rcl.yBottom;
    GpiMove( hps, &ptl );
    ptl.x = rcl.xRight - 1;
    GpiLine( hps, &ptl );
    ptl.y = rcl.yTop - 1;
    GpiLine( hps, &ptl );
    GpiSetColor( hps, SYSCLR_DIALOGBACKGROUND );
    ptl.x = rcl.xLeft;
    ptl.y = rcl.yBottom + 1;
    GpiMove( hps, &ptl );
    ptl.x = rcl.xRight - 2;
    GpiLine( hps, &ptl );
    ptl.y = rcl.yTop;
    GpiLine( hps, &ptl );
    GpiSetColor( hps, SYSCLR_BUTTONDARK );
    ptl.x = rcl.xLeft;
    ptl.y = rcl.yBottom + 1;
    GpiMove( hps, &ptl );
    ptl.y = rcl.yTop - 1;
    GpiLine( hps, &ptl );
    ptl.x = rcl.xRight - 1;
    GpiLine( hps, &ptl );
    GpiSetColor( hps, CLR_BLACK );
    ptl.x = rcl.xLeft + 1;
    ptl.y = rcl.yBottom + 2;
    GpiMove( hps, &ptl );
    ptl.y = rcl.yTop - 2;
    GpiLine( hps, &ptl );
    ptl.x = rcl.xRight - 3;
    GpiLine( hps, &ptl );
}


/* ------------------------------------------------------------------------- *
 * DrawWrappedText                                                           *
 *                                                                           *
 * Draw Unicode text within the specified rectangle, starting from the       *
 * specified point, wrapping it as needed.  The position (pptPos) is updated *
 * to the point after the last drawn character where the theoretical next    *
 * character should be drawn, if it existed.                                 *
 *                                                                           *
 * A maximum of 512 bytes (or 256 UniChars) will be drawn by this function.  *
 *                                                                           *
 * The codepage of the presentation space font attributes must be 1200 if    *
 * the text is to display correctly.                                         *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HPS          hps    : Handle of the current presentation space    (I)   *
 *   PPOINTL      pptPos : Position of the next character to be drawn  (I/O) *
 *   RECTL        rcl    : Rectangle defining the text boundaries      (I)   *
 *   FONTMETRICS  fm     : Current font metrics                        (I)   *
 *   PCBTEXTATTRS pAttrs : Number of the topmost visible line.         (I)   *
 *   UniChar    * psuText: The Unicode text to draw (256 UniChars max) (I)   *
 *                                                                           *
 * RETURNS: ULONG                                                            *
 *   Number of characters drawn.                                             *
 * ------------------------------------------------------------------------- */
ULONG DrawWrappedText( HPS hps, PPOINTL pptPos, RECTL rcl, FONTMETRICS fm, PCBTEXTATTRS pAttrs, UniChar *psuText )
{
    ULONG  ulLine,              // Current line (from 0)
           ulStart,             // Starting character index (== # already drawn)
           ulChars,             // Number of characters to draw
           ulTotal;             // Total length of the string
    POINTL ptl,                 // Current drawing position
           aptl[ 513 ] = {0};   // Array of individual character positions

    ptl.x = pptPos->x;
    ptl.y = pptPos->y;
    ulTotal = UniStrlen( psuText ) * sizeof( UniChar );
    if ( ulTotal > 512 ) ulTotal = 512;
    ulLine  = 0;
    ulStart = 0;

    while (( ulStart < ulTotal ))// && ( ptl.y >= rcl.yBottom ) &&
    //       ( ulLine <= ( pAttrs->ulOffset + pAttrs->ulHeight )))
    {
        // Calculate how many bytes (half-characters) can fit on the line...
        // - first, get a rough estimate of the number of whole characters,
        //   based on the average character width
        // - we could simply double this number to get the number of bytes, BUT
        //   we need to err on the side of being too long, so we multiply by 3
        //   instead
        ulChars = (LONG) ((rcl.xRight - rcl.xLeft) / fm.lAveCharWidth ) * 3;

        // - and then make sure it's an even number (this aligns it to the
        //   next character boundary)
        if ( ulChars % 2 ) ulChars++;

        // - and make sure it's not more than the total number of bytes
        if ( ulChars > (ulTotal-ulStart) ) ulChars = ulTotal - ulStart;

        // - OK, now we determine the actual character positions of our string
        GpiQueryCharStringPosAt( hps, &ptl, 0, ulChars,
                                 (PCH) psuText+ulStart, NULL, aptl );
        // - and scan back from our estimate to find a point that fits
        while ( aptl[ulChars].x > rcl.xRight ) ulChars -= 2;
        if ( !ulChars ) break;

        // Now draw the characters if they're within the visible area
        if (( ulLine >= pAttrs->ulOffset ) &&
            ( GpiCharStringPosAt( hps, &ptl, &rcl, CHS_CLIP, ulChars,
                                  (PCH) psuText+ulStart, NULL ) != GPI_OK ))
        {
            return ulStart;
        }

        // Increment the starting position
        ulStart += ulChars;

        // If we're not finished, move to the next line
        if ( ulStart < ulTotal ) {
            ulLine++;
            ptl.x = rcl.xLeft;
            if ( ulLine > pAttrs->ulOffset )
                ptl.y -= pAttrs->ulLineHeight;
        }

    }
    pptPos->x = ptl.x;
    pptPos->y = ptl.y;
    pAttrs->ulLines = ulLine+1;

    return ulStart;
}


/* ------------------------------------------------------------------------- *
 * AddCodepage                                                               *
 *                                                                           *
 * Add a codepage to the dropdown list.                                      *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HAB    hab:  Anchor-block handle.                                       *
 *   HWND   hwnd: Handle of the main application window.                     *
 *   ULONG  ulID: Resource ID of the codepage's description string.          *
 *   USHORT usCP: Codepage to be added.                                      *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void AddCodepage( HAB hab, HWND hwnd, ULONG ulID, USHORT usCP )
{
    CHAR szCP[ CPDESC_MAXZ ],   // name of codepage
         szBuf[ CPDESC_MAXZ ];  // buffer for string resource

    sprintf( szCP, "%u ", usCP );
    if ( WinLoadString( hab, 0, ulID, CPDESC_MAXZ-1, szBuf ))
        strncat( szCP, szBuf, CPDESC_MAXZ-1 );
    WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_INSERTITEM,
                       MPFROMSHORT(LIT_END), MPFROMP(szCP) );
}


/* ------------------------------------------------------------------------- *
 * WindowSetup                                                               *
 *                                                                           *
 * Perform some initial setup on the application window.                     *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd: Handle of the main application window.                       *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void WindowSetup( HWND hwnd )
{
    PDCMGLOBAL pGlobal;                 // global data
    HPOINTER   hicon;                   // main application icon
    USHORT     usSelCP = 0,             // selected codepage index (from INI)
               usSelWard = 0,           // selected lead byte (from INI)
               i, j;                    // loop counters
    CHAR       szIni[ CCHMAXPATH ],     // name of program INI file
               szFont[ FACESIZE ],      // last used font (from INI)
               szCPath[ CCHMAXPATH ],   // path to codepage files
               szSysCP[ CPDESC_MAXZ ],  // name of active system codepage
               szBuf[ CPDESC_MAXZ ];    // buffer for reading string resource for above
    BOOL       fCopyUni;                // Unicode copy setting (from INI)
    LONG       x  = 0,                  // window position values (from INI)
               y  = 0,
               cx = 0,
               cy = 0;
    ULONG      aulCP[ 3 ] = {0},        // array of system codepages
               cbCP = 0;                // size of returned codepage array


    pGlobal = WinQueryWindowPtr( hwnd, 0 );

    // Load the menu-bar
    WinLoadMenu( hwnd, 0, ID_MAINPROGRAM );
    WinSendMsg( hwnd, WM_UPDATEFRAME, (MPARAM) FCF_MENU, MPVOID );

    // Set the window mini-icon
    hicon = WinLoadPointer( HWND_DESKTOP, 0, ID_MAINPROGRAM );
    WinSendMsg( hwnd, WM_SETICON, MPFROMP(hicon), MPVOID );

    GetCodepagePath( szCPath, CCHMAXPATH );

    /* Populate the codepage selector.
     * First, always add the Unicode (UCS-2) codepage; we don't list this
     * one in numeric form, hence the separate logic here.
     */
    if ( ! WinLoadString( pGlobal->hab, 0, IDS_CODEPAGE_1200, CPDESC_MAXZ-1, szBuf ))
        strcpy( szBuf, "UCS-2");
    WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_INSERTITEM,
                       MPFROMSHORT(LIT_END), MPFROMP(szBuf) );

    // Add any current system codepages which aren't one of our DBCS ones.
    if ( ! WinLoadString( pGlobal->hab, 0, IDS_CODEPAGE_DESC, CPDESC_MAXZ-1, szBuf ))
        sprintf( szBuf, "%u (system codepage)");
    DosQueryCp( sizeof( aulCP ), aulCP, &cbCP );

    if ( aulCP[0] && ! IS_DBCS_CODEPAGE( aulCP[0] )) {
        sprintf( szSysCP, szBuf, aulCP[0] );
        WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_INSERTITEM,
                           MPFROMSHORT(LIT_END), MPFROMP(szSysCP) );
    }
    if ( aulCP[1] && ( aulCP[1] != aulCP[0] ) && ! IS_DBCS_CODEPAGE( aulCP[1] )) {
        sprintf( szSysCP, szBuf, aulCP[1] );
        WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_INSERTITEM,
                           MPFROMSHORT(LIT_END), MPFROMP(szSysCP) );
    }
    if ( aulCP[2] && ( aulCP[2] != aulCP[0] ) && ! IS_DBCS_CODEPAGE( aulCP[2] )) {
        sprintf( szSysCP, szBuf, aulCP[2] );
        WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_INSERTITEM,
                           MPFROMSHORT(LIT_END), MPFROMP(szSysCP) );
    }

    // Japan SAA (SJIS-1978), if installed
    if ( CodepageIsInstalled( szCPath, 942 ))
        AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_942, 942 );

    // Japan Shift-JIS i.e. codepage 932 or 943 (should always be installed)
    AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_943, 943 );

    // Korea SAA (seems to be an old version of KS-Code)
    if ( CodepageIsInstalled( szCPath, 944 ))
        AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_944, 944 );

    // Korea KS-Code (the normal Korean codepage, should always be installed)
    AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_949, 949 );

    // Taiwan SAA (some legacy Taiwanese encoding, not really sure what it is)
    if ( CodepageIsInstalled( szCPath, 948 ))
        AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_948, 948 );

    // Taiwan Big-5 encoding (this is the usual codepage for Taiwan)
    AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_950, 950 );

    // China SAA (some old PRC encoding, also not really sure)
    if ( CodepageIsInstalled( szCPath, 946 ))
        AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_946, 946 );

    // China GB-2312 (used on OS/2 prior to Aurora, I think)
    if ( CodepageIsInstalled( szCPath, 1381 ))
        AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_1381, 1381 );

    // China GBK (the standard Chinese/PRC encoding)
    if ( CodepageIsInstalled( szCPath, 1386 ))
        AddCodepage( pGlobal->hab, hwnd, IDS_CODEPAGE_1386, 1386 );


    // Activate ownerdraw mode for each valueset cell
    for ( i = 0; i < 16; i++ ) {
        for ( j = 0; j < 16; j++ ) {
            WinSendDlgItemMsg( hwnd, IDD_CHARMAP, VM_SETITEMATTR,
                               MPFROM2SHORT(i+1, j+1), MPFROM2SHORT(VIA_OWNERDRAW, TRUE) );
        }
    }

    // Check for saved INI file settings
    memset( szIni,  0, sizeof(szIni) );
    memset( szFont, 0, sizeof(szFont) );
    LocateProfile( szIni );
    pGlobal->hIni = PrfOpenProfile( pGlobal->hab, szIni );
    LoadIniData( &x,  pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_LEFT );
    LoadIniData( &y,  pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_BOTTOM );
    LoadIniData( &cx, pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_WIDTH );
    LoadIniData( &cy, pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_HEIGHT );
    LoadIniData( &usSelCP,   pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_CODEPAGE );
    LoadIniData( &usSelWard, pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_WARD );
    LoadIniData( szFont,     pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_FONT );
    LoadIniData( &fCopyUni,  pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_UNICLIP );

    // Now set the initial values
    WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_SELECTITEM,
                       MPFROMSHORT( usSelCP ), MPFROMSHORT( TRUE ));
    if ( usSelWard > 0 )
        WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_SELECTITEM,
                           MPFROMSHORT( usSelWard ), MPFROMSHORT( TRUE ));

    if ( strlen(szFont) > 0 )
        strncpy( pGlobal->szFont, szFont, FACESIZE-1 );
    UpdateSampleFont( hwnd, pGlobal->szFont );

    if ( !fCopyUni ) {
        pGlobal->fCopyUCS = FALSE;
        WinSendDlgItemMsg( hwnd, FID_MENU, MM_SETITEMATTR,
                           MPFROM2SHORT(ID_UCS, TRUE), MPFROM2SHORT(MIA_CHECKED, 0) );
    }

    if ( !(x && y && cx && cy ))
        CentreWindow( hwnd );
    else
        WinSetWindowPos( hwnd, HWND_TOP, x, y, cx, cy, SWP_MOVE | SWP_SIZE | SWP_ACTIVATE );

}


/* ------------------------------------------------------------------------- *
 * CentreWindow                                                              *
 *                                                                           *
 * Centres the given window on the screen.                                   *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd: Handle of the window to be centred.                          *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void CentreWindow( HWND hwnd )
{
    LONG scr_width, scr_height;
    LONG x, y;
    SWP wp;

    scr_width = WinQuerySysValue( HWND_DESKTOP, SV_CXSCREEN );
    scr_height = WinQuerySysValue( HWND_DESKTOP, SV_CYSCREEN );

    if ( WinQueryWindowPos( hwnd, &wp )) {
        x = ( scr_width - wp.cx ) / 2;
        y = ( scr_height - wp.cy ) / 2;
        WinSetWindowPos( hwnd, HWND_TOP, x, y, wp.cx, wp.cy, SWP_MOVE | SWP_ACTIVATE );
    }

}


/* ------------------------------------------------------------------------- *
 * LocateProfile                                                             *
 *                                                                           *
 * Figure out where to place our INI file.  This will be in the same         *
 * directory as OS2.INI (the OS/2 user profile).                             *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *     PSZ pszProfile: Character buffer to receive the INI filename.         *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void LocateProfile( PSZ pszProfile )
{
    ULONG ulRc;
    PSZ   pszUserIni,
          c;

    // Query the %USER_INI% environment variable which points to OS2.INI
    ulRc = DosScanEnv("USER_INI", &pszUserIni );
    if ( ulRc != NO_ERROR ) return;
    strncpy( pszProfile, pszUserIni, CCHMAXPATH );

    // Now change the filename portion to point to our own INI file
    if (( c = strrchr( pszProfile, '\\') + 1 ) != NULL ) {
        memset( c, 0, strlen(c) );
        strncat( pszProfile, INI_FILE, CCHMAXPATH - 1 );
    }

}


/* ------------------------------------------------------------------------- *
 * LoadIniData                                                               *
 *                                                                           *
 * Retrieve a value from the program INI file.                               *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *     PVOID pszData: Buffer where the data will be written.                 *
 *     HINI  hIni   : Handle to the INI file.                                *
 *     PSZ   pszApp : INI application name.                                  *
 *     PSZ   pszKey : INI key name.                                          *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void LoadIniData( PVOID pszData, HINI hIni, PSZ pszApp, PSZ pszKey )
{
    BOOL  fOK;
    ULONG ulBytes;

    fOK = PrfQueryProfileSize( hIni, pszApp, pszKey, &ulBytes );
    if ( fOK && ( ulBytes > 0 )) {
        PrfQueryProfileData( hIni, pszApp, pszKey, pszData, &ulBytes );
    }
}


/* ------------------------------------------------------------------------- *
 * SaveSettings                                                              *
 *                                                                           *
 * Saves various settings to the INI file.  Called on program exit.          *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd: Main window handle.                                          *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void SaveSettings( HWND hwnd )
{
    PDCMGLOBAL pGlobal;                 // global data
    SHORT      sIdx;                    // selected list index
    SWP        wp;                      // window size/position

    pGlobal = WinQueryWindowPtr( hwnd, 0 );

    // Save the window position
    if ( WinQueryWindowPos( hwnd, &wp )) {
        PrfWriteProfileData( pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_LEFT,   &(wp.x),  sizeof(wp.x) );
        PrfWriteProfileData( pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_BOTTOM, &(wp.y),  sizeof(wp.y) );
        PrfWriteProfileData( pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_WIDTH,  &(wp.cx), sizeof(wp.cx) );
        PrfWriteProfileData( pGlobal->hIni, PRF_APP_POSITION, PRF_KEY_HEIGHT, &(wp.cy), sizeof(wp.cy) );
    }

    // Save the codepage selection (as a list index)
    sIdx = (SHORT) WinSendDlgItemMsg( hwnd, IDD_CODEPAGE, LM_QUERYSELECTION,
                                      MPFROMSHORT(LIT_FIRST), MPVOID        );
    PrfWriteProfileData( pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_CODEPAGE, &(sIdx), sizeof(sIdx) );

    // Save the lead byte selection (as a list index)
    sIdx = (SHORT) WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_QUERYSELECTION,
                                      MPFROMSHORT(LIT_FIRST), MPVOID      );
    PrfWriteProfileData( pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_WARD, &(sIdx), sizeof(sIdx) );

    // Save the font
    PrfWriteProfileData( pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_FONT,
                         pGlobal->szFont, strlen(pGlobal->szFont)+1 );

    // Save the UCS clipboard option
    PrfWriteProfileData( pGlobal->hIni, PRF_APP_SETTINGS, PRF_KEY_UNICLIP,
                         &(pGlobal->fCopyUCS), sizeof(pGlobal->fCopyUCS) );

    PrfCloseProfile( pGlobal->hIni );
}


/* ------------------------------------------------------------------------- *
 * ChangeCodepage                                                            *
 *                                                                           *
 * Called whenever a new codepage is selected.  Queries the range of legal   *
 * leading-byte values and repopulates the drop-down list accordingly.  Also *
 * calles UpdateClipboard() for the new codepage.                            *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd : Handle of the main application window.                      *
 *   ULONG ulCP: The newly-selected codepage.                                *
 *                                                                           *
 * RETURNS: BOOL                                                             *
 *   TRUE if the new codepage was selected successfully; FALSE if an error   *
 *   occurred.                                                               *
 * ------------------------------------------------------------------------- */
BOOL ChangeCodepage( HWND hwnd, ULONG ulCP )
{
    PDCMGLOBAL  pGlobal;             // global program data
    UconvObject uconvNew;            // conversion object for new codepage
    UCHAR       szBuf[ 3 ];          // buffer for writing character bytes
    USHORT      i;                   // loop index
    APIRET      ulRc;                // return code
    UniChar     suCP[ CPSPEC_MAXZ ]; // codepage specification string
    BOOL        fAnySec = FALSE,     // are any valid secondary bytes reported?
                fMultiByte = TRUE;   // multi-byte codepage?


    pGlobal = WinQueryWindowPtr( hwnd, 0 );

    if ( ulCP == UNICODE ) {
        ulRc = UniCreateUconvObject( (UniChar *)L"IBM-1208@map=display,path=no", &uconvNew );
        if ( ulRc != NO_ERROR ) return FALSE;
    } else {
        if ( UniMapCpToUcsCp( ulCP, suCP, CPNAME_MAXZ ) != NO_ERROR ) return FALSE;
        UniStrcat( suCP, L"@map=display,path=no");
        ulRc = UniCreateUconvObject( suCP, &uconvNew );
        if ( ulRc != NO_ERROR ) return FALSE;
    }
    if ( pGlobal->uconvCP != NULL ) UniFreeUconvObject( pGlobal->uconvCP );
    pGlobal->uconvCP = uconvNew;
    pGlobal->ulCP    = ulCP;

    // Tell the glyph preview control that the codepage has changed
    WinSendDlgItemMsg( hwnd, IDD_SAMPLE, UPW_SETCP, (MPARAM) ulCP, MPVOID );

    // Clear the byte selector
    WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_DELETEALL, MPVOID, MPVOID );

    // Determine the available lead-byte values for this codepage
    if ( ulCP == UNICODE ) {
        // In UCS-2, all bytes are valid leading & secondary bytes
        for ( i = 0; i < 256; i++ ) {
            pGlobal->fPrimary[ i ] = 1;
            pGlobal->fSecondary[ i ] = 1;
            sprintf( szBuf, "%02X", i );
            WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_INSERTITEM,
                               MPFROMSHORT(LIT_END), MPFROMP(szBuf) );
        }
    }
    else if ( ! IS_DBCS_CODEPAGE( ulCP )) {
        memset( pGlobal->fPrimary, 1, 256 );
        memset( pGlobal->fSecondary, 0, 256 );
        fMultiByte = FALSE;
        WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_INSERTITEM,
                           MPFROMSHORT(LIT_END), MPFROMP("--") );
    }
    else {
        WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_INSERTITEM,
                           MPFROMSHORT(LIT_END), MPFROMP("--") );
        ulRc = UniQueryUconvObject( pGlobal->uconvCP, NULL, 0,
                                    pGlobal->fPrimary,
                                    pGlobal->fSecondary, NULL );
        if ( ulRc == NO_ERROR ) {
            for ( i = 0; i < 256; i++ ) {
                if ( ISLEADINGBYTE( pGlobal->fPrimary[i] )) {
                    // add value to byte selector
                    sprintf( szBuf, "%02X", i );
                    WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_INSERTITEM,
                                       MPFROMSHORT(LIT_END), MPFROMP(szBuf) );
                }
                if ( pGlobal->fSecondary[i] ) fAnySec = TRUE;
            }
            // some buggy MBCS codepages report no valid secondary bytes at all
            if ( !fAnySec )
                for ( i = 0; i < 256; i++ ) pGlobal->fSecondary[ i ] = 1;
        }
        else {
            for ( i = 0; i < 256; i++ ) {
                sprintf( szBuf, "%02X", i );
                WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_INSERTITEM,
                                   MPFROMSHORT( LIT_END ), MPFROMP( szBuf ));
            }
        }
    }

    // Select the first available ward by default
    WinSendDlgItemMsg( hwnd, IDD_OFFSET, LM_SELECTITEM,
                       MPFROMSHORT( 0 ), MPFROMSHORT( TRUE ));

    WinEnableControl( hwnd, IDD_LEADING, fMultiByte );
    WinEnableControl( hwnd, IDD_OFFSET,  fMultiByte );

    // Convert any clipboard text of ours into the new codepage
    UpdateClipboard( hwnd, pGlobal );

    return TRUE;
}


/* ------------------------------------------------------------------------- *
 * PopulateCharMap                                                           *
 *                                                                           *
 * Redraws the value set with the selected set of characters.  Called        *
 * whenever the leading byte is changed.  The current set of character       *
 * values is regenerated and stored in two places: as UCS-2 values in        *
 * pGlobal->suGlyph[] and as MBCS codepage characters in pGlobal->szGlyph[]. *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd      : Handle of the main application window.                 *
 *   USHORT usOffset: The newly-selected leading byte offset (a.k.a. ward).  *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void PopulateCharMap( HWND hwnd, USHORT usOffset )
{
    PDCMGLOBAL pGlobal;
    HWND       hwndVS;                      // handle to the charmap valueset
    CHAR       szVal[ CHARSTRING_MAXZ ];    // buffer for the current character
    PSZ        psz;                         // offset into szVal
    USHORT     i, j;                        // counters
    BYTE       chVal;                       // current character index (0-255)
    ULONG      ulSel,                       // currently-selected valueset cell
               ulRc;                        // return code
    UniChar    suVal[ 2 ],                  // a one-character Unicode string
               *psu;                        // offset into suVal
    size_t     stIn, stOut, stSub;


    pGlobal = WinQueryWindowPtr( hwnd, 0 );
    hwndVS  = WinWindowFromID( hwnd, IDD_CHARMAP );
    WinShowWindow( hwndVS, FALSE );

    memset( szVal, 0, sizeof(szVal) );
    memset( suVal, 0, sizeof(suVal) );
    for ( i = 0; i < 16; i++ ) {
        for ( j = 0; j < 16; j++ ) {
            chVal = (i*16) + j;
            // Handle Unicode specially (convert to PM-Unicode)
            if ( pGlobal->ulCP == UNICODE ) {
                suVal[ 0 ] = BYTES2UNICHAR( usOffset, chVal );
                suVal[ 1 ] = 0;
                // we have the UCS-2 value; need to generate the codepage string
                psu   = suVal;
                psz   = szVal;
                stIn  = 1;
                stOut = CHARSTRING_MAXZ-1;
                stSub = 0;
                ulRc  = UniUconvFromUcs( pGlobal->uconv1207, &psu, &stIn, (PPVOID) &psz, &stOut, &stSub );
                if ( ulRc != ULS_SUCCESS ) sprintf( szVal, "??", ulRc );
            }
            // Other codepages will be rendered directly
            else {
                if (( usOffset < 256 ) && IS_DBCS_CODEPAGE( pGlobal->ulCP ))
                    sprintf( szVal, "%c%c", usOffset, chVal );
                else
                    sprintf( szVal, "%c", chVal );
                // we have the codepage string; need to generate the UCS-2 value
                psu   = suVal;
                psz   = szVal;
                stIn  = strlen( szVal );
                stOut = 1;
                stSub = 0;
                ulRc  = UniUconvToUcs( pGlobal->uconvCP, (PPVOID) &psz, &stIn, &psu, &stOut, &stSub );
                if ( ulRc != ULS_SUCCESS ) suVal[ 0 ] = 0xFFFD;
            }
            strncpy( pGlobal->szGlyph[ chVal ], szVal, CHARSTRING_MAXZ-1 );
            pGlobal->suGlyph[ chVal ] = suVal[ 0 ];
            WinSendMsg( hwndVS, VM_SETITEM, MPFROM2SHORT(i+1, j+1), MPFROMP(szVal) );
        }
    }

    WinShowWindow( hwndVS, TRUE );
    ulSel = (ULONG) WinSendMsg( hwndVS, VM_QUERYSELECTEDITEM, MPVOID, MPVOID );
    SelectCharacter( hwnd, SHORT1FROMMP(ulSel), SHORT2FROMMP(ulSel) );

}


/* ------------------------------------------------------------------------- *
 * SelectCharacter                                                           *
 *                                                                           *
 * Called whenever the user selects a character in the value-set.  Updates   *
 * the 'preview' field and the details field underneath it.                  *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd   : Handle of the main application window.                    *
 *   USHORT usRow: Row number (1-16) of the current valueset cell.           *
 *   USHORT usCol: Column number (1-16) of the current valueset cell.        *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void SelectCharacter( HWND hwnd, USHORT usRow, USHORT usCol )
{
    PDCMGLOBAL pGlobal;
    BYTE       ucWard,
               ucCell;
    CHAR       szCharIndex[ 32 ];
    PSZ        pszGlyph;


    pGlobal = WinQueryWindowPtr( hwnd, 0 );
    ucWard = ( pGlobal->usWard > 255 ) ? 0 : (BYTE) pGlobal->usWard;

    // Get the current character value & update the controls
    ucCell = (usRow-1)*16 + (usCol-1);
    pszGlyph = IsDisabledCell( ucCell, pGlobal ) ? "" : pGlobal->szGlyph[ ucCell ];

    if ( pGlobal->ulCP == UNICODE )
        sprintf( szCharIndex, "U+%02X%02X", ucWard, ucCell );
    else if ( IS_DBCS_CODEPAGE( pGlobal->ulCP ) && ucWard ) {
        if ( *pszGlyph && ( (USHORT)(pGlobal->suGlyph[ ucCell ]) != 0xFFFD ))
            sprintf( szCharIndex, "0x%02X%02X  (%u:%u)  U+%04X", ucWard, ucCell, ucWard, ucCell, pGlobal->suGlyph[ ucCell ]);
        else
            sprintf( szCharIndex, "0x%02X%02X  (%u:%u)", ucWard, ucCell, ucWard, ucCell );
    }
    else {
        if ( *pszGlyph && ( (USHORT)(pGlobal->suGlyph[ ucCell ]) != 0xFFFD ))
            sprintf( szCharIndex, "0x%02X  (%u)  U+%04X", ucCell, ucCell, pGlobal->suGlyph[ ucCell ]);
        else
            sprintf( szCharIndex, "0x%02X  (%u)", ucCell, ucCell );
    }

    WinSetDlgItemText( hwnd, IDD_NUMBER, szCharIndex );
    WinSendDlgItemMsg( hwnd, IDD_SAMPLE, UPW_SETGLYPH, MPFROMP(pszGlyph),
                       MPFROMSHORT(pGlobal->suGlyph[ucCell]) );

}


/* ------------------------------------------------------------------------- *
 * SelectSampleFont                                                          *
 *                                                                           *
 * Allows the user to select the font used for displaying DBCS characters in *
 * our user interface.                                                       *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd   : Handle of the main application window.                    *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void SelectSampleFont( HWND hwnd )
{
    PDCMGLOBAL  pGlobal;
    HPS         hps;
    FONTDLG     fontdlg = {0};
    FONTMETRICS fm;
    HWND        hwndFD;
    CHAR        szFamily[ FACESIZE ];
    LONG        lQuery = 0;


    pGlobal = WinQueryWindowPtr( hwnd, 0 );
    hps     = WinGetPS( hwnd );

    // Find the family name of the current font
    if ( GpiQueryFonts( hps, QF_PUBLIC, pGlobal->szFont,
                        &lQuery, sizeof(FONTMETRICS), NULL ) > 0 )
    {
        lQuery = 1;
        memset( &fm, 0, sizeof(fm) );
        GpiQueryFonts( hps, QF_PUBLIC, pGlobal->szFont,
                       &lQuery, sizeof(FONTMETRICS), &fm );
        strncpy( szFamily, fm.szFamilyname, FACESIZE-1 );
    } else
        strncpy( szFamily, pGlobal->szFont, FACESIZE-1 );

    // Create the font dialog
    memset( &fontdlg, 0, sizeof(FONTDLG) );
    fontdlg.cbSize         = sizeof( FONTDLG );
    fontdlg.hpsScreen      = hps;
    fontdlg.pszTitle       = NULL;
    fontdlg.pszPreview     = NULL;
    fontdlg.pfnDlgProc     = NULL;
    fontdlg.pszFamilyname  = szFamily;
    fontdlg.usFamilyBufLen = sizeof( szFamily );
    fontdlg.fxPointSize    = MAKEFIXED( 10, 0 );
    fontdlg.flType         = (fm.fsSelection & FM_SEL_ITALIC)? FTYPE_ITALIC: 0;
    fontdlg.usWeight       = (USHORT) fm.usWeightClass;
    fontdlg.clrFore        = SYSCLR_WINDOWTEXT;
    fontdlg.clrBack        = SYSCLR_WINDOW;
    fontdlg.fl             = FNTS_CENTER | FNTS_CUSTOM | FNTS_VECTORONLY;
    fontdlg.usDlgId        = IDD_FONTDLG;
    fontdlg.hMod           = NULLHANDLE;
    hwndFD = WinFontDlg( HWND_DESKTOP, hwnd, &fontdlg );

    if (( hwndFD ) && ( fontdlg.lReturn == DID_OK )) {
        strncpy( pGlobal->szFont, fontdlg.fAttrs.szFacename, FACESIZE-1 );
        UpdateSampleFont( hwnd, pGlobal->szFont );
    }

    WinReleasePS( hps );
}


/* ------------------------------------------------------------------------- *
 * UpdateSampleFont                                                          *
 *                                                                           *
 * Set the font for displaying DBCS characters in our user interface.        *
 * This font is used in three controls: the value set (IDD_CHARMAP), the     *
 * 'preview' field (IDD_SAMPLE), and the clipboard status (IDD_CLIPBOARD).   *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd        : Handle of the main application window.               *
 *   CHAR szFontName[]: Name of the new font to use.                         *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void UpdateSampleFont( HWND hwnd, CHAR szFontName[ FACESIZE ] )
{
    CHAR szCellFont[ FACESIZE + 4 ],
         szClipFont[ FACESIZE + 4 ],
         szPreviewFont[ FACESIZE + 4 ];

    sprintf( szClipFont,    "9.%s",  szFontName );
    sprintf( szPreviewFont, "48.%s", szFontName );
    sprintf( szCellFont,    "10.%s", szFontName );
    WinSetPresParam( WinWindowFromID( hwnd, IDD_CLIPBOARD ),
                     PP_FONTNAMESIZE, strlen(szClipFont)+1, (PVOID) szClipFont );
    WinSetPresParam( WinWindowFromID( hwnd, IDD_SAMPLE ),
                     PP_FONTNAMESIZE, strlen(szPreviewFont)+1, (PVOID) szPreviewFont );
    WinSetPresParam( WinWindowFromID( hwnd, IDD_CHARMAP ),
                     PP_FONTNAMESIZE, strlen(szCellFont)+1, (PVOID) szCellFont );
}


/* ------------------------------------------------------------------------- *
 * CopyToClipboard                                                           *
 *                                                                           *
 * Copy the currently-selected character to the clipboard.  The character is *
 * appended to any data that we previously copied to the clipboard; however, *
 * any other clipboard data (placed there by another program) is deleted.    *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd   : Handle of the main application window.                    *
 *   USHORT usRow: Row number (1-16) of the current valueset cell.           *
 *   USHORT usCol: Column number (1-16) of the current valueset cell.        *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void CopyToClipboard( HWND hwnd, USHORT usRow, USHORT usCol )
{
    PDCMGLOBAL  pGlobal;
    VSTEXT      vstext;
    UniChar     unic;
    ULONG       ulChars;
    CHAR        szCellValue[ CHARSTRING_MAXZ ];
    BYTE        ucCell;

    pGlobal = WinQueryWindowPtr( hwnd, 0 );
    ucCell = (usRow-1)*16 + (usCol-1);

    // If there's no valid character in this position, do nothing
    if ( IsDisabledCell( ucCell, pGlobal )) return;

    // Get the selected character
    vstext.pszItemText = szCellValue;
    vstext.ulBufLen    = sizeof( szCellValue );
    WinSendDlgItemMsg( hwnd, IDD_CHARMAP, VM_QUERYITEM,
                       MPFROM2SHORT( usRow, usCol ), MPFROMP( &vstext ));
    if ( vstext.pszItemText == NULL ) return;

    // Get the current character's Unicode value
    unic = pGlobal->suGlyph[ ucCell ];

    // Get the previously-copied text and append the new character
    ulChars = UniStrlen( pGlobal->psuCopied ) + 1;
    pGlobal->psuCopied = (UniChar *) realloc( pGlobal->psuCopied, (ulChars+1) * sizeof(UniChar) );
    if ( pGlobal->psuCopied == NULL ) return;
    pGlobal->psuCopied[ ulChars - 1 ] = unic;
    pGlobal->psuCopied[ ulChars ]     = 0;

    // Update the clipboard viewer control
    WinSendDlgItemMsg( hwnd, IDD_CLIPBOARD, CPW_SETTEXT, MPVOID, MPFROMP(pGlobal->psuCopied) );

    // Now update the actual (system) clipboard contents
    UpdateClipboard( hwnd, pGlobal );
}


/* ------------------------------------------------------------------------- *
 * DeleteFromClipboard                                                       *
 *                                                                           *
 * Delete the last character from the clipboard buffer (a kind of virtual    *
 * 'backspace').                                                             *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd   : Handle of the main application window.                    *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void DeleteFromClipboard( HWND hwnd )
{
    PDCMGLOBAL pGlobal;
    ULONG      ulLen;

    pGlobal = WinQueryWindowPtr( hwnd, 0 );
    ulLen = UniStrlen( pGlobal->psuCopied );
    if ( ulLen < 1 ) return;
    if ( ulLen == 1 ) {
        // just clear the clipboard if this is the only character
        if ( WinOpenClipbrd( pGlobal->hab )) {
            WinEmptyClipbrd( pGlobal->hab );
            WinCloseClipbrd( pGlobal->hab );
        }
        free( pGlobal->psuCopied );
        pGlobal->psuCopied = (UniChar *) malloc( sizeof(UniChar) );
        if (pGlobal->psuCopied) pGlobal->psuCopied[ 0 ] = 0;
        WinEnableWindow( WinWindowFromID(hwnd, ID_CLEAR), FALSE );
        WinEnableWindow( WinWindowFromID(hwnd, ID_DELETE), FALSE );
        WinSendDlgItemMsg( hwnd, IDD_CLIPBOARD, CPW_SETTEXT, MPFROMP(""), MPFROMP(L"") );
        return;
    }

    // Clear the final character in the clipboard buffer
    pGlobal->psuCopied[ ulLen-1 ] = 0;

    // Update the clipboard viewer control
    WinSendDlgItemMsg( hwnd, IDD_CLIPBOARD, CPW_SETTEXT, MPVOID, MPFROMP(pGlobal->psuCopied) );

    // Now update the actual (system) clipboard contents
    UpdateClipboard( hwnd, pGlobal );
}


/* ------------------------------------------------------------------------- *
 * UpdateClipboard                                                           *
 *                                                                           *
 * We have a UCS-2 string (pGlobal->psuCopied) representing the text that    *
 * needs to go into the clipboard; this function converts it into the        *
 * current codepage and copies it into clipboard as CF_TEXT (and also copies *
 * the UCS-2 bytes directly as text/unicode if that option is enabled).      *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   HWND hwnd         : Handle of the main application window.              *
 *   PDCMGLOBAL pGlobal: Common application data.                            *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void UpdateClipboard( HWND hwnd, PDCMGLOBAL pGlobal )
{
    UniChar     *psuShared;
    PSZ         pszShared,
                pszCopy;
    CHAR        szError[ SZRES_MAXZ + 32 ],
                szRes[ SZRES_MAXZ ];
    ULONG       ulBufSize,
                ulRC;

    if ( pGlobal->psuCopied == NULL || UniStrlen(pGlobal->psuCopied) < 1 ) return;

    // Always allow for up to 4 output bytes per input UniChar
    ulBufSize = ( UniStrlen(pGlobal->psuCopied) * 4 ) + 1;
    if (( pszCopy = (PSZ) malloc( ulBufSize )) == NULL ) return;

    if ( WinOpenClipbrd( pGlobal->hab )) {

        // Copy as plain text in the current codepage
        if ( UniStrFromUcs( pGlobal->uconvCP, pszCopy,
                            pGlobal->psuCopied, ulBufSize ) == NO_ERROR ) {
            // Now copy the resulting string to the clipboard
            if (( ulRC = DosAllocSharedMem( (PVOID) &pszShared, NULL, ulBufSize,
                                            PAG_WRITE | PAG_COMMIT | OBJ_GIVEABLE )) == NO_ERROR )
            {
                memcpy( pszShared, pszCopy, ulBufSize );

                // Place the resulting string into the clipboard
                WinEmptyClipbrd( pGlobal->hab );
                if ( WinSetClipbrdData( pGlobal->hab, (ULONG) pszShared, CF_TEXT, CFI_POINTER )) {
                    WinEnableWindow( WinWindowFromID(hwnd, ID_CLEAR),  TRUE );
                    WinEnableWindow( WinWindowFromID(hwnd, ID_DELETE), TRUE );
                } else {
                    if ( ! WinLoadString( pGlobal->hab, 0, IDS_ERROR_COPYTEXT, SZRES_MAXZ-1, szRes ))
                        sprintf( szRes, "Error copying to clipboard.\n%s(): 0x%X");
                    sprintf( szError, szRes, "WinSetClipbrdData", WinGetLastError(pGlobal->hab) );
                    ErrorPopup( szError );
                }

            } else {
                if ( ! WinLoadString( pGlobal->hab, 0, IDS_ERROR_COPYTEXT, SZRES_MAXZ-1, szRes ))
                    sprintf( szRes, "Error copying to clipboard.\n%s(): 0x%X");
                sprintf( szError, szRes, "DosAllocSharedMem", ulRC );
                ErrorPopup( szError );
            }
        }

        // Copy as text/unicode (UCS-2)
        if ( pGlobal->fCopyUCS ) {
            if (( ulRC = DosAllocSharedMem( (PVOID) &psuShared, NULL,
                                            UniStrlen(pGlobal->psuCopied),
                                            PAG_WRITE | PAG_COMMIT | OBJ_GIVEABLE )) == NO_ERROR )
            {
                UniStrcpy( psuShared, pGlobal->psuCopied );
                if ( ! WinSetClipbrdData( pGlobal->hab, (ULONG) psuShared,
                                          pGlobal->cfUniText, CFI_POINTER ))
                {
                    if ( ! WinLoadString( pGlobal->hab, 0, IDS_ERROR_COPYUCS, SZRES_MAXZ-1, szRes ))
                        sprintf( szRes, "Error copying Unicode text.\n%s(): 0x%X");
                    sprintf( szError, szRes, "WinSetClipbrdData", WinGetLastError(pGlobal->hab) );
                    ErrorPopup( szError );
                }
            } else {
                if ( ! WinLoadString( pGlobal->hab, 0, IDS_ERROR_COPYUCS, SZRES_MAXZ-1, szRes ))
                    sprintf( szRes, "Error copying Unicode text.\n%s(): 0x%X");
                sprintf( szError, szRes, "DosAllocSharedMem", ulRC );
                ErrorPopup( szError );
            }
        }
        WinCloseClipbrd( pGlobal->hab );
    }
    free( pszCopy );

}


/* ------------------------------------------------------------------------- *
 * UpdateWindowSize                                                          *
 *                                                                           *
 * Resizes the character map controls to match the new application size.     *
 *                                                                           *
 * PARAMETERS:                                                               *
 *   HWND hwnd: Handle of the main program window                            *
 *   SHORT usW: New width of window                                          *
 *   SHORT usH: New height of window                                         *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void UpdateWindowSize( HWND hwnd, SHORT usW, SHORT usH )
{
    static USHORT usMBh, usTBh;     // Heights of menubar and titlebar
    HWND          hwndVS;           // Handle of the valueset control
    SWP           swp;
    POINTL        ptVS[ 2 ],        // Coordinates of the valueset control
                  ptW,              // Size of the main window workspace
                  ptMargin;


    hwndVS = WinWindowFromID( hwnd, IDD_CHARMAP );
    WinShowWindow( hwndVS, FALSE );

    WinQueryWindowPos( WinWindowFromID(hwnd, FID_MENU), &swp );
    if ( swp.cy > 0 ) usTBh = swp.cy;
    WinQueryWindowPos( WinWindowFromID(hwnd, FID_TITLEBAR), &swp );
    if ( swp.cy > 0 ) usMBh = swp.cy;

    WinQueryWindowPos( hwnd, &swp );
    ptW.x = swp.cx;
    ptW.y = swp.cy - usTBh - usMBh;
    WinQueryWindowPos( hwndVS, &swp );
    ptVS[0].x = swp.x;
    ptVS[0].y = swp.y;
    ptVS[1].x = swp.cx;
    ptVS[1].y = swp.cy;

    ptMargin.x = 3;
    ptMargin.y = 6;
    WinMapDlgPoints( hwnd, &ptMargin, 1, TRUE );
    ptVS[1].x = ptW.x - ptVS[0].x - ptMargin.x;
    ptVS[1].y = ptW.y - ptVS[0].y - ptMargin.y;

    WinSetWindowPos( hwndVS, 0L, ptVS[0].x, ptVS[0].y, ptVS[1].x, ptVS[1].y, SWP_SIZE | SWP_SHOW );

}


/* ------------------------------------------------------------------------- *
 * FixedCharWidth                                                            *
 *                                                                           *
 * This is used as a workaround for a GPI bug, where fixed-width fonts have  *
 * incorrect character increments drawn or queried with Gpi(Query)CharString *
 * under a Unicode codepage.  So in such a case we determine the width       *
 * manually ourselves.                                                       *
 *                                                                           *
 * There are two types of fixed-width font we have to deal with: "pure"      *
 * fixed-width fonts where each character truly shares the same increment    *
 * (except for special zero-width characters, or glyphs substituted in using *
 * the PM DBCS gluph-association feature); and fixed-width-plus-CJK fonts    *
 * which report as monospaced but which render CJK characters (and a few     *
 * others) at double-width.                                                  *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   Unichar     uc : The Unicode character (UCS-2 codepoint) to examine.    *
 *   FONTMETRICS fm : The current font metrics.                              *
 *                                                                           *
 * RETURNS: LONG                                                             *
 *   The calculated character increment (width).                             *
 * ------------------------------------------------------------------------- */
LONG FixedCharWidth( UniChar uc, FONTMETRICS fm )
{
    BOOL fHybridCJK;       // Is font a hybrid fixed-width/CJK font?

    fHybridCJK = fm.lMaxCharInc > fm.lAveCharWidth ? TRUE : FALSE;

    if ( uc < 0xFF )
        return ( fm.lAveCharWidth );
    else if ( fHybridCJK && IS_CJK_DOUBLEWIDTH( uc ))
        return fm.lMaxCharInc;
    else if ( IS_DOUBLEWIDTH( uc ))
        return fm.lAveCharWidth * 2;
    else if ( IS_ZEROWIDTH( uc ))
        return 0;
    else
        return ( fm.lAveCharWidth );
}


/* ------------------------------------------------------------------------- *
 * GetCodepagePath                                                           *
 *                                                                           *
 * Find the path where OS/2 keeps its installed codepage tables.  This is    *
 * the %ULSPATH%\CODEPAGE directory, which is normally \LANGUAGE\CODEPAGE on *
 * the boot volume.                                                          *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   PSZ pszCPath : Buffer to receive the path (must be allocated)       (O) *
 *   USHORT cb    : Length of pszCPath buffer                            (I) *
 *                                                                           *
 * RETURNS: N/A                                                              *
 * ------------------------------------------------------------------------- */
void GetCodepagePath( PSZ pszCPath, USHORT cb )
{
    PSZ     pszEnv;                     // returned environment variable
    ULONG   ul;
    APIRET  rc;

    // Get the path to the codepage files (e.g. ?:\LANGUAGE\CODEPAGE)
    if (( DosScanEnv("ULSPATH", &pszEnv ) == NO_ERROR ) && ( strlen(pszEnv) > 0 )) {
        strncpy( pszCPath, pszEnv, cb - 1 );
        ul = strlen( pszCPath ) - 1;
        if ( pszCPath[ ul ] == ';') pszCPath[ ul ] = '\0';
    }
    else {
        rc = DosQuerySysInfo( QSV_BOOT_DRIVE, QSV_BOOT_DRIVE, &ul, sizeof(ULONG) );
        if (( rc != NO_ERROR ) || ( ul > 26 ) || ( ul < 1 ))
            ul = 3;
        sprintf( pszCPath, "%c:\\LANGUAGE", 64 + ul );
    }
    strncat( pszCPath, "\\CODEPAGE", cb - 1 );
}


/* ------------------------------------------------------------------------- *
 * CodepageIsInstalled                                                       *
 *                                                                           *
 * Determine whether a given codepage is installed.  This is determined by   *
 * whether or not the file "IBM<codepage>" exists in the given directory.    *
 * This function does not check for aliases, so is not suitable for other    *
 * than standard IBM codepages.                                              *
 *                                                                           *
 * ARGUMENTS:                                                                *
 *   PSZ pszPath : The path to codepage files                            (I) *
 *   ULONG ulCP  : The codepage to search for                            (I) *
 *                                                                           *
 * RETURNS: BOOL                                                             *
 *   TRUE if the codepage file was found, FALSE otherwise.                   *
 * ------------------------------------------------------------------------- */
BOOL CodepageIsInstalled( PSZ pszPath, ULONG ulCP )
{
    FILEFINDBUF3 ffInfo = {0};          // file find info buffer
    HDIR   hdFind;                      // find operation handle
    CHAR   szCPMask[ CCHMAXPATH + 1 ];  // find mask for codepage files
    ULONG  flFindAttr,                  // find attributes
           ulCount;                     // number of codepages queried
    APIRET rc;

    // Now check for the installed codepage file
    sprintf( szCPMask, "%s\\IBM%u", pszPath, ulCP );
    hdFind = HDIR_SYSTEM;
    flFindAttr = FILE_NORMAL | FILE_SYSTEM | FILE_HIDDEN | FILE_READONLY;
    ulCount = 1;
    rc = DosFindFirst( szCPMask, &hdFind, flFindAttr, &ffInfo,
                       sizeof(ffInfo), &ulCount, FIL_STANDARD );
    DosFindClose( hdFind );
    return (( rc == NO_ERROR ) && ulCount ) ? TRUE : FALSE;
}


/* ------------------------------------------------------------------------- *
 * AboutDlgProc                                                              *
 *                                                                           *
 * Dialog procedure for the product information dialog.                      *
 * ------------------------------------------------------------------------- */
MRESULT EXPENTRY AboutDlgProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
    HAB  hab;
    CHAR szBuffer[ SZRES_MAXZ ],
         szText[ SZRES_MAXZ ];

    switch ( msg ) {

        case WM_INITDLG:
            hab = WinQueryAnchorBlock( hwnd );
            if ( WinLoadString( hab, 0, IDS_VERSION, SZRES_MAXZ-1, szBuffer ))
                sprintf( szText, szBuffer, SZ_VERSION );
            else
                sprintf( szText, "V%s", SZ_VERSION );
            WinSetDlgItemText( hwnd, IDD_VERSION, szText );

            if ( WinLoadString( hab, 0, IDS_COPYRIGHT, SZRES_MAXZ-1, szBuffer ))
                sprintf( szText, szBuffer, SZ_COPYRIGHT );
            else
                sprintf( szText, "(C) %s", SZ_COPYRIGHT );
            WinSetDlgItemText( hwnd, IDD_COPYRIGHT, szText );

            CentreWindow( hwnd );
            break;

        default: break;
    }

    return WinDefDlgProc( hwnd, msg, mp1, mp2 );
}

