$(document).ready(function () {
    // show receipt
    $(".main-panel").on(
        "change",
        ".container .info-receipt .product-tools .show select",
        function () {
            var value = $(this).val();
            $.ajax({
                type: "POST",
                url: "./gui/tableReceipt.php",
                data: {
                    itemOfPage: value,
                },
                dataType: "html",
                success: function (response) {
                    $(".container .info-receipt .table-product").html(response);
                    if ($(".container .info-receipt .pagination li").length - 2 == 1) {
                        $(".container .info-receipt .pagination .next").addClass(
                            "disabled"
                        );
                    }
                },
            });
        }
    );
    // delete receipt
    $(".main-panel").on(
        "click",
        ".container .info-receipt tbody .detete-receipt",
        function (e) {
            e.preventDefault();
            var id = $(this).data("id");
            Swal.fire({
                title: "Bạn có muốn xóa phiếu nhập?",
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
                        title: "Đã xóa phiếu nhập",
                        text: "",
                        icon: "success",
                    });
                    $.ajax({
                        type: "POST",
                        url: "./gui/tableReceipt.php",
                        data: {
                            id: id,
                            "delete-receipt": true,
                        },
                        dataType: "html",
                        success: function (response) {
                            console.log(response);
                            $.ajax({
                                type: "POST",
                                url: "./gui/infoReceipt.php",
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
        $.ajax({
            type: "POST",
            url: "./gui/tableReceipt.php",
            data: {
                page: page,
                itemOfPage: $(
                    ".container .info-receipt .product-tools .show select"
                ).val(),
            },
            dataType: "html",
            success: function (response) {
                $(".container .info-receipt .table-product").html(response);
                $(".container .info-receipt .pagination li").removeClass("active");
                for (
                    var i = 0;
                    i < $(".container .info-receipt .pagination li").length;
                    i++
                ) {
                    if (
                        $(".container .info-receipt .pagination li").eq(i).text() == page
                    ) {
                        $(".container .info-receipt .pagination li")
                            .eq(i)
                            .addClass("active");
                    }
                }
                if (page == 1) {
                    $(".container .info-receipt .pagination .previous").addClass(
                        "disabled"
                    );
                } else {
                    $(".container .info-receipt .pagination .previous").removeClass(
                        "disabled"
                    );
                }
                if (page == $(".container .info-receipt .pagination li").length - 2) {
                    $(".container .info-receipt .pagination .next").addClass("disabled");
                } else {
                    $(".container .info-receipt .pagination .next").removeClass(
                        "disabled"
                    );
                }
            },
        });
    }

    $(".main-panel").on(
        "click",
        ".container .info-receipt .pagination a",
        function (e) {
            e.preventDefault();
            var page = $(this).text();
            swapPage(page);
        }
    );

    // // previous page
    // $(".main-panel").on(
    //     "click",
    //     ".container .info-receipt .pagination .previous",
    //     function (e) {
    //         e.preventDefault();
    //         var pageCurrent = $(
    //             ".container .info-receipt .pagination li.active"
    //         ).text();
    //         console.log(pageCurrent);
    //         if (pageCurrent == 1) {
    //             return;
    //         }
    //         var page = Number(pageCurrent) - 1;
    //         swapPage(page);
    //     }
    // );

    // // next page
    // $(".main-panel").on(
    //     "click",
    //     ".container .info-receipt .pagination .next",
    //     function (e) {
    //         e.preventDefault();
    //         var pageCurrent = $(
    //             ".container .info-receipt .pagination li.active"
    //         ).text();
    //         alert(pageCurrent)
    //         var page = Number(pageCurrent) + 1;
    //         // swapPage(page);
    //     }
    // );
    // show receipt
    $('.container').on('click', '.table-responsive .fa-eye.show-receipt', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        $.ajax({
            type: "POST",
            url: "./gui/showReceipt.php",
            data: {
                'id': id
            },
            dataType: "html",
            success: function (response) {
                $('.container .modal-dialog').html(response);
            }
        });
    })

});