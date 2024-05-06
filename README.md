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




      ![Screenshot 2024-05-02 231214](https://github.com/hgajipara246/smart_parking_system/assets/115713866/722a1151-9cd6-4079-80c6-701f19dd0a04)


3. ESP32 Cam Setup:
   - Program the ESP32 Cam to capture images and send them to the Raspberry Pi.
   - Integrate QR code scanning functionality into the ESP32 Cam.
  
     ESP32 Cam & Servo Motor connectivity with raspberry Pi :




     ![image](https://github.com/hgajipara246/smart_parking_system/assets/115713866/077affca-5d91-4674-8e49-2cc0ced0345f)

  
🔒 Security Considerations

- Implement proper encryption methods to secure communication between components.
- Ensure Firebase Realtime Database security rules are appropriately configured.


📱Mobile Application User Interface :





![Screenshot_20240502_201417](https://github.com/hgajipara246/smart_parking_system/assets/115713866/4059b275-9ea9-474a-80ee-b9a02e2a806f)





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
