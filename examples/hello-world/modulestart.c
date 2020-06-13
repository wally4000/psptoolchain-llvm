#include <pspmoduleinfo.h>
#include <pspkernel.h>
#include <pspthreadman.h>

extern int main(int argc, char* argv[]);

int _module_main_thread(SceSize argc, void* argv){
    int retval = main(argc, argv);
	return retval;
}

int module_start(int argc, char* argv[]){
	int (*myFunc)(SceSize argc, void* argv) = &_module_main_thread; 

	SceUID thid = 0;
	thid = sceKernelCreateThread("user_main", myFunc, 32, 256 * 1024, PSP_THREAD_ATTR_USER | PSP_THREAD_ATTR_VFPU, 0);
	sceKernelStartThread(thid, 0, 0);

    return main(argc, argv);
}