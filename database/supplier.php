<?php
class supplier
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
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

    public function updateSupplier($id, $name, $phone, $email, $address)
    {
        $sql = "UPDATE suppliers SET nameSupplier = '$name', phoneNumber = '$phone', email = '$email', addressSupplier = '$address' 
            WHERE idSupplier = $id";
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
            $sql .= "  AND productName like '%$valueSearch%'";
        }
        $items = $this->db->selectAll($sql)->num_rows;
        $page = ceil($items / $itemOfPage);
        return $page;
    }
}
?>