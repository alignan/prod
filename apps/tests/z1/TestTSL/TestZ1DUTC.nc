 
#include "Timer.h"
#include "PrintfUART.h"

module TestZ1DUTC {
  uses {
    interface Leds;
    interface Boot;
    interface Timer<TMilli> as TestTimer;	
    interface Read<uint16_t> as Light;
  }
}
implementation {  
  void printTitles(){
    printfUART("\n\n");
    printfUART("   ###############################\n");
    printfUART("   #         Light TEST          #\n");
    printfUART("   ###############################\n");
    printfUART("\n");
  }
 
  event void Boot.booted() {
    printfUART_init();
    printTitles();
    // call Leds.led0On();
    call TestTimer.startPeriodic(1024);
  }  
    
  event void TestTimer.fired(){
    call Light.read();
  }
  
  event void Light.readDone(error_t error, uint16_t data){
    if (error == SUCCESS){
      printfUART("Light: %d\n", data);
    }
  }

}

