<?php
require_once __DIR__ . "/../../database/database.php";
require_once __DIR__ . "/../../database/supplier.php";
require_once __DIR__ . "/../../database/product.php";
require_once __DIR__ . "/../../database/brand.php";


$db = new database();
$supplier = new supplier($db);
$brand = new brand($db);
$product = new product($db);

$suppliers = $supplier->selectAll();


if (isset($_POST['add-supplier-detail'])) {
    $idSupplier = $_POST['idSupplier'];
    $idProduct = $_POST['idProduct'];
    $price = $_POST['price'];
    echo $supplier->insertDetailSupplier($idSupplier, $idProduct, $price);
    exit();
}
$results = (object) [
    'subBrand' => [],
    'products' => [],
];

if (isset($_POST['get-sub-brand'])) {
    $id = $_POST['idBrand'];
    $idSupplier = $_POST['idSupplier'];
    $result = $brand->selectSubBrandById($id);
    $subBrands = [];
    while ($row = $result->fetch_assoc()) {
        $subBrands[] = $row;
    }
    $results->subBrand = $subBrands;
    $result = $product->selectProductByDesignTypeSupplier($subBrands[0]['subBrandName'], $idSupplier);
    $results->products = $result;
    // echo ($result);
    echo json_encode($results);
    exit();
}

if (isset($_POST['get-products'])) {
    $subBrand = $_POST['subBrand'];
    $idSupplier = $_POST['idSupplier'];
    $result = $product->selectProductByDesignTypeSupplier($subBrand, $idSupplier);
    $results->products = $result;
    echo json_encode($results);
    exit();
}
?>

<div class="add-supplier container">
    <div class="title">
        <h1>Thêm chi tiết nhà cung cấp</h1>
    </div>

    <div class="content">
        <form action="" method="post" class="row" id="formAddProduct" enctype="multipart/form-data">

            <div class="form-floating col-12 mb-3">
                <select class="form-select" id="name-supplier" aria-label="Floating label select example">
                    <?php
                    $i = 0;
                    $idSupplier = "";
                    while ($row = $suppliers->fetch_assoc()) {
                        if ($i == 0) {
                            $idSupplier = $row['idSupplier'];
                            $i++;
                            ?>
                            <option value="<?= $row['idSupplier']; ?>" selected><?= $row['nameSupplier']; ?></option>

                            <?php
                        } else {
                            ?>
                            <option value="<?= $row['idSupplier']; ?>"><?= $row['nameSupplier']; ?></option>

                            <?php
                        }
                    }
                    ?>
                </select>
                <label for="name-supplier">Nhà cung cấp </label>
            </div>
            <div class="form-floating col-6 mb-3">
                <select class="form-select" id="brand-spd" aria-label="Floating label select example">
                    <?php
                    $result = $brand->selectAll();
                    $id = 0;
                    $i = 0;
                    while ($row = $result->fetch_assoc()) {
                        if ($i == 0) {
                            $id = $row['idBrand'];
                            $i++;
                            ?>
                            <option value="<?= $row['idBrand']; ?>" selected><?= $row['brandName']; ?></option>

                            <?php
                        } else {
                            ?>
                            <option value="<?= $row['idBrand']; ?>"><?= $row['brandName']; ?></option>

                            <?php
                        }
                    }
                    ?>
                </select>
                <label for="brand">Hãng</label>
            </div>

            <div class="form-floating col-6 mb-3">
                <select class="form-select" id="design-type-spd" aria-label="Floating label select example">
                    <?php
                    $result = $brand->selectSubBrandById($id);
                    $subBrands = "";
                    $i = 0;
                    while ($row = $result->fetch_assoc()) {
                        if ($i == 0) {
                            $subBrands = $row['subBrandName'];

                            $i++;
                            ?>
                            <option value="<?= $row['subBrandName']; ?>" selected><?= $row['subBrandName']; ?></option>

                            <?php
                        } else {
                            ?>
                            <option value="<?= $row['subBrandName']; ?>"><?= $row['subBrandName']; ?></option>

                            <?php
                        }
                    }
                    ?>
                </select>
                <label for="design-type">Thiết kế</label>
            </div>
            <div class="form-floating col-12 mb-3">
                <select class="form-select" id="name-product-spd" aria-label="Floating label select example">
                    <?php
                    $result = $product->selectProductByDesignTypeSupplier($subBrands, $idSupplier);
                    $i = 0;
                    $idProduct = 0;
                    foreach ($result as $key => $row) {
                        if ($i == 0) {
                            $idProduct = $row['idProduct'];
                            $i++;
                            ?>
                            <option value="<?= $row['idProduct']; ?>" data-name="<?= $row['productName']; ?>" selected>
                                <?= $row['productName']; ?>
                            </option>

                            <?php
                        } else {
                            ?>
                            <option value="<?= $row['idProduct']; ?>" data-name="<?= $row['productName']; ?>">
                                <?= $row['productName']; ?>
                            </option>

                            <?php
                        }
                    }
                    ?>
                </select>
                <label for="name-product">Tên sản phẩm</label>
            </div>
            <div class="form-floating mb-3 col-12">
                <input type="text" class="form-control" id="supplier-price" placeholder="Nhập vào giá nhập">
                <label for="product-name">Giá nhập</label>
            </div>
            <div class="image col-12">
                <div class="accordion accordion-flush" id="accordionFlushExample">

                </div>
            </div>

            <div class="form-group mt-3 d-flex justify-content-center align-items-center col-12">
                <button class="btn btn-primary" id="save-supplier-detail">Thêm nhà chi tiết nhà cung cấp</button>
            </div>

        </form>
    </div>
</div>