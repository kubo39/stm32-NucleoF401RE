# STM32-NucleoF401RE

STM32-NucleoF401RE dev board library for LDC.

## Tools

### Ubuntu 17.10

- Required packages

```console
$ sudo apt install -y openocd gdb-arm-none-eabi gcc-arm-none-eabi
```

- LLVM D Compiler

I have tested on LDC-1.9.0.

```console
$ curl -fsS https://dlang.org/install.sh | bash -s ldc-1.9.0
$ source $HOME/dlang/ldc-1.9.0/activate
```

## Prerequirements

Create udev-rules files and reload udev-rules

```console
$ cat /etc/udev/rules.d/99-fdi.rules
# FT232 - USB <-> Serial Converter
ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", GROUP="uucp"
$ cat /etc/udev/rules.d/99-openocd.rules
# STM32F407DISCOVERY rev A/B - ST-LINK/V2
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", GROUP="uucp"

# STM32F407DISCOVERY rev C+ - ST-LINK/V2-1
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", GROUP="uucp"
$ sudo udevadm control --reload-rules
```

Check if you are in `uucp` group.

```console
$ groups $(id -nu)| grep uucp
(..) uucp (..)
```

If not, add yourself to `uucp` group.

```console
$ sudo usermod -a -G uucp $(id -nu)
```

And `git submodule init && git submodule update`.

```console
$ git submodule init && git submodule update
```

## Example

### LED

Connect STM32-NuceloF401RE and run openocd.

```console
$ openocd -f board/st_nucleo_f4.cfg
```

`make led-run` in another terminal.

```console
$ make led-run
```
