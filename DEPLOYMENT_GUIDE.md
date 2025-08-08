# 🚀 Stark Tech - Deployment Guide

Your Flutter/Dart application has been successfully pushed to GitHub! Here's how to deploy both the backend and frontend.

## 📋 Repository Status
✅ **GitHub Repository**: https://github.com/Starktechfounder/Starktech-website.git
✅ **All Code Pushed**: Flutter app, Dart backend, deployment configs
✅ **MongoDB Connected**: Atlas cluster configured

## 🖥️ Backend Deployment Options

### Option 1: Railway (Recommended - Free Tier)
1. Visit [Railway.app](https://railway.app)
2. Sign up with your GitHub account
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your `Starktech-website` repository
5. Railway will auto-detect the Dockerfile
6. Add environment variables:
   - `MONGODB_URI`: `mongodb+srv://starktechfounder:Palkhi@Reddy1432@cluster0.eieiv58.mongodb.net/starktech?retryWrites=true&w=majority&appName=Cluster0`
   - `PORT`: `8080` (Railway default)
   - `HOST`: `0.0.0.0`
7. Deploy! Your API will be available at: `https://your-app-name.railway.app`

### Option 2: Heroku
1. Install Heroku CLI
2. Login: `heroku login`
3. Create app: `heroku create starktech-api`
4. Set environment variables:
   ```bash
   heroku config:set MONGODB_URI="mongodb+srv://starktechfounder:Palkhi@Reddy1432@cluster0.eieiv58.mongodb.net/starktech?retryWrites=true&w=majority&appName=Cluster0"
   ```
5. Deploy: `git push heroku main`

### Option 3: DigitalOcean App Platform
1. Visit DigitalOcean App Platform
2. Connect your GitHub repository
3. Configure build settings (Dockerfile detected automatically)
4. Add environment variables
5. Deploy

## 🌐 Frontend Deployment Options

### Option 1: Netlify (Recommended for Flutter Web)
1. Visit [Netlify.com](https://netlify.com)
2. Sign up with GitHub
3. Click "New site from Git"
4. Select your repository
5. Build settings:
   - **Build command**: `cd starktech_flutter && flutter build web --release`
   - **Publish directory**: `starktech_flutter/build/web`
6. Add environment variable:
   - `API_BASE_URL`: `https://your-railway-app.railway.app` (your backend URL)
7. Deploy!

### Option 2: Vercel
1. Visit [Vercel.com](https://vercel.com)
2. Import your GitHub repository
3. Vercel will detect the `vercel.json` configuration
4. Add environment variables in dashboard
5. Deploy automatically

### Option 3: Firebase Hosting
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Initialize: `firebase init hosting`
4. Build: `cd starktech_flutter && flutter build web`
5. Deploy: `firebase deploy`

## 📱 Mobile App Deployment

### Android (Google Play Store)
```bash
cd starktech_flutter
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS (App Store)
```bash
cd starktech_flutter
flutter build ios --release
```

## 🔧 Environment Configuration

### Backend Environment Variables
```env
MONGODB_URI=mongodb+srv://starktechfounder:Palkhi@Reddy1432@cluster0.eieiv58.mongodb.net/starktech?retryWrites=true&w=majority&appName=Cluster0
PORT=8080
HOST=0.0.0.0
NODE_ENV=production
```

### Frontend Environment Variables
```env
API_BASE_URL=https://your-backend-url.com
```

## 🚀 Quick Deploy Commands

### Deploy Backend to Railway
```bash
# Railway will auto-deploy from GitHub
# Just connect your repo and set environment variables
```

### Deploy Frontend to Netlify
```bash
# Connect GitHub repo to Netlify
# Set build command: cd starktech_flutter && flutter build web --release
# Set publish directory: starktech_flutter/build/web
```

## 📊 Monitoring & Health Checks

### Backend Health Check
- URL: `https://your-backend-url.com/health`
- Should return: `{"status": "healthy", "timestamp": "..."}`

### API Endpoints
- `POST /api/contact` - Contact form submission
- `GET /api/projects` - Get all projects
- `GET /api/contacts` - Get all contacts (admin)

## 🔒 Security Notes

1. **MongoDB Credentials**: Already configured in your Atlas cluster
2. **CORS**: Configured to allow your frontend domain
3. **Input Validation**: Implemented on both client and server
4. **Rate Limiting**: Can be added for production

## 📈 Next Steps

1. **Deploy Backend**: Choose Railway, Heroku, or DigitalOcean
2. **Deploy Frontend**: Use Netlify or Vercel
3. **Update API URL**: Set the backend URL in frontend environment
4. **Test Everything**: Verify contact form and API endpoints
5. **Custom Domain**: Add your own domain to both services
6. **SSL Certificate**: Automatically provided by hosting platforms

## 🆘 Troubleshooting

### Common Issues:
1. **Build Failures**: Ensure Flutter/Dart versions are compatible
2. **MongoDB Connection**: Verify connection string and network access
3. **CORS Errors**: Check backend CORS configuration
4. **API Not Found**: Verify backend deployment and URL

### Support:
- Check deployment logs on your hosting platform
- Test API endpoints with Postman or curl
- Verify environment variables are set correctly

## 🎉 Success!

Your Stark Tech application is now ready for deployment! The complete Flutter/Dart stack with MongoDB integration has been successfully created and pushed to GitHub.

**Repository**: https://github.com/Starktechfounder/Starktech-website.git
