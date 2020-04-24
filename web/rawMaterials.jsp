<%-- 
    Document   : rawMaterials
    Created on :  Apr 23, 2020, 06:48:20 PM
    Author     : AKILA
--%>

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
            String PAGE_NAME = "Raw Materials", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
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
                String curruntpage = "Create";
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

                                        <button class="btn btn-danger btn-sm" style="float: right;" data-toggle="modal" data-target="#newitemRegModal" onclick='resetAll_regRawItemForm();'>
                                            <span class="fa fa-pencil"></span>&nbsp;&nbsp;REGISTER
                                        </button>

                                        <h3 class="card-title" style="margin-bottom: 15px;">Raw Materials</h3>
                                        <div class="material-datatables">
                                            <table id="dataTable" class="table table-striped table-no-bordered table-hover" cellspacing="0" width="100%" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Name</th>
                                                        <th>Measurement Type</th>
                                                        <th>ROL</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        int rowCount = 0;
                                                        List<RawItems> rawItemsList = sess.createCriteria(RawItems.class).list();
                                                        for (RawItems rawItemObj : rawItemsList) {
                                                            rowCount += 1;
                                                    %>
                                                    <tr>
                                                        <td><%=rowCount%></td>
                                                        <td><%=rawItemObj.getName()%></td>
                                                        <td><%=rawItemObj.getMeasurementType().getName()%></td>
                                                        <td><%=new DecimalFormat("0.000").format(rawItemObj.getRol())%></td>
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


    <!-- NEW RAW-MATERIAL ITEM REGISTRATION -Modal-->
    <div class="modal fade" id="newitemRegModal" tabindex="-1" role="dialog" aria-labelledby="newitemRegModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                    <h4 class="modal-title">Register Raw Material Item</h4>
                </div>
                <div class="modal-body">
                    <div class="card-content">

                        <div class="form-group">
                            <label class="control-label" style="font-size: 14px;">Name *</label>
                            <input 
                                class="form-control" 
                                type="text" 
                                required="true" 
                                autofocus="true"
                                maxlength="44"
                                minlength="0"
                                id="regRawItem_name" 
                                onkeydown='setElementFocus_regRawItemForm(event, "regRawItem_msrType");' 
                                onkeyup='checkValidations_regRawItemForm();'>
                            <span class="material-input"></span>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label class="control-label" style="font-size: 14px; padding-left: 3px;">Measurement Type *</label>
                                <div class="form-group" style="margin-top: 0px;">
                                    <div class="select">
                                        <select 
                                            class="form-control" 
                                            required="true"
                                            autofocus="true"
                                            id="regRawItem_msrType" 
                                            onkeydown='setElementFocus_regRawItemForm(event, "regRawItem_rol");' 
                                            onkeyup='checkValidations_regRawItemForm();'
                                            onclick='checkValidations_regRawItemForm();'>

                                            <option value="x">Select a Type</option>
                                            <%  Criteria msrTypeCriteria = sess.createCriteria(MeasurementType.class);
                                                msrTypeCriteria.add(Restrictions.eq("status", 1));
                                                List<MeasurementType> msrTypeList = msrTypeCriteria.list();
                                                for (MeasurementType msrTypeObject : msrTypeList) { %>
                                            <option value="<%out.print(msrTypeObject.getMeasurementTypeId());%>"><%out.print(msrTypeObject.getName());%>&nbsp;</option>
                                            <% }%>
                                        </select>
                                    </div>
                                    <span class="material-input"></span></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label" style="font-size: 14px;">ROL *</label>
                            <input 
                                class="form-control" 
                                type="number" 
                                number="true" 
                                required="true"
                                autofocus="true"
                                min="0.001"
                                step="0.001"
                                id="regRawItem_rol"
                                onblur='priceValFormatting(this);'
                                onkeyup='checkValidations_regRawItemForm();'
                                onkeydown='setElementFocus_regRawItemForm(event, "buttonSubmit_regRawItem");'>
                            <span class="material-input"></span>
                        </div>

                    </div><div class="card-footer text-center"></div>
                </div>
                <div class="modal-footer">
                    <button style="float: right; margin-right: 10px;" class="btn btn-danger" data-dismiss="modal" 
                            type="submit" 
                            disabled="true"
                            onmouseover='checkValidations_regRawItemForm();'
                            onclick='execRegRawItemFormFunc(
                                            "regRawItem_name=" + document.getElementById("regRawItem_name").value + "&" +
                                            "regRawItem_msrType=" + document.getElementById("regRawItem_msrType").value + "&" +
                                            "regRawItem_rol=" + document.getElementById("regRawItem_rol").value
                                            );'
                            id="buttonSubmit_regRawItem">
                        &nbsp;&nbsp;Register&nbsp;&nbsp;
                    </button>
                </div>
            </div>
        </div>
    </div><!-- .end modal -->   



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

    <!-- ========= REGISTER-RAW-ITEM FORM Scripts ==================================================================================== -->
    <!-- SET FOCUS TO ELEMENTS -->
    <script>
        function setElementFocus_regRawItemForm(event, fcsElement) {
            // Enter Key
            if (event.keyCode == 13) {
                document.getElementById('buttonSubmit_regRawItem').disabled = true;  //  disable it ( 4 disable auto Form submits )
                document.getElementById(fcsElement).focus();
                document.getElementById('buttonSubmit_regRawItem').disabled = false;
            }
        }
    </script>

    <!-- RESET REG.RAW-ITEM FORM-->
    <script>
        function resetAll_regRawItemForm() {
            document.getElementById("regRawItem_name").value = "";
            document.getElementById("regRawItem_msrType").value = "x";
            document.getElementById("regRawItem_rol").value = "0.100";
            document.getElementById("buttonSubmit_regRawItem").disabled = true; // disable it
        }
    </script>

    <!-- CHECK ELEMENTs VALUEs IN REG.RAW-ITEM FORM-->
    <script>
        function checkValidations_regRawItemForm() {
            var flagSubmitSts = false;
            // value validations
            if (!document.getElementById('regRawItem_name').checkValidity()) {
                flagSubmitSts = false;
            } else if (!document.getElementById('regRawItem_rol').checkValidity()) {
                flagSubmitSts = false;
            } else if (document.getElementById('regRawItem_msrType').value == "x") {
                flagSubmitSts = false;
            }
            // length validations
            else if (document.getElementById('regRawItem_name').value.length > 45) {
                flagSubmitSts = false;
            }
            // check Double Field
            else if (document.getElementById('regRawItem_rol').value.toString().trim().length == 0) {
                flagSubmitSts = false;
            } else if (document.getElementById('regRawItem_rol').value.toString().trim() == "NaN") {
                document.getElementById("regRawItem_rol").value = "0.100";
                flagSubmitSts = false;
            } else if (document.getElementById('regRawItem_rol').value < 0.100) {
                flagSubmitSts = false;
            }

            // when all OK
            else {
                flagSubmitSts = true;
            }

            //  == set submit btn status ==================
            if (flagSubmitSts) {
                document.getElementById('buttonSubmit_regRawItem').disabled = false;  //  enable submit !!!
            } else {
                document.getElementById('buttonSubmit_regRawItem').disabled = true;  //  disable submit 
            }
        }
    </script>

    <!--  SAVE NEW-RAW-ITEM -->
    <script type="text/javascript">
        function execRegRawItemFormFunc(param) {
            $.post("RegisterRawItemServlet", param, function (outputData) {
                //  Show output-Message  [ Title : MsgText : MsgType ]
                swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                // Post Actions..
                setTimeout(function () {
                    location.reload();
                }, 800);
            });
        }
    </script>

</html>