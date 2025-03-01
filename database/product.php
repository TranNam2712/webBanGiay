<?php

class product
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function selectAll()
    {
        $sql = "SELECT * FROM products
            JOIN BRANDS ON products.idBrand = BRANDS.idBrand
            JOIN imageProductS ON products.idProduct = imageProductS.idProduct
            WHERE products.STATUS = 1
            GROUP BY products.idProduct";
        return $this->db->selectAll($sql);
    }

    public function selectByCondition($sql)
    {
        return $this->db->selectAll($sql);
    }

    public function selectProductNew()
    {
        $sql = "SELECT *
            FROM products JOIN imageProductS ON products.idProduct = imageProductS.idProduct
            WHERE products.STATUS = 1
            GROUP BY products.idProduct
            ORDER BY products.idProduct DESC LIMIT 10";
        return $this->db->selectAll($sql);
    }

    public function selectProductBestSeller()
    {
        $sql = "SELECT *
            FROM products
            JOIN imageProductS ON products.idProduct = imageProductS.idProduct
            WHERE products.STATUS = 1
            GROUP BY products.idProduct
            ORDER BY products.quantitySold DESC LIMIT 10";
        return $this->db->selectAll($sql);
    }

    public function selectProductById($id)
    {
        $sql = "SELECT * FROM products
            JOIN BRANDS ON products.idBrand = BRANDS.idBrand
            WHERE idProduct = $id";
        $result = $this->db->selectAll($sql);
        return $result->fetch_assoc();
    }

    public function selectImageById($id)
    {
        $sql = "SELECT * FROM imageproducts WHERE idProduct = $id";
        $result = $this->db->selectAll($sql);
        $images = [];
        while ($row = $result->fetch_assoc()) {
            $images[] = $row;
        }
        return $images;
    }

    public function selectSizeById($id)
    {
        $sql = "SELECT *
                    FROM sizeproducts
                    WHERE idProduct = $id
                    and STATUSSIZE = 1";
        $result = $this->db->selectAll($sql);
        $sizes = [];
        while ($row = $result->fetch_assoc()) {
            $sizes[] = $row;
        }
        return $sizes;
    }

    public function selectProductByDesignType($type)
    {
        $sql = "SELECT * FROM products JOIN imageproducts
                    ON products.idProduct = imageproducts.idProduct
                    WHERE designType = '$type'
                    GROUP BY products.idProduct
                    ORDER BY products.idProduct DESC";
        $result = $this->db->selectAll($sql);
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
        return $products;
    }
    public function selectProductByDesignTypeSupplier($type, $idSupplier)
    {
        $sql = "SELECT p.*
                FROM products p
                LEFT JOIN supplierDetail s ON p.idProduct = s.idProduct AND s.idSupplier = $idSupplier
                WHERE s.idProduct IS NULL AND p.designType = '$type'";
        $result = $this->db->selectAll($sql);
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
        return $products;
    }
    public function selectProductsByPrice($idBrand, $limit)
    {
        $sql = "SELECT *
                FROM products
                WHERE products.STATUS = 1 AND products.idBrand = $idBrand
                ORDER BY products.currentPrice DESC LIMIT $limit";

        $result = $this->db->selectAll($sql);
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
        return $products;
    }

    public function deleteImageProduct($idImage)
    {
        $sql = "SELECT * FROM imageproducts WHERE idImage = $idImage";
        $result = $this->db->selectAll($sql);
        $row = $result->fetch_assoc();
        $image = $row['image'];
        $link = __DIR__ . '/.' . $image;
        unlink($link);

        $sql = "DELETE FROM imageproducts WHERE idImage = $idImage";

        return $this->db->delete($sql);
    }

    public function updateImageProduct($idImage, $image)
    {
        require_once __DIR__ . '/../handle.php';
        $imageSQL = changeImageProduct($image, $idImage, $this->db);
        $sql = "UPDATE imageproducts SET image = '$imageSQL'
            WHERE idImage = $idImage";
        $this->db->update($sql);
        return $imageSQL;
    }

    public function updateBrandAndDesignType($idBrand, $designType, $idProduct)
    {
        $sql = "UPDATE PRODUCTS SET IDBRAND = $idBrand,
            DESIGNTYPE = '$designType'
            WHERE IDPRODUCT = $idProduct";
        return $this->db->update($sql);
    }

    public function updateNameAndPrice($id, $name, $price)
    {
        if ($price == '') {
            $sql = "UPDATE products SET productName = '$name'
                WHERE idProduct = $id";
        } else {
            $sql = "UPDATE products SET productName = '$name', oldPrice = currentPrice
                WHERE idProduct = $id";
            $this->db->update($sql);
            $sql = "UPDATE products SET currentPrice = $price
                WHERE idProduct = $id";
        }
        return $this->db->update($sql);
    }
    public function updateQuantityProduct($idProduct, $quantity, $size)
    {
        $sql = "UPDATE sizeproducts set quantityRemain = quantityRemain-$quantity
        where idProduct= $idProduct and size= $size ";
        return $this->db->update($sql);
    }

    public function insertProduct($idBrand, $designType, $name, $price, $size, $image)
    {
        $sql = "INSERT INTO products (idBrand, designType, productName, currentPrice)
            VALUES ($idBrand, '$designType', '$name', $price)";
        $id = $this->db->insert($sql);
        foreach ($size as $s) {
            $this->addSizeProduct($id, $s);
        }

        $index = 1;
        foreach ($image as $i) {
            $base = explode('/', $i);
            $arr = explode('.', $base[2]);
            $file = __DIR__ . '/../admin/' . $i;
            $target = __DIR__ . '/../image/products/' . $id . '-' . $index . '.' . $arr[1];
            copy($file, $target);
            $imageLink = "./image/products/" . $id . '-' . $index . '.' . $arr[1];
            $sql = "INSERT INTO imageproducts (idProduct, image) values ($id, '$imageLink')";
            $this->db->insert($sql);
            $index++;
        }

        return $id;
    }

    public function addImageProduct($idProduct, $image)
    {
        require_once __DIR__ . '/../handle.php';
        $imageSQL = uploadsImageProduct($image, $idProduct, $this->db);
        $sql = "INSERT INTO imageproducts (idProduct, image) values ($idProduct, '$imageSQL')";
        $id = $this->db->insert($sql);
        $data = [
            'id' => $id,
            'image' => $imageSQL
        ];
        return $data;
    }

    public function addSizeProduct($idProduct, $size)
    {
        $sql = "INSERT INTO sizeproducts (idProduct, size) values ($idProduct, '$size')";
        return $this->db->insert($sql);
    }

    public function deleteSizeProduct($idProduct, $size)
    {
        $sql = "UPDATE sizeproducts SET STATUSSIZE = 0
            WHERE idProduct = $idProduct
            and size = '$size'";
        return $this->db->update($sql);
    }

    public function deleteProduct($id)
    {
        $sql = "UPDATE products SET STATUS = 0 WHERE idProduct = $id";
        return $this->db->update($sql);
    }

    public function getQuantityProduct()
    {
        $sql = "SELECT *
            FROM PRODUCTS
            WHERE STATUS = 1";
        return $this->db->selectAll($sql)->num_rows;
    }

    public function pagination($itemOfPage, $valueSearch)
    {
        $sql = "SELECT * FROM products WHERE STATUS = 1";
        if ($valueSearch != "") {
            $sql .= "  AND productName like '%$valueSearch%'";
        }
        $items = $this->db->selectAll($sql)->num_rows;
        $page = ceil($items / $itemOfPage);
        return $page;
    }
    public function paginationInSupplier($itemOfPage, $valueSearch, $idSupplier)
    {
        $sql = "SELECT * FROM supplierDetail join products on supplierDetail.idproduct = products.idProduct WHERE idSupplier = $idSupplier  and STATUS =1";
        if ($valueSearch != "") {
            $sql .= "  AND productName like '%$valueSearch%'";
        }
        $items = $this->db->selectAll($sql)->num_rows;
        $page = ceil($items / $itemOfPage);
        return $page;
    }
}
