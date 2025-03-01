<?php
require_once __DIR__ . "/../../database/database.php";
require_once __DIR__ . "/../../database/supplier.php";

$db = new database();

$supplier = new supplier($db);
$suppliers = $supplier->getSuppliers();
?>

<div class="page-inner info-supplier-detail">
    <h3 class="page-title">Thông tin sản phẩm được cung cấp</h3>

    <div class="product-tools">
        <div class="show">
            <span>Hiển thị sản phẩm của nhà cung cấp :</span>
            <select class="form-select" name="itemOfPage" id="supplier-detail" class="form-control">
                <?php
                $idSupplier = "";
                $i = 0;
                foreach ($suppliers as $key => $row) {
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
        </div>

        <div class="search">
            <input type="text" placeholder="Tìm kiếm" class="form-control" />
        </div>
    </div>

    <div class="table-product">
        <?php
        include_once __DIR__ . "/tableSupplierDetail.php";
        ?>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">

        </div>
    </div>

</div>