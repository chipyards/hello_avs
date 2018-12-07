/*
gcc -Wall -c vis_my.C
g++ -mdll -o vis_my.dll vis_my.o -lgdi32
N.B. si on met gcc au lieu de g++ au link, on a "undefined reference to `__gxx_personality_v0'"
g++ -shared -o vis_my.dll -s -Wl,--output-def=vis_my.def -Wl,--out-implib=vis_my.a -Wl,--dll vis_my.o -lgdi32

selon codeblocks 2018
mingw32-gcc.exe -Wall -O2 -c vis_my.c
mingw32-g++.exe -shared -Wl,--output-def=libvis_my.def -Wl,--out-implib=libvis_my.a -Wl,--dll vis_my.o -o vis_my.dll -s -lgdi32 -luser32

finalement :
gcc -Wall -fno-exceptions -c vis_my.c
gcc -shared -Wl,--dll vis_my.o -o vis_my.dll -lgdi32

*/

#include <windows.h>
#include <stdio.h>
#include <time.h>
#include "vis_my.h"

char szAppName[] = "JLNvisu"; // Our window class, etc

// mesure FPS toutes les 20s
time_t old_time = 0;
int rendercnt = 0;
int fps = 0;

void profilux()
{
time_t t = time( NULL );
++rendercnt;
if	( t >= ( old_time + 20 ) )
	{
	old_time = t;
	fps = rendercnt / 20;
	rendercnt = 0;
	}
}

// configuration declarations
int config_x=50, config_y=50;   // screen X position and Y position, respectively

// le point d'entree
// (obligatoire pour LoadLibrary, facultatif pour LoadLibraryEx)
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void* lpReserved)
{ return 1; }

// version codeblocks moderne
__declspec( dllexport ) BOOL APIENTRY DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{ return TRUE; }

// returns a winampVisModule when requested. Used in hdr, below
winampVisModule *getModule(int which);

// "member" functions
void config(struct winampVisModule *this_mod); // configuration dialog
int init(struct winampVisModule *this_mod);        // initialization for module
int render1(struct winampVisModule *this_mod);  // rendering for module 1
int render2(struct winampVisModule *this_mod);  // rendering for module 2
int render3(struct winampVisModule *this_mod);  // rendering for module 3
void quit(struct winampVisModule *this_mod);   // deinitialization for module

// our window procedure
LRESULT CALLBACK WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
HWND hMainWnd; // main window handle

// colors
HPEN noir, rouge, vert;
HBRUSH Rouge, Vert;

// Module header, includes version, description, and address of the module retriever function
winampVisHeader hdr = { VIS_HDRVER, "JLNsoft Visualization v66.67", getModule };

// first module (oscilliscope)
winampVisModule mod1 =
{
        "JLNscope",
        NULL,   // hwndParent
        NULL,   // hDllInstance
        0,              // sRate
        0,              // nCh
        0,             // latencyMS
        0,             // delayMS
        0,              // spectrumNch
        2,              // waveformNch
        { {0, }, }, // spectrumData
        { {0, }, }, // waveformData
        config,
        init,
        render1,
        quit
};

// second module (spectrum analyser)
winampVisModule mod2 =
{
        "Spectrum JLNyser",
        NULL,   // hwndParent
        NULL,   // hDllInstance
        0,              // sRate
        0,              // nCh
        0,             // latencyMS
        0,             // delayMS
        2,              // spectrumNch
        0,              // waveformNch
        { {0, }, }, // spectrumData
        { {0, }, }, // waveformData
        config,
        init,
        render2,
        quit
};

// third module (VU meter)
winampVisModule mod3 =
{
        "VU Meter",
        NULL,   // hwndParent
        NULL,   // hDllInstance
        0,              // sRate
        0,              // nCh
        0,             // latencyMS
        0,             // delayMS
        0,              // spectrumNch
        2,              // waveformNch
        { {0, }, }, // spectrumData
        { {0, }, }, // waveformData
        config,
        init,
        render3,
        quit
};


// this is the only exported symbol. returns our main header.

__declspec( dllexport ) winampVisHeader *winampVisGetHeader()
{
        return &hdr;
}


// getmodule routine from the main header. Returns NULL if an invalid module was requested,
// otherwise returns either mod1, mod2 or mod3 depending on 'which'.
winampVisModule *getModule(int which)
{
        switch (which)
        {
                case 0: return &mod1;
                case 1: return &mod2;
                case 2: return &mod3;
                default:return NULL;
        }
}

// configuration. Passed this_mod, as a "this" parameter. Allows you to make one configuration
// function that shares code for all your modules (you don't HAVE to use it though, you can make
// config1(), config2(), etc...)
void config(struct winampVisModule *this_mod)
{
char lbuf[256];
winampVisModule * m = this_mod;

snprintf( lbuf, sizeof(lbuf), " sRate=%d nCh=%d\n latencyMS=%d\n delayMS=%d\n this_mod=%08x, mod1=%08x\n fps=%u\n",
	  m->sRate, m->nCh, m->latencyMs, m->delayMs, (unsigned int)this_mod, (unsigned int)&mod1, fps );

MessageBox( this_mod->hwndParent, lbuf, "Configuration", MB_OK );
}

// initialization. Registers our window class, creates our window, etc. Again, this one works for
// both modules, but you could make init1() and init2()...
// returns 0 on success, 1 on failure.
int init(struct winampVisModule *this_mod)
{
        int width = (this_mod == &mod3)?256:576; // width and height are the same for mod1 and mod2,
        int height = (this_mod == &mod3)?32:512; // but mod3 is shaped differently
        config_x=50, config_y=50;

        {       // Register our window class
                WNDCLASS wc;
                memset(&wc,0,sizeof(wc));
                wc.lpfnWndProc = WndProc;                               // our window procedure
                wc.hInstance = this_mod->hDllInstance;  // hInstance of DLL
                wc.lpszClassName = szAppName;                   // our window class name
                wc.hbrBackground = (HBRUSH)GetStockObject( LTGRAY_BRUSH );

                if (!RegisterClass(&wc))
                {
                        MessageBox(this_mod->hwndParent,"Error registering window class","blah",MB_OK);
                        return 1;
                }
        }


        hMainWnd = CreateWindowEx(
                WS_EX_TOOLWINDOW|WS_EX_APPWINDOW,       // these exstyles put a nice small frame,
                                             // but also a button in the taskbar
                szAppName,                   // our window class name
                this_mod->description,       // use description for a window title
                WS_VISIBLE|WS_SYSMENU,       // make the window visible with a close button
                config_x,config_y,           // screen position
                width,height,                // width & height of window (need to adjust client area later)
                this_mod->hwndParent,        // parent window (winamp main window)
                NULL,                        // no menu
                this_mod->hDllInstance,      // hInstance of DLL
                0);                          // no window creation data

        if (!hMainWnd)
        {
                MessageBox(this_mod->hwndParent,"Error creating window","blah",MB_OK);
                return 1;
        }


        SetWindowLong(hMainWnd,GWL_USERDATA,(LONG)this_mod); // set our user data to a "this" pointer

        {       // adjust size of window to make the client area exactly width x height
                RECT r;
                GetClientRect(hMainWnd,&r);
                SetWindowPos(hMainWnd,0,0,0,width*2-r.right,height*2-r.bottom,SWP_NOMOVE|SWP_NOZORDER);
        }

        noir = CreatePen( PS_SOLID, 1, 0 );
        rouge = CreatePen( PS_SOLID, 1, 255 );
        vert = CreatePen( PS_SOLID, 1, 255 << 8 );
        Rouge = CreateSolidBrush( 155 );
        Vert = CreateSolidBrush( 155 << 8 );

        // show the window
        ShowWindow(hMainWnd,SW_SHOWNORMAL);
        return 0;
}

// render function for oscilliscope. Returns 0 if successful, 1 if visualization should end.
int render1(struct winampVisModule *this_mod)
{
        int x, y, yy;  HDC memDC;
        memDC = GetDC(hMainWnd);

	profilux();

        SelectObject( memDC, noir );
        SelectObject( memDC, GetStockObject( BLACK_BRUSH ) );
        // clear background
        Rectangle(memDC,0,0,576,512);
        // draw oscilliscope
        for (y = 0; y < 2; y ++)
            {
                SelectObject( memDC, (y)?(vert):(rouge) );
                yy = y * 256 + 128;
                MoveToEx( memDC, 0, yy, NULL );
                for (x = 0; x < 576; x ++)
                     LineTo( memDC, x, ( yy + this_mod->waveformData[y][x] )  );
            }
        { // copy doublebuffer to window
                //HDC hdc = GetDC(hMainWnd);
                //BitBlt(hdc,0,0,288,256,memDC,0,0,SRCCOPY);
                //ReleaseDC(hMainWnd,hdc);
                ReleaseDC(hMainWnd,memDC);
        }
        return 0;
}

// render function for analyser. Returns 0 if successful, 1 if visualization should end.
int render2(struct winampVisModule *this_mod)
{
        int x, y, yy; HDC memDC;
        memDC = GetDC(hMainWnd);

	profilux();

        SelectObject( memDC, noir );
        SelectObject( memDC, GetStockObject( BLACK_BRUSH ) );
        // clear background
        Rectangle(memDC,0,0,576,512);
        // draw analyser
        for (y = 0; y < 2; y ++)
        {
                SelectObject( memDC, (y)?(vert):(rouge) );
                yy = y*256+254;
                for (x = 0; x < 576; x ++)
                {
                MoveToEx( memDC, x, yy, NULL);
                LineTo( memDC, x, ( yy - this_mod->spectrumData[y][x] ) );
                }
        }
        ReleaseDC(hMainWnd,memDC);
        return 0;
}

// render function for VU meter. Returns 0 if successful, 1 if visualization should end.
int render3(struct winampVisModule *this_mod)
{
        int x, y; HDC memDC;
        memDC = GetDC(hMainWnd);

	profilux();

        SelectObject( memDC, noir );
        SelectObject( memDC, GetStockObject( BLACK_BRUSH ) );
        // clear background
        Rectangle(memDC,0,0,256,32);
        // draw VU meter
        for (y = 0; y < 2; y ++)
        {
                int last=this_mod->waveformData[y][0];
                int total=0;
                for (x = 1; x < 576; x ++)
                {
                        total += abs(last - this_mod->waveformData[y][x]);
                        last = this_mod->waveformData[y][x];
                }
                total /= 288;
                if (total > 127) total = 127;
                SelectObject( memDC, (y)?(vert):(rouge) );
                SelectObject( memDC, (y)?(Vert):(Rouge) );
                if (y) Rectangle(memDC,128,1,128+total,31);
                else Rectangle(memDC,128-total,1,128,31);
        }
        ReleaseDC(hMainWnd,memDC);
        return 0;
}

// cleanup (opposite of init()). Destroys the window, unregisters the window class
void quit(struct winampVisModule *this_mod)
{
        DestroyWindow(hMainWnd); // delete our window
        UnregisterClass(szAppName,this_mod->hDllInstance); // unregister window class
}


// window procedure for our window
LRESULT CALLBACK WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
        switch (message)
        {
                case WM_CREATE:         return 0;
                case WM_ERASEBKGND: return 0;
                case WM_PAINT:
                        { // update from doublebuffer
                                PAINTSTRUCT ps;
                                RECT r;
                                // HDC hdc = BeginPaint(hwnd,&ps);
                                BeginPaint(hwnd,&ps);
                                GetClientRect(hwnd,&r);
                                // BitBlt(hdc,0,0,r.right,r.bottom,memDC,0,0,SRCCOPY);
                                EndPaint(hwnd,&ps);
                        }
                return 0;
                case WM_DESTROY: PostQuitMessage(0); return 0;
                case WM_KEYDOWN: // pass keyboard messages to main winamp window (for processing)
                case WM_KEYUP:
                        {       // get this_mod from our window's user data
                                winampVisModule *this_mod = (winampVisModule *) GetWindowLong(hwnd,GWL_USERDATA);
                                PostMessage(this_mod->hwndParent,message,wParam,lParam);
                        }
                return 0;
                case WM_MOVE:
                return 0;
        }
        return DefWindowProc(hwnd,message,wParam,lParam);
}

