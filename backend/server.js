require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const xss = require('xss-clean');
const mongoSanitize = require('express-mongo-sanitize');
const csrf = require('csurf');
const cookieParser = require('cookie-parser');

const app = express();

// Security Middleware
app.use(helmet()); // Security headers
app.use(xss()); // Prevent XSS attacks
app.use(mongoSanitize()); // Prevent NoSQL injection
app.use(cookieParser()); // Required for CSRF

// CORS configuration
app.use(cors({
    origin: process.env.FRONTEND_URL || 'http://localhost:3000',
    credentials: true
}));

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 5, // 5 requests per windowMs per IP
    message: 'Too many requests from this IP, please try again later.'
});
app.use('/api/contact', limiter);

// Body parsing
app.use(express.json({ limit: '10kb' })); // Limit body size

// CSRF protection
app.use(csrf({ cookie: true }));

// Serve CSRF token
app.get('/api/csrf-token', (req, res) => {
    res.json({ csrfToken: req.csrfToken() });
});

// MongoDB Connection with retry logic
const connectWithRetry = () => {
    mongoose.connect(process.env.MONGODB_URI, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        serverSelectionTimeoutMS: 5000
    })
    .then(() => console.log('Connected to MongoDB'))
    .catch(err => {
        console.error('MongoDB connection error:', err.message);
        setTimeout(connectWithRetry, 5000);
    });
};
connectWithRetry();

// Contact Schema with validation
const contactSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Name is required'],
        trim: true,
        minlength: [2, 'Name must be at least 2 characters'],
        maxlength: [50, 'Name cannot exceed 50 characters'],
        match: [/^[a-zA-Z\s]{2,50}$/, 'Name can only contain letters and spaces']
    },
    email: {
        type: String,
        required: [true, 'Email is required'],
        trim: true,
        lowercase: true,
        match: [/^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Please enter a valid email']
    },
    subject: {
        type: String,
        required: [true, 'Subject is required'],
        trim: true,
        minlength: [3, 'Subject must be at least 3 characters'],
        maxlength: [100, 'Subject cannot exceed 100 characters'],
        match: [/^[a-zA-Z0-9\s\-_,.!?]{3,100}$/, 'Subject contains invalid characters']
    },
    message: {
        type: String,
        required: [true, 'Message is required'],
        trim: true,
        minlength: [10, 'Message must be at least 10 characters'],
        maxlength: [1000, 'Message cannot exceed 1000 characters']
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    ipAddress: String
});

const Contact = mongoose.model('Contact', contactSchema);

// Project Schema
const projectSchema = new mongoose.Schema({
    title: String,
    description: String,
    technologies: [String],
    imageUrl: String,
    projectUrl: String,
    createdAt: { type: Date, default: Date.now }
});

const Project = mongoose.model('Project', projectSchema);

// Error handler middleware
const errorHandler = (err, req, res, next) => {
    console.error('Error:', err.name, err.message);
    
    if (err.name === 'ValidationError') {
        return res.status(400).json({
            status: 'error',
            message: Object.values(err.errors).map(e => e.message).join(', ')
        });
    }

    if (err.code === 'EBADCSRFTOKEN') {
        return res.status(403).json({
            status: 'error',
            message: 'Invalid CSRF token. Please refresh the page and try again.'
        });
    }

    res.status(500).json({
        status: 'error',
        message: 'An unexpected error occurred. Please try again later.'
    });
};

// Contact form endpoint with input validation
app.post('/api/contact', async (req, res, next) => {
    try {
        const { name, email, subject, message } = req.body;

        // Create new contact with sanitized data
        const contact = new Contact({
            name: decodeURIComponent(name),
            email: decodeURIComponent(email),
            subject: decodeURIComponent(subject),
            message: decodeURIComponent(message),
            ipAddress: req.ip
        });

        await contact.save();

        res.status(201).json({
            status: 'success',
            message: 'Message sent successfully'
        });
    } catch (error) {
        next(error);
    }
});

// Error handling middleware
app.use(errorHandler);

// Handle unhandled routes
app.all('*', (req, res) => {
    res.status(404).json({
        status: 'error',
        message: `Cannot find ${req.originalUrl} on this server`
    });
});

// Handle uncaught exceptions and unhandled rejections
process.on('uncaughtException', err => {
    console.error('UNCAUGHT EXCEPTION:', err);
    process.exit(1);
});

process.on('unhandledRejection', err => {
    console.error('UNHANDLED REJECTION:', err);
    process.exit(1);
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
}); 