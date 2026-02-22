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

PWM_PIN_A = board.D23  # pick any pwm pins on their own channels
PWM_PIN_B = board.D24

# Set PWM pin as high
pin = digitalio.DigitalInOut(board.D12)
pin.direction = digitalio.Direction.OUTPUT
pin.value = True

# DC motor setup
# DC Motors generate electrical noise when running that can reset the microcontroller in extreme
# cases. A capacitor can be used to help prevent this.
pwm_a = pwmio.PWMOut(PWM_PIN_A, frequency=50)
pwm_b = pwmio.PWMOut(PWM_PIN_B, frequency=50)
motor1 = motor.DCMotor(pwm_a, pwm_b)

print("***DC motor test***")

while True:
  print("\nForwards slow")
  motor1.throttle = 0.5
  print("  throttle:", motor1.throttle)
  time.sleep(1.5)
  print("\nForwards slow")
  motor1.throttle = -0.5
  print("  throttle:", motor1.throttle)
  time.sleep(0.3)
