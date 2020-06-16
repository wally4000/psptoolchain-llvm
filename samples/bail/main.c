#include <pspkernel.h>
#include <pspdebug.h>
#include <pspdisplay.h>
#include <stdio.h>

PSP_MODULE_INFO("HELLO WORLD", 0, 1, 0);

int main(int argc, char* argv[])
{
    FILE* fp = fopen("test.txt", "rw+");
    char buffer[20];
    fread(buffer, sizeof(char), 20, fp);
    
    printf("%s", buffer);

    sceKernelExitGame();
    return 0;
}
