# NixOS Config

This repo contains my setup for managing machine builds for NixOS using Nix flakes.

Inspiration has come from [Mathias Benaets](https://github.com/MatthiasBenaets/nixos-config) and 
his [YouTube video tutorial](https://www.youtube.com/watch?v=AGVXJ-TIv3Y) on how to install and configure 
a NixOS system, and how to use Home Manager and Nix Flakes. While it's a long tutorial, it's definitely
worth spending the time as it goes into a lot of detail and explains a lot of things about Nix and NixOS.

## Usage

You can use this repo to install and maintain a NixOS system on your machines. At the moment it's under development and has only been tested with a VMWare virtual machine, but I will be adding configurations for other machines as I learn more about NixOS and deploy it on my own computers.

Right now, it will install NixOS with i3 as the Window Manager, no desktop environment and Polybar. I'm still playing with the environment so not everything is working and the configurations have been modified from my Arch setup so many things may still be broken.

## Installation

Installation instructions have been modified slightly from [these instructions](https://mudrii.medium.com/nixos-native-flake-deployment-with-luks-drive-encryption-and-lvm-b7f3738b71ca) by [Ion Mudreac](https://mudrii.medium.com/) who has lot of other useful articles on Nix for anyone interested.

### VM Details

This build is currently being tested using VMWare Workstation 15.

Things to note on the virtual machine you build:

  - When starting the LiveCD NixOS creates a tmpfs RAM drive allocating 50% of the VM's RAM. If you give the VM too little RAM, the installation may fail when you run out of disk space as the installer mounts the Nix store to tmpfs. This configuration installs the nerdfonts package for example (I know, I know, it's massive! Why would you do that? Well if I hadn't then the install mightn't have failed and I wouldn't have found out about this tmpfs limitation)

  - You need to setup the VM with an EFI firmware to install the Grub EFI boot, otherwise you will get a failure when Grub tries to install the bootloader. It will complain about not finding the file or directory `/boot/efi`.

With that out of the way grab yourself the latest LiveCD of your choice from the [NixOS website](https://nixos.org/download.html) and boot up the Live environment.

### Installation Steps:

#### Create partitions

I'm not going to provide instructions for this as there's plenty of guides on how to do it using `parted`, `fdisk` or `gparted` etc., already by people more knowledgable than me. To use this flake you need to create the following:

| Partition Format | Partition Size           | Label   | Description        |
| ---------------- | ------------------------ | ------- | ------------------ |
| fat32            | 512MiB                   | NIXBOOT | EFI Boot Partition |
| ext4             | Remaining less Swap Size | NIXROOT | Root Partition     |
| linux-swap       | Swap Size                | NIXSWAP | Swap Partition     |

> NOTE: If you don't want a swap partition, don't create one, but you will need to update `hardware-configuration.nix` and remove the device from the swap-device section.

#### Mount partitions

Open up a terminal and `sudo -i` into root. 

> The LiveCD has no password for the LiveCD user or root user so you shouldn't need a password

Run the following commands to mount the file system you will be installing on:

```bash
mount /dev/disk/by-label/NIXROOT /mnt
mkdir -p /mnt/boot/efi
mount /dev/disk/by-label/NIXBOOT /mnt/boot/efi
```

If you want to use swap space you can do, but I don't think you need this step for the installation. To enable swap:

```bash
swapon /dev/disk/by-label/NIXSWAP
```

#### Enable Git and Nix Flakes

You won't have access to git and nix flakes by default on the LiveCD, but you can use nix-shell to create a new shell with those features for you to retrieve the git repo and run `nixos-install` with a flake:

```bash
nix-shell -p git nixFlakes
```

#### Get the repo

Now we need to clone the repo using git:

```bash
git clone https://github.com/guoguojin/nixos-config.git /mnt/etc/nixos
```

The `main` branch will contain the latest configuration. Later once I know what I'm doing and have this properly configured and tested, I will start tagging versions that have been tested and I know are stable(-ish). If you don't want to install from the main branch, you can always checkout the version you want you run the installation.

```bash
cd /mnt/etc/nixos
git checkout <tag or branch you want>
cd -
```

> `cd -` returns you to the last directory you were in, a bit like popd would do if you had used a pushd to change directories.

Edit `config/configuration.nix` and `config/user/home.nix` to change your user name and user details (I know, I need to put this in one place and have home.nix inherit it, but I haven't figured it out yet), and the initialPassword of your choosing.

> initialPassword is the password to give your user when creating the user. You can generate a hashed password and provide that in the nix configuration files, but I personally don't like that idea. Better to have the user change their password after the machine has been built and they have logged in. If you do not set the initialPassword, the user will not be able to log in. Instead you will need to log in with the root account, set the user password and then you will be able to log in to the user account.

#### Install NixOS

You are now ready to install NixOS using the flake. Before you install, you might want to update the configuration and add/remove things you don't want (like nerdfonts!!!), otherwise let's go ahead:

```bash
nixos-install --root /mnt --flake /mnt/etc/nixos#shukaku
```

> For NixOS builds, I've decided to name my machines after the tailed beasts from the Naruto and Naruto: Shippuden Manga/Anime series. Shukaku is the 1 tail and the first build configuration.

The installer should download and unpack everything. Once it's been installed, it will prompt you for the root password. Enter the password you want to use for the root account and repeat it when prompted and you will be done.

#### Reboot and log in

```bash
reboot
```

The machine should restart and boot into SDDM. Use the initial password to log in to the user account. **CHANGE THE USER PASSWORD!!!!** Enjoy!

If you have come across this repo and are attempting to execute any of the instructions provided and discover a mistake, please feel free to let me know. I can provide no guarantees that what I've written is 100% accurate and this is very much a work in progress, but I hope you find it useful.
