#include <windows.h>
#include <stdio.h>
#include "winamp_vis.h"
#include "portaudio.h"
#include "audio.h"
#include "host.h"

/* portaudio : de quoi a-t-on besoin pour compiler nos applis ?
	le gros package Appli\portaudio, qu'on a compile a l'aide de configure et make (referençant ASIO sdk)
		- headers : F:\Appli\portaudio\include
		- library path : F:\Appli\portaudio\lib\.libs
		- library : portaudio i.e. libportaudio.a (512k), winmm, ole32 qui sont utilisees par portaudio
*/

// essential static storage
static glostru theglo;
static winampVisModule * module;

// #define PROFILUX

#ifdef PROFILUX
// mesure FPS toutes les 10s
#include <time.h>
static time_t old_time = 0;
static int rendercnt = 0;
static int fps = 0;

void profilux()
{
time_t t = time( NULL );
++rendercnt;
if	( t >= ( old_time + 10 ) )
	{
	old_time = t;
	fps = rendercnt / 10;
	printf("fps=%d\n", fps );
	rendercnt = 0;
	}
}
#endif

// timer callback
void CALLBACK timer_call( HWND hwnd, UINT message, UINT iTimerID, DWORD dwTime )
// TIMERPROC timer_call( HWND hwnd, UINT message, UINT iTimerID, DWORD dwTime )
{
// copier les data audio -  N.B. 576 = the hard coded winamp buffer size !
unsigned int istart, iend, qsamp1, id, is;
iend = theglo.ringWi & QRING_MASK;
if	( iend >= 576 )				// le cas simple
	{
	istart = iend - 576;
	is = istart;
	for	( id = 0; id < 576; ++id )
		{
		module->waveformData[0][id] = (signed char)( theglo.ringL[is] >> 8 );
		module->waveformData[1][id] = (signed char)( theglo.ringR[is] >> 8 );
		++is;
		}
	}
else	{					// le cas ou on a boucle dans le ring buffer
	istart = QRING + iend - 576;
	// premiere partie : lire de istart a la fin du ring
	qsamp1 =  QRING - istart;	// =  576 - iend
	is = istart;
	for	( id = 0; id < qsamp1; ++id )
		{
		module->waveformData[0][id] = (signed char)( theglo.ringL[is] >> 8 );
		module->waveformData[1][id] = (signed char)( theglo.ringR[is] >> 8 );
		++is;
		}
	// seconde partie : lire du debut du ring a iend
	is = 0;
	for	( id = qsamp1; id < 576; ++id )
		{
		module->waveformData[0][id] = (signed char)( theglo.ringL[is] >> 8 );
		module->waveformData[1][id] = (signed char)( theglo.ringR[is] >> 8 );
		++is;
		}
	}
module->Render( module );
#ifdef PROFILUX
profilux();
#endif
}

int main_start( HWND myhand, const char * args )
{
HINSTANCE libHandle;
const char * dllname = "vis_avs.dll";
const char * mainfuncname = "winampVisGetHeader";
winampVisGetHeaderType exportedfunc;
winampVisHeader * plugin_head;
glostru * glo = &theglo;
int input_device = -1;

printf("args = %s\n", args );
if	( args[0] == 'v' )		// ici un hack debile pour les arguments
	dllname = args;
else if	( ( args[0] >= '0' ) && ( args[0] <= '9' ) )
	{
	input_device = atoi( args );
	if	( args[1] == 'v' )
		dllname = args+1;
	}

libHandle = LoadLibrary( dllname );
if ( libHandle == NULL )
   {
   printf("loading %s failed\n", dllname );
   return 1;
   }
printf("loaded %s ok\n", dllname );

exportedfunc = (winampVisGetHeaderType)GetProcAddress( libHandle, mainfuncname );
if ( exportedfunc == NULL )
   {
   printf("getting %s address failed\n", mainfuncname );
   return 1;
   }

plugin_head = exportedfunc();
if ( plugin_head == NULL )
   {
   printf("getting plugin_head failed\n" );
   return 1;
   }

printf("plugin is %s version %x\n", plugin_head->description, plugin_head->version );

int i = 0;
do	{
	module = plugin_head->getModule(i);
	if	( module )
		{
		printf("module %d : %s\n", i, module->description );
		++i;
		}
	} while ( module );

module = plugin_head->getModule(0);
if	( !module )
	return 1;

printf(" sRate=%d\n nCh=%d\n latencyMs=%d\n delayMs=%d\n spectrumNch=%d\n waveformNch=%d\n",
module->sRate, module->nCh, module->latencyMs, module->delayMs, module->spectrumNch, module->waveformNch );

if	( audio_io_start( glo, ( input_device == 5 )?0.020:0.090, input_device, -1, 0 ) )
	{ printf("audio start failed\n"); return 2; }

printf("audio i/o started\n");


module->hwndParent   = myhand;
module->hDllInstance = libHandle;
module->sRate = CODEC_FREQ;
module->nCh = CODEC_QCHAN;

module->Init( module );

SetTimer( myhand, 666, module->latencyMs + module->delayMs, timer_call );
printf("render timer started @ %ums\n", module->latencyMs + module->delayMs );

// module->Render( module );
// module->Config( module );

return 0;
}

void main_end()
{
printf("closing\n");
audio_io_stop( &theglo );
}


