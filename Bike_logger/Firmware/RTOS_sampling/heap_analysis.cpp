#include "Arduino.h"

extern TaskHandle_t Handle_gps_Task;
extern TaskHandle_t Handle_baroTask;
extern TaskHandle_t Handle_imu_Task;
extern TaskHandle_t Handle_ina1_Task;
extern TaskHandle_t Handle_ina2_Task;
extern TaskHandle_t Handle_blink_Task;
extern TaskHandle_t Handle_speed_Task;
extern TaskHandle_t Handle_brake_Task;

void heap_analysis()
{
  int x;
  int measurement;

  Serial.flush();
  Serial.println("");
  Serial.println("****************************************************");
  Serial.print("Free Heap: ");
  Serial.print(xPortGetFreeHeapSize());
  Serial.println(" bytes");

  Serial.print("Min Heap: ");
  Serial.print(xPortGetMinimumEverFreeHeapSize());
  Serial.println(" bytes");
  Serial.flush();

#if 0
  Serial.println("****************************************************");
  Serial.println("Task            ABS             %Util");
  Serial.println("****************************************************");

  //vTaskGetRunTimeStats(ptrTaskList); //save stats to char array
  Serial.println(ptrTaskList); //prints out already formatted stats
  Serial.flush();

  Serial.println("****************************************************");
  Serial.println("Task            State   Prio    Stack   Num     Core" );
  Serial.println("****************************************************");

  //vTaskList(ptrTaskList); //save stats to char array
  Serial.println(ptrTaskList); //prints out already formatted stats
  Serial.flush();

  Serial.println("****************************************************");
  Serial.println("[Stacks Free Bytes Remaining] ");
#endif

  measurement = uxTaskGetStackHighWaterMark(Handle_gps_Task);
  Serial.print("Handle_gps_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_baroTask);
  Serial.print("Handle_baroTask: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_imu_Task);
  Serial.print("Handle_imu_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_ina1_Task);
  Serial.print("Handle_ina1_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_ina2_Task);
  Serial.print("Handle_ina2_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_blink_Task);
  Serial.print("Handle_blink_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_speed_Task);
  Serial.print("Handle_speed_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_brake_Task);
  Serial.print("Handle_brake_Task: ");
  Serial.println(measurement);

  Serial.println("****************************************************");
  Serial.flush();
}
