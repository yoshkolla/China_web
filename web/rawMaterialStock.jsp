<%-- 
    Document   : rawMaterialStock
    Created on :  Apr 23, 2020, 07:47:08 PM
    Author     : AKILA
--%>

<%@page import="resources.RawStock"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.MeasurementType"%>
<%@page import="resources.RawItems"%>
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
            String PAGE_NAME = "Raw Material Stock", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
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
                String curruntpage = "Stock";
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
                                        <h3 class="card-title" style="margin-bottom: 15px;">Raw Material Stock</h3>
                                        <div class="material-datatables">
                                            <table id="dataTable" class="table table-striped table-no-bordered table-hover" cellspacing="0" width="100%" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Item</th>
                                                        <th>Measurement Type</th>
                                                        <th>ROL</th>
                                                        <th>Qty</th>
                                                        <th>Cost (Rs.)</th>
                                                        <th>Last Update</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        int rowCount = 0;
                                                        List<RawStock> rawStockList = sess.createCriteria(RawStock.class).list();
                                                        for (RawStock rawStockObj : rawStockList) {
                                                            rowCount += 1;
                                                    %>
                                                    <tr>
                                                        <td><%=rowCount%></td>
                                                        <td><%=rawStockObj.getRawItems().getName()%></td>
                                                        <td><%=rawStockObj.getRawItems().getMeasurementType().getName()%></td>
                                                        <td><%=new DecimalFormat("0.000").format(rawStockObj.getRawItems().getRol())%></td>
                                                        <td><%=new DecimalFormat("0.000").format(rawStockObj.getQty())%></td>
                                                        <td><%=new DecimalFormat("0.00").format(rawStockObj.getCost())%></td>
                                                        <td><%=rawStockObj.getDate() + " @" + rawStockObj.getTime()%></td>
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
            $('#dataTable').DataTable();
        });
    </script>

</html>