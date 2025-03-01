<?php
require_once __DIR__ . "/../../database/database.php";
require_once __DIR__ . "/../../database/supplier.php";
require_once __DIR__ . "\\..\\..\\handle.php";

$db = new database();
$supplier = new supplier($db);

if (isset($_POST['edit'])) {
    $idProduct = $_POST['idProduct'];
    $idSupplier = $_POST['idSupplier'];
    $price = $_POST['price'];
    echo $supplier->updateDetailSupplier($idSupplier, $idProduct, $price);
    exit();
}

if (isset($_POST['edit-purcharse-price'])) {
    $idSupplier = $_POST['idSupplierEdit'];
    $idProduct = $_POST['idProductEdit'];
    $infoSupplier = $supplier->selectDetailByIdSupplierAndIdProduct($idSupplier, $idProduct);
}
?>

<div class="modal-content">
    <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Sửa giá nhập</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
        <form action="" class="container-fluid row">
            <div class="mb-3 col-12">
                <label for="full-name" class="form-label">Tên nhà cung cấp</label>
                <input type="text" class="form-control" id="supplier-name-edit" placeholder="Nhập tên nhà cung cấp"
                    readonly value="<?php echo $infoSupplier['nameSupplier']; ?>">
                <span class="text-danger"></span>
            </div>
            <div class="mb-3 col-12">
                <label for="full-name" class="form-label">Tên sản phẩm</label>
                <input type="text" class="form-control" id="supplier-product-edit" readonly
                    value="<?php echo $infoSupplier['productName']; ?>">
                <span class="text-danger"></span>
            </div>
            <div class="mb-3 col-12">
                <label for="full-name" class="form-label">Giá nhập</label>
                <input type="text" class="form-control" id="supplier-price-edit" placeholder="Nhập giá nhập"
                    value="<?php echo ($infoSupplier['price']); ?>">
                <span class="text-danger"></span>
            </div>
        </form>
    </div>
    <div class="modal-footer d-flex justify-content-center">
        <button type="button" class="btn btn-primary" id="save-btn"
            data-idSup="<?php echo $infoSupplier['idSupplier']; ?>"
            data-idProduct="<?php echo $infoSupplier['idProduct']; ?>">
            Lưu thay đổi
        </button>
    </div>
</div>