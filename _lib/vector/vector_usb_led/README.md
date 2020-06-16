Simple USB powered LED circuit. Mostly intended to provide vector test for gEDA_designer . Some effort has been made to demonstrate best practices and include fabrication test cases.

May be manufactured as dual-layer, quad-layer, or six-layer.


# Future Work

* Via sizes could be changed to conform to 34mil hole size, 8mil annular ring size, 50mil outside diameter, and/or 25mil milldrill minimum hole size. This would improve the usefulness of this example for less than ideal photolithography manufacturing.

* PCB-INTEGRAL Trace based connector... could be marked noplace/nobom or similar.

# Valid Packages

Intentionally, some of the packages generated are NOT valid. This is due to pcb file containing irrelevant layers, which are left in place as test cases for gEDA_designer scripts .


At least some packages are valid for manufacturing.

_build/pcbway/usb_led_noempty.zip
_build/pcbway/usb_led_noempty-twoLayer.zip
_build/pcbway/usb_led_noempty-fourLayer.zip
_build/pcbway/usb_led_noempty-sixLayer.zip

_build/oshpark/usb_led-twoLayer.zip
_build/oshpark/usb_led_noempty.zip
_build/oshpark/usb_led_noempty-twoLayer.zip
_build/oshpark/usb_led_noempty-fourLayer.zip
