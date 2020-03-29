<%-- 
    Document   : createinvoice
    Created on : Mar 19, 2020, 5:14:33 PM
    Author     : SCORFi3LD
--%>

<%@page import="resources.Customer"%>
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
        <!-- Select2-->
        <link href="assets/vendors/select2/select2.min.css" rel="stylesheet" type="text/css"/>
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

            .form-group{
                padding-bottom: 10px;
                margin: 0;
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
                        <img src="assets/img/empty_cart.png" class="img-responsive" style="margin: 0 auto;">
                        <h3 style="margin:0">Cart is Empty!</h3>
                    </div>
                    <%
                    } else {
                    %>
                    <h6 style="margin: 5px 0">Customer</h6>
                    <select id="cus" class="form-control" style="width:100%">
                        <option></option>
                        <%
                            List<Customer> cList = s.createCriteria(Customer.class).add(Restrictions.eq("status", 1)).list();
                            for (Customer c : cList) {
                        %>
                        <option value="<%=c.getCustomerId()%>"><%=c.getName()%></option>
                        <%
                            }
                        %>
                    </select>
                    <div style="height:200px;overflow-y:auto;border:#5e5e5e solid 1px;padding:5px" class="boxscroll">
                        <%
                            for (InvoiceItem items : cartItems) {
                        %>                    
                        <div class="card" style="background-color:#eee;border-radius:3px;margin:0;padding:10px">
                            <div class="card-body">
                                <div class="col-sm-4 col-xs-4">
                                    <img src="<%=items.getStock().getItems().getImage()%>" class="img-responsive" style="height:50%;">
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
                    <hr style="border-top: 2px dashed #5e5e5e;margin: 10px 0 0;">
                    <table border="0" width="100%">
                        <tr>
                            <td width="20%"><h6 style="margin: 5px 0">SUBTOTAL</h6></td>
                            <td class="text-right"><h5 id="sub" style="font-weight:bold;margin:0">0.00</h5></td>
                        </tr>
                        <tr>
                            <td width="20%"><h6 style="margin: 5px 0">DISCOUNT (%)</h6></td>
                            <td><input id="cdis" type="number" value="0" min="0" max="100" style="font-weight:bold;font-size:1.25em;width:100%;height:26px;text-align:right;margin:0"/></td>
                        </tr>
                        <tr>
                            <td width="20%"><h6 style="margin: 5px 0">NET TOTAL</h6></td>
                            <td class="text-right"><h5 id="net" style="font-weight:bold;margin:0">0.00</h5></td>
                        </tr>
                    </table>

                    <div class="btn-group" role="group" aria-label="Payment Methods" style="width:100%">
                        <button type="button" class="btn btn-success btn-secondary" style="width:50%;background:#ff9900;" id="cheqpay">Cheque Payment</button>
                        <button type="button" class="btn btn-success btn-secondary" style="width:50%" id="cashpay">Cash Payment</button>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="chequeModal" role="dialog" style="display: none;">
        <div class="modal-dialog">   
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i></button>
                    <h4 class="modal-title">Cheque Details</h4>
                </div>
                <div class="modal-body">
                    <table width="100%" cellspacing="5">
                        <tr>
                            <td width="50%">
                                <div class="form-group open" style="margin-bottom:10px;">
                                    <div class="select" aria-expanded="true">
                                        <select class="form-control" id="chqtype">
                                            <option>CASH CHEQUE</option>
                                            <option>DATE CHEQUE</option>
                                        </select>
                                    </div>
                                    <span class="material-input"></span>
                                </div>
                                <div class="form-group label-floating" style="margin-bottom:10px;">
                                    <label class="control-label">Cheque No <small>*</small></label>
                                    <input type="text" class="form-control" id="chqno"/>
                                </div>
                                <div class="form-group label-floating" style="margin-bottom:10px;">
                                    <label class="control-label">Date Picker <small>*</small></label>
                                    <input type="date" class="form-control" value="<%=Helper.getDate()%>" id="chqdate"/>
                                </div>
                                <div class="form-group label-floating" style="margin-bottom:10px;">
                                    <label class="control-label">Bank <small>*</small></label>
                                    <input type="text" class="form-control" id="bank"/>
                                </div>
                                <div class="form-group label-floating" style="margin-bottom:10px;">
                                    <label class="control-label">Branch <small>*</small></label>
                                    <input type="text" class="form-control" id="branch"/>
                                </div>
                                <div class="form-group label-floating" style="margin-bottom:10px;">
                                    <label class="control-label">Net Total</label>
                                    <input type="text" class="form-control" value="0.00" id="pqnet" disabled/>
                                </div>
                                <div class="form-group label-floating" style="margin-bottom:10px;">
                                    <label class="control-label">Amount <small>*</small></label>
                                    <input type="number" class="form-control" id="amount"/>
                                </div>
                            </td>
                            <td width="50%" align="center">
                                <div class="fileinput fileinput-new text-center" data-provides="fileinput">
                                    <div class="fileinput-new thumbnail">
                                        <img src="assets/img/image_placeholder.jpg" alt="...">
                                    </div>
                                    <div class="fileinput-preview fileinput-exists thumbnail" style="" id="chqimg"></div>
                                    <div>
                                        <span class="btn btn-round btn-file">
                                            <span class="fileinput-new">Select image</span>
                                            <span class="fileinput-exists">Change</span>
                                            <input type="hidden"><input type="file" name="...">
                                            <div class="ripple-container"></div>
                                        </span>
                                        <a href="#" class="btn btn-danger btn-round fileinput-exists" data-dismiss="fileinput"><i class="fa fa-times"></i> Remove</a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-right">
                                <input type="submit" class="btn btn-success" id="cheque_checkout">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="cashModal" role="dialog" style="display: none;">
        <div class="modal-dialog">   
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i></button>
                    <h4 class="modal-title">Payment Details</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group label-floating" style="margin-bottom:10px;">
                        <label class="control-label">Net Total</label>
                        <input type="text" class="form-control" value="0.00" id="pcnet" disabled/>
                    </div>
                    <div class="form-group label-floating is-focused" style="margin-bottom:10px;">
                        <label class="control-label">Cash <small>*</small></label>
                        <input type="number" class="form-control" id="cash"/>
                    </div>
                    <div class="form-group label-floating" style="margin-bottom:10px;">
                        <label class="control-label">Balance</label>
                        <input type="text" class="form-control" value="0.00" id="bal" disabled/>
                    </div>
                    <div class="text-right">
                        <input type="submit" class="btn btn-success" id="cash_checkout">
                    </div>
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
    <!-- Select2-->
    <script src="assets/vendors/select2/select2.min.js" type="text/javascript"></script>
    <!-- Material Dashboard javascript methods -->
    <script src="assets/js/turbo.js"></script>
    <script>

    </script>
    <!-- for pre loader -->
    <script type="text/javascript">
        $(window).on("load", function (e) {
            $('.preloader').fadeOut('slow');
        });

        $(document).ready(function () {
            $('#cus').select2({
                placeholder: "Select a customer",
                allowClear: true
            });
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
            $('#cdis').focus();
        });

        function getSubTotal() {
            $.ajax({
                url: "GetCartSubTotalServlet",
                success: function (data) {
                    $('#sub').html(data);
                    $('#net').html(data);
                    $('#cash').val("");
                    $('#bal').val("0.00");
                }
            });
        }

        function loadStocks(id) {
            $('#stock').load('viewstocks.jsp?id=' + id);
        }

        $('#cash').keyup(function () {
            var sub = $('#net').html()
            var cash = $(this).val();
            var dis = $('#cdis').val();

            if (dis == "" | dis.length == 0) {
                $('#cdis').val("0");
            }

            if (cash == "" | cash.length == 0) {
                $('#bal').val("0.00");
                return;
            }

            var bal = parseFloat(cash) - parseFloat(sub);
            if (bal >= 0) {
                $('#bal').val(bal.toFixed(2));
            } else {
                $('#bal').val("0.00");
            }
        });

        $('#cdis').keyup(function () {
            var sub = $('#sub').html();
            var dis = $(this).val();

            $('#cash').val('');
            $('#bal').val('0.00');

            if (dis == "" | dis.length == 0) {
                return;
            }

            if (parseFloat(dis) == 0) {
                $('#net').html(sub);
            } else {
                var net = parseFloat(sub) - ((parseFloat(sub) * parseFloat(dis)) / 100);
                $('#net').html(net.toFixed(2));
            }
        });

        $('#cdis').keypress(function (e) {
            if (e.keyCode == 13) { // Enter Key
                $('#cash').focus();
            }
        });

        $('#cash').keypress(function (e) {
            if (e.keyCode == 13) { // Enter Key
                $('#checkout').click();
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

        var cshFlag = false;
        $('#cashpay').click(function () {
            if ($('#cus').val() == "") {
                swal("", "Please select the customer", "warning").then(function () {
                    $('#cus').focus();
                });
                return;
            }

            $('#cartModal').modal('hide');
            $('#pcnet').val($('#net').html());
            cshFlag = true;
        });

        $('#cashModal').on('shown.bs.modal', function () {
            $('#cash').focus();
        });

        var chqFlag = false;
        $('#cheqpay').click(function () {
            if ($('#cus').val() == "") {
                swal("", "Please select the customer", "warning").then(function () {
                    $('#cus').focus();
                });
                return;
            }

            $('#cartModal').modal('hide');
            $('#pqnet').val($('#net').html());
            chqFlag = true;
        });

        $('#cartModal').on('hidden.bs.modal', function () {
            if (cshFlag == true) {
                $('#cashModal').modal('show');
            }
            if (chqFlag == true) {
                $('#chequeModal').modal('show');
            }
            chqFlag = false;
            cshFlag = false;
        });

        $('#cash_checkout').click(function () {
            var cus = $('#cus').val();
            var sub = $('#sub').html();
            var dis = $('#cdis').val();
            var net = $('#net').html();
            var cash = $('#cash').val();

            if (cash == "" | cash.length == 0) {
                cash = net;
            }

            $.ajax({
                url: "SaveCashInvoiceServlet",
                data: {cus: cus, sub: sub, dis: dis, net: net, cash: cash},
                success: function (data) {
                    window.open("invoiceprint.jsp?inv=" + data, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,fullscreen=yes");
                    location.reload();
                }
            });
        });

        $('#cheque_checkout').click(function () {
            var cus = $('#cus').val();
            var sub = $('#sub').html();
            var dis = $('#cdis').val();
            var net = $('#net').html();

            var chqtype = $('#chqtype').val();
            var amount = $('#amount').val();
            var chqno = $('#chqno').val();
            var chqdate = $('#chqdate').val();
            var bank = $('#bank').val();
            var branch = $('#branch').val();
            var chqimg = 'assets/img/image_placeholder.jpg';

            if (chqno == "" | chqdate == "" | bank == "" | branch == "" | amount == "") {
                swal("", "Please fill the all fields", "warning");
                return;
            }

            if (amount.length == 0) {
                swal("", "The amount must be not zero", "warning");
                return;
            }
            if ($('#chqimg').find('img').attr('src') != null) {
                chqimg = $('#chqimg').find('img').attr('src');
            }

            $.ajax({
                type: 'POST',
                url: "SaveChequeInvoiceServlet",
                data: {
                    cus: cus,
                    sub: sub,
                    dis: dis,
                    net: net,
                    chqtype: chqtype,
                    chqno: chqno,
                    chqdate: chqdate,
                    bank: bank,
                    branch: branch,
                    chqimg: chqimg,
                    amount: amount
                },
                success: function (data) {
                    window.open("invoiceprint.jsp?inv=" + data, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,fullscreen=yes");
                    location.reload();
                }
            });
        });
    </script>
</html>