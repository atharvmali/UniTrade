# UniTrade

UniTrade is a Java JSP/Servlet campus marketplace backed by MySQL. Students can register, log in, list items, browse listings, save products to a wishlist, and manage their own products. Admin users can review users, products, and recent activity from a protected dashboard.

## Table of Contents

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

## Overview

The application is organized around a small set of JSP pages and servlet endpoints. The current implementation focuses on marketplace basics rather than a large framework stack: authentication, product management, search, wishlist, and admin reporting.

## Features

### Authentication and access control
- User registration and login
- Session-based authentication
- Logout
- Admin role support through `users.is_admin`

### Product management
- Add products with title, description, price, image, contact number, condition, category, and campus location
- View all products
- Edit and delete personal listings
- Mark listings as sold

### Search and browsing
- Keyword search across title, category, and campus location
- Category filtering
- Condition filtering
- Minimum and maximum price filtering
- Sorting by price or title

### Wishlist
- Save a product to a wishlist
- Remove a product from the wishlist
- View saved products in a separate page

### Admin dashboard
- View total users and total products
- Inspect recent products and recent users
- Manage users and products from admin pages

## Tech Stack

| Category | Technology |
|----------|-----------|
| **Backend** | Java, Jakarta Servlet API (JSP/Servlet) |
| **Frontend** | HTML5, CSS3, JavaScript |
| **Database** | MySQL 8.0+ |
| **Server** | Apache Tomcat 10+ |
| **JDBC Driver** | MySQL Connector/J 9.4.0 |
| **IDE** | Eclipse, IntelliJ IDEA |
| **Java Version** | Java 11+ |

## Installation

### Prerequisites

Before you begin, ensure you have the following installed:

```bash
# Check Java version
java -version
# Required: Java 11 or higher

# Check MySQL version
mysql --version
# Required: MySQL 8.0 or higher

# Apache Tomcat 10.0 or higher
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
    is_admin BOOLEAN DEFAULT FALSE,
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
INSERT INTO users (name, email, password, is_admin)
VALUES ('Admin User', 'admin@unitrade.com', 'admin123', TRUE);
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
            "mysqlroot"          // ← Change to your MySQL password
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
  is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Columns:**
- `id`: Unique user identifier
- `name`: Full name of user
- `email`: Email address (unique)
- `password`: Stored password value
- `is_admin`: Admin flag used by `AdminUtility`
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
  - role: `admin` or `user`
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
├── src/main/java/
│   ├── dao/DBConnection.java
│   ├── model/Product.java
│   ├── servlet/
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── AddProductServlet.java
│   │   ├── ViewProductsServlet.java
│   │   ├── SearchServlet.java
│   │   ├── MyProductsServlet.java
│   │   ├── WishlistServlet.java
│   │   ├── SaveProductServlet.java
│   │   ├── RemoveWishlistServlet.java
│   │   ├── MarkSoldServlet.java
│   │   ├── AdminDashboardServlet.java
│   │   ├── AdminUsersServlet.java
│   │   ├── AdminProductsServlet.java
│   │   ├── AdminDeleteUserServlet.java
│   │   └── AdminDeleteProductServlet.java
│   └── util/AdminUtility.java
└── src/main/webapp/
  ├── index.jsp
  ├── login.jsp
  ├── register.jsp
  ├── home.jsp
  ├── addProduct.jsp
  ├── editProduct.jsp
  ├── viewProducts.jsp
  ├── myProducts.jsp
  ├── wishlist.jsp
  ├── adminDashboard.jsp
  ├── adminUsers.jsp
  ├── adminProducts.jsp
  └── assets/
    ├── css/theme.css
    └── js/ui.js
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
          "mysqlroot"                               // Password
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
- **Password:** mysqlroot (change in production!)
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

No license file is included in this repository.

---

## 📞 Support & Contact

### Getting Help

- Review the servlet classes under `src/main/java/servlet/`
- Check `DBConnection.java` if the app cannot connect to MySQL
- Inspect the JSP pages under `src/main/webapp/` for the UI flow

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
