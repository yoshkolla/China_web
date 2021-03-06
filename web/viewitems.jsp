<%-- 
    Document   : index
    Created on : Mar 19, 2020, 5:14:33 PM
    Author     : Chamara
--%>
<%@page import="java.io.File"%>
<%@page import="resources.ItemStaffCost"%>
<%@page import="resources.ProductionSteps"%>
<%@page import="resources.ItemsHasRawItems"%>
<%@page import="java.util.Set"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Items"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="holder.LogedUserHolder"%>
<%@page import="holder.DetailsHolder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%
            String PAGE_NAME = "View Item Details", NAME = "", USERNAME = "";
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
                    LOGED_USER_ID = luh.getUserId();
                    STAF_ID = luh.getStafId();

                } else {
                    response.sendRedirect("LogOutServlet");
                }
            } catch (Exception e) {
                response.sendRedirect("LogOutServlet");

            }
            Session ses = connection.GetConnection.getSessionFactory().openSession();
            Items ITEM = null;
            if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
                ITEM = (Items) ses.load(Items.class, Integer.parseInt(request.getParameter("id")));
            } else {
                response.sendRedirect("items.jsp");
            }

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
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" rel="stylesheet"/>
        <link href="assets/vendors/material-design-iconic-font/dist/css/material-design-iconic-font.min.css" rel="stylesheet">
        <!-- for pre loader -->
        <style>
            #datatables_length{
                float: left;
            }
            .dataTables_info{
                float: left !important;;
            }
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
    <body>
        <!-- for pre loader -->
        <div class="preloader"></div>
        <!-- for pre loader -->
        <div class="wrapper">
            <%
                String curruntpage = "View Item Details";
            %>
            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb" style="font-size: 14px;">
                                        <li class="breadcrumb-item"><a href="index.jsp"><span class="fa fa-home">&nbsp;</span>Home</a></li>
                                        <li class="breadcrumb-item active"><a href="items.jsp"><span class="fa fa-arrow-left">&nbsp;</span>Sales items</a></li>
                                        <li class="breadcrumb-item active">View Item Details</li>
                                    </ol>
                                </nav>

                                <div class="card card-stats">
                                    <div class="card-content">
                                        <%if (ITEM != null) { %>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <center>
                                                    <%
                                                        File f = new File(application.getRealPath("/") + ITEM.getImage());
                                                        if (f.exists()) {
                                                    %>
                                                    <img src="<%=ITEM.getImage()%>" class="img-responsive" style="height: 20%;width: 20%;">
                                                    <% } else {%>
                                                    <img src="assets/img/noimage.png" style="height: 15%;width: 15%;">
                                                    <% }%>
                                                </center>
                                            </div>
                                                <div class="col-sm-12" style="margin-top: 25px;">
                                                <table style="width: 100%; text-align: left;" >
                                                    <tr>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">ITEM NAME : <%=ITEM.getName().toUpperCase()%></td>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">RE ORDER LEVEL : <%=ITEM.getRol()%></td>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">SELLING TYPE : <%=ITEM.getMeasurementType().getName().toUpperCase()%></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-sm-6">
                                                <table style="width: 100%; text-align: left; margin-top: 30px;">
                                                    <tr>
                                                        <td colspan="2"><h6 style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;text-align: center;">Raw materials for one item </h6></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="background-color:#009432;color: white;  border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">NAME</td>
                                                        <td style="background-color:#009432;color: white;  border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">AMOUNT</td>
                                                    </tr>
                                                    <%
                                                        Set<ItemsHasRawItems> RI = ITEM.getItemsHasRawItemses();
                                                        for (ItemsHasRawItems I : RI) {
                                                            if (I.getStatus() == 1) {
                                                    %>
                                                    <tr>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;"><%=I.getRawItems().getName().toUpperCase()%></td>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;"><%=I.getAmount() + "  " + I.getRawItems().getMeasurementType().getName().toUpperCase()%></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                            </div>    


                                            <div class="col-sm-6">
                                                <table style="width: 100%; text-align: left; margin-top: 30px;">
                                                    <tr>
                                                        <td colspan="2"><h6 style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;text-align: center;">PRODUCTION STEPS AND COST</h6></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="background-color:#EE5A24;color: white;  border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">STEP NAME</td>
                                                        <td style="background-color:#EE5A24;color: white;  border:#455A64 solid 1px; padding: 3px 3px 3px 3px;">COST</td>
                                                    </tr>
                                                    <%
                                                        Set<ProductionSteps> PS = ITEM.getProductionStepses();
                                                        for (ProductionSteps I : PS) {
                                                            if (I.getStatus() == 1) {
                                                                double cost = 0.0;
                                                                Set<ItemStaffCost> IC = I.getItemStaffCosts();
                                                                for (ItemStaffCost IT : IC) {
                                                                    cost = IT.getCost();
                                                                }

                                                    %>
                                                    <tr>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;"><%=I.getStepName().toUpperCase()%></td>
                                                        <td style="border:#455A64 solid 1px; padding: 3px 3px 3px 3px;"><%=cost%></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                            </div>
                                            <div class="col-sm-12">
                                                <a class="btn btn-warning" href="itemupdate.jsp?id=<%=ITEM.getItemsId()%>"><span class="fa fa-edit">&nbsp;&nbsp;</span> UPDATE</a>
                                            </div>

                                        </div>



                                        <%}%>
                                    </div>
                                    <!-- end content-->
                                </div>
                                <!--  end card  -->
                            </div>
                            <!-- end col-md-12 -->
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
    <!-- Material Dashboard javascript methods -->
    <script src="assets/js/turbo.js"></script>
    <!-- for pre loader -->
    <script>
        $(window).on("load", function (e) {
            $('.preloader').fadeOut('slow');
        });
        $(document).ready(function () {
            $('#minimizeSidebar').click();
            $('#datatables').dataTable();
        });
    </script>
    <!-- for pre loader -->
</html>
