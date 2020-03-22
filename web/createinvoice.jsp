<%-- 
    Document   : createinvoice
    Created on : Mar 19, 2020, 5:14:33 PM
    Author     : SCORFi3LD
--%>


<%@page import="resources.Items"%>
<%@page import="java.util.ArrayList"%>
<%@page import="resources.InvoiceItem"%>
<%@page import="holder.InvoiceItemHolder"%>
<%@page import="help.Helper"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Stock"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%@page import="holder.LogedUserHolder"%>
<%@page import="holder.DetailsHolder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String PAGE_NAME = "Create Invoice", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
            int LOGED_USER_ID = 0;
            int STAF_ID = 0;
            LogedUserHolder luh;
            DetailsHolder dth;

            try {
                if (request.getSession().getAttribute("admin") != null && request.getSession().getAttribute("details") != null) {
                    dth = (DetailsHolder) request.getSession().getAttribute("details");
                    luh = (LogedUserHolder) request.getSession().getAttribute("admin");
                    NAME = dth.getName();
                    USERNAME = luh.getUsername();
                    LOGED_USER_NAME = luh.getName();
                    LOGED_USER_ID = luh.getUserId();
                    STAF_ID = luh.getStafId();

                } else {
                    response.sendRedirect("LogOutServlet");
                }
            } catch (Exception e) {
                response.sendRedirect("LogOutServlet");

            }

            InvoiceItemHolder holder;
            if (session.getAttribute("cart") != null) {
                holder = (InvoiceItemHolder) session.getAttribute("cart");
            } else {
                holder = new InvoiceItemHolder();
            }
            request.getSession().setAttribute("cart", holder);

            holder.printAll();

            Session s = GetConnection.getSessionFactory().openSession();
        %>

        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title><%=NAME + " | " + PAGE_NAME%></title>
        <!-- Bootstrap core CSS -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Material Dashboard CSS -->
        <link href="assets/css/turbo.css" rel="stylesheet" />
        <!-- Favicon -->
        <link rel="icon" type="image/png" href="assets/img/favicon.ico" />
        <!-- Fonts and icons -->
        <link href="assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" rel="stylesheet"/>
        <link href="assets/vendors/material-design-iconic-font/dist/css/material-design-iconic-font.min.css" rel="stylesheet">
        <!-- for pre loader -->
        <style>
            .preloader {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 9999;
                background-image: url('assets/img/l.gif');
                background-repeat: no-repeat; 
                background-color: #FFF;
                background-position: center;
            }
        </style>
        <!-- for pre loader -->
    </head>
    <body >
        <!-- for pre loader -->
        <div class="preloader"></div>
        <!-- for pre loader -->
        <div class="wrapper">
            <%
                String curruntpage = "Sales";
            %>
            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-12 text-right">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cartModal">
                                    <i class="material-icons">shopping_cart</i> Cart <span class="badge badge-light" id="cart_count"><%=Helper.intFormat.format(holder.getHolder().size())%></span>
                                </button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <%
                                    List<Items> iList = s.createCriteria(Items.class).list();
                                    for (Items item : iList) {
                                %>
                                <div class="col-sm-2">
                                    <div class="card" style="border:#c7c7c7 1px solid;box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);">   
                                        <div class="pt-header">
                                            <img src="<%=item.getImage()%>" class="img-responsive"/>
                                        </div>
                                        <div class="text-center">
                                            <h5 style="margin-bottom:10px"><%=item.getName()%></h5>
                                            <button class="btn btn-primary p-l-20 p-r-20"  data-toggle="modal" data-target="#stockModal" onclick="loadStocks(<%=item.getItemsId()%>)">Add to Cart</button>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>

                <%@include file="includes/footer.jsp"%>
            </div>
        </div>
    </body>

    <!-- stock Modal -->
    <div class="modal fade" id="stockModal" role="dialog" style="display: none;">
        <div class="modal-dialog">   
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-bottom: 20px;"><i class="fa fa-close"></i></button>
                </div>
                <div class="modal-body" id="stock" style="padding-top: 24px;padding-right: 24px;padding-bottom: 16px;padding-left: 24px;">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin:auto;background:#fff;display:block;" width="200px" height="200px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
                    <circle cx="50" cy="50" r="32" stroke-width="8" stroke="#fe718d" stroke-dasharray="50.26548245743669 50.26548245743669" fill="none" stroke-linecap="round" transform="rotate(179.178 50 50)">
                    <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50"></animateTransform>
                    </circle>
                    </svg>
                </div>
            </div>
        </div>
    </div>

    <!-- Cart Modal -->
    <div class="modal fade" id="cartModal" role="dialog" style="display: none;">
        <div class="modal-dialog">   
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i></button>
                    <h4 class="modal-title">Cart</h4>
                </div>
                <div class="modal-body">
                    <%
                        ArrayList<InvoiceItem> cartItems = holder.getHolder();
                        if (holder.getHolder().size() == 0) {
                    %>
                    <div class="text-center" style="padding:10px">
                        <h3 style="margin-bottom:20px;">Cart is Empty!</h3>
                    </div>
                    <%
                    } else {
                    %>
                    <div style="height:250px;overflow-y:auto;" class="boxscroll">
                        <%
                            for (InvoiceItem items : cartItems) {
                        %>                    
                        <div class="card" style="background-color:#eee;border-radius:3px;margin:0;padding:10px">
                            <div class="card-body">
                                <div class="col-sm-4 col-xs-4">
                                    <img src="<%=items.getStock().getItems().getImage()%>" class="img-responsive" style="width:50%;">
                                </div>
                                <div class="col-sm-8 col-xs-8">                        
                                    <a href="RemoveItemsFromCartServlet?id=<%=items.getStock().getStockId()%>">
                                        <button class="btn btn-sm btn-round btn-danger" style="top:0;right:0;position:absolute;margin:0;padding:5px 7px;"><i class="fa fa-trash"></i></button>
                                    </a>
                                    <h5 class="card-title"><%=items.getStock().getItems().getName()%></h5>
                                    <div class="col-sm-6 col-xs-6">
                                        <strong>Rs.<span id="net<%=items.getStock().getStockId()%>"><%=Helper.priceFormt.format(items.getNetTotal())%></span></strong>
                                    </div>
                                    <div class="col-sm-6 col-xs-6">
                                        Qty : <span style="border: #c7c7c7 1px solid;padding: 2px 5px;"><%=Helper.intFormat.format(items.getQty())%></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <table border="0" width="100%">
                        <tbody>
                            <tr>
                                <td><h5>SUBTOTAL</h5></td>
                                <td><h5 id="sub">0.00</h5></td>
                            </tr>
                            <tr>
                                <td><h5>CASH</h5></td>
                                <td><input id="cash" type="number" value="" min="0" style="font-size:1.25em;width:100%"/></td>
                            </tr>
                            <tr>
                                <td><h5>BALANCE</h5></td>
                                <td><h5 id="bal">0.00</h5></td>
                            </tr>
                        </tbody>
                    </table>

                    <button class="btn btn-success btn-block">
                        <span class="btn-label"><i class="material-icons">check</i></span> Checkout
                    </button>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <!--   Core JS Files   -->
    <script src="assets/vendors/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="assets/vendors/jquery-ui.min.js" type="text/javascript"></script>
    <script src="assets/vendors/bootstrap.min.js" type="text/javascript"></script>
    <script src="assets/vendors/material.min.js" type="text/javascript"></script>
    <script src="assets/vendors/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>

    <!-- Forms Validations Plugin -->
    <script src="assets/vendors/jquery.validate.min.js"></script>

    <!--  Plugin for Date Time Picker and Full Calendar Plugin-->
    <script src="assets/vendors/moment.min.js"></script>

    <!--  Charts Plugin -->
    <script src="assets/vendors/charts/flot/jquery.flot.js"></script>
    <script src="assets/vendors/charts/flot/jquery.flot.resize.js"></script>
    <script src="assets/vendors/charts/flot/jquery.flot.pie.js"></script>
    <script src="assets/vendors/charts/flot/jquery.flot.stack.js"></script>
    <script src="assets/vendors/charts/flot/jquery.flot.categories.js"></script>
    <script src="assets/vendors/charts/chartjs/Chart.min.js" type="text/javascript"></script>

    <!--  Plugin for the Wizard -->
    <script src="assets/vendors/jquery.bootstrap-wizard.js"></script>
    <!--  Notifications Plugin    -->
    <script src="assets/vendors/bootstrap-notify.js"></script>
    <!-- DateTimePicker Plugin -->
    <script src="assets/vendors/bootstrap-datetimepicker.js"></script>
    <!-- Vector Map plugin -->
    <script src="assets/vendors/jquery-jvectormap.js"></script>
    <!-- Sliders Plugin -->
    <script src="assets/vendors/nouislider.min.js"></script>
    <!-- Select Plugin -->
    <script src="assets/vendors/jquery.select-bootstrap.js"></script>
    <!--  DataTables.net Plugin    -->
    <script src="assets/vendors/jquery.datatables.js"></script>
    <!-- Sweet Alert 2 plugin -->
    <script src="assets/vendors/sweetalert2.js"></script>
    <!-- Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
    <script src="assets/vendors/jasny-bootstrap.min.js"></script>
    <!--  Full Calendar Plugin    -->
    <script src="assets/vendors/fullcalendar.min.js"></script>
    <!-- TagsInput Plugin -->
    <script src="assets/vendors/jquery.tagsinput.js"></script>
    <!-- Material Dashboard javascript methods -->
    <script src="assets/js/turbo.js"></script>
    <!-- for pre loader -->
    <script>
                                                $(window).on("load", function (e) {
                                                    $('.preloader').fadeOut('slow');
                                                });

                                                $(document).ready(function () {
                                                    $('#minimizeSidebar').click();
                                                    getSubTotal();
                                                });

                                                $("#stockModal").on('hide.bs.modal', function () {
                                                    location.reload();
                                                });

                                                $("#stockModal").on('shown.bs.modal', function () {
                                                    $('#qty').focus();
                                                });

                                                $("#cartModal").on('shown.bs.modal', function () {
                                                    $('#cash').focus();
                                                });

                                                function getSubTotal() {
                                                    $.ajax({
                                                        url: "GetCartSubTotalServlet",
                                                        success: function (data) {
                                                            $('#sub').html(data);
                                                            $('#cash').val("");
                                                            $('#bal').html("0.00");
                                                        }
                                                    });
                                                }

                                                function loadStocks(id) {
                                                    $('#stock').load('viewstocks.jsp?id=' + id);

                                                }

                                                $('#cash').keyup(function () {
                                                    var sub = $('#sub').html()
                                                    var cash = $(this).val();

                                                    if (cash == "" | cash.length == 0) {
                                                        return;
                                                    }

                                                    var bal = parseFloat(cash) - parseFloat(sub);
                                                    if (bal >= 0) {
                                                        $('#bal').html(bal)
                                                    }
                                                });

                                                function addToCart(id, aqty) {
                                                    var qty = $('#qty').val();
                                                    var dis = $('#dis').val();

                                                    if (parseFloat(qty) > parseFloat(aqty)) {
                                                        swal("Invalied Qty Amount!", "You entered stock qty is not valid! Please enter anoher value!", "error").then(function () {
                                                            $('#qty').focus();
                                                        });
                                                        return;
                                                    }

                                                    $.ajax({
                                                        url: "AddItemToCartServlet",
                                                        data: {id: id, qty: qty, dis: dis},
                                                        success: function (data) {
                                                            $('#cart_count').html(data.split(",")[0]);
                                                            loadStocks(data.split(",")[1]);
                                                            getSubTotal();
                                                            swal("Done!", "Item added successfuly!", "success").then(function () {
                                                                $('#qty').focus();
                                                            });
                                                        }
                                                    });
                                                }
    </script>
    <!-- for pre loader -->
</html>