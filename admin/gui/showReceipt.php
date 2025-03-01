<?php
if (isset($_POST['id'])) {
    require_once __DIR__ . "/../../database/database.php";
    require_once __DIR__ . "/../../database/receipt.php";
    require_once __DIR__ . "/../../handle.php";

    $db = new database();
    $receipt = new receipt($db);

    $id = $_POST['id'];
    $infoReceipt = $receipt->getInfoReceipt($id);
    $detailReceipt = $receipt->selectDetailReceiptShow($id);
}
?>

<div class="modal-content">
    <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Thông tin phiếu nhập</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body container-fluid row" style="margin: auto;">
        <div class="info col-12 row">
            <div class="receiver col-12 mb-3">
                <h5 class="text-danger">Người nhập:
                    <span class="text-capitalize text-black">
                        <?php echo $infoReceipt['staff']; ?>
                    </span>
                </h5>
            </div>
            <div class="totalBill col-12 mb-3">
                <h5 class="text-danger">Tổng tiền phiếu nhập:
                    <span class="text-capitalize text-black">
                        <?php echo convertPrice($infoReceipt['totalReceipt']); ?>
                    </span>
                </h5>
            </div>
            <div class="order-time col-12 mb-3">
                <h5 class="text-danger">Thời gian nhập:
                    <span class="text-black">
                        <?php echo convertTime($infoReceipt['createTime']) . ", ngày " . convertDate($infoReceipt['createTime']); ?>
                    </span>
                </h5>
            </div>
        </div>

        <div class="list-product col-12" style="border-top: 1px solid black;">
            <h3 class="text-center text-uppercase mt-3 mb-3">Danh sách sản phẩm:</h3>

            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Ảnh</th>
                        <th style="width: 35%;">Tên sản phẩm</th>
                        <th style="width: 35%;">Nhà cung cấp</th>
                        <th style="width: 10%;">Giá</th>
                        <th style="width: 5%;">Size</th>
                        <th style="width: 5%;">Số lượng</th>
                        <th>Tổng tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($detailReceipt as $d) {
                        ?>
                        <tr>
                            <td>
                                <?php
                                $img = "." . $d['image'];
                                ?>
                                <img src="<?= $img ?>" alt="" class="img-fluid" width="100">
                            </td>
                            <td>
                                <?= $d['productName'] ?>
                            </td>
                            <td>
                                <?= $d['nameSupplier'] ?>
                            </td>
                            <td>
                                <?= convertPrice($d['pucharsePrice']) ?>
                            </td>
                            <td>
                                <?= $d['size'] ?>
                            </td>
                            <td>
                                <?= $d['quantity'] ?>
                            </td>
                            <td>
                                <?= convertPrice($d['pucharsePrice'] * $d['quantity']) ?>
                            </td>
                        </tr>

                        <?php
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
</div>