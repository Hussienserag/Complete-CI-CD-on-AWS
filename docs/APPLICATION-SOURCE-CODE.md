# Application Source Code Documentation

This document provides a comprehensive overview of the ITI E-Commerce Platform application architecture, including both the Node.js backend API and React frontend application.

## Table of Contents

- [Overview](#overview)
- [Technology Stack](#technology-stack)
- [Backend Architecture](#backend-architecture)
- [Frontend Architecture](#frontend-architecture)
- [API Documentation](#api-documentation)
- [Database Models](#database-models)
- [Authentication & Authorization](#authentication--authorization)
- [File Upload System](#file-upload-system)
- [State Management](#state-management)
- [Component Structure](#component-structure)
- [Configuration Management](#configuration-management)
- [Docker Configuration](#docker-configuration)
- [Testing Strategy](#testing-strategy)
- [Performance Optimization](#performance-optimization)

## Overview

The ITI E-Commerce Platform is a full-stack web application built with modern JavaScript technologies. It provides a complete e-commerce solution with user authentication, product management, shopping cart functionality, order processing, and file uploads.

### Application Features
- **User Management**: Registration, login, profile management
- **Product Catalog**: Browse, search, and view product details
- **Shopping Cart**: Add/remove items, quantity management
- **Order Processing**: Checkout, order history, order tracking
- **Admin Panel**: Product management, order management
- **File Uploads**: Product images with AWS S3 integration
- **Responsive Design**: Mobile-friendly user interface

## Technology Stack

### Backend
- **Runtime**: Node.js with Express.js framework
- **Database**: MongoDB with Mongoose ODM
- **Authentication**: JSON Web Tokens (JWT)
- **File Storage**: AWS S3 with multer
- **CORS**: Cross-origin resource sharing support
- **Build Tools**: Babel for ES6+ transpilation

### Frontend
- **Framework**: React.js (Hooks-based)
- **State Management**: Redux with Redux Thunk
- **Routing**: React Router DOM
- **HTTP Client**: Axios
- **UI Components**: Custom CSS with responsive design
- **Build Tools**: Create React App

### DevOps & Deployment
- **Containerization**: Docker with multi-stage builds
- **Orchestration**: Kubernetes
- **CI/CD**: Jenkins pipeline
- **Registry**: AWS ECR

## Backend Architecture

### Project Structure
```
backend/
├── server.js              # Main server application
├── config.js              # Configuration settings
├── models/                 # Database models
│   ├── userModel.js       # User schema
│   ├── productModel.js    # Product schema
│   └── orderModel.js      # Order schema
├── routes/                 # API routes
│   ├── userRoute.js       # User authentication routes
│   ├── productRoute.js    # Product management routes
│   ├── orderRoute.js      # Order processing routes
│   └── uploadRoute.js     # File upload routes
├── uploads/               # Local file storage (development)
├── Dockerfile             # Container configuration
└── package.json           # Dependencies and scripts
```

### Server Configuration (server.js)

#### Core Setup
```javascript
import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';

const app = express();
const mongodbUrl = process.env.MONGODB_URI || 'mongodb://localhost:27017/amazona';

// MongoDB Connection
mongoose.connect(mongodbUrl, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
```

#### CORS Configuration
```javascript
const corsOptions = {
  origin: function (origin, callback) {
    // Allow requests with no origin (mobile apps, curl, etc.)
    if (!origin) return callback(null, true);
    // Allow any origin for development/testing
    return callback(null, true);
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With'],
  credentials: true
};

app.use(cors(corsOptions));
```

#### Health Check Endpoint
```javascript
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});
```

### Database Models

#### User Model (userModel.js)
```javascript
const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  isAdmin: { type: Boolean, required: true, default: false },
}, {
  timestamps: true,
});
```

**Features:**
- User authentication with email/password
- Admin role management
- Automatic timestamps
- Unique email constraint

#### Product Model (productModel.js)
```javascript
const productSchema = new mongoose.Schema({
  name: { type: String, required: true },
  image: { type: String, required: true },
  brand: { type: String, required: true },
  price: { type: Number, required: true },
  category: { type: String, required: true },
  countInStock: { type: Number, required: true },
  description: { type: String, required: true },
  rating: { type: Number, required: true, default: 0 },
  numReviews: { type: Number, required: true, default: 0 },
}, {
  timestamps: true,
});
```

**Features:**
- Complete product information
- Inventory management (countInStock)
- Rating and review system
- Category-based organization

#### Order Model (orderModel.js)
```javascript
const orderSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  orderItems: [orderItemSchema],
  shippingAddress: shippingSchema,
  paymentMethod: { type: String, required: true },
  itemsPrice: { type: Number, required: true },
  shippingPrice: { type: Number, required: true },
  taxPrice: { type: Number, required: true },
  totalPrice: { type: Number, required: true },
  isPaid: { type: Boolean, required: true, default: false },
  isDelivered: { type: Boolean, required: true, default: false },
}, {
  timestamps: true,
});
```

**Features:**
- User association with order history
- Multiple order items support
- Shipping and billing information
- Payment and delivery status tracking

### API Routes

#### User Routes (userRoute.js)
- `POST /api/users/register` - User registration
- `POST /api/users/signin` - User authentication
- `GET /api/users/:id` - Get user profile
- `PUT /api/users/:id` - Update user profile

#### Product Routes (productRoute.js)
- `GET /api/products` - Get all products
- `GET /api/products/:id` - Get product by ID
- `POST /api/products` - Create new product (admin)
- `PUT /api/products/:id` - Update product (admin)
- `DELETE /api/products/:id` - Delete product (admin)

#### Order Routes (orderRoute.js)
- `POST /api/orders` - Create new order
- `GET /api/orders/:id` - Get order by ID
- `GET /api/orders` - Get user's orders
- `PUT /api/orders/:id/pay` - Update payment status

#### Upload Routes (uploadRoute.js)
- `POST /api/uploads` - Upload product images
- AWS S3 integration for file storage
- Multer middleware for file handling

## Frontend Architecture

### Project Structure
```
frontend/
├── public/                 # Static assets
│   ├── index.html         # Main HTML template
│   └── favicon.ico        # Site icon
├── src/                   # Source code
│   ├── components/        # Reusable UI components
│   ├── screens/           # Page components
│   ├── actions/           # Redux action creators
│   ├── reducers/          # Redux reducers
│   ├── constants/         # Action type constants
│   ├── App.js            # Main application component
│   ├── store.js          # Redux store configuration
│   └── index.js          # Application entry point
├── Dockerfile            # Container configuration
└── package.json          # Dependencies and scripts
```

### Application Entry Point (App.js)

#### Main Component Structure
```javascript
function App() {
  return (
    <BrowserRouter>
      <div className="grid-container">
        <header className="row">
          <div>
            <Link className="brand" to="/">amazona</Link>
          </div>
          <div>
            <Link to="/cart">Cart</Link>
            <Link to="/signin">Sign In</Link>
          </div>
        </header>
        <main>
          <Route path="/cart/:id?" component={CartScreen} />
          <Route path="/product/:id" component={ProductScreen} />
          <Route path="/signin" component={SigninScreen} />
          <Route path="/register" component={RegisterScreen} />
          <Route path="/" component={HomeScreen} exact />
        </main>
      </div>
    </BrowserRouter>
  );
}
```

#### Route Configuration
- `/` - Home screen with product listing
- `/product/:id` - Product details page
- `/cart/:id?` - Shopping cart page
- `/signin` - User login page
- `/register` - User registration page
- `/profile` - User profile management
- `/shipping` - Shipping address form
- `/payment` - Payment method selection
- `/placeorder` - Order confirmation
- `/order/:id` - Order details page

### State Management (Redux)

#### Store Configuration (store.js)
```javascript
import { createStore, compose, applyMiddleware, combineReducers } from 'redux';
import thunk from 'redux-thunk';
import {
  productListReducer,
  productDetailsReducer,
} from './reducers/productReducers';
import { cartReducer } from './reducers/cartReducers';
import {
  userSigninReducer,
  userRegisterReducer,
} from './reducers/userReducers';

const initialState = {
  userSignin: {
    userInfo: localStorage.getItem('userInfo')
      ? JSON.parse(localStorage.getItem('userInfo'))
      : null,
  },
  cart: {
    cartItems: localStorage.getItem('cartItems')
      ? JSON.parse(localStorage.getItem('cartItems'))
      : [],
  },
};

const reducer = combineReducers({
  productList: productListReducer,
  productDetails: productDetailsReducer,
  cart: cartReducer,
  userSignin: userSigninReducer,
  userRegister: userRegisterReducer,
});

const store = createStore(reducer, initialState, compose(applyMiddleware(thunk)));
```

#### Key Reducers
1. **Product Reducers**: Product listing and details
2. **Cart Reducers**: Shopping cart management
3. **User Reducers**: Authentication and user management
4. **Order Reducers**: Order processing and history

### Component Architecture

#### Screen Components
- **HomeScreen**: Product catalog and search
- **ProductScreen**: Product details and add to cart
- **CartScreen**: Shopping cart management
- **SigninScreen**: User authentication
- **RegisterScreen**: User registration
- **ProfileScreen**: User profile management
- **ShippingScreen**: Delivery address
- **PaymentScreen**: Payment method selection
- **PlaceOrderScreen**: Order summary and confirmation
- **OrderScreen**: Order details and status

#### Reusable Components
- **Header**: Navigation and user menu
- **Footer**: Site information and links
- **Product**: Product card display
- **Rating**: Star rating display
- **Message**: Alert and error messages
- **LoadingBox**: Loading spinner
- **CheckoutSteps**: Progress indicator

### API Integration (api.js)

#### Axios Configuration
```javascript
import axios from 'axios';

const API = axios.create({
  baseURL: process.env.REACT_APP_API_URL || '/api',
  timeout: 10000,
});

// Request interceptor for authentication
API.interceptors.request.use((config) => {
  const userInfo = localStorage.getItem('userInfo');
  if (userInfo) {
    const { token } = JSON.parse(userInfo);
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});
```

#### API Functions
- **Product API**: Fetch products, product details
- **User API**: Authentication, profile management
- **Cart API**: Cart operations (if server-side cart)
- **Order API**: Order creation and management
- **Upload API**: File upload operations

## Authentication & Authorization

### JWT Implementation

#### Backend Authentication
```javascript
import jwt from 'jsonwebtoken';

const generateToken = (user) => {
  return jwt.sign(
    {
      _id: user._id,
      name: user.name,
      email: user.email,
      isAdmin: user.isAdmin,
    },
    process.env.JWT_SECRET || 'somethingsecret',
    {
      expiresIn: '30d',
    }
  );
};

const isAuth = (req, res, next) => {
  const authorization = req.headers.authorization;
  if (authorization) {
    const token = authorization.slice(7, authorization.length); // Bearer XXXXXX
    jwt.verify(token, process.env.JWT_SECRET || 'somethingsecret', (err, decode) => {
      if (err) {
        res.status(401).send({ message: 'Invalid Token' });
      } else {
        req.user = decode;
        next();
      }
    });
  } else {
    res.status(401).send({ message: 'No Token' });
  }
};
```

#### Frontend Authentication
```javascript
// User signin action
export const signin = (email, password) => async (dispatch) => {
  dispatch({ type: USER_SIGNIN_REQUEST, payload: { email, password } });
  try {
    const { data } = await Axios.post('/api/users/signin', { email, password });
    dispatch({ type: USER_SIGNIN_SUCCESS, payload: data });
    localStorage.setItem('userInfo', JSON.stringify(data));
  } catch (error) {
    dispatch({
      type: USER_SIGNIN_FAIL,
      payload:
        error.response && error.response.data.message
          ? error.response.data.message
          : error.message,
    });
  }
};
```

### Authorization Levels
1. **Public**: Product browsing, registration
2. **Authenticated**: Cart, orders, profile
3. **Admin**: Product management, user management

## File Upload System

### AWS S3 Integration
```javascript
import AWS from 'aws-sdk';
import multer from 'multer';

// AWS S3 configuration
const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  region: process.env.AWS_REGION,
});

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB limit
  },
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Only image files are allowed!'), false);
    }
  },
});
```

### Upload Workflow
1. **Frontend**: File selection and upload
2. **Backend**: File validation and processing
3. **AWS S3**: Secure file storage
4. **Database**: Store file URL reference

## Configuration Management

### Backend Configuration (config.js)
```javascript
export default {
  PORT: process.env.PORT || 5000,
  MONGODB_URI: process.env.MONGODB_URI || 'mongodb://localhost:27017/amazona',
  JWT_SECRET: process.env.JWT_SECRET || 'somethingsecret',
  AWS_ACCESS_KEY_ID: process.env.AWS_ACCESS_KEY_ID,
  AWS_SECRET_ACCESS_KEY: process.env.AWS_SECRET_ACCESS_KEY,
  AWS_REGION: process.env.AWS_REGION || 'us-east-1',
  S3_BUCKET: process.env.S3_BUCKET || 'your-bucket-name',
};
```

### Frontend Configuration
```javascript
// Environment variables
REACT_APP_API_URL=http://localhost:5000/api
REACT_APP_STRIPE_PUBLIC_KEY=pk_test_...
```

### Environment-Specific Settings
- **Development**: Local MongoDB, local file storage
- **Production**: Cloud MongoDB, AWS S3 storage
- **Testing**: In-memory database, mock services

## Docker Configuration

### Backend Dockerfile
```dockerfile
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

EXPOSE 5000

CMD ["npm", "run", "init-prod"]
```

### Frontend Dockerfile
```dockerfile
# Build stage
FROM node:16-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm ci --silent

COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### Multi-Stage Build Benefits
- **Smaller Images**: Only production dependencies
- **Security**: No development tools in production
- **Performance**: Optimized for runtime

## Testing Strategy

### Backend Testing
```javascript
// Example test structure
describe('Product API', () => {
  test('GET /api/products should return products list', async () => {
    const response = await request(app)
      .get('/api/products')
      .expect(200);
    
    expect(response.body).toHaveProperty('products');
    expect(Array.isArray(response.body.products)).toBe(true);
  });
});
```

### Frontend Testing
```javascript
// Component testing with React Testing Library
import { render, screen } from '@testing-library/react';
import { Provider } from 'react-redux';
import Product from './Product';
import store from '../store';

test('renders product information', () => {
  const product = {
    name: 'Test Product',
    price: 99.99,
    image: '/images/test.jpg'
  };
  
  render(
    <Provider store={store}>
      <Product product={product} />
    </Provider>
  );
  
  expect(screen.getByText('Test Product')).toBeInTheDocument();
  expect(screen.getByText('$99.99')).toBeInTheDocument();
});
```

### Testing Types
1. **Unit Tests**: Individual functions and components
2. **Integration Tests**: API endpoints and data flow
3. **E2E Tests**: Complete user workflows
4. **Performance Tests**: Load and stress testing

## Performance Optimization

### Backend Optimization
1. **Database Indexing**: Optimize MongoDB queries
2. **Caching**: Redis for session and data caching
3. **Compression**: Gzip compression for responses
4. **Rate Limiting**: Prevent API abuse

### Frontend Optimization
1. **Code Splitting**: Lazy loading of components
2. **Image Optimization**: WebP format, lazy loading
3. **Bundle Analysis**: Webpack bundle analyzer
4. **Service Workers**: Offline support and caching

### Production Considerations
1. **CDN**: Static asset delivery
2. **Load Balancing**: Multiple server instances
3. **Monitoring**: Application performance monitoring
4. **Error Tracking**: Centralized error logging

## Development Workflow

### Local Development Setup
```bash
# Backend setup
cd backend
npm install
npm start

# Frontend setup
cd frontend
npm install
npm start
```

### Build and Deployment
```bash
# Production build
npm run build

# Docker build
docker build -t app-backend .
docker build -t app-frontend .

# Kubernetes deployment
kubectl apply -f k8s/
```

### Code Quality
- **ESLint**: JavaScript/React linting
- **Prettier**: Code formatting
- **Husky**: Git hooks for quality checks
- **Jest**: Unit testing framework

## API Documentation

### Base URL
- **Development**: `http://localhost:5000/api`
- **Production**: `https://your-domain.com/api`

### Authentication Header
```
Authorization: Bearer <jwt_token>
```

### Common Response Format
```json
{
  "success": true,
  "data": {},
  "message": "Operation successful"
}
```

### Error Response Format
```json
{
  "success": false,
  "error": "Error message",
  "statusCode": 400
}
```

## Security Best Practices

### Backend Security
1. **Input Validation**: Sanitize all user inputs
2. **SQL Injection Prevention**: Use parameterized queries
3. **Rate Limiting**: Prevent brute force attacks
4. **HTTPS**: Secure communication
5. **Environment Variables**: Secure configuration

### Frontend Security
1. **XSS Prevention**: Sanitize user-generated content
2. **CSRF Protection**: Use CSRF tokens
3. **Secure Storage**: Encrypt sensitive data
4. **Content Security Policy**: Prevent code injection

## Monitoring and Logging

### Application Metrics
- **Response Times**: API performance monitoring
- **Error Rates**: Track application errors
- **User Analytics**: User behavior tracking
- **System Resources**: CPU, memory, disk usage

### Logging Strategy
- **Structured Logging**: JSON format logs
- **Log Levels**: Error, warn, info, debug
- **Centralized Logging**: ELK stack or CloudWatch
- **Log Rotation**: Prevent disk space issues

## Additional Resources

- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [React Documentation](https://reactjs.org/docs)
- [Redux Documentation](https://redux.js.org/)
- [Express.js Guide](https://expressjs.com/en/guide/)
- [MongoDB Documentation](https://docs.mongodb.com/)
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
