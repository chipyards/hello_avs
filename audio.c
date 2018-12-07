#include <stdio.h>
#include "portaudio.h"
#include "pa_devs.h"
#include "audio.h"

/** ============================ PLAY with portaudio ======================= */

// ---- portaudio callback vs codec stereo --------
// It may called at interrupt level on some machines so don't do anything
// that could mess up the system like calling malloc() or free().
static int portaudio_call( const void *inbuf, void *outbuf,
			unsigned long framesPerBuffer,
			const PaStreamCallbackTimeInfo* time_info,
			PaStreamCallbackFlags status_flags,
			// void *userData
			glostru * glo )
{
unsigned int i, iend;
iend = framesPerBuffer * CODEC_QCHAN;
if	( inbuf )    // This may get called with NULL inputBuffer during initial setup.
	{
	for	( i = 0; i < iend; i+= CODEC_QCHAN )
		{
		glo->ringL[QRING_MASK&glo->ringWi] = ((short *)inbuf)[i];
		glo->ringR[QRING_MASK&glo->ringWi] = ((short *)inbuf)[i+1];
		++glo->ringWi;
		}
	}
++glo->pa_blk_cnt;
return 0;
}

// demarrer le stream audio, rend 0 si ok
int audio_io_start( glostru * glo, double mylatency, int indevice, int outdevice, int pa_dev_options )
{
PaError err;
glo->ringWi = 0;
glo->pa_blk_cnt = 0;

// Initialize library before making any other calls.
err = Pa_Initialize();
if	( err != paNoError )
	{ Pa_Terminate(); return 1; }	// gasp("Error PA : %d : %s", err, Pa_GetErrorText( err ) );

// printf("nombre de devices : %d\n", Pa_GetDeviceCount() );

// Open an audio I/O stream.
// "For an example of enumerating devices and printing information about their capabilities
//  see the pa_devs.c program in the test directory of the PortAudio distribution."
// "On the PC, the user can specify a default device by setting an environment variable. For example, to use device #1.
//  set PA_RECOMMENDED_OUTPUT_DEVICE=1
//  The user should first determine the available device ids by using the supplied application "pa_devs"."

PaStreamParameters papai;
if	( indevice < 0 )
	{
	print_pa_devices( pa_dev_options );
	papai.device = Pa_GetDefaultInputDevice();	// un device index au sens de PA (all host APIs merged)
	}
else 	papai.device = indevice;

papai.channelCount = CODEC_QCHAN;    	// JAW uses always stereo output, best portability
papai.sampleFormat = paInt16;		// 16 bits, same reason
papai.suggestedLatency = mylatency;	// in seconds
papai.hostApiSpecificStreamInfo = NULL;

printf("open input device #%d\n", indevice );
err = Pa_OpenStream(	&glo->stream,
			&papai,			// input channels
			NULL,			// no output channel
                        (double)CODEC_FREQ,	// sample frequ
			FRAMES_PER_BUFFER,	// 256 <==> 5.8 ms i.e. 172.265625 buffers/s */
			paClipOff,		// bof, sais pas s'il gere vraiment le clip en mode 16 bits
			// cette usine a gaz c'est parceque notre callback prend un glostru* au lieu de void*
                        (int (*)(const void *, void *, unsigned long, const PaStreamCallbackTimeInfo*,
				 PaStreamCallbackFlags, void *))portaudio_call,
                        glo );
if	( err != paNoError )
	{ Pa_Terminate(); return 2; }	// gasp("Error PA : %d : %s", err, Pa_GetErrorText( err ) );

const PaStreamInfo* PaInfo = Pa_GetStreamInfo( glo->stream );
if	( PaInfo == NULL )
	{ Pa_Terminate(); return 3; }	// gasp("NULL PaStreamInfo");
printf("input  latency : %g vs %g s\n", PaInfo->inputLatency, mylatency );

err = Pa_StartStream( glo->stream );
if	( err != paNoError )
	{ Pa_Terminate(); return 4; }	// gasp("Error PA : %d : %s", err, Pa_GetErrorText( err ) );
return 0;
}

// arreter le stream audio full-duplex
void audio_io_stop( glostru * glo )
{
Pa_StopStream( glo->stream );
Pa_CloseStream( glo->stream );
Pa_Terminate();
}
