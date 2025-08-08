# Stark Tech - Flutter & Dart Application with MongoDB

This project is a complete conversion of the original HTML/Node.js website to a modern Flutter application with a Dart backend and MongoDB database.

## Project Structure

```
├── starktech_flutter/          # Flutter client application
│   ├── lib/
│   │   ├── main.dart          # App entry point
│   │   ├── constants/         # Theme and constants
│   │   ├── pages/             # App pages (Home, About, Projects, Blog, Contact)
│   │   ├── widgets/           # Reusable widgets
│   │   └── services/          # API services
│   └── pubspec.yaml
├── dart_backend/              # Dart server application
│   ├── lib/
│   │   ├── server.dart        # Server entry point
│   │   ├── models/            # Data models
│   │   ├── routes/            # API routes
│   │   └── middleware/        # Middleware (error handling)
│   ├── .env                   # Environment variables
│   └── pubspec.yaml
└── README.md
```

## Features

### Flutter Client
- **Modern UI**: Clean, minimalist design using only typography, colors, and layout
- **Dark/Light Theme**: Toggle between themes with persistent preference
- **Responsive Design**: Adapts to different screen sizes
- **Smooth Animations**: Using flutter_animate package
- **Form Validation**: Client-side validation for contact form
- **API Integration**: Communicates with Dart backend

### Dart Backend
- **RESTful API**: Built with Shelf framework
- **MongoDB Integration**: Using mongo_dart package
- **Input Validation**: Server-side validation for all inputs
- **Error Handling**: Comprehensive error handling middleware
- **CORS Support**: Cross-origin resource sharing enabled
- **Health Checks**: Server health monitoring endpoint

## Prerequisites

Before running this application, make sure you have:

1. **Flutter SDK** (3.10.0 or higher)
2. **Dart SDK** (3.0.0 or higher)
3. **MongoDB** (local installation or MongoDB Atlas account)

## Setup Instructions

### 1. MongoDB Setup

#### Option A: Local MongoDB
1. Install MongoDB on your system
2. Start MongoDB service:
   ```bash
   # On macOS with Homebrew
   brew services start mongodb-community
   
   # On Ubuntu/Debian
   sudo systemctl start mongod
   
   # On Windows
   net start MongoDB
   ```

#### Option B: MongoDB Atlas (Cloud)
1. Create a free account at [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Create a new cluster
3. Get your connection string
4. Update the `MONGODB_URI` in `dart_backend/.env`

### 2. Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd dart_backend
   ```

2. Install dependencies:
   ```bash
   dart pub get
   ```

3. Configure environment variables:
   - Edit `dart_backend/.env` file
   - Update `MONGODB_URI` with your MongoDB connection string
   - Adjust other settings as needed

4. Run the backend server:
   ```bash
   dart run lib/server.dart
   ```

   The server will start on `http://localhost:5000`

### 3. Flutter App Setup

1. Navigate to the Flutter directory:
   ```bash
   cd starktech_flutter
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the Flutter app:
   ```bash
   flutter run
   ```

   For web:
   ```bash
   flutter run -d chrome
   ```

   For mobile (with device/emulator connected):
   ```bash
   flutter run
   ```

## API Endpoints

### Contact Endpoints
- `POST /api/contact` - Submit contact form
- `GET /api/contacts` - Get all contacts (admin)

### Project Endpoints
- `GET /api/projects` - Get all projects
- `POST /api/projects` - Create new project (admin)
- `GET /api/projects/:id` - Get project by ID

### Utility Endpoints
- `GET /health` - Health check
- `GET /api/` - API information

## Environment Variables

### Backend (.env)
```env
MONGODB_URI=mongodb://localhost:27017/starktech
PORT=5000
HOST=localhost
NODE_ENV=development
FRONTEND_URL=http://localhost:3000
```

## Database Schema

### Contacts Collection
```json
{
  "_id": "ObjectId",
  "name": "string",
  "email": "string",
  "subject": "string",
  "message": "string",
  "createdAt": "DateTime",
  "ipAddress": "string"
}
```

### Projects Collection
```json
{
  "_id": "ObjectId",
  "title": "string",
  "description": "string",
  "technologies": ["string"],
  "imageUrl": "string",
  "projectUrl": "string",
  "category": "string",
  "createdAt": "DateTime"
}
```

## Development

### Running in Development Mode

1. Start MongoDB (if using local installation)
2. Start the Dart backend:
   ```bash
   cd dart_backend
   dart run lib/server.dart
   ```
3. Start the Flutter app:
   ```bash
   cd starktech_flutter
   flutter run
   ```

### Testing the API

You can test the API endpoints using curl or Postman:

```bash
# Health check
curl http://localhost:5000/health

# Submit contact form
curl -X POST http://localhost:5000/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "subject": "Test Message",
    "message": "This is a test message."
  }'

# Get projects
curl http://localhost:5000/api/projects
```

## Deployment

### Backend Deployment
1. Choose a hosting platform (Heroku, DigitalOcean, AWS, etc.)
2. Set up environment variables on the platform
3. Deploy the Dart backend
4. Update the Flutter app's API base URL

### Flutter App Deployment
- **Web**: `flutter build web` and deploy to any static hosting
- **Mobile**: Build APK/IPA and distribute through app stores
- **Desktop**: `flutter build windows/macos/linux`

## Troubleshooting

### Common Issues

1. **MongoDB Connection Failed**
   - Check if MongoDB is running
   - Verify connection string in `.env`
   - Check network connectivity for Atlas

2. **Flutter Dependencies Issues**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter version compatibility

3. **API Connection Issues**
   - Verify backend server is running
   - Check CORS configuration
   - Confirm API base URL in Flutter app

4. **Build Issues**
   - Update Flutter SDK to latest stable version
   - Check for any deprecated APIs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Contact

For questions or support, please contact:
- Email: starktechfounder@gmail.com
- GitHub: [Starktechfounder](https://github.com/Starktechfounder)
- LinkedIn: [Akati Omkar Reddy](https://www.linkedin.com/in/akati-omkar-reddy-b3987735a)
