# 🎓 UniTrade - Campus Marketplace Platform

<div align="center">

![UniTrade](https://img.shields.io/badge/UniTrade-v1.0-blue?style=for-the-badge&logo=java)
![Java](https://img.shields.io/badge/Java-11+-orange?style=for-the-badge&logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-JSP%2FServlet-green?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-brightgreen?style=for-the-badge&logo=mysql)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)

**A modern, fast, and simple marketplace platform built for students to buy, sell, and trade items within their campus community.**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [API Docs](#-servlet-api-documentation) • [Architecture](#-architecture)

</div>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Usage Guide](#-usage-guide)
- [Architecture](#-architecture)
- [Database Schema](#-database-schema)
- [Servlet API Documentation](#-servlet-api-documentation)
- [Project Structure](#-project-structure)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🚀 Overview

**UniTrade** is a campus-based e-commerce marketplace application designed specifically for college students. It provides a clean, intuitive interface for discovering, listing, and trading items within the campus community. Students can easily browse products, manage their listings, save favorite items to a wishlist, and connect with other students.

### Why UniTrade?

✨ **Student-Focused** - Built with campus life in mind  
⚡ **Lightning Fast** - Optimized performance for smooth browsing  
🔒 **Secure** - Protected authentication and data handling  
📱 **Responsive** - Works on desktop and mobile devices  
💬 **Transparent** - Direct contact info for easy communication  

---

## ✨ Features

### 👥 Authentication & User Management
- ✅ User registration with email validation
- ✅ Secure login system
- ✅ Session-based authentication
- ✅ User logout functionality
- ✅ Admin role support

### 🛍️ Product Management
- ✅ **Add Products** - List items with title, description, price, image
- ✅ **Product Details** - Condition (New/Like New/Good/Fair), category, campus location
- ✅ **Edit Products** - Update product information anytime
- ✅ **Delete Products** - Remove listings
- ✅ **Mark as Sold** - Update availability status
- ✅ **Image Upload** - Upload product photos (auto-resize & storage)
- ✅ **View Products** - Browse all active listings

### 🔍 Search & Filtering
- ✅ **Advanced Search** - Search by keyword, title, category, location
- ✅ **Price Filter** - Filter by minimum and maximum price range
- ✅ **Category Filter** - Browse by product categories
- ✅ **Condition Filter** - Filter by product condition
- ✅ **Smart Sorting** - Sort by price (asc/desc), name (asc/desc)

### ❤️ Wishlist System
- ✅ **Save Products** - Add items to your wishlist
- ✅ **View Wishlist** - Organized wishlist page
- ✅ **Remove from Wishlist** - Remove items with one click
- ✅ **Seller Contact** - Direct contact info for wishlist items

### 👨‍💼 Admin Dashboard
- ✅ **Dashboard Overview** - Total users, total products, recent activity
- ✅ **User Management** - View, edit, delete users
- ✅ **Product Management** - Monitor all products
- ✅ **Statistics** - Real-time marketplace statistics
- ✅ **Recent Activity** - Track 5 most recent products and users

### 📊 Additional Features
- ✅ **My Products** - Personal product listings
- ✅ **Contact Details** - Seller phone number & email
- ✅ **Campus Location Tracking** - Know where items are located
- ✅ **Sold Status** - Mark items as sold
- ✅ **Responsive UI** - Modern, clean design

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Backend** | Java, Jakarta EE (JSP/Servlet) |
| **Frontend** | HTML5, CSS3, JavaScript |
| **Database** | MySQL 8.0+ |
| **Server** | Apache Tomcat 9.0+ |
| **JDBC Driver** | MySQL Connector/J 9.4.0 |
| **IDE** | Eclipse, IntelliJ IDEA |
| **Java Version** | Java 11+ |

---

## 📦 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

```bash
# Check Java version
java -version
# Required: Java 11 or higher

# Check MySQL version
mysql --version
# Required: MySQL 8.0 or higher

# Apache Tomcat 9.0 or higher
# Download from: https://tomcat.apache.org/
```

### Step 1: Clone/Download Project

```bash
# Navigate to your projects directory
cd ~/projects

# Clone the repository (if using git)
git clone <repository-url> UniTrade
cd UniTrade
```

### Step 2: Set Up MySQL Database

```bash
# Connect to MySQL
mysql -u root -p

# Execute the following SQL commands:
```

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS unitrade;
USE unitrade;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    price DOUBLE NOT NULL,
    image VARCHAR(255),
    seller_id INT NOT NULL,
    contact_number VARCHAR(20),
    sold BOOLEAN DEFAULT FALSE,
    product_condition VARCHAR(50),
    category VARCHAR(100),
    campus_location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_seller (seller_id),
    INDEX idx_sold (sold),
    INDEX idx_category (category)
);

-- Create wishlist table
CREATE TABLE IF NOT EXISTS wishlist (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_wishlist (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Insert sample admin user
INSERT INTO users (name, email, password) 
VALUES ('Admin User', 'admin@unitrade.com', 'admin123');
```

### Step 3: Update Database Connection

**File:** `src/main/java/dao/DBConnection.java`

```java
public static Connection getConnection() {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/unitrade",
            "root",              // ← Change if your MySQL username differs
            "admin"              // ← Change to your MySQL password
        );
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
```

### Step 4: Configure Tomcat

1. **Download & Extract Tomcat**
   ```bash
   # macOS/Linux
   cd /opt
   wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.70/bin/apache-tomcat-9.0.70.tar.gz
   tar -xzf apache-tomcat-9.0.70.tar.gz
   
   # Windows: Download from https://tomcat.apache.org/
   ```

2. **Configure Server Port** (Optional)
   ```bash
   # Edit: {TOMCAT_HOME}/conf/server.xml
   # Find line: <Connector port="8080"...
   # Default port is 8080
   ```

### Step 5: Deploy Application

#### Option A: IDE Deployment (Recommended)

**Using Eclipse:**
1. Right-click project → Properties
2. Project Facets → Convert to faceted form
3. Right-click project → Run As → Run on Server
4. Select Tomcat Server → Finish

**Using IntelliJ IDEA:**
1. Run → Edit Configurations
2. Add New Configuration → Tomcat Server
3. Set Application Server → Configure Tomcat
4. Select UniTrade as deployment artifact
5. Click Run

#### Option B: Manual WAR Deployment

```bash
# Build WAR file from your IDE, then:

# Copy to Tomcat
cp UniTrade.war /path/to/tomcat/webapps/

# Start Tomcat
cd /path/to/tomcat/bin
./catalina.sh start  # macOS/Linux
# or: catalina.bat start (Windows)

# View logs
tail -f /path/to/tomcat/logs/catalina.out
```

### Step 6: Access Application

```
http://localhost:8080/UniTrade
```

---

## 🎯 Quick Start

### First-Time Login

1. **Visit Home Page:** `http://localhost:8080/UniTrade`
2. **Click "Login"**
3. **Enter Credentials:**
   - Email: `admin@unitrade.com`
   - Password: `admin123`
4. **Explore Dashboard!**

### Register New Account

1. Click **"Register"** on login page
2. Enter: Name, Email, Password
3. Click **"Register"**
4. You'll be redirected to login
5. Login with your new credentials

### Add Your First Product

1. After login, click **"Add Product"**
2. Fill in the form:
   - **Title:** Product name
   - **Description:** Detailed description
   - **Price:** In your local currency
   - **Category:** Select from dropdown
   - **Condition:** New/Like New/Good/Fair
   - **Campus Location:** Where item is located
   - **Contact Number:** Your phone number
   - **Image:** Upload product photo
3. Click **"Add Product"**
4. View your listing in **"My Products"**

---

## 📚 Usage Guide

### For Sellers

#### Listing a Product
```
Home → Add Product → Fill Details → Upload Image → Submit
```

**Product Information Required:**
- Title (max 200 chars)
- Description (detailed info helps sales)
- Price
- Product Condition
- Category
- Campus Location
- Contact Number
- Product Image

#### Managing Your Listings
```
Home → My Products → [View/Edit/Delete/Mark Sold]
```

**Actions Available:**
- ✏️ **Edit** - Update product details
- 🗑️ **Delete** - Remove listing
- ✔️ **Mark Sold** - Update availability
- 👁️ **View** - See product details

### For Buyers

#### Browsing Products
```
Home → All Products
```

**Features:**
- Search by keyword
- Filter by category
- Filter by condition
- Sort by price or name
- View seller details

#### Saving Favorites
1. Click **"♥ Save"** button on product
2. Saved items appear in **"Wishlist"**
3. Click **"Remove"** to delete from wishlist

#### Contacting Sellers
- View seller name, email, phone
- Click to call or email
- Connect on campus

#### Search Tips
- Use specific keywords
- Filter by location for nearby items
- Sort by price to find deals
- Check condition for quality

---

## 🏗️ Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Browser/Client                        │
│            (HTML, CSS, JavaScript, JSP)                  │
└────────────────────┬────────────────────────────────────┘
                     │ HTTP/HTTPS
┌────────────────────▼────────────────────────────────────┐
│              Apache Tomcat Server                        │
│         (Servlet Container, JSP Engine)                  │
├─────────────────────────────────────────────────────────┤
│                  Servlet Layer                           │
│  [LoginServlet][AddProductServlet][SearchServlet]...    │
├─────────────────────────────────────────────────────────┤
│                  Business Logic                          │
│     [DAO] [Model] [Utility] [Service Classes]           │
├─────────────────────────────────────────────────────────┤
│              Database Layer (JDBC)                       │
│        [PreparedStatement] [Connection Pool]            │
└────────────────────┬────────────────────────────────────┘
                     │ JDBC
┌────────────────────▼────────────────────────────────────┐
│              MySQL Database                              │
│     [users] [products] [wishlist] [tables]              │
└─────────────────────────────────────────────────────────┘
```

### Layers Explained

| Layer | Components | Responsibility |
|-------|-----------|---|
| **Presentation** | JSP files, HTML, CSS, JS | User Interface |
| **Servlet Layer** | 19+ Servlets | Request handling, routing |
| **Business Logic** | Model, DAO, Utility | Data processing |
| **Data Access** | DBConnection, JDBC | Database queries |
| **Database** | MySQL tables | Data persistence |

---

## 📊 Database Schema

### Entity-Relationship Diagram

```
┌─────────────────┐          ┌──────────────────┐
│     USERS       │ 1     ∞  │    PRODUCTS      │
├─────────────────┤◄─────────┤──────────────────┤
│ id (PK)         │          │ id (PK)          │
│ name            │          │ title            │
│ email (UNIQUE)  │          │ description      │
│ password        │          │ price            │
│ created_at      │          │ image            │
└─────────────────┘          │ seller_id (FK)   │
                             │ contact_number   │
                             │ sold             │
                             │ product_condition│
                             │ category         │
                             │ campus_location  │
                             │ created_at       │
                             └────────┬─────────┘
                                      │ M:M
                             ┌────────▼─────────┐
                             │    WISHLIST      │
                             ├──────────────────┤
                             │ id (PK)          │
                             │ user_id (FK)     │
                             │ product_id (FK)  │
                             │ created_at       │
                             └──────────────────┘
```

### Table Definitions

#### Users Table
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Columns:**
- `id`: Unique user identifier
- `name`: Full name of user
- `email`: Email address (unique)
- `password`: Hashed password
- `created_at`: Registration timestamp

#### Products Table
```sql
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    price DOUBLE NOT NULL,
    image VARCHAR(255),
    seller_id INT NOT NULL,
    contact_number VARCHAR(20),
    sold BOOLEAN DEFAULT FALSE,
    product_condition VARCHAR(50),
    category VARCHAR(100),
    campus_location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_seller (seller_id),
    INDEX idx_sold (sold),
    INDEX idx_category (category)
);
```

**Columns:**
- `id`: Product ID
- `title`: Product name
- `description`: Detailed description
- `price`: Selling price
- `image`: Image file path
- `seller_id`: Reference to seller
- `contact_number`: Seller's phone
- `sold`: Availability status
- `product_condition`: Quality level
- `category`: Product category
- `campus_location`: Where item is
- `created_at`: Listing timestamp

#### Wishlist Table
```sql
CREATE TABLE wishlist (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_wishlist (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
```

**Columns:**
- `id`: Wishlist entry ID
- `user_id`: Reference to user
- `product_id`: Reference to product
- `created_at`: When saved

---

## 🔌 Servlet API Documentation

### Authentication Servlets

#### LoginServlet
```
URL: /LoginServlet
Method: POST
Parameters:
  - email (String)
  - password (String)
Response:
  - Success: Redirect to home.jsp
  - Failure: Redirect to login.jsp?error=1
Session Attributes Set:
  - user: User email
  - userId: User ID
```

#### RegisterServlet
```
URL: /RegisterServlet
Method: POST
Parameters:
  - name (String)
  - email (String)
  - password (String)
Response:
  - Success: Redirect to login.jsp
  - Failure: Redirect to register.jsp?error=1
Validation:
  - Email must be unique
  - All fields required
```

#### LogoutServlet
```
URL: /LogoutServlet
Method: GET/POST
Response: Invalidate session → Redirect to index.jsp
```

### Product Management Servlets

#### AddProductServlet
```
URL: /AddProductServlet
Method: POST
Parameters:
  - title (String)
  - description (String)
  - price (Double)
  - contactNumber (String)
  - productCondition (String)
  - category (String)
  - campusLocation (String)
  - image (File)
Security: Requires login
Features:
  - Dual file storage (local + web)
  - Auto timestamp filename
Response: Redirect to home.jsp
```

#### EditProductServlet
```
URL: /EditProductServlet
Method: POST
Parameters:
  - productId (Integer)
  - title, description, price, etc.
Security: Seller ownership verified
Response: Redirect to myProducts.jsp
```

#### DeleteProductServlet
```
URL: /DeleteProductServlet
Method: GET/POST
Parameters:
  - productId (Integer)
Security: Seller ownership verified
Response: Redirect to myProducts.jsp
```

#### UpdateProductServlet
```
URL: /UpdateProductServlet
Method: POST
Purpose: Update product details
Parameters: Same as EditProductServlet
```

#### MarkSoldServlet
```
URL: /MarkSoldServlet
Method: GET/POST
Parameters:
  - productId (Integer)
Security: Seller ownership verified
Action: Sets sold = TRUE
Response: Redirect to myProducts.jsp
```

### Product Browsing Servlets

#### ViewProductsServlet
```
URL: /ViewProductsServlet
Method: GET
Parameters (Optional):
  - keyword (String)
  - minPrice (Double)
  - maxPrice (Double)
  - category (String)
  - condition (String)
  - sort (String): "price_asc", "price_desc", "name_asc", "name_desc"
Response: Forward to viewProducts.jsp
Attributes:
  - products (List<Product>)
Features:
  - Advanced filtering
  - Multi-parameter sorting
  - Logged-in user sees seller info
```

#### SearchServlet
```
URL: /SearchServlet
Method: GET
Parameters:
  - keyword (String)
Search Fields:
  - title
  - category
  - campus_location
Response: Forward to viewProducts.jsp
Attributes:
  - products (List<Product>)
```

#### MyProductsServlet
```
URL: /MyProductsServlet
Method: GET
Security: Requires login
Response: Forward to myProducts.jsp
Attributes:
  - products (List<Product>) - User's listings only
```

### Wishlist Servlets

#### WishlistServlet
```
URL: /WishlistServlet
Method: GET
Security: Requires login
Response: Forward to wishlist.jsp
Attributes:
  - products (List<Product>) - Saved items
```

#### SaveProductServlet
```
URL: /SaveProductServlet
Method: GET/POST
Parameters:
  - productId (Integer)
Security: Requires login
Action: Add product to wishlist
Response: Redirect to referrer
```

#### RemoveWishlistServlet
```
URL: /RemoveWishlistServlet
Method: GET/POST
Parameters:
  - productId (Integer)
Security: Requires login
Action: Remove from wishlist
Response: Redirect to wishlist.jsp
```

### Admin Servlets

#### AdminDashboardServlet
```
URL: /AdminDashboardServlet
Method: GET
Security: Requires login
Authorization: Checks AdminUtility.isAdmin()
Response: Forward to adminDashboard.jsp
Attributes:
  - totalUsers (Integer)
  - totalProducts (Integer)
  - recentProducts (List<Product>) - Last 5
  - recentUsers (List<String[]>) - Last 5
```

#### AdminUsersServlet
```
URL: /AdminUsersServlet
Method: GET
Security: Admin only
Response: Forward to adminUsers.jsp
Attributes:
  - users (List<User>)
```

#### AdminProductsServlet
```
URL: /AdminProductsServlet
Method: GET
Security: Admin only
Response: Forward to adminProducts.jsp
Attributes:
  - products (List<Product>)
```

#### AdminDeleteUserServlet
```
URL: /AdminDeleteUserServlet
Method: GET/POST
Parameters:
  - userId (Integer)
Security: Admin only
Action: Delete user and cascade delete products/wishlist
Response: Redirect to adminUsers.jsp
```

#### AdminDeleteProductServlet
```
URL: /AdminDeleteProductServlet
Method: GET/POST
Parameters:
  - productId (Integer)
Security: Admin only
Action: Delete product and remove from wishlists
Response: Redirect to adminProducts.jsp
```

---

## 📁 Project Structure

```
UniTrade/
│
├── src/main/
│   ├── java/
│   │   ├── dao/
│   │   │   └── DBConnection.java              # Database connection management
│   │   │
│   │   ├── model/
│   │   │   └── Product.java                   # Product POJO
│   │   │
│   │   ├── servlet/
│   │   │   ├── LoginServlet.java              # User login
│   │   │   ├── RegisterServlet.java           # User registration
│   │   │   ├── LogoutServlet.java             # User logout
│   │   │   ├── AddProductServlet.java         # Add new product
│   │   │   ├── EditProductServlet.java        # Edit product
│   │   │   ├── UpdateProductServlet.java      # Update product
│   │   │   ├── DeleteProductServlet.java      # Delete product
│   │   │   ├── MarkSoldServlet.java           # Mark as sold
│   │   │   ├── ViewProductsServlet.java       # Browse all products
│   │   │   ├── SearchServlet.java             # Search products
│   │   │   ├── MyProductsServlet.java         # User's listings
│   │   │   ├── WishlistServlet.java           # View wishlist
│   │   │   ├── SaveProductServlet.java        # Save to wishlist
│   │   │   ├── RemoveWishlistServlet.java     # Remove from wishlist
│   │   │   ├── AdminDashboardServlet.java     # Admin overview
│   │   │   ├── AdminUsersServlet.java         # Manage users
│   │   │   ├── AdminProductsServlet.java      # Manage products
│   │   │   ├── AdminDeleteUserServlet.java    # Delete user
│   │   │   └── AdminDeleteProductServlet.java # Delete product
│   │   │
│   │   └── util/
│   │       └── AdminUtility.java              # Admin utility functions
│   │
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml                        # Deployment descriptor
│       │   └── lib/
│       │       └── mysql-connector-j-9.4.0.jar
│       │
│       ├── assets/
│       │   ├── css/
│       │   │   └── theme.css                  # Application styles
│       │   └── js/
│       │       └── ui.js                      # UI interactions
│       │
│       ├── uploads/                           # Product images directory
│       │
│       ├── index.jsp                          # Landing page
│       ├── login.jsp                          # Login page
│       ├── register.jsp                       # Registration page
│       ├── home.jsp                           # Home page (logged in)
│       ├── addProduct.jsp                     # Add product form
│       ├── editProduct.jsp                    # Edit product form
│       ├── viewProducts.jsp                   # Browse products
│       ├── myProducts.jsp                     # User's listings
│       ├── wishlist.jsp                       # Wishlist page
│       ├── adminDashboard.jsp                 # Admin dashboard
│       ├── adminUsers.jsp                     # Admin users page
│       └── adminProducts.jsp                  # Admin products page
│
├── database_update.sql                        # Database migrations
├── PROJECT_ANALYSIS.md                        # Project analysis
├── README.md                                  # This file
└── .gitignore                                 # Git ignore rules
```

---

## ⚙️ Configuration

### Database Configuration

**File:** `src/main/java/dao/DBConnection.java`

```java
public static Connection getConnection() {
    try {
        // Load MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Create connection
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/unitrade",  // Database URL
            "root",                                   // Username
            "admin"                                   // Password
        );
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
```

**Connection Parameters:**
- **Host:** localhost
- **Port:** 3306 (MySQL default)
- **Database:** unitrade
- **Username:** root
- **Password:** admin (change in production!)
- **Driver:** MySQL Connector/J 9.4.0

### File Upload Configuration

**File:** `src/main/java/servlet/AddProductServlet.java` (Lines 52-53)

```java
// Local storage (permanent backup)
String uploadPath = System.getProperty("user.home") + File.separator + 
                   "Documents" + File.separator + "Projects_Storage" + 
                   File.separator + "UniTradeUploads";

// Web-accessible storage
String projectPath = getServletContext().getRealPath("") + "uploads";
```

**Storage Locations:**
- **Local:** `~/Documents/Projects_Storage/UniTradeUploads/`
- **Web:** `{PROJECT_ROOT}/uploads/`

### Tomcat Configuration

**File:** `{TOMCAT_HOME}/conf/server.xml`

```xml
<!-- Default port configuration -->
<Connector port="8080" protocol="HTTP/1.1"
    connectionTimeout="20000"
    redirectPort="8443" />

<!-- HTTPS configuration (Optional) -->
<Connector port="8443" protocol="org.apache.coyote.http11.Http11Protocol"
    maxThreads="150" SSLEnabled="true"
    scheme="https" secure="true"
    keystoreFile="path/to/keystore.jks"
    keystorePass="password" />
```

---

## 🐛 Troubleshooting

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| **"Connection refused"** | MySQL not running | Start MySQL: `mysql.server start` (macOS) |
| **"Unknown database"** | Database not created | Run SQL setup queries from Installation step 2 |
| **Servlet returns 404** | Servlet not deployed | Check web.xml mapping, redeploy |
| **Login doesn't work** | Database connection error | Verify DBConnection.java credentials |
| **Image won't upload** | Directory permissions | `chmod 755 ~/Documents/Projects_Storage/UniTradeUploads` |
| **Session not working** | Session timeout | Check Tomcat session configuration |
| **Blank page after login** | JSP not compiled | Clear browser cache, restart Tomcat |
| **Database locked** | Concurrent access issue | Restart MySQL service |

### Debug Mode

**Enable console logging:**

1. Edit: `src/main/java/servlet/[Servlet].java`
2. Add: `System.out.println("Debug message");`
3. Redeploy and check: `{TOMCAT_HOME}/logs/catalina.out`

### Verify Installation

```bash
# Check Java
java -version
# Output: java version "11" or higher ✓

# Check MySQL
mysql -u root -p -e "SELECT VERSION();"
# Output: 8.0.x or higher ✓

# Check Tomcat
curl -I http://localhost:8080/
# Output: HTTP/1.1 200 OK ✓

# Check Application
curl -I http://localhost:8080/UniTrade/
# Output: HTTP/1.1 200 OK ✓
```

---

## 👥 Contributing

We welcome contributions! Here's how you can help:

### Getting Started

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/UniTrade.git
   cd UniTrade
   ```

2. **Create feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make your changes**
   - Follow Java conventions
   - Use meaningful commit messages
   - Add tests for new features

4. **Submit pull request**
   ```bash
   git push origin feature/amazing-feature
   ```

### Code Style

- **Naming:** camelCase for variables/methods, PascalCase for classes
- **Indentation:** 4 spaces
- **Comments:** Only for non-obvious code
- **Line length:** Max 100 characters

### Testing

Before submitting:
- ✅ Test all servlet endpoints
- ✅ Verify database queries
- ✅ Test file uploads
- ✅ Check session handling
- ✅ Validate user inputs

### Feature Ideas

- 🎨 Dark mode toggle
- 📧 Email notifications
- 💬 In-app messaging
- ⭐ Product ratings & reviews
- 📱 Mobile app
- 🔔 Real-time notifications
- 💳 Payment integration
- 📍 Advanced location features

---

## 📜 License

This project is licensed under the **MIT License** - see LICENSE file for details.

```
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 📞 Support & Contact

### Getting Help

- **Documentation:** See README.md & PROJECT_ANALYSIS.md
- **Issues:** Report bugs on GitHub Issues
- **Discussions:** Use GitHub Discussions for questions

### Contact Information

| Contact | Details |
|---------|---------|
| **GitHub Issues** | [UniTrade Issues](https://github.com/your-repo/issues) |
| **Email** | contact@unitrade.com |
| **Discord** | [Join Community Server](https://discord.gg/unitrade) |

---

## 🎓 Learning Resources

### Java & Web Development

- [Oracle Java Tutorials](https://docs.oracle.com/javase/tutorial/)
- [Jakarta EE Documentation](https://jakarta.ee/)
- [Servlet Tutorial](https://www.tutorialspoint.com/servlets/)
- [JSP Tutorial](https://www.tutorialspoint.com/jsp/)

### Database

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [SQL Tutorial](https://www.w3schools.com/sql/)
- [JDBC Guide](https://docs.oracle.com/javase/tutorial/jdbc/)

### Tools & Servers

- [Apache Tomcat](https://tomcat.apache.org/)
- [MySQL Workbench](https://www.mysql.com/products/workbench/)
- [IntelliJ IDEA](https://www.jetbrains.com/idea/)

---

## 📈 Roadmap

### Version 1.0 (Current) ✅
- ✅ Basic CRUD operations
- ✅ User authentication
- ✅ Search & filtering
- ✅ Wishlist system
- ✅ Admin dashboard

### Version 1.1 (Planned)
- 🔄 User profiles & reviews
- 🔄 Email notifications
- 🔄 Product ratings
- 🔄 Chat system

### Version 2.0 (Future)
- 🔄 Mobile app
- 🔄 Payment integration
- 🔄 Advanced analytics
- 🔄 API endpoints

---

## 🙏 Acknowledgments

- **Jakarta EE** - Enterprise Java platform
- **Apache Tomcat** - Application server
- **MySQL** - Relational database
- **Community** - For feedback and support

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024 | Initial release |
| 0.9 | 2024 | Beta release |
| 0.1 | 2024 | Development started |

---

<div align="center">

### Made with ❤️ for the Campus Community

⭐ If you found this helpful, please give it a star!

[Back to Top](#-unitrade---campus-marketplace-platform)

</div>
