Smart Parking System 

🅰️ Introduction

Welcome to our Smart Parking System! This system allows users to pre-book parking slots using live data from IR sensors. Upon booking and payment, a QR code is generated and stored in the database. When users arrive to park their vehicles, the system verifies their booking by comparing the QR code they present with the system-generated QR code. If they match, the parking barrier opens; otherwise, it remains closed.

🔧 Setup

To set up the Smart Parking System, you'll need the following components:

- Raspberry Pi
- IR sensors
- ESP32 Cam
- Flutter application connected to Firebase Realtime Database

💡 Usage

1. User Registration and Login:
   - Users can register with their details, including name, email, password, city, gender, and car number plate.
   - Alternatively, users can login with their registered email and password.

1. Booking a Slot:
   - Users can pre-book a parking slot through the Flutter application.
   - Upon successful booking and payment, a QR code is generated and stored in the Firebase Realtime Database.

2. Arrival and Parking:
   - When a user arrives to park, they present their QR code.
   - The ESP32 Cam captures the QR code and sends it to the Raspberry Pi.

3. QR Code Verification:
   - The Raspberry Pi compares the presented QR code with the system-generated QR code stored in the database.
   - If the codes match, the parking barrier opens, allowing the user to park.
   - If they don't match, the barrier remains closed, indicating that the user has not booked that slot.

📝 Configuration

1. Raspberry Pi Setup:
   - Ensure the Raspberry Pi is connected to the IR sensors, Servo motor and ESP32 Cam.
   - Install necessary libraries for QR code scanning on Raspberry Pi.
   - Configure the Raspberry Pi to communicate with the Firebase Realtime Database.

   Ir Sensor Connectivity with Raspberry pi :




 

3. ESP32 Cam Setup:
   - Program the ESP32 Cam to capture images and send them to the Raspberry Pi.
   - Integrate QR code scanning functionality into the ESP32 Cam.
  
     ESP32 Cam & Servo Motor connectivity with raspberry Pi :




     ![image](https://github.com/hgajipara246/smart_parking_system/assets/115713866/077affca-5d91-4674-8e49-2cc0ced0345f)

  
🔒 Security Considerations

- Implement proper encryption methods to secure communication between components.
- Ensure Firebase Realtime Database security rules are appropriately configured.


📱Mobile Application User Interface :







![Untitled design (2)](https://github.com/hgajipara246/smart_parking_system/assets/115713866/5d4269ee-56b2-4e88-99a9-bcd6d66c44d2)
![Untitled design (3)](https://github.com/hgajipara246/smart_parking_system/assets/115713866/ec2e164e-937a-4e2c-a5a9-eebb383df28a)
![Untitled design (4)](https://github.com/hgajipara246/smart_parking_system/assets/115713866/f4803f05-bdff-4916-978e-998fb1ba7062)
![Untitled design (5)](https://github.com/hgajipara246/smart_parking_system/assets/115713866/51b5b296-f131-45ee-8cbe-3cef553f3453)
![Automate Park](https://github.com/hgajipara246/smart_parking_system/assets/115713866/1ff67a39-6bbb-46c7-8db0-da9ea5839837)









👍 Contributing

Contributions to the project are welcome! Feel free to submit pull requests with any improvements or bug fixes.

📞 Support

harshilgajipara5@gmail.com,
manavkumbhani@gmail.com,
babariyakhushi6@gmail.com,
viradiyasurbhi@gmail.com

If you encounter any issues or have questions, please don't hesitate to reach out to our support team.


📄 Credits

- Developed by Team of Smart Parking System

📅 Release History

- Version  1.0.0+1

📧 Contact Information

For inquiries, please contact over team

harshilgajipara5@gmail.com,
manavkumbhani@gmail.com,
babariyakhushi6@gmail.com,
viradiyasurbhi@gmail.com

---

This readme file provides a comprehensive guide to understanding and setting up our Smart Parking System. If you have any further questions, don't hesitate to ask!
