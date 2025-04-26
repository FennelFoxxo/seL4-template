# seL4-template
A template for building projects on the seL4 microkernel

# Compiling
```
git clone --recurse-submodules https://github.com/FennelFoxxo/seL4-template.git
cd seL4-template
sudo ./setup
make
```

# Usage
The image final image is written to build/boot/disk.img. It can be simulated with:
```
make simulate
```
