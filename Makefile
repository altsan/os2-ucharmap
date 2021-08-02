# IBM C/C++ (VisualAge) Makefile for DBCSMAP, English version.
#
# To compile other languages, change 'NLV' (below) to the appropriate country
# code.  That NLV directory must exist and must have the correct language files.
#

!ifndef NLV
    NLV = 001
!endif

CC     = icc.exe
RC     = rc16.exe
LINK   = ilink.exe
IPFC   = ipfc.exe
CFLAGS = /Gm /Ss /Q+ /Wuse      # /Wrea /Wuni
RFLAGS = -n -cc $(NLV)
LFLAGS = /NOE /PMTYPE:PM /NOLOGO /MAP
NAME   = dbcsmap
OBJS   = $(NAME).obj
MRI    = resource
LIBS   = libconv.lib libuls.lib

BL_DESC = "Extended Character Map (ctry $(NLV))"
BL_AUTH = "Alexander Taylor"

!ifdef NLV
    LANGDIR  = $(NLV)
!   if "$(NLV)" == "007"
       LANGCODE = RUS
!   elif "$(NLV)" == "031"
       LANGCODE = NLD
!   elif "$(NLV)" == "033"
       LANGCODE = FRA
!   elif "$(NLV)" == "034"
       LANGCODE = ESP
!   elif "$(NLV)" == "039"
       LANGCODE = ITA
!   elif "$(NLV)" == "046"
       LANGCODE = SVE
!   elif "$(NLV)" == "049"
       LANGCODE = DEU
!   elif "$(NLV)" == "055"
       LANGCODE = PTB
!   elif "$(NLV)" == "081"
       LANGCODE = JPN
       RFLAGS = $(RFLAGS) -cp 932
!   elif "$(NLV)" == "082"
       LANGCODE = KOR
       RFLAGS = $(RFLAGS) -cp 949
!   elif "$(NLV)" == "086"
       LANGCODE = PRC
       RFLAGS = $(RFLAGS) -cp 1386
!   elif "$(NLV)" == "088"
       LANGCODE = CHT
       RFLAGS = $(RFLAGS) -cp 950
!   else
       LANGCODE = ENU
!   endif
    IPFFLAGS = -d:$(LANGDIR) -l:$(LANGCODE)
!else
    LANGDIR = 001
    IPFFLAGS = -d:$(LANGDIR)
!endif

!ifdef DEBUG
    CFLAGS   = $(CFLAGS) /Ti /Tm
    LFLAGS   = $(LFLAGS) /DEBUG
!endif

all         : $(NAME).exe $(NAME).hlp

$(NAME).exe : $(OBJS) $(NAME).h $(MRI).h $(MRI).res Makefile
                -@makedesc.cmd -D$(BL_DESC) -N$(BL_AUTH) -V"^#define=SZ_VERSION,$(NAME).h" $(NAME).def
                $(LINK) $(LFLAGS) $(OBJS) $(LIBS) $(NAME).def
                $(RC) -x -n $(MRI).res $@

$(MRI).res  : {$(NLV)}$(MRI).rc {$(NLV)}$(MRI).dlg $(MRI).h
                %cd $(NLV)
                $(RC) -i .. -r $(RFLAGS) $(MRI).rc ..\$@
                %cd ..

$(NAME).hlp : {$(NLV)}$(NAME).ipf
                %cd $(NLV)
                $(IPFC) -d:$(NLV) $(NAME).ipf ..\$@
                %cd ..

clean       :
                del $(OBJS) $(MRI).res $(NAME).exe $(NAME).hlp >NUL

