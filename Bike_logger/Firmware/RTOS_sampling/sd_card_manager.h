#include "FS.h"
#include "SD.h"

class SD_Manager {       // The class
  public:             // Access specifier
    SD_Manager(void);
    void SD_Manager_init();
    void appendFile(File *file, const char * message);
};
