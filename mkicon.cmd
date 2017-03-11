/* MKICON.CMD for DBCSMAP */
CALL RxFuncAdd 'SysLoadFuncs', 'REXXUTIL', 'SysLoadFuncs'
CALL SysLoadFuncs

exename = 'DBCSMAP.EXE'

PARSE SOURCE . . me
mydir = FILESPEC('DRIVE', me ) || FILESPEC('PATH', me )
map_exe = STREAM( mydir'\'exename, 'C', 'QUERY EXISTS')
IF map_exe == '' THEN
    map_exe = SysSearchPath('PATH', exename )

IF map_exe == '' THEN DO
    SAY 'Cannot create desktop object - unable to locate' exename'.'
    RETURN 1
END
SAY

SAY 'Ready to create/update desktop object for:' map_exe
CALL CHAROUT, 'Continue (Y/n)? '
opt = TRANSLATE( SysGetKey() )
SAY

IF opt == 'N' THEN DO
    SAY 'Cancelled.'
    RETURN 0
END

ok = SysCreateObject('WPProgram', 'Extended Character Map', '<WP_DESKTOP>', 'EXENAME='map_exe';OBJECTID=<WP_XCMAP>;', 'U')
IF ok == 0 THEN
    SAY 'Object creation failed!'
ELSE
    SAY 'Object created successfully.'

RETURN 0
