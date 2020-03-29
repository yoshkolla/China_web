<%@page import="resources.Details"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <script>
            addEventListener("load", function () {
                setTimeout(hideURLbar, 0);
            }, false);
            function hideURLbar() {
                window.scrollTo(0, 1);
            }
        </script>
        <!-- Meta tags -->
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <!-- font-awesome icons -->
        <link href="assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <!-- //font-awesome icons -->
        <!--stylesheets-->
        <link href="assets/css/loginstylesheet.css" rel="stylesheet" type="text/css"/>
        <!--//style sheet end here-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
        <link rel="icon" type="image/png" href="assets/img/favicon.ico" />

    </head>

    <body style="padding-top: 30px;">
        <%
            String PAGE_NAME = "User Login";
            Session sesDetails = connection.GetConnection.getSessionFactory().openSession();
            Details st = null;
            String Name;
            String Address;
            String Image;
            String Fax;
            String Contact;
            String Emial;

            st = (Details) sesDetails.load(Details.class, 1);

            if (st != null) {
                Name = st.getName();
                Address = st.getAddress();
                Image = st.getImage();
                Fax = st.getFax();
                Contact = st.getTp();
                Emial = st.getEmail();
            } else {
                Name = "";
                Address = "";
                Image = "";
                Fax = "";
                Contact = "";
                Emial = "";
            }
            sesDetails.close();
        %>
        <title><%=Name + " | " + PAGE_NAME%></title>
        <div class="w3layouts-two-grids"  >
            <div class="mid-class">
                <div class="txt-left-side">
                    <h2> Login Here </h2>
                    <p>Please enter username , password and then click login now button or hit enter.</p>

                    <div class="form-left-to-w3l">
                        <span class="fa fa-user " aria-hidden="true"></span>
                        <input type="text" name="un" id="un" placeholder="Username" required="">

                        <div class="clear"></div>
                    </div>
                    <div class="form-left-to-w3l ">

                        <span class="fa fa-lock" aria-hidden="true"></span>
                        <input type="password" name="pw" id="pw" placeholder="Password" required="">
                        <div class="clear"></div>
                    </div>
                    <div class="main-two-w3ls">

                    </div>
                    <div class="btnn">
                        <button type="button" id="login" style="background-color:  #27ae60;" >Login </button>
                    </div>

                    <div class="w3layouts_more-buttn">

                    </div>

                </div>
                <div class="img-right-side">
                    <img src="assets/img/splash.png" class="img-fluid" alt="">
                </div>
            </div>
        </div>
        <footer class="copyrigh-wthree">
            <p>© 2020 A P K Hub All Rights Reserved V 1.0.0 Beta</p>
        </footer>
        <script src="assets/vendors/jquery-3.1.1.min.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $('#un').focus();
            $('#un').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#pw').focus();
                }
            });
            $('#pw').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    getLogin();
                }
            });
            $("#login").click(function () {
                getLogin();

            });

            function getLogin() {
                $.ajax({
                    url: 'GetLoginServlet',
                    data: {
                        email: $('input[name="un"]').val(),
                        password: $('input[name="pw"]').val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        if (data === "1") {

                            window.location.replace("index.jsp");


                        } else if (data === "0") {
                            swal({
                                title: "Empty field data !",
                                text: "Can't let any field empty.",
                                icon: "error",
                                button: "OK"
                            });


                        } else if (data === "2") {
                            swal({
                                title: "incorect username or password !",
                                text: "username or password you enterd, is wrong.",
                                icon: "error",
                                button: "OK"
                            });


                        }
                    },
                    error: function () {
                        swal({
                            title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                        });

                    }
                });
            }
        </script>

    </body>


</html>