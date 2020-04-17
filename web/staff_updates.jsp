<%-- 
    Document   : index
    Created on : Dec 6, 2019, 11:37:56 AM
    Author     : SCORFi3LD
--%>

<%@page import="resources.JobRoll"%>
<%@page import="resources.Staff"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="resources.Customer"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%@page import="holder.LogedUserHolder"%>
<%@page import="holder.DetailsHolder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />
        <title>APK HUB</title>
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
        <%
            String PAGE_NAME = "Dashboard", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
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

            int staff_id = 0;

            if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
                staff_id = Integer.parseInt(request.getParameter("id"));
            } else {
                response.sendRedirect("staff_reg.jsp");
            }
            System.out.println("test");
        %>
    </head>

    <body>
        <div class="wrapper">
            <%                String curruntpage = "cusreg";
            %>
            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="container">  
                                    <%
                                        int job_r = 0;
                                        if (staff_id > 0) {
                                            Session ses = connection.GetConnection.getSessionFactory().openSession();
                                            Staff staff = (Staff) ses.load(Staff.class, staff_id);
                                            job_r = staff.getJobRoll().getJobRollId();

                                    %>
                                    <form action="Staff_update" method="GET">
                                        <div class="modal-body">
                                            <div class="col-md-12">
                                                <div class="card">
                                                    <div class="card-content">
                                                        <h3>Staff Update</h3>
                                                        <div class="card-content">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <select class="form-group form-control" name="job" id="jobroll">
                                                                        <option disabled selected value="0">Choose JOB TYPE</option>
                                                                        <%                                                                            Session s = GetConnection.getSessionFactory().openSession();

                                                                            List<JobRoll> cList = s.createCriteria(JobRoll.class).list();

                                                                            for (JobRoll job : cList) {
                                                                        %>                                                                   
                                                                        <option value="<%=job.getJobRollId()%>"><%=job.getName()%> </option>                                                              
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="row">

                                                                <div class="col-sm-12">

                                                                    <div class="form-group label-floating is-empty">

                                                                        <input type="text" name="name" class="form-control" value="<%=staff.getName()%>">
                                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                                        <span class="material-input"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <div class="form-group label-floating is-empty">                                                                       
                                                                        <input type="text"  name="mobile" class="form-control" maxLength="10"  value="<%=staff.getMobile()%>">
                                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                                        <span class="material-input"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <div class="form-group label-floating is-empty">

                                                                        <textarea name="address" class="form-control"><%=staff.getAddress()%></textarea>
                                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                                        <span class="material-input"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <div class="form-group label-floating is-empty">                                                                       
                                                                        <input type="text"  name="nic" class="form-control" value="<%=staff.getNic()%>">
                                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                                        <span class="material-input"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <input type="hidden" id="staff_id" name="staff_id" value="<%=staff_id%>">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <div class="text-right">
                                                    <button class="btn btn-success">
                                                        <span class="btn-label">
                                                            <i class="material-icons">check</i>
                                                        </span>
                                                        Update
                                                    </button>
                                                </div>
                                            </div>

                                        </div>
                                    </form>
                                    <%

                                        }
                                    %>


                                </div>
                            </div>
                        </div>
                        <br>
                        <br>
                        <br>    


                    </div>

                </div>
            </div>
        </div>

        <%@include file="includes/footer.jsp"%>

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

    <script>
        $(window).on("load", function (e) {
            $('.preloader').fadeOut('slow');
        });
        $(document).ready(function () {
            $('#datatables').DataTable();
            $('#jobroll').val(<%=job_r%>);
        });
    </script>
</html>
