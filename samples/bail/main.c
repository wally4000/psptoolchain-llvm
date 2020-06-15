#include <pspkernel.h>
#include <pspdebug.h>
#include <pspdisplay.h>

PSP_MODULE_INFO("HELLO WORLD", 0, 1, 0);

int main(int argc, char* argv[])
{
    sceKernelExitGame();
    return 0;
}
