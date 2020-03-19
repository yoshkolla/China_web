<%-- 
    Document   : index
    Created on : Mar 19, 2020, 5:14:33 PM
    Author     : Chamara
--%>


<%@page import="holder.LogedUserHolder"%>
<%@page import="holder.DetailsHolder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%
            String PAGE_NAME = "Create Item", NAME = "", USERNAME = "";
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
                String curruntpage = "Create";
            %>
            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h3 style="color: #263238 !important;">Create new sales item</h3>
                                </div>

                                <div class="card-content">
                                    <!-- BEGIN FORM WIZARD -->
                                    <div id="formwizard_simple" class="form-wizard form-wizard-horizontal">
                                        <form class="form floating-label">
                                            <div class="form-wizard-nav">
                                                <div class="progress" style="width: 75%;">
                                                    <div class="progress-bar progress-bar-primary" style="width: 0%;"></div>
                                                </div>
                                                <ul class="nav nav-justified nav-pills">
                                                    <li class="active"><a href="#fws_tab1" data-toggle="tab"><span class="step">1</span> <span class="title">DETAILS</span></a></li>
                                                    <li><a href="#fws_tab2" data-toggle="tab"><span class="step">2</span> <span class="title">ADDRESS</span></a></li>
                                                    <li><a href="#fws_tab3" data-toggle="tab"><span class="step">3</span> <span class="title">SETTINGS</span></a></li>
                                                    <li><a href="#fws_tab4" data-toggle="tab"><span class="step">4</span> <span class="title">CONFIRM</span></a></li>
                                                </ul>
                                            </div>
                                            <!--end .form-wizard-nav -->

                                            <div class="tab-content clearfix p-30">
                                                <div class="tab-pane active" id="fws_tab1">
                                                    
                                                    <div class="form-group is-empty">
                                                        <input type="text" name="it_name" id="it_name" class="form-control">
                                                        <h4 for="it_name" class="control-label">Item name</h4>
                                                    <span class="material-input"></span></div>
                                                    <div class="row">
                                                        <div class="col-sm-8">
                                                            <div class="form-group is-empty">
                                                                <input type="text" name="City" id="City" class="form-control">
                                                                <label for="City" class="control-label">City</label>
                                                            <span class="material-input"></span></div>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <div class="form-group is-empty">
                                                                <input type="text" name="State" id="State" class="form-control">
                                                                <label for="State" class="control-label">State</label>
                                                            <span class="material-input"></span></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end #tab1 -->

                                                <div class="tab-pane" id="fws_tab2">
                                                    <br><br>
                                                    <div class="form-group is-empty">
                                                        <input type="text" name="Country" id="Country" class="form-control">
                                                        <label for="Country" class="control-label">Country</label>
                                                    <span class="material-input"></span></div>
                                                    <div class="form-group is-empty">
                                                        <input type="text" name="Zipcode" id="Zipcode" class="form-control">
                                                        <label for="Zipcode" class="control-label">Zipcode</label>
                                                    <span class="material-input"></span></div>
                                                </div>
                                                <!--end #tab2 -->

                                                <div class="tab-pane" id="fws_tab3">
                                                    <br><br>
                                                    <div class="form-group is-empty">
                                                        <input type="text" name="URL" id="URL" class="form-control">
                                                        <label for="URL" class="control-label">URL</label>
                                                        <p class="help-block">Starts with http://</p>
                                                    <span class="material-input"></span></div>
                                                    <div class="form-group is-empty">
                                                        <input type="text" name="rangelength" id="rangelength" class="form-control">
                                                        <label for="rangelength" class="control-label">Range restriction</label>
                                                        <p class="help-block">Between 5 and 10</p>
                                                    <span class="material-input"></span></div>
                                                </div>
                                                <!--end #tab3 -->

                                                <div class="tab-pane" id="fws_tab4">
                                                    <br><br>
                                                    <div class="form-group is-empty">
                                                        <select id="Age1" name="Age" class="form-control">
                                                            <option value="">&nbsp;</option>
                                                            <option value="30">30</option>
                                                            <option value="40">40</option>
                                                            <option value="50">50</option>
                                                            <option value="60">60</option>
                                                            <option value="70">70</option>
                                                        </select>
                                                        <label for="Age1">Age</label>
                                                        <p class="help-block">This is supporting text for this field.</p>
                                                    <span class="material-input"></span></div>
                                                </div>
                                                <!--end #tab4 -->

                                                <ul class="pager wizard ">
                                                    <li class="previous first disabled ml-2"><a class="btn-raised" href="javascript:void(0);">First</a></li>
                                                    <li class="previous disabled"><a class="btn-raised" href="javascript:void(0);">Previous</a></li>
                                                    <li class="next last"><a class="btn-raised" href="javascript:void(0);">Last</a></li>
                                                    <li class="next"><a class="btn-raised" href="javascript:void(0);">Next</a></li>
                                                </ul>
                                            </div>
                                            <!--end .tab-content -->


                                        </form>
                                    </div>
                                    <!--end #rootwizard -->
                                    <!-- END FORM WIZARD --> 

                                </div>
                            </div>
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
    <!-- Material Dashboard javascript methods -->
    <script src="assets/js/turbo.js"></script>
    <!-- for pre loader -->
    <script>
        $(window).on("load", function (e) {
            $('.preloader').fadeOut('slow');
        });
    </script>
    <!-- for pre loader -->
</html>
