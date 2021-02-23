#include "FS.h"


class SD_Manager {       // The class
  public:             // Access specifier
    SD_Manager(void);
    void listDir(fs::FS &fs, const char * dirname, uint8_t levels);
    void createDir(fs::FS &fs, const char * path);
    void readFile(fs::FS &fs, const char * path);
    void removeDir(fs::FS &fs, const char * path);
    void writeFile(fs::FS &fs, const char * path, const char * message);
    void appendFile(fs::FS &fs, const char * path, const char * message);
    void appendFileSimple( const char * path, const char * message);
    void renameFile(fs::FS &fs, const char * path1, const char * path2);
    void deleteFile(fs::FS &fs, const char * path);
    void testFileIO(fs::FS &fs, const char * path);
    void run_sd_card_tests();
};
