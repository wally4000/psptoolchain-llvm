#include <pspkernel.h>
#include <pspdebug.h>
#include <stdbool.h>
#include <pspdisplay.h>

PSP_MODULE_INFO("HELLO WORLD", 0, 1, 0);

int main(int argc, char* argv[])
{
    unsigned int* ptr = (unsigned int*)0x44000000;
    
    unsigned int color = 0;
    unsigned int iter = 0;
    unsigned char r, g, b;
    r = g = b = 1;
    bool rdir, gdir, bdir;
    rdir = gdir = bdir = false;

    while(iter < 600){
        for(int x = 0; x < 512; x++){
            for(int y = 0; y < 272; y++){
                *(ptr + y * 512 + x) = 0xFF000000 | color;
                color = b << 16 | g << 8 | r;
            }
        }
        iter++;

        if(iter % 3 == 0){
            if(r == 255 || r == 0){
                rdir = !rdir;
            }

            r += (rdir) ? -1 : 1;
        }

        if(iter % 2 == 0){
            if(g == 255 || g == 0){
                gdir = !gdir;
            }
            g += (gdir) ? -1 : 1;
        }

        if(iter % 5 == 0){
            if(b == 255 || g == 0){
                bdir = !bdir;
            }
            b += (bdir) ? -1 : 1;
        }
        sceKernelDelayThread(16 * 1000);
    }

    for(int x = 0; x < 512; x++){
        for(int y = 0; y < 272; y++){
            *(ptr + y * 512 + x) = 0;
        }
    }

    return 0;
}