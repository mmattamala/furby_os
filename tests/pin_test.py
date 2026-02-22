# SPDX-FileCopyrightText: 2021 ladyada for Adafruit Industries
# SPDX-License-Identifier: MIT

# This example uses an L9110 H-bridge driver to run a DC Motor using two PWM pins.
#  https://www.adafruit.com/product/4489

# Hardware setup:
#   DC motor via L9110 H-bridge driver on two PWM pins that are on their own channels
#   e.g., RP2040 Pico pins GP28, GP27

import time

import board
import pwmio
import digitalio

from adafruit_motor import motor

PWM_PIN_A = board.D4  # pick any pwm pins on their own channels
PWM_PIN_B = board.D5

# Set PWM pin as high
pin = digitalio.DigitalInOut(board.D12)
pin.direction = digitalio.Direction.OUTPUT

while True:
  pin.value = True


