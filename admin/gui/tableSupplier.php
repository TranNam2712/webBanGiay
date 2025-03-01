<?php

require_once __DIR__ . "/../../database/database.php";
require_once __DIR__ . "/../../database/supplier.php";
require_once __DIR__ . "/../../database/role.php";
require_once __DIR__ . "\\..\\..\\handle.php";

$db = new database();

$supplier = new supplier($db);
$role = new role($db);

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

$tasks = $role->checkPermissionLook($_SESSION['account_login']['idRole'], 8);
$countTask = $tasks->num_rows;
$checkDeleteAndUpdate = false;
foreach ($tasks as $key => $value) {
    if ($value['idTask'] == 2 || $value['idTask'] == 3) {
        $checkDeleteAndUpdate = true;
    }
}


if (isset($_POST['delete-supplier'])) {
    $id = $_POST['id'];
    $supplier->deleteSupplier($id);
    exit();
}

$page = (int) isset($_POST['page']) ? $_POST['page'] : 1;
$itemOfPage = (int) isset($_POST['itemOfPage']) ? $_POST['itemOfPage'] : 10;
$valueSearch = isset($_POST['valueSearch']) ? $_POST['valueSearch'] : "";

$sql = "SELECT * FROM suppliers
    WHERE suppliers.STATUSREMOVE = 0";

if ($valueSearch != "") {
    $sql .= " AND suppliers.nameSupplier like '%$valueSearch%'";
}

$sql .= " GROUP BY suppliers.idSupplier
    ORDER BY suppliers.idSupplier DESC ";
$sql .= " LIMIT " . ($page - 1) * $itemOfPage . ", " . $itemOfPage . " ";

$products = $supplier->selectByCondition($sql);

?>

<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
            <tr>
                <th>Nhà cung cấp</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <?php
                if ($checkDeleteAndUpdate) {
                    ?>
                    <th>Chức năng</th>
                    <?php
                }
                ?>
            </tr>
        </thead>
        <tbody>
            <?php
            if ($products->num_rows < 0) {
                ?>

                <tr>
                    <td colspan="5">Không tìm thấy nhà cung cấp</td>
                </tr>


                <?php
            }
            foreach ($products as $product) {
                ?>
                <tr>
                    <td>
                        <?php echo $product['nameSupplier'] ?>
                    </td>
                    <td>
                        <?php echo $product['phoneNumber'] ?>
                    </td>
                    <td>
                        <?php echo $product['email'] ?>
                    </td>
                    <td>
                        <?php echo $product['addressSupplier'] ?>
                    </td>
                    <?php
                    if ($countTask > 0) {
                        ?>
                        <td>
                            <div class="action">
                                <?php
                                foreach ($tasks as $key => $value) {
                                    if ($value['idTask'] == 2) {
                                        ?>
                                        <i class="fa fa-trash" data-id="<?php echo $product['idSupplier'] ?>"></i>

                                        <?php
                                    }
                                    ?>
                                    <?php
                                    if ($value['idTask'] == 3) {
                                        ?>
                                        <i class="fa fa-edit" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                                            data-id="<?php echo $product['idSupplier'] ?>"></i>
                                        <?php
                                    }
                                }
                                ?>
                            </div>
                        </td>

                        <?php
                    }
                    ?>
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
        $product = new supplier($db);
        $page = $product->pagination($itemOfPage, $valueSearch);
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