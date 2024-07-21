# Recycling App

A comprehensive recycling app built with Flutter that uses TensorFlow Lite for live image detection and OpenAI API for classifying whether detected objects are recyclable. The app also integrates with ResilientDB for handling transactions, allowing users to earn tokens for their recyclable items.

## Features

- **Live Object Detection**: Utilizes TensorFlow Lite for real-time object detection. Tensor flow model used from [github](https://github.com/tensorflow/flutter-tflite/tree/main/example/live_object_detection_ssd_mobilenet)

- **Object Classification**: Uses OpenAI API to determine if detected objects are recyclable.
- **Token Earning**: Users earn tokens based on the number of recyclable items detected.
- **Transaction Logging**: Integrates with ResilientDB to log transactions and retrieve transaction details.

## Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed. Follow the installation guide [here](https://flutter.dev/docs/get-started/install).
- **VS Code**: After installing the Flutter SDK and following the steps, you can install the Dart extension.
- **XCode**: For IOS development

## Setup

### 1. Clone the Repository
Clone the repository to get started:

```sh
git clone https://github.com/your-repo/recycling-app.git
cd recycling-app
```

### 2. Install Dependenciesy
Install Flutter dependencies:

```sh
flutter pub get
```

### 3. TensorFlow Lite and OpenAI API
The app uses a TensorFlow Lite model for real-time object detection and the OpenAI API for classifying objects as recyclable. It is advised to use the OpenAI API key for the app to function correctly.

### 4. Run the App
To run the app, use the following command:
```sh
flutter run
```

## Usage
### Live Object Detection and Classification
- **Start Scanning:** Open the app and start scanning items using your camera.
- **Real-Time Detection:** The app uses TensorFlow Lite to detect objects in real-time.
- **Classification:** Detected objects are classified using the OpenAI API to determine if they are recyclable.
- **Stop Scanning:** After scanning, users can stop the process and proceed to the next page.

## Earning Tokens
- **Enter Details:** On the next page, users enter their name.
- **Recyclable Items Count:** The app displays the number of recyclable items detected.
- **Post Transaction:** Users post a transaction to earn tokens for their recyclable items.
- **Transaction Details:** The transaction details are retrieved and displayed to the user.

## ResilientDB Integration
The app integrates with ResilientDB to handle transactions, allowing users to log their recycling efforts and earn tokens. Transactions are logged using GraphQL APIs provided by ResilientDB, ensuring secure and transparent transaction handling.

### Example GraphQL Mutations and Queries
#### Generate Keys
```graphql
mutation {
  generateKeys {
    publicKey
    privateKey
  }
}
```
#### Post Transaction
```graphql
mutation {
  postTransaction(data: {
    operation: "CREATE",
    amount: 50,
    signerPublicKey: "yourPublicKey",
    signerPrivateKey: "yourPrivateKey",
    recipientPublicKey: "recipientPublicKey",
    asset: """{
      "data": {
        "time": 1690881023169,
        "name": "Rohan",
        "recycled_items": 3
      }
    }"""
  }) {
    id
  }
}
```
#### Get Transaction
````graphql
query {
  getTransaction(id: "transactionId") {
    id
    version
    amount
    metadata
    operation
    asset
    publicKey
    uri
    type
  }
}
````
## Postman API Calls
Postman can be used to test and translate the GraphQL queries into equivalent Dart code for use in the Flutter app. By making API calls through Postman, you can easily debug and generate the necessary headers, body, and GraphQL query formats required for integration. This is particularly useful when working with complex GraphQL queries and mutations, allowing you to verify their correctness before implementing them in Dart.




## Contributing
Please fork the repository and submit a pull request with your contributions.

## VIDEO DEMO
https://github.com/user-attachments/assets/ef2eb333-f479-4260-af8f-c802befbc349


## License
This project is licensed under the MIT License - see the LICENSE file for details.

