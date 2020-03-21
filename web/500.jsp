<!doctype html>
<html lang="en">
    <head>
        <title>Internal Server Error | 500</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Material Dashboard CSS -->
        <link href="assets/css/turbo.css" rel="stylesheet" />
        <!-- Favicon -->
        <link rel="icon" type="image/png" href="assets/img/favicon.ico" />
        <!-- Fonts and icons -->
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" rel="stylesheet"/>
        <link href="assets/vendors/material-design-iconic-font/dist/css/material-design-iconic-font.min.css" rel="stylesheet">
        <style>
            .error_page_header {
                color: rgb(255, 255, 255);
                font-size: 48px;
                font-weight: 300;
                margin-bottom: 40px;
                background: rgb(21, 101, 192);
                padding: 80px 0px 20px;
            }
        </style>
    </head>

    <body>
        <div class="error_page_header">
            <div class="m-l-25 uk-container-center">
                500!
            </div>
        </div>
        <div class="error_page_content">
            <div class="m-l-25">
                <p class="heading_b">Internal Server Error</p>
                <p class="uk-text-large">
                    The server encountered an internal error or misconfiguration and was unable to complete your request.
                </p>
                <a href="LogOutServlet">Go back to previous page</a>
            </div>
        </div>
        <!--   Core JS Files   -->
        <script src="assets/vendors/jquery-3.1.1.min.js" type="text/javascript"></script>
        <script src="assets/vendors/jquery-ui.min.js" type="text/javascript"></script>
        <script src="assets/vendors/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/vendors/material.min.js" type="text/javascript"></script>
        <script src="assets/vendors/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>

    </body>

</html>
