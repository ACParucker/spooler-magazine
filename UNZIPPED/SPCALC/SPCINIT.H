#if !defined (__WINDOWSX_H)
#include <Windowsx.h>
#endif

#if !defined (__ASSERT_H)
#include <Assert.h>
#endif

#if !defined (__STDLIB_H)
#include <StdLib.h>
#endif

#if !defined (__STDIO_H)
#include <Stdio.h>
#endif

#if !defined (__CTYPE_H)
#include <Ctype.h>
#endif

#if !defined (__STRING_H)
#include <String.h>
#endif

#if !defined (__MATH_H)
#include <Math.h>
#endif

#if !defined (__NEW_H)
#include <New.h>
#endif

#if !defined (__SPCINIT_H)
#define __SPCINIT_H


const int IDD_VISOR = 100;
const int DIGITS =    10;

const WPARAM CTRL_TOP =  101;
const WPARAM CTRL_POS =  102;
const WPARAM CTRL_P1 =   104;
const WPARAM CTRL_P2 =   105;
const WPARAM CTRL_P3 =   106;
const WPARAM CTRL_P4 =   107;
const WPARAM CTRL_P5 =   108;
const WPARAM CTRL_CLI =  110;

#define SC_USER (0xF000-1)
const UINT SC_PREF =  SC_USER-1;
const UINT SC_AUTOR = SC_USER-2;


typedef  struct tagPrivIniData
	{
	UINT topposition;
	UINT position;
	UINT xpos;
	UINT ypos;
	UINT pattern;
	UINT clique;
	} PrivIniData;

typedef struct tagSTATUSDATA
	{
	WORD wCode;
	char achMsg[20];
	} STATUSDATA;

typedef struct WindowAttr
	{
	LPCSTR lpszClassName;
	LPCSTR lpszWindowName;
	DWORD dwStyle;
	int x;
	int y;
	int dx;
	int dy;
	HWND hwndParent;
	HMENU Menu;
	HINSTANCE hinstance;
	void FAR *lpvParam;
	};

void trap_alloc(void);
void changeSysMenu(HWND hwnd, UINT nToChange, BOOL addItems);
void bigProblem(HWND parent, LPCSTR problem);
void updatePos(HWND hwnd);
void updatePosOnTop(HWND hwnd);

class WinBase {

protected:

	static HINSTANCE hInstance;
	static HINSTANCE hPrevInstance;
	static LPSTR     lpszCmdLine;
	static int       nCmdShow;
	static LPSTR     lpszName;
	static LPSTR     lpszNameChild;

	WinBase(){}
	WinBase(HINSTANCE,
		HINSTANCE,
		LPSTR    ,
		int     );

	virtual WORD run()=0;
	HWND hWnd() {return hWindow;}

	HWND hWindow;
};


class Window : public WinBase {

public:

	virtual WORD run();

protected:

	Window(HWND){}

	Window(HINSTANCE ,
	       HINSTANCE ,
	       LPSTR , 
	       int );

	~Window();

private:

	static Window *winList;
	Window *nextWin;

protected:

	WindowAttr WinAttr;
	WNDCLASS ClassAttr;

	virtual void registerClass()
		{if(! ::RegisterClass(&ClassAttr)) exit(FALSE);}

	virtual void createWindow(HWND=0);

	static Window *inCreate;

	void insert() {
		nextWin = winList;
		winList = this;
		  }

	virtual void MainSysMenu();
				
	static LRESULT CALLBACK _export wndProc (HWND, UINT, WPARAM, LPARAM);

	virtual LONG dispatch(UINT msg, WPARAM wParam, LPARAM lParam)
			{
			return ::DefWindowProc((HWND) hWnd(),
			msg,
			wParam,
			lParam);                
			}
};

class MainWindow : public Window {

public:

	MainWindow(HINSTANCE,
		   HINSTANCE,
		   LPSTR, 
		   int  );

protected:

	virtual LONG dispatch (WPARAM, WPARAM, LPARAM);

private:

	char  npstrNumber[DIGITS + 1];
	BOOL  bNewNumber;
	BOOL  bDispFull;
	BOOL  bNegative;
	BOOL  ovFlow;
	BOOL  ovMemFlow;
	int   nOperation;
	double firstOperand;

	char npstrMemNumber[DIGITS + 1];
	BOOL bMemNegative;

	BOOL processCommand(WPARAM);
	void registerClass();
	void createDlg();

	void putNumbers(NPSTR);
	void firstFigure();
	void initAll();
	void allClear();
	WPARAM validOp(WPARAM);
	NPSTR calcHandler(NPSTR, int );
	BOOL calcNumber (char npstrNb[], BOOL bDisp, double op);
	BOOL repError(char npstrNber[], BOOL bDisp);
	int min(int value1, int value2) {return ( (value1 < value2) ? value1 : value2);}
	void insertKey(WPARAM wP);
	void aboutBox();
	void prefBox();
	void readIniFile();

};


class ModalDialog : public WinBase
{
public:

	ModalDialog(HWND);

	~ModalDialog() {
		assert(curDlg != 0);
		curDlg=0;
		}

	virtual WORD run();

protected:

	virtual BOOL dispatch (HWND, UINT, WPARAM, LPARAM)
	{return FALSE;}

	WORD result;

private:

	virtual LPCSTR getDialogName()=0;

	static BOOL CALLBACK _export dlgProc(HWND, UINT, WPARAM, LPARAM);

	static ModalDialog *curDlg;
};

class TAboutWindow;

class AboutBox:public ModalDialog
{
public:
	
	AboutBox(HWND);
	void InitAboutWindow(HWND, LPCSTR );
	TAboutWindow *AboutWindow;

private:

	virtual LPCSTR getDialogName();

	virtual BOOL dispatch(HWND, UINT, WPARAM, LPARAM);
};


inline ModalDialog::ModalDialog(HWND hOwner) : result (0)
{
	assert(curDlg == 0);
	curDlg=this;
	hWindow=hOwner;
}

inline AboutBox::AboutBox(HWND hOwner): ModalDialog(hOwner)
{
}

class TAboutWindow : public Window {

	friend class AboutBox;
	HBITMAP Bitmap;
	BITMAP BitSize;
	static int prevreg;

	TAboutWindow (HWND AParent, LPCSTR ABitmapName);

	~TAboutWindow() {DeleteBitmap(Bitmap);}

	virtual LONG dispatch (WPARAM, WPARAM, LPARAM);
	void DrawBitmap(HDC, int, int, HBITMAP);

	void createWindow(HWND);
	void registerClass();

};

class PrefBox:public ModalDialog
{

public:

	PrefBox(HWND);

private:

	virtual LPCSTR getDialogName();

	virtual BOOL dispatch(HWND, UINT, WPARAM, LPARAM);
};

inline PrefBox::PrefBox(HWND hOwner): ModalDialog(hOwner)
{
}

#endif // __SPCINIT_H
