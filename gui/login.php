<?php
require_once "../database/database.php";
require_once "../database/user.php";
// require_once "./googleLogin.php";

$db = new Database();
$user = new user($db);
if (isset($_POST['username']) && isset($_POST['password'])) {
    $check = $user->checkLogin($_POST['username'], $_POST['password']);
    echo $check;
} else {
    ?>

    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header login-register">
                <a href="./gui/login.php" class="selected">Đăng nhập</a>
                <a href="./gui/register.php">Đăng kí</a>
            </div>
            <div class="modal-body">
                <form action="" class="form-login d-flex flex-column justify-content-center align-items-center">
                    <div class="form-group">
                        <input type="text" name="username" placeholder="Tài khoản" <?php
                        if (isset($_GET['username'])) {
                            echo "value='" . $_GET['username'] . "'";
                        }
                        ?>>
                        <i><i class="fa-solid fa-user icon-user"></i></i>
                        <span class="underline"></span>
                        <span class="error"></span>
                    </div>

                    <div class="form-group">
                        <input type="password" name="password" placeholder="Mật khẩu">
                        < <i><i class="fa-solid fa-lock icon-lock"></i></i>
                            <span class="underline"></span>
                            <span class="error"></span>
                    </div>


                    <button type="submit" class="btn btn-primary" id="submit-login">Đăng nhập</button>

                </form>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            // show register form
            $(".modal .modal-header.login-register").on("click", "a", function (e1) {
                e1.preventDefault();
                var url = $(this).attr("href");
                var form = $(this).text()
                $(".modal .login-register a").removeClass("selected");
                $(this).addClass("selected");
                var content = new Promise(function (resolve, reject) {
                    $.get(url,
                        function (data, textStatus, jqXHR) {
                            resolve(data);
                        },
                        "html"
                    );
                })
                content.then(function (value) {
                    if (form === "Đăng kí") {
                        $(".modal-body").html(value);
                    } else {
                        $(".modal").html(value);
                    }
                });
            });

            // login
            $("#submit-login").on("click", function (e) {
                e.preventDefault();
                var username = $("input[name='username']").val();
                var password = $("input[name='password']").val();

                if (username.trim() === "" || password.trim() === "") {
                    Swal.fire({
                        title: "Không để rỗng các trường!",
                        text: "",
                        icon: "error",
                        showConfirmButton: false,
                    });
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "./gui/login.php",
                    data: {
                        username: username,
                        password: password
                    },
                    dataType: "html",
                    success: function (response) {
                        console.log(response);
                        if (response === "Tài khoản của bạn đã bị khóa") {
                            Swal.fire({
                                icon: "error",
                                title: response,
                                text: "",
                                footer: '',
                            });
                        }
                        if (response === "") {
                            Swal.fire({
                                position: "top-end",
                                icon: "success",
                                title: "Đăng nhập thành công",
                                showConfirmButton: false,
                                timer: 1500
                            });

                            setTimeout(function () {
                                location.reload();
                            }, 1500);
                        } else if (response !== "admin") {
                            Swal.fire({
                                icon: "error",
                                title: response,
                                text: "Vui lòng kiểm tra lại thông tin đăng nhập!",
                                footer: '',
                            });
                        } else {
                            window.location.href = "http://localhost/webBanGiay/admin/";
                        }
                    }
                });
            })
        });
    </script>

    <?php
}
?>