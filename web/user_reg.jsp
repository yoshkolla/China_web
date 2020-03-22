<%-- 
    Document   : index
    Created on : Dec 6, 2019, 11:37:56 AM
    Author     : SCORFi3LD
--%>

<%@page import="resources.Staff"%>
<%@page import="resources.User"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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
                                
                                <div class="card">

                                    <form action="Save_user_servelrt" method="Get">
                                        <div class="card-header card-header-text">
                                            <h4 class="card-title">User Registration</h4>
                                        </div>
                                        <div class="card-content">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <select class="form-group form-control" name="staff" id="jobroll">
                                                        <option disabled selected>Choose Staff</option>
                                                        <%
                                                            Session s = GetConnection.getSessionFactory().openSession();
                                                            
                                                            List<Staff> cList = s.createCriteria(Staff.class).list();
                                                            for (Staff c : cList) {
                                                        %>                                                                   
                                                        <option value="<%=c.getStaffId()%>"><%=c.getName()%> </option>                                                              
                                                        <%
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Username</label>
                                                        <input type="text" name="Username" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Password</label>
                                                        <input type="text" name="Password" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Sales</label>
                                                        <input type="text" name="Sales" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Purchase</label>
                                                        <input type="text" name="Purchase" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Production</label>
                                                        <input type="text" name="Production" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Create</label>
                                                        <input type="text" name="Create" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">User</label>
                                                        <input type="text" name="User" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Cheque</label>
                                                        <input type="text" name="Cheque" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Report</label>
                                                        <input type="text" name="Report" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label">Other</label>
                                                        <input type="text" name="Other" class="form-control" value="">
                                                        <span class="help-block">A block of help text that breaks onto a new line.</span>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="text-right">
                                                <button class="btn btn-success">
                                                    <span class="btn-label">
                                                        <i class="material-icons">check</i>
                                                    </span>
                                                    Success
                                                </button>

                                                <button class="btn btn-warning">
                                                    <i class="material-icons">warning</i> Read PDF
                                                </button>
                                            </div>

                                        </div>
                                    </form>
                                </div>
                                <br>
                                <br>
                                <br>    
                                Username Password Sales Purchase Production Create User Cheque Report Other


                                <div class="card">
                                    <div class="card-content">
                                        <h3 class="card-title" style="margin-bottom: 15px;">Customer Data</h3>
                                        <div class="toolbar"></div>
                                        <div class="material-datatables">
                                            <table id="datatables" class="table table-sm table-bordered" cellspacing="0" width="100%" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>Username</th>
                                                        <th>Password</th>
                                                        <th>Permissions</th>
                                                        <th>Update</th>
                                                        <th>Delete</th>
                                                    </tr>
                                                </thead>

                                                <tbody>
                                                    <%     
                                                        
                                                        List<User> list =s.createCriteria(User.class).add(Restrictions.eq("status",1)).list();
                                                        for (User u : list) {
                                                            
                                                    %>
                                                    <tr>
                                                        <td><%=u.getUsername()%></td>
                                                        <td><%=u.getPassword()%></td>
                                                        <td>
                                                            Sales : <%=u.getSales()%><br>
                                                            Purchase : <%=u.getPurchase()%> <br>
                                                            Production : <%=u.getProduction()%> <br>
                                                            Create : <%=u.getCreates()%> <br>
                                                            User : <%=u.getUser()%> <br>
                                                            Cheque : <%=u.getCheque()%> <br>
                                                            Report : <%=u.getReport()%> <br>
                                                            Other : <%=u.getOther()%> <br>
                                                        </td>
                                                        <td>
                                                            <a href="user_update.jsp?id=<%= u.getUserId()%>">
                                                                <button class="btn btn-warning btn-sm">
                                                                    <i class="material-icons"></i> Update
                                                                </button>
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <form action="User_delete_servlert" method="POST">
                                                                <button class="btn btn-danger btn-sm">
                                                                    <input type="hidden" id="id" name="id" value="<%= u.getUserId()%>">
                                                                    <i class="material-icons"></i> Delete
                                                                </button>
                                                            </form>

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

                            </div>
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
            $('#datatables').DataTable({
                "pagingType": "full_numbers",
                "lengthMenu": [
                    [10, 25, 50, -1],
                    [10, 25, 50, "All"]
                ],
                responsive: true,
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search records",
                }
            });
        });
    </script>
</html>
