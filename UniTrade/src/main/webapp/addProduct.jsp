<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="WishlistServlet">Wishlist</a>
    </div>
</div>

<!-- Form -->
<div class="page-shell top-align">

    <div class="form-card">
        <h2>Add Product</h2>
        <p class="section-subtitle">List a new item with a photo and clear details.</p>

        <form action="AddProductServlet" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Title</label>
                <input type="text" name="title" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" name="description" required>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="text" name="price" required>
            </div>

            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" name="contactNumber" placeholder="Enter your contact number" required>
            </div>

            <div class="form-group">
                <label>Condition</label>
                <select name="productCondition" required>
                    <option value="">Select Condition</option>
                    <option value="New">New</option>
                    <option value="Like New">Like New</option>
                    <option value="Used">Used</option>
                </select>
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="category" required>
                    <option value="">Select Category</option>
                    <option value="Books">Books</option>
                    <option value="Electronics">Electronics</option>
                    <option value="Furniture">Furniture</option>
                    <option value="Clothing">Clothing</option>
                    <option value="Sports">Sports</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label>Campus Location</label>
                <input type="text" name="campusLocation" placeholder="Example: Library, Hostel A, Main Gate" required>
            </div>

            <div class="form-group">
                <label>Upload Image</label>
                <div class="drop-zone" id="dropZone">
                    <input type="file" name="image" id="imageInput" accept="image/*" required>
                    <div class="drop-title">Drop photo here</div>
                    <div class="drop-text">or click to choose image</div>
                    <div class="file-name" id="fileName">No file selected</div>
                </div>
            </div>

            <input type="submit" value="Add Product" class="btn">

        </form>
    </div>

</div>

<script>
    const dropZone = document.getElementById("dropZone");
    const imageInput = document.getElementById("imageInput");
    const fileName = document.getElementById("fileName");

    dropZone.addEventListener("click", function () {
        imageInput.click();
    });

    imageInput.addEventListener("change", function () {
        showFileName();
    });

    dropZone.addEventListener("dragover", function (e) {
        e.preventDefault();
        dropZone.classList.add("drag-over");
    });

    dropZone.addEventListener("dragleave", function () {
        dropZone.classList.remove("drag-over");
    });

    dropZone.addEventListener("drop", function (e) {
        e.preventDefault();
        dropZone.classList.remove("drag-over");

        if (e.dataTransfer.files.length > 0) {
            imageInput.files = e.dataTransfer.files;
            showFileName();
        }
    });

    function showFileName() {
        if (imageInput.files.length > 0) {
            fileName.innerText = imageInput.files[0].name;
        } else {
            fileName.innerText = "No file selected";
        }
    }
</script>
<script src="assets/js/ui.js"></script>

</body>
</html>
