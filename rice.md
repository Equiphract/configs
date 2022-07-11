# Rice

## 0. If installing in a VirtualBox-VM

Visit <https://wiki.archlinux.org/title/VirtualBox/Install_Arch_Linux_as_a_guest>

## 1. Install xorg, xorg-xinit

```bash
pacman -S xorg
pacman -S xorg-xinit
```

## 2. Create .xinitrc, .xprofile and .xserverrc

### ~/.xinitrc

```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

```bash
# ...

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

exec dwm
```

### ~/.xprofile

This file is sourced by display managers or the `.xinitrc` right before the
window manager starts.

```bash
#!/bin/sh

slstatus &
```

### ~/.xserverrc

The ArchWiki recomments that the following snippet is put into `.xserverrc`:

```bash
#!/bin/sh

exec /usr/bin/Xorg -nolisten tcp "$@" vt$XDG_VTNR
```

## 2. Install Dwm, Dmenu, St, Slock, Slstatus

```bash
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st
git clone https://git.suckless.org/slock
git clone https://git.suckless.org/slstatus
```

## 3. Configurations for basic functionality

When configuring suckless software, put all the changes into the respective
`config.def.h` file, add `@rm config.h` to the `clean` target in the projects
Makefile. Create a new branch where the configurations can live. In case of an
upstream update do a rebase. Follow the following link for detailed information:
<dwm.suckless.org/customisation/patches_in_git>.

### Dwm

To change the Modkey from Alt (Mod1Mask) to the Windows-Key (Mod4Mask), set it
in `config.def.h`:

```c
#define MODKEY Mod4Mask
```

To install flameshot run `pacman -S flameshot`

Create shortcut for slock and flameshot in `config.def.h`:

```c
static const char *flameshotcmd[] = { "flameshot", "gui", NULL };
static const char *slockcmd[] = { "slock", NULL };

static Key keys[] = {
  // ...

  { MODKEY|ShiftMask, XK_s, spawn, {.v = flameshotcmd } },
  { MODKEY,           XK_o, spawn, {.v = slockcmd } },

  // ...
};
```

### St

To change the default font size it needs to be set in the font matching pattern
in `config.def.h`:

```c
static char *font = "Liberation Mono:pixelsize=22:antialias=true:autohint=true";
```

See <https://freedesktop.org/software/fontconfig/fontconfig-user.html> for more
information on how font management works in general.

### Slock

In `config.def.h` the following values must be set for the respective user:

```c
static const char *user  = "me";
static const char *group = "me";
```

Slock's man page recommends to put the following in a `.conf` file in the
directory `/etc/X11/xorg.conf.d/`:

```bash
Section "ServerFlags"
  Option "DontVTSwitch" "True"
  Option "DontZap"      "True"
EndSection
```

This makes sure, that it is not possible to switch to another VT or kill X via a
certain keyboard shortcut which should theoretically increase security when
using slock to lock a system.

### Bash completion

Completion for git and a multitude of other command line applications can be
used after installing the `bash-completion` package:

```bash
pacman -S bash-completion
```

### Git

To enable basic support for a git prompt, put the following into `~/.bashrc`:

```bash
source /usr/share/git/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=enabled
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
```

## 4. Visual refinement

### Fonts

Download Fira code as a coding font:

```bash
pacman -S ttf-fira-code
```

Set it in st's `config.def.h`:

```c
static char *font = "FiraCode-Regular:pixelsize=22";
```

In order for the ligatures to work in st a patch is needed:
<https://st.suckless.org/patches/ligatures/>

Download the required version and then run:

```bash
git apply patches/st-ligatures-20210824-0.8.4.diff
```

### Slock visual refinement

Install the following patch to draw a dwm logo on the lock screen:
<https://tools.suckless.org/slock/patches/dwmlogo/>

### St visual refinement

Install the following patch so that st can be resized in single pixel steps:
<https://st.suckless.org/patches/anysize/>

