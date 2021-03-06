module stm32f401re.timer;

import core.bitop;
import cortexm;
import stm32f401re.rcc;

version (ARM_Thumb) :
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

/**
 *  Timer
 */

__gshared Tim* TIM2 = cast(Tim*) 0x40000000; // Start address of the TIM2 register
__gshared Tim* TIM3 = cast(Tim*) 0x40000400; // Start address of the TIM3 register
__gshared Tim* TIM4 = cast(Tim*) 0x40000800; // Start address of the TIM4 register
__gshared Tim* TIM5 = cast(Tim*) 0x40000C00; // Start address of the TIM5 register
__gshared Tim* TIM1 = cast(Tim*) 0x40010000; // Start address of the TIM1 register
__gshared Tim* TIM10 = cast(Tim*) 0x40014400; // Start address of the TIM10 register
__gshared Tim* TIM11 = cast(Tim*) 0x40014800; // Start address of the TIM11 register

struct Tim
{
    ushort cr1;
    ushort __reserved0;
    ushort cr2;
    ushort __reserved1;
    ushort smcr;
    ushort __reserved2;
    ushort dier;
    ushort __reserved3;
    ushort sr;
    ushort __reserved4;
    ushort egr;
    ushort __reserved5;
    ushort ccmr1;
    ushort __reserved6;
    ushort ccmr2;
    ushort __reserved7;
    ushort ccer;
    ushort __reserved8;
    uint cnt;
    ushort psc;
    ushort __reserved9;
    uint arr;
    uint __reserved10;
    uint ccr1;
    uint ccr2;
    uint ccr3;
    uint ccr4;
    uint __reserved11;
    ushort dcr;
    ushort __reserved12;
    ushort dmar;
    ushort __reserved13;
    ushort or;
    ushort __reserved14;
}

static assert(Tim.sizeof == 0x50 + 0x4);


// Power on TIM.
Tim* powerOnTIM(string name)()
{
    static if (name == "TIM2" || name == "TIM3" || name == "TIM4" || name == "TIM5")
        mixin("volatileStore(&RCC.apb1enr, volatileLoad(&RCC.apb1enr) | RCC_APB1ENR_"
              ~ name ~ "EN);return " ~ name ~ ";");
    else static assert (false);
}


// Resume the timer count.
void resume(Tim* tim)
{
    volatileStore(&tim.cr1, volatileLoad(&tim.cr1) | 1);
}

// Pause the timer count.
void pause(Tim* tim)
{
    volatileStore(&tim.cr1, volatileLoad(&tim.cr1) & ~1);
}

// Configure the prescaler to have the timer operate.
void setPrescaler(Tim* tim, ushort prescaler)
{
    volatileStore(&tim.psc, prescaler);
}

// set the timer to go off `autoreload` ticks.
void setAutoreload(Tim* tim, uint autoreload)
{
    volatileStore(&tim.arr, autoreload);
}

// Check if update event has occurred.
bool isUpdated(Tim* tim)
{
    return (volatileLoad(&tim.sr) & 1) == 1;
}

// Clear update flag.
void clearUpdateFlag(Tim* tim)
{
    volatileStore(&tim.sr, volatileLoad(&tim.sr) & ~1);
}

// Enable update event interrupt.
void enableUpdateEventInterrupt(Tim* tim)
{
    volatileStore(&tim.dier, volatileLoad(&tim.dier) | 1);
}
