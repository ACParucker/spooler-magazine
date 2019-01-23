
#define FALSE 0
#define TRUE 1

// Fun‡”es e vari veis definidas nos m¢dulos em linguagem Assembly

extern void near protectentry (void);
extern int  near check386 (void);
extern int near IsProtectedMode (void);
extern near void fakemem(void);
extern int near Is_Himem (void);
extern int near Is_Cache (void);
extern int near Is_DPMI (void);
extern int near OldDos (void);
extern unsigned long no_of_instrs;
extern unsigned int tracecounter;
extern unsigned int tracebuffer_cs[32];
extern unsigned int tracebuffer_ip[32];
extern char trace_status;
extern unsigned long stackbytesbelow;
extern char pageerrorok;
extern unsigned long  pageerror;
extern unsigned char hmaflag;
extern unsigned char virtualbox;
extern unsigned char erro;
extern unsigned char code_erro;
extern unsigned long VideoSegment;
extern unsigned char himap[96];
extern unsigned char stackbytes[32];
extern unsigned char virtstack[16];
extern char stackerrorok;
extern unsigned long stackerror;
extern unsigned long stackeip;
extern unsigned stackcs;
extern unsigned long stackflags;
extern unsigned long stackesp;
extern unsigned stackss;
extern unsigned stackes;
extern unsigned stackds;
extern unsigned stackfs;
extern unsigned stackgs;
extern char stackvirt;

// Vari vel global acedida externamente

unsigned long ReportVirtExtended;

// Prot¢tipos das fun‡”es utilizadas neste m¢dulo

void  CheckVideoType(void);
void SayHelloRealWorld(void);
void ReportError(void);
void CommdLine(char *args[]);
unsigned ExtMem(void);
void CalcVirtMem(unsigned long extmem);

char *diskcache[]= { "Smartdrive/Ncache/Pc-cache",
		     "Hyperdisk",
		     "Qcache/Pc-Kwick",
		     "Pc-cache"
		    };

