# UniTrade

UniTrade is a Java web application for buying and selling items within a campus community. It is built with JSP, Servlets, JDBC, and MySQL.

## Features

- User registration and login
- Browse all products
- Search products by keyword
- Filter and sort products by price and name
- Add products with image upload
- View, edit, and delete your own products
- Display seller contact details on product cards
- Responsive UI with a modern gradient-based theme

## Tech Stack

- Java Servlet API
- JSP
- JDBC
- MySQL
- HTML, CSS, and JavaScript in JSP views

## Project Structure

```text
src/main/java/
  dao/        Database connection helper
  model/      Data model classes
  servlet/    Servlet controllers

src/main/webapp/
  *.jsp       UI pages
  assets/css/ Shared styling
  WEB-INF/    Web application config
```

## Database Setup

Create the database and tables with the following schema:

```sql
CREATE DATABASE unitrade;

USE unitrade;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    image VARCHAR(255),
    seller_id INT NOT NULL,
    contact_number VARCHAR(20) NOT NULL,

    CONSTRAINT fk_user
    FOREIGN KEY (seller_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);
```


## Configuration

The database connection is currently configured in [src/main/java/dao/DBConnection.java](src/main/java/dao/DBConnection.java). Update the JDBC URL, username, and password to match your local MySQL setup.

If needed, also adjust the image upload path in [src/main/java/servlet/AddProductServlet.java](src/main/java/servlet/AddProductServlet.java).

## Running the Project

1. Import the project into Eclipse, IntelliJ IDEA, or another Java IDE with Tomcat support.
2. Make sure MySQL is running and the `unitrade` database has been created.
3. Update the DB credentials in [src/main/java/dao/DBConnection.java](src/main/java/dao/DBConnection.java).
4. Deploy the app to a servlet container such as Apache Tomcat.
5. Open the app in your browser and start from `index.jsp`.

## Main Pages

- `index.jsp` - landing page
- `login.jsp` - login form
- `register.jsp` - user registration
- `home.jsp` - authenticated home dashboard
- `addProduct.jsp` - add a new product
- `viewProducts.jsp` - browse all products
- `myProducts.jsp` - manage your products
- `editProduct.jsp` - edit product details

## Notes

- User passwords are currently stored in plain text in the database.
- Edit and update ownership checks should be reviewed before production use.
- The current UI is styled through [src/main/webapp/assets/css/theme.css](src/main/webapp/assets/css/theme.css).

## License

No license has been specified yet.