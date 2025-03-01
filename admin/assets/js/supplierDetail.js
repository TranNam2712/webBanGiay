$(document).ready(function () {
    $.when($.getScript("../js/validate.js")).done(function () { });
    //swap supplier
    $(".main-panel").on("change", ".container .info-supplier-detail #supplier-detail", function () {
        var id = $(this).val();
        $.ajax({
            type: "POST",
            url: "./gui/tableSupplierDetail.php",
            data: {
                idSupplier: id,
                "swap-supplier": true,
            },
            dataType: "html",
            success: function (response) {
                $(".container .info-supplier-detail .table-product").html(response);
                if ($(".container .info-supplier-detail .pagination li").length - 2 == 1) {
                    $(".container .info-supplier-detail .pagination .next").addClass(
                        "disabled"
                    );
                }
            },
        });
    });

    // show edit product
    $(".main-panel").on(
        "click",
        ".container .info-supplier-detail tbody .fa-edit",
        function (e) {
            e.preventDefault();
            var idProduct = $(this).data("id") + "";

            var idSupplier = $(".container .info-supplier-detail #supplier-detail").val();
            $.ajax({
                type: "POST",
                url: "./gui/editPurcharsePrice.php",
                data: {
                    idProductEdit: idProduct,
                    idSupplierEdit: idSupplier,
                    "edit-purcharse-price": true,
                },
                dataType: "html",
                success: function (response) {
                    $(".main-panel .container .info-supplier-detail .modal-dialog").html(
                        response
                    );
                    $(".main-panel .container .info-supplier-detail .modal").modal("show");
                },
            });
        }
    );



    // search product
    $(".main-panel").on(
        "keyup change",
        ".container .info-supplier-detail .product-tools .search input",
        () => {
            var idSupplier = $(".container .info-supplier-detail #supplier-detail").val();
            var valueInput = $(
                ".main-panel .container .info-supplier-detail  .product-tools .search input"
            ).val();
            var valueItem = $(
                ".main-panel .container .info-supplier-detail  .product-tools .search select"
            ).val();
            $.ajax({
                type: "POST",
                url: "./gui/tableSupplierDetail.php",
                data: {
                    itemOfPage: valueItem,
                    valueSearch: valueInput,
                    idSupplier: idSupplier,
                },
                dataType: "html",
                success: function (response) {
                    $(".container .info-supplier-detail .table-product").html(response);
                    if ($(".container .info-supplier-detail  .pagination li").length - 2 == 1) {
                        $(".container .info-supplier-detail  .pagination .next").addClass(
                            "disabled"
                        );
                    }
                },
            });
        }
    );

    // Delete product
    $(".main-panel").on(
        "click",
        ".container .info-supplier-detail  tbody .fa-trash",
        function (e) {
            e.preventDefault();
            var idProduct = $(this).data("id");
            var idSupplier = $(".container .info-supplier-detail #supplier-detail").val();
            Swal.fire({
                title: "Bạn có muốn xóa liên kết giữa sản phẩm và nhà cung cấp?",
                text: "",
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Xóa",
                cancelButtonText: "Hủy bỏ",
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: "Đã xóa sản phẩm",
                        text: "",
                        icon: "success",
                    });
                    $.ajax({
                        type: "POST",
                        url: "./gui/tableSupplierDetail.php",
                        data: {
                            idSupplier: idSupplier,
                            idProduct: idProduct,
                            "delete-product": true,
                        },
                        dataType: "html",
                        success: function (response) {
                            console.log(response);
                            $.ajax({
                                type: "POST",
                                url: "./gui/infoSupplierDetail.php",
                                dataType: "html",
                                success: function (response) {
                                    $(".main-panel .container").html(response);
                                },
                            });

                        },
                    });
                }
            });
        }
    );
    // swap page
    function swapPage(page) {
        var idSupplier = $(".container .info-supplier-detail #supplier-detail").val();
        $.ajax({
            type: "POST",
            url: "./gui/tableSupplierDetail.php",
            data: {
                page: page,
                itemOfPage: 10,
                idSupplier: idSupplier,
            },
            dataType: "html",
            success: function (response) {
                $(".container .info-supplier-detail  .table-product").html(response);
                $(".container .info-supplier-detail  .pagination li").removeClass("active");
                for (
                    var i = 0;
                    i < $(".container .info-supplier-detail  .pagination li").length;
                    i++
                ) {
                    if (
                        $(".container .info-supplier-detail .pagination li").eq(i).text() == page
                    ) {
                        $(".container .info-supplier-detail .pagination li")
                            .eq(i)
                            .addClass("active");
                    }
                }
                if (page == 1) {
                    $(".container .info-supplier-detail .pagination .previous").addClass(
                        "disabled"
                    );
                } else {
                    $(".container .info-supplier-detail .pagination .previous").removeClass(
                        "disabled"
                    );
                }
                if (page == $(".container .info-supplier-detail .pagination li").length - 2) {
                    $(".container .info-supplier-detail .pagination .next").addClass("disabled");
                } else {
                    $(".container .info-supplier-detail .pagination .next").removeClass(
                        "disabled"
                    );
                }
            },
        });
    }

    $(".main-panel").on(
        "click",
        ".container .info-supplier-detail .pagination a",
        function (e) {
            e.preventDefault();
            var page = $(this).text();
            swapPage(page);
        }
    );

    //update purcharse price
    $(".container").on(
        "click",
        ".info-supplier-detail .modal-dialog #save-btn",
        function (e) {
            e.preventDefault();
            var idSupplier = $(this).data('idsup');
            var idProduct = $(this).data('idproduct');
            var price = $("#supplier-price-edit").val();
            if (price === "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Không được để trống giá nhập!',
                    text: 'Xin vui lòng nhập vào giá nhập',
                });
                return;
            }
            if (isNaN(price) || price <= 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Giá phải là số nguyên dương!',
                    text: 'Xin vui lòng nhập lại',
                });
                return;
            }

            var formData = new FormData();
            formData.append('edit', true);
            formData.append('idProduct', idProduct);
            formData.append('idSupplier', idSupplier);
            formData.append('price', price);
            $.ajax({
                type: "POST",
                url: "./gui/editPurcharsePrice.php",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response === "Sửa thành công") {
                        $(".main-panel .container .info-supplier-detail .modal").modal("hide");
                        var id = $('.info-supplier-detail .modal-dialog #save-btn').data('id');
                        let row = $('.container .info-supplier-detail tbody .fa-edit[data-id="' + idProduct + '"]').closest('tr');
                        if (row.length) {
                            row.find('td:eq(3)').text(new Intl.NumberFormat('vi-VN').format(price) + "đ");
                            swal.fire({
                                icon: 'success',
                                title: 'Đã sửa giá nhập thành công!',
                            });
                        } else {
                            console.log("Không tìm thấy sản phẩm trong bảng.");
                        }
                    }
                    else {
                        swal.fire({
                            icon: 'info',
                            title: 'Không có gì thay đổi',
                        });
                        $(".main-panel .container .info-supplier-detail .modal").modal("hide");
                    }
                }
            });
        }
    );

});