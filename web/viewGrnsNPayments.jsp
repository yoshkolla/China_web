<%-- 
    Document   : viewGrnsNPayments
    Created on :  Apr 3, 2020, 06:21:52 PM
    Author     : AKILA
--%>

<%@page import="resources.Grn"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.Invoice"%>
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
            String PAGE_NAME = "View GRNs & Payments", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
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
            Helper hlp = new Helper();
            Session sess = GetConnection.getSessionFactory().openSession();
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
        </style>
        <!-- for pre loader -->
    </head>
    <body >
        <!-- for pre loader -->
        <div class="preloader"></div>
        <!-- for pre loader -->
        <div class="wrapper">
            <%
                String curruntpage = "Purchase";
            %>
            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid"> 
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-content">
                                        <h3 class="card-title" style="margin-bottom: 15px;">View GRNs & Payments</h3>
                                        <div class="material-datatables">
                                            <table id="grnTable" class="table table-striped table-no-bordered table-hover" cellspacing="0" width="100%" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>GRN No #</th>
                                                        <th>Supplier</th>
                                                        <th>Date & Time</th>
                                                        <th>Net Total (Rs.)</th>
                                                        <th>Payment Status</th>
                                                        <th class="disabled-sorting text-right"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<Grn> grnList = sess.createCriteria(Grn.class).list();
                                                        for (Grn grnPaymentObj : grnList) {
                                                    %>
                                                    <tr>
                                                        <td><%=new DecimalFormat("0000").format(grnPaymentObj.getGrnId())%></td>
                                                        <td><%=grnPaymentObj.getSupplier().getName()%></td>
                                                        <td><%=grnPaymentObj.getDate()%> @<%=grnPaymentObj.getTime()%></td>
                                                        <td><%=hlp.priceFormt.format(grnPaymentObj.getNetTotal())%></td>
                                                        <% if (grnPaymentObj.getBalance() == 0.00) { %>
                                                        <td>COMPLETED</td>
                                                        <% } else {%>
                                                        <td style="color: #ff0000b5;">PENDING [ Due Amount: Rs.<%=hlp.priceFormt.format(grnPaymentObj.getBalance())%> ]</td>
                                                        <% }%>
                                                        <td class="text-right">
                                                            <a class="btn btn-info btn-xs btn_VwGRN" data-ref-VwGRN="<%=grnPaymentObj.getGrnId()%>">View GRN</a>
                                                            <a class="btn btn-success btn-xs btn_VwPayments" data-ref-VwPayments="<%=grnPaymentObj.getGrnId()%>">View Payments</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- end content-->
                                </div>
                                <!--  end card  -->
                            </div>
                        </div>
                    </div>
                </div>

                <%@include file="includes/footer.jsp"%>
            </div>
        </div>
    </body>

    <!-- DETAILS-PREVIEW Modal -->
    <div class="modal fade" id="expandDetModal" role="dialog" style="display: none;">
        <div class="modal-dialog modal-lg">   
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><button type="button" class="close" data-dismiss="modal" style="margin-bottom: 20px;"><i class="fa fa-close"></i></button></h4>
                </div>
                <div class="modal-body" id="expandDetBox">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin:auto;background:#fff;display:block;" width="200px" height="200px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
                    <circle cx="50" cy="50" r="32" stroke-width="8" stroke="#fe718d" stroke-dasharray="50.26548245743669 50.26548245743669" fill="none" stroke-linecap="round" transform="rotate(179.178 50 50)">
                    <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50"></animateTransform>
                    </circle>
                    </svg>
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
            $('#minimizeSidebar').click();
            $('#grnTable').DataTable();
        });
    </script>

    <script>
        $('.btn_VwGRN').click(function () {
            var id = $(this).attr('data-ref-VwGRN');
            $('#expandDetModal').modal('show');
            $('#expandDetBox').load('viewGrnsNPayments_loadDetailsModal.jsp?id=' + id + '&type=VwGRN');
        });

        $('.btn_VwPayments').click(function () {
            var id = $(this).attr('data-ref-VwPayments');
            $('#expandDetModal').modal('show');
            $('#expandDetBox').load('viewGrnsNPayments_loadDetailsModal.jsp?id=' + id + '&type=VwPayments');
        });
    </script>

</html>