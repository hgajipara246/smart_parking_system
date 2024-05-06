import RPi.GPIO as GPIO
import time
import pyrebase

# Firebase configuration
firebaseConfig = {
    "apiKey": "AIzaSyDpfc443lJiH62YOlePgOLGj44Hom44Ek8",
    "authDomain": "automate-park-42481.firebaseapp.com",
    "databaseURL": "https://automate-park-42481-default-rtdb.asiasoutheast1.firebasedatabase.app",
    "projectId": "automate-park-42481",
    "storageBucket": "gs://automate-park-42481.appspot.com",
    "messagingSenderId": "669445423505",
    "appId": "1:669445423505:android:873dade159f55a26cc9a30"
}

# Initialize Firebase
firebase = pyrebase.initialize_app(firebaseConfig)
db = firebase.database()

# Set the GPIO mode
GPIO.setmode(GPIO.BCM)

# Set the GPIO pins for the IR sensors
ir_1 = 10
ir_2 = 5
ir_3 = 14
ir_4 = 23

# Setup GPIO pins as input
GPIO.setup(ir_1, GPIO.IN)
GPIO.setup(ir_2, GPIO.IN)
GPIO.setup(ir_3, GPIO.IN)
GPIO.setup(ir_4, GPIO.IN)

# Occupancy data for parking slots
slotdata = {"slot1": 0, "slot2": 0, "slot3": 0, "slot4": 0}

try:
    while True:
        # Read the state of the IR sensors
        sensor_state1 = GPIO.input(ir_1)
        sensor_state2 = GPIO.input(ir_2)
        sensor_state3 = GPIO.input(ir_3)
        sensor_state4 = GPIO.input(ir_4)

        # Update slot occupancy based on sensor readings
        if sensor_state1 == GPIO.HIGH:
            print("Slot 1 is not detected")
            slotdata["slot1"] = 0
        else:
            print("Slot 1 detected")
            slotdata["slot1"] = 1

        if sensor_state2 == GPIO.HIGH:
            print("Slot 2 is not detected")
            slotdata["slot2"] = 0
        else:
            print("Slot 2 detected")
            slotdata["slot2"] = 1

        if sensor_state3 == GPIO.HIGH:
            print("Slot 3 is not detected")
            slotdata["slot3"] = 0
        else:
            print("Slot 3 detected")
            slotdata["slot3"] = 1

        if sensor_state4 == GPIO.HIGH:
            print("Slot 4 is not detected")
            slotdata["slot4"] = 0
        else:
            print("Slot 4 detected")
            slotdata["slot4"] = 1

        try:
            # Update occupancy data in the database
            db.child("sensor_data").child("sensor_occupancy").update(slotdata)
            print("Data Updated Successfully")
        except Exception as e:
            print("Error updating database:", e)

        # Delay before reading the sensors again
        time.sleep(3)

except KeyboardInterrupt:
    # Clean up GPIO settings on keyboard interrupt
    GPIO.cleanup()
