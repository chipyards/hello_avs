
#define CODEC_FREQ		44100
#define CODEC_QCHAN		2
#define FRAMES_PER_BUFFER	256	// 256 <==> 5.8 ms i.e. 172.265625 buffers/s
#define QRING			(1<<10)	// buffer circulaire
#define QRING_MASK		(QRING-1)

typedef struct
{
PaStream *stream;	// portaudio stream
short int ringL[QRING];
short int ringR[QRING];
unsigned int ringWi;		// index d'ecriture dans l'anneau, pointe sur la prochaine place a ecrire
unsigned int pa_blk_cnt;	// mesure du temps en buffer de PA
} glostru;

// demarrer le stream audio, rend 0 si ok
int audio_io_start( glostru * glo, double mylatency, int indevice, int outdevice, int pa_dev_options );

// arreter le stream audio
void audio_io_stop( glostru * glo );
