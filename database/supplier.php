<?php
class supplier
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function selectAll()
    {
        $sql = "SELECT * FROM suppliers
            GROUP BY suppliers.idsupplier";
        return $this->db->selectAll($sql);
    }
    public function selectDetailByProduct($idProduct)
    {
        $sql = "SELECT * FROM supplierDetail
                JOIN suppliers on supplierDetail.idSupplier = suppliers.idSupplier
                WHERE idProduct = $idProduct
            GROUP BY supplierDetail.idsupplier";
        $result = $this->db->selectAll($sql);
        $details = [];
        while ($row = $result->fetch_assoc()) {
            $details[] = $row;
        }
        return $details;
    }
    public function selectDetailByIdSupplier($idSupplier)
    {
        $sql = "SELECT * FROM supplierDetail
                JOIN products on products.idProduct = supplierDetail.idProduct
                WHERE idSupplier = $idSupplier
            GROUP BY supplierDetail.idProduct";
        $result = $this->db->selectAll($sql);
        $details = [];
        while ($row = $result->fetch_assoc()) {
            $details[] = $row;
        }
        return $details;
    }
    public function selectDetailByIdSupplierAndIdProduct($idSupplier, $idProduct)
    {
        $sql = "SELECT * FROM supplierDetail
                JOIN suppliers on supplierDetail.idSupplier = suppliers.idSupplier
                JOIN products on products.idProduct = supplierDetail.idProduct
                WHERE supplierDetail.idProduct = $idProduct and supplierDetail.idSupplier=$idSupplier ";
        $result = $this->db->selectAll($sql);
        $row = $result->fetch_assoc();
        return $row;
    }
    public function selectByCondition($sql)
    {
        return $this->db->selectAll($sql);
    }
    public function selectById($id)
    {
        $sql = "SELECT *
                    FROM suppliers
                    WHERE idsupplier = $id
                    and STATUSREMOVE = 0";
        $result = $this->db->selectAll($sql);
        $row = $result->fetch_assoc();
        return $row;
    }

    public function selectDetailSupplier($idSup, $idProduct)
    {
        $sql = "SELECT *
                    FROM supplierDetail
                    WHERE idsupplier = $idSup
                    and idproduct = $idProduct";
        $result = $this->db->selectAll($sql);
        $row = $result->fetch_assoc();
        return $row;
    }
    public function selectALLDetailSupplier($idSup)
    {
        $sql = "SELECT *
                    FROM supplierDetail
                    WHERE idsupplier = $idSup";
        $result = $this->db->selectAll($sql);
        $details = [];
        while ($row = $result->fetch_assoc()) {
            $details[] = $row;
        }
        return $details;
    }
    public function insertSupplier($name, $phone, $email, $address)
    {
        // insert Receipt
        $sql = "INSERT INTO suppliers (nameSupplier, phoneNumber, email,addressSupplier) VALUES ('$name', '$phone', '$email', '$address')";
        $idReceipt = $this->db->insert($sql);
        if (!$idReceipt) {
            return "Lỗi: Không thể tạo Supplier.";
        }
        return "Thêm thành công";
    }

    public function insertDetailSupplier($idSupplier, $idProduct, $price)
    {
        $sql = "INSERT INTO supplierDetail (idSupplier, idProduct,price) VALUES ($idSupplier,$idProduct,$price)";
        $rs = $this->db->insert($sql);
        return "Thêm thành công";
    }

    public function updateSupplier($id, $name, $phone, $email, $address)
    {
        $sql = "UPDATE suppliers SET nameSupplier = '$name', phoneNumber = '$phone', email = '$email', addressSupplier = '$address' 
            WHERE idSupplier = $id";
        if ($this->db->update($sql) == 1) {
            return "Sửa thành công";
        }
        return "Erro";
    }
    public function updateDetailSupplier($idSupplier, $idProduct, $price)
    {
        $sql = "UPDATE supplierDetail SET price = $price
            WHERE idSupplier = $idSupplier and idProduct=$idProduct";
        if ($this->db->update($sql) == 1) {
            return "Sửa thành công";
        }
        return "Erro";
    }
    public function deleteSupplier($idSupplier)
    {
        $sql = "UPDATE suppliers SET statusRemove = 1 WHERE idSupplier = $idSupplier";
        return $this->db->update($sql);
    }
    public function deleteSupplierDetail($idSupplier, $idProduct)
    {
        $sql = "DELETE FROM supplierdetail WHERE idSupplier = $idSupplier and idProduct = $idProduct";
        return $this->db->update($sql);
    }
    public function getSuppliers()
    {
        $sql = "SELECT * FROM suppliers";
        $result = $this->db->selectAll($sql);
        $receipt = [];
        while ($row = $result->fetch_assoc()) {
            $receipt[] = $row;
        }
        return $receipt;
    }
    public function pagination($itemOfPage, $valueSearch)
    {
        $sql = "SELECT * FROM suppliers WHERE STATUSREMOVE = 0";
        if ($valueSearch != "") {
            $sql .= "  AND nameSupplier like '%$valueSearch%'";
        }
        $items = $this->db->selectAll($sql)->num_rows;
        $page = ceil($items / $itemOfPage);
        return $page;
    }
}
?>