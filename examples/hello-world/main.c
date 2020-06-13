#include <pspkernel.h>
#include <pspdebug.h>
#include <pspdisplay.h>

PSP_MODULE_INFO("HELLO WORLD", 0, 1, 0);
PSP_MAIN_THREAD_ATTR(THREAD_ATTR_VFPU | THREAD_ATTR_USER);
PSP_HEAP_SIZE_KB(-1024);

int main(int argc, char* argv[]);
int module_start(int argc, char* argv[]){
    return main(argc, argv);
}

int main(int argc, char* argv[])
{
    unsigned int* ptr = (unsigned int*)0x44000000;

    for(int x = 0; x < 512; x++){
        for(int y = 0; y < 272; y++){
            *(ptr + y * 512 + x) = 0xFF000000 | (x + y * 512);
        }
    }
    
    sceKernelExitGame();
    return 0;
}