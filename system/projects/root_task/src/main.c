#include <sel4/sel4.h>
#include <stdio.h>

void halt() {
    while (1) seL4_TCB_Suspend(seL4_CapInitThreadTCB);
}

int main() {
    printf("\n\nHello World!\n");
    halt();
    return 0;
}