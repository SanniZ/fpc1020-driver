#!/system/bin/sh

# --------------------------------------
# fpc1020 Linux driver simple testscript
#    (execute from target terminal)
# --------------------------------------

source fpc1020_envsetup.sh
source fpc1020_dump.sh
source fpc1020_image.sh
source fpc1020_tools.sh


#  ****************************************************************************
function WaitEnter
{
    echo ""
    echo -n "Press Enter to continue"
    read
    clear
}

#  ****************************************************************************
function MainMenu
{
	sel=
	until [ "$sel" = "q" ]; do
		clear
		echo ""
		echo "*******************************"
		echo "*** Fpc1020 Diagnostic tool ***"
		echo "*******************************"
		echo "(l)oad module"
		echo "(u)nload module"
		echo ""
		echo "1- Check chip id"
		echo "2- Dump settings"
		echo ""
		echo "3- Sensor selftest"
		echo ""
		echo "4- Capture, wait-and-capture"
		echo "5- Capture, single image"
		echo "6- Capture, single image multicapture"
		echo "7- Capture, checkerboard test"
		echo ""
		echo "(r)ead sensor register"
		echo ""
		echo "(q)uit"
		echo ""
		echo -n "Enter selection: "
		read sel
		echo ""

		case $sel in
			l ) ToolsLoadModule ;		WaitEnter ;;
			u ) ToolsUnloadModule ;		WaitEnter ;;
			1 ) DumpChipId ;		WaitEnter ;;
			2 ) DumpSettings ;
			    DumpSettingsADC ;		WaitEnter ;;
			3 ) ToolsSelftest ;		WaitEnter ;;
			4 ) ImageWaitCapture ;		WaitEnter ;;
			5 ) ImageCapture ;		WaitEnter ;;
			6 ) ImageCaptureMulti ;		WaitEnter ;;
			7 ) ImageCheckerboard ;
			    ImageCheckerboardInverted;	WaitEnter ;;
			r ) ToolsReadRegister;		WaitEnter ;;
			q ) exit ;;
			* ) echo "Try again ..."; WaitEnter
		esac
	done
}      

#  ****************************************************************************

Setup

MainMenu

