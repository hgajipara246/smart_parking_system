import cv2
import RPi.GPIO as GPIO
from pyzbar.pyzbar import decode

# ESP32-CAM IP address and port for image streaming  "THIS IS REAL CODE"
ESP32_CAM_IP = '192.168.4.1'
STREAM_PORT = 81  # Default port for ESP32-CAM image streaming

# Function to get the current frame from ESP32-CAM
#def get_frame():
#   cap = cv2.VideoCapture("http://192.168.4.1:81/stream")
#  ret, frame = cap.read()s
# cap.release()
#return frame
GPIO.setmode(GPIO.BCM)
GPIO.setup(16, GPIO.OUT)
servo = GPIO.PWM(16, 50)
servo.start(0)
def get_frame():
    # Open a connection to the stream
    cap = cv2.VideoCapture("http://192.168.4.1:81/stream")
    if not cap.isOpened():
        print("Error: Unable to open stream.")
        return None

    ret, frame = cap.read()

    cap.release()

    if not ret or frame is None:
        print("Error: Unable to read frame or empty frame.")
        return None

    return frame


# Main loop for QR code detection
while True:
    # Get frame from ESP32-CAM
    frame = get_frame()

    # Convert frame to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Decode QR codes
    decoded_objects = decode(gray)

    # Process decoded QR codes
    for obj in decoded_objects:
        print("Data:", obj.data.decode('utf-8'))
        print("Type:", obj.type)
        print("Bounding box:", obj.rect)
        print("Polygon:", obj.polygon)

        servo.ChangeDutyCycle(7.5)
        time.sleep(4)
        servo.ChangeDutyCycle(2.5)
        time.sleep(1)
        servo.ChangeDutyCycle(0)


        # Draw bounding box around QR code
        points = obj.polygon
        if len(points) > 4:
            hull = cv2.convexHull(np.array([point for point in points], dtype=np.float32))
            cv2.polylines(frame, [hull], True, (255, 255, 255), 3)
        else:
            cv2.polylines(frame, [np.array(points, dtype=np.int32)], True, (255, 255, 255), 3)

    # Display frame
    cv2.imshow("ESP32-CAM Stream", frame)

    # Exit loop if 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release resources
cv2.destroyAllWindows()
servo.stop()
GPIO.cleanup()


