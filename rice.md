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

The ArchWiki recommends that the following snippet is put into `.xserverrc`:

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

---

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

---

There is a bug with java applications (see: `man dwm`) and one way to fix it in
most cases is to add the following line into `~/.xinitrc`:

```bash
export _JAVA_AWT_WM_NONREPARENTING=1
```

---

For microphone, volume and screen brightness control, add the following to
`config.def.h`:

```c
static const char *brightnessupcmd[]  = { "brillo", "-q", "-A", "10", NULL };
static const char *brightnessdowncmd[]  = { "brillo", "-q", "-U", "10", NULL };
static const char *upvolcmd[] = { "amixer", "set", "Master", "5%+", NULL };
static const char *downvolcmd[] = { "amixer", "set", "Master", "5%-", NULL };
static const char *mutevolcmd[] = { "amixer", "set", "Master", "toggle", NULL };
static const char *mutemiccmd[] = { "amixer", "set", "Capture", "toggle", NULL };

#include <X11/XF86keysym.h>

static Key keys[] = {

// ...

  { 0, XF86XK_MonBrightnessUp,       spawn,         {.v = brightnessupcmd }   },
  { 0, XF86XK_MonBrightnessDown,     spawn,         {.v = brightnessdowncmd } },
  { 0, XF86XK_AudioLowerVolume,      spawn,         {.v = downvolcmd }        },
  { 0, XF86XK_AudioMute,             spawn,         {.v = mutevolcmd }        },
  { 0, XF86XK_AudioMicMute,          spawn,         {.v = mutemiccmd }        },
  { 0, XF86XK_AudioRaiseVolume,      spawn,         {.v = upvolcmd   }        },
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
export GIT_PS1_SHOWUPSTREAM=enabled
PS1='\W$(__git_ps1 " (%s)") › '
```

### Fzf

Install fzf for convenient fuzzy-finding capabilities using bash:

```bash
pacman -S fzf
```

Place the following two lines in `~/.bashrc` to enable keyboard shortcuts and
some completions, read the docs for more information on these topics:

```bash
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
```

## 4. Visual refinement

The overall theme of the system should match the vim theme "gruvbox-material" by
sainnhe: <https://github.com/sainnhe/gruvbox-material>

### Slock visual refinement

Install the following patch to draw a dwm logo on the lock screen:
<https://tools.suckless.org/slock/patches/dwmlogo/>

### St visual refinement

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

---

Install the following patch so that st can be resized in single pixel steps:
<https://st.suckless.org/patches/anysize/>

---

Install the following patch to apply the gruvbox-material theme to st:
<https://st.suckless.org/patches/gruvbox-material/>

Careful: the patch is outdated and the changes need to be made manually by
copying them from the `.diff` file. Some variable in the patch are still static
but not in the upstream source of st, so remove that keyword where necessary.
Also, make sure the correct color is set for the background, so that it matches
the one in vim.

### Dwm visual refinement

Apply an appropriate theme to dwm that goes well with gruvbox-material by
replacing the colors in `config.def.h` with the following:

```c
static const char col_gray1[]       = "#32302f";
static const char col_gray2[]       = "#1d2021";
static const char col_gray3[]       = "#e2d3ba";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#171717";
```

---

Install the following patch to add gaps to windows:
<http://dwm.suckless.org/patches/uselessgap/>

### Dmenu visual refinement

Careful, the following patches are outdated and all changes need to be applied
manually.

Install the following patch to center dmenu on the screen:
<http://tools.suckless.org/dmenu/patches/center/>

Install the following patch to add borders to dmenu:
<http://tools.suckless.org/dmenu/patches/border/>

In order for dmenu to show results below its prompt in list form, the dmenu call
in dwm's `config.def.h` needs to be edited as follows:

```c
static const char *dmenucmd[] = {
  "dmenu_run",
  "-m", dmenumon,
  "-fn", dmenufont,
  "-nb", col_gray1,
  "-nf", col_gray3,
  "-sb", col_cyan,
  "-sf", col_gray4,
  "-l", "20", // this line was added
  NULL
};
```

### Wallpaper

Install feh, a program that is able to display images as well as set wallpapers,
then run the following into command:

```bash
feh --bg-scale /path/to/wallpaper.jpg
```

This will set the wallpaper for the current session and generate a script in the
home directory called `.fehbg` containing the same command. This script can be
sourced in `~/.xprofile` to ensure that it is set everytime X starts up:

```bash
~/.fehbg
```

### Colored ls output

To make ls always print colored output, add the following to `~/.bashrc`:

```bash
alias ls='ls --color=auto'
```

### Syntax highlighting in less

To enable syntax highlighting in less the source-highlight package is needed:

```bash
pacman -S source-highlight
```

Then put the following to lines into `~/.bashrc`:

```bash
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
```

