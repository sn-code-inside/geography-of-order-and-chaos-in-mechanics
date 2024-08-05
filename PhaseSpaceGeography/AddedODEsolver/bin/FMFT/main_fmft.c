#include<stdio.h>
#include<math.h>
#include "nrutil.h"

static int     MIN_F;
static int     MAX_F;
static int     FMFT_FLAG;
static int     NFREQ;
static int     DATA_SEP;
static int     NDATA;

#define PI 3.14159265358979
#define TWOPI (2.*PI)

int main(int argc, char *argv[]){
  long i;
  double **output, **input;
  double time, freq, amp, phase;
  double minfreq, maxfreq;

if (argc != 7){
	  printf("Error in parameter number\n");
	  exit(-1);
  }

  MIN_F =            atoi(argv[1]);
  MAX_F =            atoi(argv[2]);
  FMFT_FLAG =        atoi(argv[3]);
  NFREQ =            atoi(argv[4]);
  DATA_SEP =         atoi(argv[5]);
  NDATA =            atoi(argv[6]);

 // minfreq = MIN_F /180./3600. * PI *DATA_SEP * 15.;
 // maxfreq = MAX_F /180./3600. * PI *DATA_SEP * 15.;
  minfreq = MIN_F/1000. /180./3600. /2 *DATA_SEP * 15.*0.864; //Modificato per correggere intervallo frequenze calcolate
  maxfreq = MAX_F/1000. /180./3600. /2 *DATA_SEP * 15.*0.864; //Modificato per correggere intervallo frequenze calcolate

  input = dmatrix(1,2,1,NDATA);
  output = dmatrix(1,3*FMFT_FLAG,1,NFREQ);

  i=1;
  while(i<=NDATA && scanf("%lg %lg %lg",&time,
	      &input[1][i],&input[2][i]) != EOF) i++;

  if(i <= NDATA){
    printf("error on input ...\n");
    return 0;
  }

  if(fmft(output, (int)NFREQ, minfreq, maxfreq, FMFT_FLAG,
	  input, (long)NDATA) == 1)

      printf("**************************************************************\n");
	  printf("Frequency x 1000          Amplitude           Phase (degrees) \n");
	  printf("**************************************************************\n\n");

   for(i=1;i<=NFREQ;i++){
//      freq = output[3*FMFT_FLAG-2][i] *180.*3600./PI / DATA_SEP * 77.1604937877407;
//      freq = output[3*FMFT_FLAG-2][i] *180.*3600.* 2 / DATA_SEP * 77.1604937877407;
      freq = output[3*FMFT_FLAG-2][i] *180.*3600.* 2 / DATA_SEP * 77.1604937877407/1.0000294929/1.00000000000923;
      amp = output[3*FMFT_FLAG-1][i];
      phase = output[3*FMFT_FLAG][i] *180./PI;
      if(phase < 0) phase += 360.;

      printf("%  -20.14lg   %  -20.10lg   %  -20.10lg\n", freq, amp, phase);
    }

  return 1;
}









