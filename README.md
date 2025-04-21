# FormFit - A Wearable Device for Exercise Optimization and Injury Prevention

FormFit is a wearable device + mobile app combination which, unlike any other wearable exercise product, provides the user with live, quantitative, and specific feedback.
FormFit operates using an Arduino microcontroller connected to a 6-axis accelerometer and gyroscope, collecting 10 samples every second and sending this data via Bluetooth to the corresponding app.

This repository stores the mobile app built in Flutter/Dart containing the user interface and data processing. To view the FormFit Arduino code, go to muvaro2/FormFitArduinoCode

To use this app on mobile devices, install Flutter/Dart on either Android Studio (recommended) or VSCode, clone this repository, and run "flutter run" in the terminal while the mobile device is plugged into your computer's USB port. The device must have developer options and USB debugging enabled. Currently, this app is most stable with Android devices, as this is primarily what we used to test and demonstrate the device.

Below is a screenshot of the FormFit homepage:

![Screenshot 2025-04-21 130423](https://github.com/user-attachments/assets/01b9ee54-145b-403b-8acc-d3f79ed8bf50)
