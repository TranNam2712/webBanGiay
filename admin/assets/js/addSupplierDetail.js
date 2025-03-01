$(document).ready(function () {
    // load script
    $.when($.getScript("../js/validate.js")).done(function () { });

    $(".container").on('change', '#name-supplier', function () {
        var subBrand = $('#design-type-spd').val();
        var idSupplier = $("#name-supplier").val();
        console.log(subBrand);
        console.log(idSupplier);


        $.ajax({
            type: "POST",
            url: "./gui/addSupplierDetail.php",
            data: {
                "subBrand": subBrand,
                "idSupplier": idSupplier,
                "get-products": true
            },
            dataType: "json",
            success: function (response) {
                $("#name-product-spd").empty();
                if (response.products && response.products.length > 0) {
                    $.each(response.products, function (key, value) {
                        console.log(value);
                        $("#name-product-spd").append(
                            "<option value='" + value['idProduct'] + "' data-name='" + value['productName'] + "'>" +
                            value['productName'] + "</option>"
                        );
                    });
                } else {
                    $("#name-product-spd").append(
                        "<option >" +
                        "Nhà cung cấp đã liên kết toàn bộ sản phẩm thuộc dòng này" + "</option>"
                    );
                    console.log("Không có sản phẩm nào!");
                }
            }
        });
    });


    $(".container").on('change', '#brand-spd', function () {
        var idBrand = $(this).val();
        var idSupplier = $("#name-supplier").val();
        $.ajax({
            type: "POST",
            url: "./gui/addSupplierDetail.php",
            data: {
                "idBrand": idBrand,
                "idSupplier": idSupplier,
                "get-sub-brand": true,
                "get-products": true
            },
            dataType: "json",
            success: function (response) {
                console.log(response);
                // cap nhat subBrand
                $("#design-type-spd").empty();
                $.each(response.subBrand, function (key, value) {
                    $("#design-type-spd").append("<option value='" + value['subBrandName'] + "'>" + value['subBrandName'] + "</option>");
                });
                //cap nhat ten san pham
                $("#name-product-spd").empty();
                if (response.products && response.products.length > 0) {
                    $.each(response.products, function (key, value) {
                        console.log(value);
                        $("#name-product-spd").append(
                            "<option value='" + value['idProduct'] + "' data-name='" + value['productName'] + "'>" +
                            value['productName'] + "</option>"
                        );
                    });
                } else {
                    $("#name-product-spd").append(
                        "<option >" +
                        "Nhà cung cấp đã liên kết toàn bộ sản phẩm thuộc dòng này" + "</option>"
                    );
                    console.log("Không có sản phẩm nào!");
                }
            }
        });
    });

    $(".container").on('change', '#design-type-spd', function () {
        var subBrand = $(this).val();
        var idSupplier = $("#name-supplier").val();
        $.ajax({
            type: "POST",
            url: "./gui/addSupplierDetail.php",
            data: {
                "subBrand": subBrand,
                "idSupplier": idSupplier,
                "get-products": true
            },
            dataType: "json",
            success: function (response) {
                console.log(response);
                $("#name-product-spd").empty();
                if (response.products && response.products.length > 0) {
                    $.each(response.products, function (key, value) {
                        console.log(value);
                        $("#name-product-spd").append(
                            "<option value='" + value['idProduct'] + "' data-name='" + value['productName'] + "'>" +
                            value['productName'] + "</option>"
                        );
                    });
                } else {
                    $("#name-product-spd").append(
                        "<option >" +
                        "Nhà cung cấp đã liên kết toàn bộ sản phẩm thuộc dòng này" + "</option>"
                    );
                    console.log("Không có sản phẩm nào!");
                }
            }
        });
    });
    //add supplier
    $(".container").on('click', '#save-supplier-detail', function (e) {
        e.preventDefault();
        var idSupplier = $("#name-supplier").val();
        var idProduct = $("#name-product-spd").val();
        var price = $("#supplier-price").val();
        if (idProduct === "") {
            Swal.fire({
                icon: 'error',
                title: 'Không có sản phẩm nào được chọn!',
                text: 'Xin vui lòng chọn sản phẩm',
            });
            return;
        }
        if (idSupplier === "") {
            Swal.fire({
                icon: 'error',
                title: 'Không có nhà cung cấp nào được chọn!',
                text: 'Xin vui lòng chọn nhà cung cấp',
            });
            return;
        }
        if (price === "") {
            Swal.fire({
                icon: 'error',
                title: 'Không được để trống giá nhâp!',
                text: 'Xin vui lòng nhập vào giá',
            });
            return;
        }
        if (isNaN(price) || price <= 0) {
            Swal.fire({
                icon: 'error',
                title: "Giá phải là số nguyên dương",
            });
            return;
        }
        var formData = new FormData();
        formData.append('add-supplier-detail', true);
        formData.append('idSupplier', idSupplier);
        formData.append('idProduct', idProduct);
        formData.append('price', price);
        $.ajax({
            type: "POST",
            url: "./gui/addSupplierDetail.php",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log(response)
                if (response === "Thêm thành công") {
                    $("#supplier-price").val("");
                    swal.fire({
                        icon: 'success',
                        title: 'Đã thêm chi tiết nhà cung cấp',
                    });
                }
            }
        });

    });
});