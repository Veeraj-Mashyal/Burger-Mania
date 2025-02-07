<html>
<head>
    <title>CRUD Operations</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        h3 {
            color: #2c3e50;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 8px;
            margin-bottom: 15px;
            font-size: 1.6em;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .crud-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            background-color: #fdfdfd;
            transition: all 0.3s ease-in-out;
        }

        .crud-section:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .category-section, .product-section {
            display: inline-block;
            width: 48%;
            margin-right: 4%;
            vertical-align: top;
        }

        .category-section:last-child, .product-section:last-child {
            margin-right: 0;
        }

        .form-container {
            width: 100%;
            margin-top: 15px;
        }

        label {
            font-weight: bold;
            font-size: 1rem;
            margin-bottom: 8px;
            display: inline-block;
            color: #555;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            margin: 6px 0;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1rem;
            color: #333;
            background-color: #f9f9f9;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        select:focus {
            border-color: #007BFF;
            background-color: #fff;
            outline: none;
        }

        input[type="submit"] {
            background-color: #2c3e50;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            text-transform: uppercase;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .alert {
            padding: 12px;
            margin: 15px 0;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
            font-size: 1rem;
        }

        .alert.success {
            background-color: #28a745;
            color: white;
        }

        .alert.error {
            background-color: #dc3545;
            color: white;
        }

        .operation {
            margin-bottom: 20px;
            padding: 12px;
            background-color: #f1f1f1;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .operation:hover {
            background-color: #f9f9f9;
        }

        select {
            appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="gray" d="M2 0L0 2h4z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 10px 10px;
        }

        footer {
            text-align: center;
            margin-top: 30px;
            font-size: 0.9rem;
            color: #777;
        }

    </style>
</head>
<body>
    <div class="container">
        <!-- Category CRUD Section -->
        <div class="crud-section category-section">
            <h3>Add a New Category:</h3>
            <div class="operation">
                <form action="crud.jsp" method="POST">
                    <input type="hidden" name="action" value="createCategory"/>
                    <label for="categoryName">Category Name:</label>
                    <input type="text" id="categoryName" name="categoryName"/>
                    <input type="submit" value="Add Category"/>
                </form>
            </div>

            <h3>Update Existing Category:</h3>
            <div class="operation">
                <form action="crud.jsp" method="POST">
                    <input type="hidden" name="action" value="updateCategory"/>
                    <label for="categoryId">Category:</label>
                    <select name="categoryId">
                        <!-- Options dynamically populated from DB -->
                    </select>
                    <label for="newCategoryName">New Category Name:</label>
                    <input type="text" name="categoryName"/>
                    <input type="submit" value="Update Category"/>
                </form>
            </div>

            <h3>Delete Category:</h3>
            <div class="operation">
                <form action="crud.jsp" method="POST">
                    <input type="hidden" name="action" value="deleteCategory"/>
                    <label for="deleteCategoryId">Category:</label>
                    <select name="categoryId">
                        <!-- Options dynamically populated from DB -->
                    </select>
                    <input type="submit" value="Delete Category"/>
                </form>
            </div>
        </div> <!-- End Category CRUD Section -->

        <!-- Product CRUD Section -->
        <div class="crud-section product-section">
            <h3>Add a New Product:</h3>
            <div class="operation">
                <form action="crud.jsp" method="POST">
                    <input type="hidden" name="action" value="createProduct"/>
                    <label for="productName">Product Name:</label>
                    <input type="text" id="productName" name="productName"/>
                    <label for="price">Price:</label>
                    <input type="text" name="price"/>
                    <label for="imageUrl">Image URL:</label>
                    <input type="text" name="imageUrl"/>
                    <label for="categoryId">Category:</label>
                    <select name="categoryId">
                        <!-- Options dynamically populated from DB -->
                    </select>
                    <input type="submit" value="Add Product"/>
                </form>
            </div>

            <h3>Update Existing Product:</h3>
            <div class="operation">
                <form action="crud.jsp" method="POST">
                    <input type="hidden" name="action" value="updateProduct"/>
                    <label for="productId">Product:</label>
                    <select name="productId">
                        <!-- Options dynamically populated from DB -->
                    </select>
                    <label for="newProductName">New Product Name:</label>
                    <input type="text" name="productName"/>
                    <label for="newPrice">New Price:</label>
                    <input type="text" name="price"/>
                    <label for="newImageUrl">New Image URL:</label>
                    <input type="text" name="imageUrl"/>
                    <label for="newCategoryId">Category:</label>
                    <select name="categoryId">
                        <!-- Options dynamically populated from DB -->
                    </select>
                    <input type="submit" value="Update Product"/>
                </form>
            </div>

            <h3>Delete Product:</h3>
            <div class="operation">
                <form action="crud.jsp" method="POST">
                    <input type="hidden" name="action" value="deleteProduct"/>
                    <label for="deleteProductId">Product:</label>
                    <select name="productId">
                        <!-- Options dynamically populated from DB -->
                    </select>
                    <input type="submit" value="Delete Product"/>
                </form>
            </div>
        </div> <!-- End Product CRUD Section -->
    </div> <!-- End Container -->
</body>
</html>
