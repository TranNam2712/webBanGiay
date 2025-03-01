<?php
require_once __DIR__ . "/../../database/database.php";
require_once __DIR__ . "/../../database/brand.php";
require_once __DIR__ . "/../../database/product.php";
require_once __DIR__ . "/../../database/receipt.php";
require_once __DIR__ . "/../../database/supplier.php";
require_once __DIR__ . "\\..\\..\\handle.php";


session_start();
// unset($_SESSION['receipt']);
$db = new database();
$brand = new brand($db);
$product = new product($db);
$receipt = new receipt($db);
$supplier = new supplier($db);
$results = (object) [
    'subBrand' => [],
    'products' => [],
    'size' => [],
    'detailSup' => [],

];

if (isset($_POST['get-sub-brand'])) {
    $id = $_POST['idBrand'];
    $result = $brand->selectSubBrandById($id);

    $subBrands = [];
    while ($row = $result->fetch_assoc()) {
        $subBrands[] = $row;
    }
    $results->subBrand = $subBrands;
    $result = $product->selectProductByDesignType($subBrands[0]['subBrandName']);
    $results->products = $result;
    $results->size = $product->selectSizeById($results->products[0]["idProduct"]);
    $results->detailSup = $supplier->selectDetailByProduct($results->products[0]["idProduct"]);
    echo json_encode($results);
    exit();
}

if (isset($_POST['get-products'])) {
    $subBrand = $_POST['subBrand'];
    $result = $product->selectProductByDesignType($subBrand);
    $results->products = $result;
    $results->size = $product->selectSizeById($results->products[0]["idProduct"]);
    $results->detailSup = $supplier->selectDetailByProduct($results->products[0]["idProduct"]);
    echo json_encode($results);
    exit();
}
if (isset($_POST['get-size'])) {
    $idProduct = $_POST['idProduct'];
    $result = $product->selectSizeById($idProduct);
    $results->size = $result;
    $results->detailSup = $supplier->selectDetailByProduct($idProduct);
    echo json_encode($results);
    exit();
}
if (isset($_POST['get-remain'])) {
    $idProduct = $_POST['idProduct'];
    $size = $_POST['size'];
    $result = $product->selectSizeById($idProduct);

    $results->size = $result;
    echo json_encode($results);
    exit();
}
if (isset($_POST['deleteReceipt'])) {
    $index = $_POST['index'];
    if (isset($_SESSION['receipt']['data'][$index])) {
        $_SESSION['receipt']['total'] -= $_SESSION['receipt']['data'][$index]['total'];
        unset($_SESSION['receipt']['data'][$index]);
        $response = [
            "message" => "success",
            'total' => $_SESSION['receipt']['total']
        ];
        echo json_encode($response);
    }
    exit();
}
if (isset($_POST['addReceipt'])) {
    $idProduct = $_POST['idProduct'];
    $name = $_POST['name'];
    $size = $_POST['size'];
    $idSupplier = $_POST['supplier'];
    $namencc = $_POST['nameSupplier'];
    $price = $_POST['price'];
    $quantity = $_POST['quantity'];
    $results = $product->selectImageById($idProduct);
    $message = addToReceipt($idProduct, $idSupplier, $namencc, $size, $quantity, $price, $name, $results[0]['image']);

    $response = [
        "message" => $message,
        "product" => $_SESSION['receipt']['data'][$idProduct . '-' . $size . '-' . $idSupplier],
        'total' => $_SESSION['receipt']['total']
    ];

    echo json_encode($response);
    exit();
}
function addToReceipt($productId, $idSupplier, $namencc, $size, $quantity, $price, $name, $img)
{
    if (!isset($_SESSION['receipt'])) {
        $_SESSION['receipt'] = [];
        $_SESSION['receipt']['total'] = 0;

    }
    if (isset($_SESSION['receipt']['data'][$productId . '-' . $size . '-' . $idSupplier])) {
        $_SESSION['receipt']['data'][$productId . '-' . $size . '-' . $idSupplier]["quantity"] += $quantity;
        $_SESSION['receipt']['data'][$productId . '-' . $size . '-' . $idSupplier]["total"] = $_SESSION['receipt']['data'][$productId . '-' . $size . '-' . $idSupplier]["quantity"] * $_SESSION['receipt']['data'][$productId . '-' . $size . '-' . $idSupplier]["price"];
        $_SESSION['receipt']['total'] += $quantity * $price;
        return "update";
    } else {
        $newItem = [
            "id" => $productId,
            "idSupplier" => $idSupplier,
            "name" => $name,
            "namencc" => $namencc,
            "size" => $size,
            "price" => $price,
            "quantity" => $quantity,
            "img" => $img,
            "total" => $price * $quantity,
        ];
        $_SESSION['receipt']['data'][$productId . '-' . $size . '-' . $idSupplier] = $newItem;
        $_SESSION['receipt']['total'] += $price * $quantity;
        return 'new';
    }
}
if (isset($_POST['add-list-receipt'])) {
    if (isset($_SESSION['receipt'])) {
        $idUser = $_SESSION['account_login']['idUser'];
        $staff = $_SESSION['account_login']['fullName'];
        $total = $_SESSION['receipt']['total'];
        $result = $receipt->insertReceipt($idUser, $staff, $total);
        echo $result;
        exit();
    }
}
?>


<div class="import-products container">
    <div class="title">
        <h1>Nhập sản phẩm</h1>
    </div>

    <div class="content">
        <form action="" method="post" class="row" id="formAddProduct" enctype="multipart/form-data">

            <div class="form-floating col-6 mb-3">
                <select class="form-select" id="brand-rc" aria-label="Floating label select example">
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
                <select class="form-select" id="design-type-rc" aria-label="Floating label select example">
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
                <select class="form-select" id="name-product-rc" aria-label="Floating label select example">
                    <?php
                    $result = $product->selectProductByDesignType($subBrands);
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

            <div class="form-floating mb-3 col-6">
                <select class="form-select" id="product-size" aria-label="Floating label select example">
                    <?php
                    $result = $product->selectSizeById($idProduct);
                    $i = 0;
                    $reMain = 0;
                    foreach ($result as $key => $row) {
                        if ($i == 0) {
                            $i++;
                            $reMain = $row['quantityRemain'];
                            ?>
                            <option value="<?= $row['size']; ?>" data-remain="<?= $row['quantityRemain']; ?>" selected>
                                <?= $row['size']; ?>
                            </option>

                            <?php
                        } else {
                            ?>
                            <option value="<?= $row['size']; ?>" data-remain="<?= $row['quantityRemain']; ?>">
                                <?= $row['size']; ?>
                            </option>
                            <?php
                        }
                    }
                    ?>
                </select>
                <label for="product-size">Size</label>
            </div>

            <div class="form-floating mb-3 col-6">
                <input type="text" class="form-control" id="inventory-product" placeholder="Số lượng tồn kho"
                    value="<?php echo $reMain ?>" readonly>
                <label for="size-input">Số lượng tồn kho</label>
            </div>

            <div class="form-floating col-12 mb-3">
                <select class="form-select" id="supplier" aria-label="Floating label select example">
                    <?php
                    $result = $supplier->selectDetailByProduct($idProduct);
                    $i = 0;
                    foreach ($result as $key => $row) {
                        if ($i == 0) {
                            $purchasePrice = $supplier->selectDetailSupplier($row["idSupplier"], $idProduct);
                            $i++;
                            ?>
                            <option value="<?= $row['idSupplier']; ?>" data-price="<?= $row['price']; ?>" selected>
                                <?= $row['nameSupplier']; ?>
                            </option>

                            <?php
                        } else {
                            ?>
                            <option value="<?= $row['idSupplier']; ?> " data-price="<?= $row['price']; ?>">
                                <?= $row['nameSupplier']; ?>
                            </option>
                            <?php
                        }
                    }
                    ?>
                </select>
                <label for="name-supplier">Nhà cung cấp</label>
            </div>
            <div class="form-floating col-6 mb-3">
                <input type="text" class="form-control" id="product-price" placeholder="Giá" readonly
                    value="<?php echo convertPrice($purchasePrice['price']) ?>">
                <label for="product-price">Giá</label>
            </div>
            <div class="form-floating col-6 mb-3">
                <input type="text" class="form-control" id="quantity-import" placeholder="Giá">
                <label for="product-price">Số lượng nhập</label>
            </div>


            <div class="image col-12">
                <div class="accordion accordion-flush" id="accordionFlushExample">

                </div>
            </div>

            <div class="form-group mt-3 d-flex justify-content-center align-items-center col-12">
                <button class="btn btn-primary" id="add-receipt">Thêm vào danh sách nhập</button>
            </div>
        </form>
    </div>


    <div class="table-responsive mt-2">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Nhà cung cấp</th>
                    <th>Size</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tổng tiền</th>
                    <th>Chức năng</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (!isset($_SESSION['receipt']) || empty($_SESSION['receipt'])) {
                    ?>
                    <tr>
                        <td colspan="8">Chưa có mặt hàng nào</td>
                    </tr>
                    <?php
                }
                if (!empty($_SESSION['receipt'])) {
                    foreach ($_SESSION['receipt']['data'] as $productId => $item) {
                        ?>
                        <tr>
                            <td>
                                <?php echo $item['name'] ?>
                            </td>
                            <td>
                                <?php
                                $image = '.' . $item['img'] . "?" . time();
                                ?>
                                <img src="<?php echo $image ?>" alt="" width="50" height="50">
                            </td>
                            <td>
                                <?php echo $item['namencc'] ?>
                            </td>
                            <td>
                                <?php echo $item['size'] ?>
                            </td>
                            <td>
                                <?php echo convertPrice($item['price']); ?>
                            </td>
                            <td>
                                <?php echo $item['quantity'] ?>
                            </td>
                            <td>
                                <?php echo convertPrice($item['total']); ?>
                            </td>
                            <td>
                                <div class="action">
                                    <i class="fa fa-trash" id="delete-icon"
                                        data-id="<?php echo $item['id'] . '-' . $item['size'] . '-' . $item['idSupplier'] ?>"></i>
                                </div>
                            </td>
                        </tr>

                        <?php
                    }
                }
                ?>
            </tbody>
        </table>
    </div>
    <form action="" method="post" class="row" id="formAddProduct" enctype="multipart/form-data">

        <div class="form-floating col-12 mb-3">
            <input type="text" class="form-control" id="total-receipt" placeholder="" readonly value="<?php if (isset($_SESSION['receipt'])) {
                echo convertPrice($_SESSION['receipt']['total']);
            } else {
                echo convertPrice('0');
            } ?>">
            <label for="product-price ">Tổng tiền danh sách nhập</label>
        </div>
        <div class="mt-3 d-flex justify-content-center align-items-center col-12">
            <button class="btn btn-danger" id="add-list-receipt">Nhập hàng</button>
        </div>
    </form>
</div>