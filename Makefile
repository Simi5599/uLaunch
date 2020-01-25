
export UL_MAJOR	:=	0
export UL_MINOR	:=	3
export UL_MICRO :=	0
export UL_VERSION	:=	$(UL_MAJOR).$(UL_MINOR).$(UL_MICRO)

export UL_DEV	:=	1

export UL_APM_WRAPS	:=	-Wl,-wrap,apmInitialize -Wl,-wrap,apmSetPerformanceConfiguration -Wl,-wrap,apmExit

export UL_DEFS	:=	-DUL_DEV=$(UL_DEV) -DUL_MAJOR=$(UL_MAJOR) -DUL_MINOR=$(UL_MINOR) -DUL_MICRO=$(UL_MICRO) -DUL_VERSION=\"$(UL_VERSION)\"

export UL_COMMON_SOURCES	:=	../uLaunch/source ../uLaunch/source/am ../uLaunch/source/cfg ../uLaunch/source/db ../uLaunch/source/fs ../uLaunch/source/net ../uLaunch/source/os ../uLaunch/source/util
export UL_COMMON_INCLUDES	:=	../uLaunch/include

export UL_CXXFLAGS	:=	-fno-rtti -fexceptions -std=gnu++17

.PHONY: all base make_hbtarget hbtarget make_daemon daemon make_menu menu clean

all: hbtarget daemon menu

base:
	@mkdir -p SdOut/
	@$(MAKE) -C master-libnx/

make_hbtarget:
	@$(MAKE) -C uHbTarget/
	@mkdir -p SdOut/ulaunch/bin/uHbTarget
	@mkdir -p SdOut/ulaunch/bin/uHbTarget/sys
	@mkdir -p SdOut/ulaunch/bin/uHbTarget/applet
	@mkdir -p SdOut/ulaunch/bin/uHbTarget/app
	@cp uHbTarget/uHbTarget.nso SdOut/ulaunch/bin/uHbTarget/sys/main
	@cp uHbTarget/uHbTarget.nso SdOut/ulaunch/bin/uHbTarget/applet/main
	@cp uHbTarget/uHbTarget.nso SdOut/ulaunch/bin/uHbTarget/app/main
	@cp uHbTarget/uHbTarget_sys.npdm SdOut/ulaunch/bin/uHbTarget/sys/main.npdm
	@cp uHbTarget/uHbTarget_applet.npdm SdOut/ulaunch/bin/uHbTarget/applet/main.npdm
	@cp uHbTarget/uHbTarget_app.npdm SdOut/ulaunch/bin/uHbTarget/app/main.npdm

hbtarget: base make_hbtarget

make_daemon:
	@$(MAKE) -C libstratosphere/
	@$(MAKE) -C uDaemon/
	@mkdir -p SdOut/atmosphere/contents/0100000000001000
	@cp uDaemon/uDaemon.nsp SdOut/atmosphere/contents/0100000000001000/exefs.nsp

daemon: base make_daemon

make_menu:
	@$(MAKE) -C Plutonium/
	@$(MAKE) -C uMenu/
	@mkdir -p SdOut/ulaunch/bin/uMenu
	@cp uMenu/uMenu.nso SdOut/ulaunch/bin/uMenu/main
	@cp uMenu/uMenu.npdm SdOut/ulaunch/bin/uMenu/main.npdm
	@build_romfs uMenu/romfs SdOut/ulaunch/bin/uMenu/romfs.bin

menu: base make_menu

clean:
	@rm -rf SdOut/
	@$(MAKE) clean -C uDaemon/
	@$(MAKE) clean -C uMenu/
	@$(MAKE) clean -C uHbTarget/