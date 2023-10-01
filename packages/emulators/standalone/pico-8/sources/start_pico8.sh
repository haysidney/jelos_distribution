#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

# Source predefined functions and variables
. /etc/profile

case ${HW_ARCH} in
  aarch64)
    STATIC_BIN="pico8_64"
  ;;
  *)
    STATIC_BIN="pico8"
  ;;
esac

if [ ! -z "${1}" ] && [ -s "${1}" ]
then
  OPTIONS="-run"
  CART="${1}"
else
  OPTIONS="-splore"
fi

INTEGER_SCALE=$(get_setting pico-8.integerscale)
if [ "${INTEGER_SCALE}" = "1" ]
then
  OPTIONS="${OPTIONS} -pixel_perfect 1"
else
  OPTIONS="${OPTIONS} -software_blit 1 -draw_rect 0,0,720,720"
fi

cp -f /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/roms/pico-8/sdl_controllers.txt

if [ -e "/storage/roms/pico-8/${STATIC_BIN}" ]
then
  jslisten set "-9 ${STATIC_BIN}"
  /storage/roms/pico-8/${STATIC_BIN} -home -root_path /storage/roms/pico-8 -joystick 0 ${OPTIONS} "${CART}"
  exit
fi

if [ -e "/storage/roms/pico-8/pico8_dyn" ] || [ ! "$?" = 0 ]
then
  jslisten set "-9 pico8_dyn"
  /storage/roms/pico-8/pico8_dyn -home -root_path /storage/roms/pico-8 -joystick 0 ${OPTIONS} "${CART}"
  exit
else
  text_viewer -e -w -t "Missing Pico-8 binaries!" -m "Extract your purchased pico8 package into the pico-8 directory on your games partition."
fi

ret_error=$?

exit $ret_error
