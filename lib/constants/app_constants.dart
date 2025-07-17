import 'package:shopsy/utils/image_utils.dart';

List<Map<String, dynamic>> productsList = [
  {
    "id": "1",
    "name": "Earbuds",
    "description": "Noise-cancelling wireless earbuds with 20h battery life.",
    "salePrice": 1999.0,
    "actualPrice": 2100.0,
    "stock": 50,
    "lowStockQuantityAlert": 5,
    "isTrendingProduct": true,
    "productImage": icBluetooth1,
    "productImageList": [
      icBluetooth1,
      icBluetooth2,
      icBluetooth3,
      icBluetooth4,
      icBluetooth5,
    ],
    "totalRatings": 120,
    "totalRatingsGiven": 90,
    "keyInformation": [
      {
        "paramName": "Box Contents",
        "paramValue": "Earbuds, Charging Cable, User Manual"
      },
      {"paramName": "Material", "paramValue": "Plastic & Silicone"},
      {"paramName": "Compatibility", "paramValue": "Android, iOS"},
      {"paramName": "Battery Life", "paramValue": "20 Hours"},
      {"paramName": "Connectivity", "paramValue": "Bluetooth 5.1"},
      {"paramName": "Warranty", "paramValue": "1 Year Warranty"}
    ]
  },
  {
    "id": "2",
    "name": "Speaker",
    "description": "Portable speaker with deep bass and 10h playtime.",
    "salePrice": 2499.0,
    "actualPrice": 3000.0,
    "isTrendingProduct": false,
    "stock": 30,
    "lowStockQuantityAlert": 5,
    "productImage": icBluetoothSpekaer1,
    "productImageList": [
      icBluetoothSpekaer1,
      icBluetoothSpekaer2,
      icBluetoothSpekaer3,
      icBluetoothSpekaer4,
      icBluetoothSpekaer5,
    ],
    "totalRatings": 150,
    "totalRatingsGiven": 110,
    "keyInformation": [
      {
        "paramName": "Box Contents",
        "paramValue": "Speaker, Charging Cable, Manual"
      },
      {"paramName": "Material", "paramValue": "ABS Plastic"},
      {"paramName": "Compatibility", "paramValue": "Mobile, Laptop, TV"},
      {"paramName": "Battery Capacity", "paramValue": "3000mAh"},
      {"paramName": "Connectivity", "paramValue": "Bluetooth, AUX, USB"},
      {"paramName": "Water Resistance", "paramValue": "IPX5 Certified"}
    ]
  },
  {
    "id": "3",
    "name": "Smart Watch",
    "description": "Fitness tracking smartwatch with AMOLED display.",
    "salePrice": 3499.0,
    "actualPrice": 4000.0,
    "stock": 40,
    "lowStockQuantityAlert": 10,
    "isTrendingProduct": true,
    "productImage": icSmartWatch1,
    "productImageList": [
      icSmartWatch1,
      icSmartWatch2,
      icSmartWatch3,
    ],
    "totalRatings": 300,
    "totalRatingsGiven": 250,
    "keyInformation": [
      {
        "paramName": "Box Contents",
        "paramValue": "Watch, Strap, Charger, Manual"
      },
      {"paramName": "Material", "paramValue": "Metal & Silicone"},
      {"paramName": "Compatibility", "paramValue": "Android, iOS"},
      {"paramName": "Battery Backup", "paramValue": "7 Days"},
      {"paramName": "Connectivity", "paramValue": "Bluetooth 5.2"},
      {
        "paramName": "Health Features",
        "paramValue": "Heart Rate, SpO2, Sleep Tracker"
      }
    ]
  },
  {
    "id": "4",
    "name": "Gaming Mouse",
    "description": "Ergonomic gaming mouse with RGB lighting.",
    "salePrice": 1599.0,
    "actualPrice": 2000.0,
    "stock": 60,
    "lowStockQuantityAlert": 10,
    "isTrendingProduct": true,
    "productImage": icGamingMouse1,
    "productImageList": [
      icGamingMouse1,
      icGamingMouse2,
      icGamingMouse3,
      icGamingMouse4,
    ],
    "totalRatings": 90,
    "totalRatingsGiven": 70,
    "keyInformation": [
      {"paramName": "Box Contents", "paramValue": "Mouse, Manual"},
      {"paramName": "Material", "paramValue": "Plastic"},
      {"paramName": "Compatibility", "paramValue": "Windows, MacOS"},
      {"paramName": "DPI", "paramValue": "16000"},
      {"paramName": "Connectivity", "paramValue": "Wired USB"},
      {"paramName": "Lighting", "paramValue": "RGB Lighting"}
    ]
  },
  {
    "id": "5",
    "name": "Laptop Backpack",
    "description": "Water-resistant backpack with dedicated laptop sleeve.",
    "salePrice": 1499.0,
    "actualPrice": 1999.0,
    "stock": 25,
    "lowStockQuantityAlert": 5,
    "isTrendingProduct": true,
    "productImage": icLaptopBackpack1,
    "productImageList": [
      icLaptopBackpack1,
      icLaptopBackpack2,
      icLaptopBackpack3,
    ],
    "totalRatings": 50,
    "totalRatingsGiven": 40,
    "keyInformation": [
      {"paramName": "Box Contents", "paramValue": "Backpack"},
      {"paramName": "Material", "paramValue": "Polyester Fabric"},
      {"paramName": "Laptop Size Support", "paramValue": "Up to 15.6 inches"},
      {"paramName": "Water Resistance", "paramValue": "Yes"},
      {"paramName": "Compartments", "paramValue": "3 Main Compartments"},
      {"paramName": "Strap Type", "paramValue": "Adjustable Padded Straps"}
    ]
  },
  {
    "id": "6",
    "name": "Wireless Keyboard",
    "description": "Slim wireless keyboard with silent typing keys.",
    "salePrice": 1299.0,
    "actualPrice": 1999.0,
    "stock": 40,
    "lowStockQuantityAlert": 10,
    "isTrendingProduct": false,
    "productImage": icWirelessKeyboard1,
    "productImageList": [
      icWirelessKeyboard1,
      icWirelessKeyboard2,
      icWirelessKeyboard3,
    ],
    "totalRatings": 80,
    "totalRatingsGiven": 60,
    "keyInformation": [
      {
        "paramName": "Box Contents",
        "paramValue": "Keyboard, USB Receiver, Manual"
      },
      {"paramName": "Material", "paramValue": "Plastic"},
      {"paramName": "Compatibility", "paramValue": "Windows, MacOS"},
      {"paramName": "Battery Type", "paramValue": "AAA Batteries"},
      {"paramName": "Connectivity", "paramValue": "2.4GHz Wireless"},
      {"paramName": "Special Keys", "paramValue": "Media Controls, Silent Keys"}
    ]
  },
  {
    "id": "7",
    "name": "Fitness Band",
    "description": "Track your heart rate, steps, and calories.",
    "salePrice": 2299.0,
    "actualPrice": 2499.0,
    "productImage": icFitnessBand1,
    "isTrendingProduct": false,
    "stock": 35,
    "lowStockQuantityAlert": 5,
    "productImageList": [
      icFitnessBand1,
      icFitnessBand2,
      icFitnessBand3,
      icFitnessBand4,
    ],
    "totalRatings": 110,
    "totalRatingsGiven": 85,
    "keyInformation": [
      {"paramName": "Box Contents", "paramValue": "Band, Charger, Manual"},
      {"paramName": "Material", "paramValue": "Silicone"},
      {"paramName": "Compatibility", "paramValue": "Android, iOS"},
      {"paramName": "Battery Life", "paramValue": "10 Days"},
      {"paramName": "Sensors", "paramValue": "Heart Rate, Steps"},
      {"paramName": "Water Resistance", "paramValue": "IP67"}
    ]
  },
  {
    "id": "8",
    "name": "Portable Hard Drive",
    "description": "1TB external hard drive for secure backup.",
    "salePrice": 4999.0,
    "productImage": icPortableHarddrive1,
    "actualPrice": 5999.0,
    "stock": 20,
    "isTrendingProduct": false,
    "lowStockQuantityAlert": 3,
    "productImageList": [
      icPortableHarddrive1,
      icPortableHarddrive2,
      icPortableHarddrive3,
      icPortableHarddrive4,
    ],
    "totalRatings": 95,
    "totalRatingsGiven": 70,
    "keyInformation": [
      {"paramName": "Box Contents", "paramValue": "Hard Drive, Cable, Manual"},
      {"paramName": "Material", "paramValue": "Plastic"},
      {"paramName": "Compatibility", "paramValue": "Windows, MacOS"},
      {"paramName": "Capacity", "paramValue": "1TB"},
      {"paramName": "Connectivity", "paramValue": "USB 3.0"},
      {"paramName": "Color", "paramValue": "Black"}
    ]
  },
  {
    "id": "9",
    "name": "Phone Stand Holder",
    "description": "Adjustable desk phone stand for mobile phones.",
    "salePrice": 599.0,
    "actualPrice": 1999.0,
    "isTrendingProduct": false,
    "stock": 70,
    "productImage": icPhoneStand1,
    "lowStockQuantityAlert": 15,
    "productImageList": [
      icPhoneStand1,
      icPhoneStand2,
      icPhoneStand3,
    ],
    "totalRatings": 130,
    "totalRatingsGiven": 90,
    "keyInformation": [
      {"paramName": "Box Contents", "paramValue": "Phone Stand"},
      {"paramName": "Material", "paramValue": "Aluminium Alloy"},
      {"paramName": "Adjustable", "paramValue": "Yes"},
      {"paramName": "Device Support", "paramValue": "Phones, Tablets"},
      {"paramName": "Color", "paramValue": "Black"},
      {"paramName": "Foldable", "paramValue": "Yes"}
    ]
  },
  {
    "id": "10",
    "name": "Wireless Charger",
    "description": "Fast wireless charging pad for mobile devices.",
    "salePrice": 1899.0,
    "actualPrice": 1999.0,
    "isTrendingProduct": false,
    "productImage": icWirelessCharger1,
    "stock": 45,
    "lowStockQuantityAlert": 5,
    "productImageList": [
      icWirelessCharger1,
      icWirelessCharger2,
      icWirelessCharger3,
    ],
    "totalRatings": 170,
    "totalRatingsGiven": 140,
    "keyInformation": [
      {"paramName": "Box Contents", "paramValue": "Charger, Cable, Manual"},
      {"paramName": "Material", "paramValue": "Plastic"},
      {"paramName": "Compatibility", "paramValue": "iOS & Android"},
      {"paramName": "Charging Power", "paramValue": "15W Fast Charge"},
      {"paramName": "Cable Included", "paramValue": "Type-C Cable"},
      {"paramName": "Color", "paramValue": "White"}
    ]
  },
];

///ROUTE NAMES
const routeHomeScreen = "routeHomeScreen";
const routeProductDetailScreen = "routeProductDetailScreen";
const routeCartScreen = "routeCartScreen";
const routeOrderConfirmationScreen = "routeOrderConfirmationScreen";
