// version "run-time linking", la plus soft
/* compilation sous VC6
     cl hello_rtl.c
   l'exe cherche la dll dans les chemins standard
     dumpbin /imports hello_rtl.exe : rien
   compilation sous minGW
     gcc -Wall -o hello.exe hello_rtl.c
 */
#include <windows.h>
#include <winbase.h>
#include <stdio.h>
#include "winamp_vis.h"


int main( int argc, char ** argv )
{
HINSTANCE libHandle;
const char * dllname = "vis_jln.dll";
const char * mainfuncname = "winampVisGetHeader";
winampVisGetHeaderType exportedfunc;
winampVisHeader * plugin_head;
winampVisModule * module;

if   ( argc > 1 )
     dllname = argv[1]; 

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

module->hwndParent   = NULL;
module->hDllInstance = libHandle;
module->sRate = 44100;
module->nCh = 2;

module->Init( module );
module->Render( module );
// module->Config( module );

fflush(stdout);
fflush(stdin);

while   ( getchar() != 'q' )
	{}

module->Quit( module );

return 0;
}
