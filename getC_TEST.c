#include <stdio.h>
#include <stdlib.h>
#include <string.h>
  
  void main(int argc, const char *argv[]){
    int val = 0;
    
	// Print number of arguments (only for test)
    //printf("argc=%d\n", argc);
    
	// Just 4 Bytes
    if(argc > 5){
	printf("Too much arguments");
	return;
    }else if(argc < 5){
	printf("Too few arguments");
	return;
    }
    
    // Order Bytes
    for (int i=argc-1; i>0; i--) {
      //printf("argv(s)=%s,  ", argv[i]);
      //printf("argv(i)=0x%08lX\n", strtol(argv[i], NULL, 16 ));	
      val += (strtol(argv[i], NULL, 16) << 8*(i-1));
      //printf("VAL = 0x%08X\n", val);
    }
    
    //printf("\n\nValue: 0x%08X\n", val);
    //printf("INT: %d, FLOAT: %f\n", val, (float)val/1000);
	// RETURN VALUE	
    printf("%f", (float)val/1000);
  }








