<%--
    Document   : chequeManagement
    Created on : May 15, 2020, 11:10:04 AM
    Author     : SCORFi3LD <https://github.com/SCORFi3LD>
--%>

<%@page import="resources.GrnChequeDetails"%>
<%@page import="resources.InvoiceChequeDetails"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Query"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%@page import="holder.LogedUserHolder"%>
<%@page import="holder.DetailsHolder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String PAGE_NAME = "Cheque Management", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
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

            DecimalFormat df = new DecimalFormat("0000");

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
        <link href="assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" rel="stylesheet"/>
        <link href="assets/vendors/material-design-iconic-font/dist/css/material-design-iconic-font.min.css" rel="stylesheet">
        <!-- Select2-->
        <link href="assets/vendors/select2/select2.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="wrapper">
            <%String curruntpage = "Cheque";%>

            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <!-- start content-->
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content">
                                        <ul class="nav nav-pills nav-pills-warning">
                                            <li class="active">
                                                <a href="#pill1" data-toggle="tab" aria-expanded="true">Received Cheques</a>
                                            </li>
                                            <li class="">
                                                <a href="#pill2" data-toggle="tab" aria-expanded="false">Issued Cheques</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="pill1">
                                                <table class="table table-bordered table-striped table-sm" id="recChqTable">
                                                    <thead>
                                                        <tr style="background-color: #10ac84 !important; color: white !important;">
                                                            <th>Cheque No</th>
                                                            <th>Cheque Date</th>
                                                            <th>Cheque Invoice No.</th>
                                                            <th>Bank & Branch</th>
                                                            <th>Amount</th>
                                                            <th>Status</th>
                                                            <th>Options</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            List<InvoiceChequeDetails> invList = s.createCriteria(InvoiceChequeDetails.class).list();
                                                            for (InvoiceChequeDetails li : invList) {
                                                        %>
                                                        <tr>
                                                            <td><%=li.getChequeNo()%></td>
                                                            <td><%=li.getChequeDate()%></td>
                                                            <td>#<%=df.format(li.getInvoicePayment().getInvoice().getInvoiceId())%></td>
                                                            <td><%=li.getBank()%> - <%=li.getBranch()%></td>
                                                            <td><%=li.getAmount()%></td>
                                                            <td><%
                                                                if (li.getStatus() == 0) {
                                                                    out.write("<span class='label label-danger'>RETURNED</span>");
                                                                } else if (li.getStatus() == 1) {
                                                                    out.write("<span class='label label-primary'>POST-DATED</span>");
                                                                } else if (li.getStatus() == 2) {
                                                                    out.write("<span class='label label-success'>DEPOSITED</span>");
                                                                } else if (li.getStatus() == 3) {
                                                                    out.write("<span class='label label-warning'>PAID TO THIRD PARTY</span>");
                                                                }
                                                                %></td>
                                                            <td width="15%">
                                                                <button class="btn btn-sm btn-block btn-info" data-img="<%=li.getChequeImage()%>" onclick="showImage(this)">Click to View Image</button>
                                                                <%
                                                                    if (li.getStatus() == 1) {
                                                                %>
                                                                <button class="btn btn-sm btn-block btn-danger rtn-chq" data-ref="<%=li.getInvoiceChequeDetailsId()%>">Return the cheque</button>
                                                                <button class="btn btn-sm btn-block btn-warning pid-chq" data-ref="<%=li.getInvoiceChequeDetailsId()%>">Paid to 3<sup style="text-transform:lowercase">rd</sup> party</button>
                                                                <button class="btn btn-sm btn-block btn-success dst-chq" data-ref="<%=li.getInvoiceChequeDetailsId()%>">Deposit the cheque</button>
                                                                <%
                                                                    }
                                                                %>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="tab-pane" id="pill2">
                                                <table class="table table-bordered table-striped table-sm" id="issChqTable">
                                                    <thead>
                                                        <tr style="background-color: #10ac84 !important; color: white !important;">
                                                            <th>Cheque No</th>
                                                            <th>Cheque Date</th>
                                                            <th>Cheque GRN No.</th>
                                                            <th>Bank & Branch</th>
                                                            <th>Amount</th>
                                                            <th>Status</th>
                                                            <th>Options</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            List<GrnChequeDetails> grnList = s.createCriteria(GrnChequeDetails.class).list();
                                                            for (GrnChequeDetails li : grnList) {
                                                        %>
                                                        <tr>
                                                            <td><%=li.getChequeNo()%></td>
                                                            <td><%=li.getChequeDate()%></td>
                                                            <td>#<%=df.format(li.getGrnPayment().getGrn().getGrnId())%></td>
                                                            <td><%=li.getBank()%> - <%=li.getBranch()%></td>
                                                            <td><%=li.getAmount()%></td>
                                                            <td><%
                                                                if (li.getStatus() == 0) {
                                                                    out.write("<span class='label label-danger'>RETURNED</span>");
                                                                } else if (li.getStatus() == 1) {
                                                                    out.write("<span class='label label-primary'>RELEASED</span>");
                                                                } else if (li.getStatus() == 2) {
                                                                    out.write("<span class='label label-warning'>OVERDRAFTED</span>");
                                                                } else if (li.getStatus() == 3) {
                                                                    out.write("<span class='label label-success'>PAID FROM BANK</span>");
                                                                }
                                                                %></td>
                                                            <td width="15%">
                                                                <button class="btn btn-sm btn-block btn-info" data-img="<%=li.getChequeImage()%>" onclick="showImage(this)">Click to View Image</button>
                                                                <%
                                                                    if (li.getStatus() == 1) {
                                                                %>
                                                                <button class="btn btn-sm btn-block btn-danger rtng-chq" data-ref="<%=li.getGrnChequeDetailsId()%>">Return the cheque</button>
                                                                <button class="btn btn-sm btn-block btn-warning pidg-chq" data-ref="<%=li.getGrnChequeDetailsId()%>">Paid from bank</button>
                                                                <button class="btn btn-sm btn-block btn-success odtg-chq" data-ref="<%=li.getGrnChequeDetailsId()%>">OD the cheque</button>
                                                                <%
                                                                    }
                                                                %>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end content-->
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="includes/footer.jsp"%>


            <!--Modal-->
            <div class="modal fade" id="imgViewModal" tabindex="-1" role="dialog" aria-labelledby="newitemRegModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-close"></i></span></button>
                        </div>
                        <div class="modal-body">
                            <div class="card-content">
                                <img src="" id="imgViewer" class="img-responsive"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/Modal -->

    </body>

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
    <!-- Select2-->
    <script src="assets/vendors/select2/select2.min.js" type="text/javascript"></script>
    <script>
    </script>
    <script>
        $(window).on("load", function (e) {
            $('.preloader').fadeOut('slow');
        });
        $(document).ready(function () {
            $('#minimizeSidebar').click();
            $('#recChqTable').DataTable();
            $('#issChqTable').DataTable();
        });

        function showImage(el) {
            $('#imgViewer').attr('src', $(el).attr('data-img'));
            $('#imgViewModal').modal('toggle');
        }

        $('.rtn-chq').click(function () {
            var id = $(this).attr('data-ref');
            swal({
                title: "Are you sure?",
                text: "Do you want to return this cheque?",
                icon: "warning",
                buttons: ["No", "Yes"],
                dangerMode: true,
            }).then((willReturn) => {
                if (willReturn) {
                    $.ajax({
                        type: 'POST',
                        url: "ReturnInvoiceChequeServlet",
                        data: {
                            id: id
                        }, success: function (data) {
                            if (data == "1") {
                                swal("The cheque has been successfully returned!", {
                                    icon: "success"
                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal("Oops!", "Somthings wants wrong. Please try again!", "error");
                            }
                        }
                    });
                }
            });
        });
        $('.pid-chq').click(function () {
            var id = $(this).attr('data-ref');
            swal({
                title: "Are you sure?",
                text: "Do you want to paid this cheque to 3rd party?",
                icon: "warning",
                buttons: ["No", "Yes"],
                dangerMode: true,
            }).then((willReturn) => {
                if (willReturn) {
                    $.ajax({
                        type: 'POST',
                        url: "PaidInvoiceChequeServlet",
                        data: {
                            id: id
                        }, success: function (data) {
                            if (data == "1") {
                                swal("The cheque has been paid to 3rd party successfully!", {
                                    icon: "success"
                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal("Oops!", "Somthings wants wrong. Please try again!", "error");
                            }
                        }
                    });
                }
            });
        });
        $('.dst-chq').click(function () {
            var id = $(this).attr('data-ref');
            swal({
                title: "Are you sure?",
                text: "Do you want to deposit this cheque?",
                icon: "warning",
                buttons: ["No", "Yes"],
                dangerMode: true,
            }).then((willReturn) => {
                if (willReturn) {
                    $.ajax({
                        type: 'POST',
                        url: "DepositInvoiceChequeServlet",
                        data: {
                            id: id
                        }, success: function (data) {
                            if (data == "1") {
                                swal("The cheque had successfully deposited!", {
                                    icon: "success"
                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal("Oops!", "Somthings wants wrong. Please try again!", "error");
                            }
                        }
                    });
                }
            });
        });


        $('.rtng-chq').click(function () {
            var id = $(this).attr('data-ref');
            swal({
                title: "Are you sure?",
                text: "Do you want to return this cheque?",
                icon: "warning",
                buttons: ["No", "Yes"],
                dangerMode: true,
            }).then((willReturn) => {
                if (willReturn) {
                    $.ajax({
                        type: 'POST',
                        url: "ReturnGrnChequeServlet",
                        data: {
                            id: id
                        }, success: function (data) {
                            if (data == "1") {
                                swal("The cheque has been successfully returned!", {
                                    icon: "success"
                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal("Oops!", "Somthings wants wrong. Please try again!", "error");
                            }
                        }
                    });
                }
            });
        });
        $('.pidg-chq').click(function () {
            var id = $(this).attr('data-ref');
            swal({
                title: "Are you sure?",
                text: "Do you want to set cheque as paid from bank?",
                icon: "warning",
                buttons: ["No", "Yes"],
                dangerMode: true,
            }).then((willReturn) => {
                if (willReturn) {
                    $.ajax({
                        type: 'POST',
                        url: "PaidGrnChequeServlet",
                        data: {
                            id: id
                        }, success: function (data) {
                            if (data == "1") {
                                swal("The cheque has been paid from bank successfully!", {
                                    icon: "success"
                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal("Oops!", "Somthings wants wrong. Please try again!", "error");
                            }
                        }
                    });
                }
            });
        });
        $('.odtg-chq').click(function () {
            var id = $(this).attr('data-ref');
            swal({
                title: "Are you sure?",
                text: "Do you want to OD this cheque?",
                icon: "warning",
                buttons: ["No", "Yes"],
                dangerMode: true,
            }).then((willReturn) => {
                if (willReturn) {
                    $.ajax({
                        type: 'POST',
                        url: "ODGrnChequeServlet",
                        data: {
                            id: id
                        }, success: function (data) {
                            if (data == "1") {
                                swal("The cheque had successfully Overdrafted!", {
                                    icon: "success"
                                }).then(function () {
                                    location.reload();
                                });
                            } else {
                                swal("Oops!", "Somthings wants wrong. Please try again!", "error");
                            }
                        }
                    });
                }
            });
        });
    </script>
</html>

