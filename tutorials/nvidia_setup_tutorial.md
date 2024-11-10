### Setting up Cuda -- Following [this](https://jaggu-iitm.medium.com/setting-up-deep-learning-with-cuda-tensorflow-and-keras-on-arch-linux-with-dual-gpu-nvidia-gpu-82963d2ecb75):
* First lets install the nvidia proprietary drivers:
```
  sudo pacman -S nvidia-dkms nvidia-utils nvtop nvidia-settings

  # If EOS is the distribution install the following packages as well:
  sudo pacman -S nvidia-hook nvidia-inst nvidia-installer-common

  # Else create the pacman hook for the dkms following the arch wiki instructions
```
*Note:* The `nvidia-drm.modeset=1` as a bootloader option and the kernel modules
`nvidia, nvidia_modeset, mvidia_uvm, nvidia_drm` in the the initramfs 
(*`/etc/mkinitcpio.conf`*) are not required for effective GPU computing.
* Load the nvidia modules: `sudo modprobe nvidia`. In case this fails make
sure the latest linux-headers refering to the present kernel version are in use.
* Avoid *bumblebee* and *optimus-manager* if possible.
* Install the appropriate packages based on use case:
```
  sudo pacman -S cuda cuda-tools openmpi

  # Do not install tensorflow or pytorch from pip
  # If the AVX2 instruction set is available in 
  # the cpu, opt for the optimized packages.
  sudo pacman -S cudnn python-tensorflow-opt-cuda
```
* Test the Cuda environment:
  * cd into `/opt/cuda/bin`
  * Sample code for testing can be found in the followng [github](https://github.com/NVIDIA/cuda-samples/blob/master/Samples/1_Utilities/deviceQuery/deviceQuery.cpp)
  * Test the tensorflow library using the following code:
  ```
    from tensorflow.python.client import device_lib
    print(device_lib.list_local_devices())
  ```
  In case of `einsum` error install the `yay -S python-opt-einsum` package.
  * Avoid using pip, opt for arch linux packages instead to simplify the process.
* Install Keras
  * The bundled Keras can be used from the tensorflow package, the following are
  instructions on installing it from source.
  ```
    git clone https://github.com/fchollet/keras
    cd keras
    sudo python setup.py install
  ```
  * Test using the `python examples/mnist_cnn.py`