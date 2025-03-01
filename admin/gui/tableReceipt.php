<?php

require_once __DIR__ . "/../../database/database.php";
require_once __DIR__ . "/../../database/receipt.php";
require_once __DIR__ . "\\..\\..\\handle.php";

$db = new database();

$product = new receipt($db);

if (isset($_POST['delete-receipt'])) {
    $id = $_POST['id'];
    $product->deleteReceipt($id);
    exit();
}

$page = (int) isset($_POST['page']) ? $_POST['page'] : 1;
$itemOfPage = (int) isset($_POST['itemOfPage']) ? $_POST['itemOfPage'] : 10;
$valueSearch = isset($_POST['valueSearch']) ? $_POST['valueSearch'] : "";

$sql = "SELECT * FROM receipts
    WHERE receipts.STATUSREMOVE = 0";
$sql .= " GROUP BY receipts.idReceipt
    ORDER BY receipts.idReceipt DESC ";
$sql .= " LIMIT " . ($page - 1) * $itemOfPage . ", " . $itemOfPage;

$products = $product->selectByCondition($sql);

?>

<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
            <tr>
                <th>Người nhập</th>
                <th>Tổng tiền</th>
                <th>Chức năng</th>
            </tr>
        </thead>
        <tbody>
            <?php
            if ($products->num_rows <= 0) {
                ?>

                <tr>
                    <td colspan="3">Không tìm thấy phiếu nhập</td>
                </tr>


                <?php
            }
            foreach ($products as $product) {
                ?>
                <tr>
                    <td>
                        <?php echo $product['staff'] ?>
                    </td>
                    <td>
                        <?php echo convertPrice($product['totalReceipt']) ?>
                    </td>
                    <td>
                        <div class="action">
                            <i class="fa fa-trash detete-receipt" data-id="<?php echo $product['idReceipt'] ?>"></i>
                            <i class="fas fa-eye show-receipt" data-bs-toggle="modal" data-bs-target="#modalReceipt"
                                data-id="<?= $product['idReceipt']; ?>"></i>
                        </div>
                    </td>
                </tr>

                <?php
            }
            ?>
        </tbody>
    </table>
</div>

<div class="pagination">
    <ul class="pagination">
        <!-- <li class="page-item">
            <a class="page-link previous disabled" href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                <span class="sr-only">Previous</span>
            </a>
        </li> -->

        <?php
        $db = new database();
        $product = new receipt($db);
        $page = $product->pagination($itemOfPage);
        for ($i = 1; $i <= $page; $i++) {
            ?>

            <?php
            if ($i == 1) {
                ?>

                <li class="page-item active"><a class="page-link" href="#"><?php echo $i ?></a></li>

                <?php
            } else {
                ?>

                <li class="page-item"><a class="page-link" href="#"><?php echo $i ?></a></li>

                <?php
            }
        }
        ?>
        <!-- 
        <li class="page-item">
            <a class="page-link next" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                <span class="sr-only">Next</span>
            </a>
        </li> -->
    </ul>
</div>