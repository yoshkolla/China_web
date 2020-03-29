<%-- 
    Document   : createGRN
    Created on : Mar 28, 2020, 2:16:28 AM
    Author     : AKILA
--%>

<%@page import="resources.MeasurementType"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Query"%>
<%@page import="resources.Grn"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Supplier"%>
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
        <link href="assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" rel="stylesheet"/>
        <link href="assets/vendors/material-design-iconic-font/dist/css/material-design-iconic-font.min.css" rel="stylesheet">

        <%
            String PAGE_NAME = "Create GRN", LOGED_USER_NAME = "", NAME = "", USERNAME = "";
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
            Session sess = GetConnection.getSessionFactory().openSession();
        %>
    </head>
    <body>
        <div class="wrapper">
            <%String curruntpage = "Purchase";%>

            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <!-- start content-->

                            <!-- GRN.INFO -CARD ================================================================ -->
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="row">
                                            <div class="col-md-3" style="margin-bottom: 14px;">
                                                <p style="text-align: left; font-size: 15px; background-color:#03a9f4; color:#fff; padding: 2px;">&nbsp;GRN No | #<%=new DecimalFormat("0000").format(sess.createCriteria(Grn.class).list().size() + 1)%></p>
                                            </div>
                                            <div class="col-md-3"></div>

                                            <div class="col-md-6">
                                                <span style="text-align: left; font-size: 15px;">&nbsp;Supplier</span>
                                                <div class="form-group open" style="padding-left: 10px; margin-top: -28px; margin-left: 85px;">
                                                    <div class="select" aria-expanded="true">
                                                        <select class="form-control">
                                                            <option>Select a Supplier</option>
                                                            <option>Option 1</option>
                                                            <option>Option 2</option>
                                                            <option>Option 3</option>
                                                            <option>Option 4</option>
                                                            <option>Option 5</option>
                                                        </select>
                                                    </div>
                                                    <span class="material-input"></span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Add_GRN.Items -CARD ================================================================ -->
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header card-header-text">
                                        <h5 class="card-title">Add Items</h5>
                                    </div>
                                    <div class="card-content">
                                        <button class="btn btn-danger btn-sm" style="float: right; margin-top: -40px;" data-toggle="modal" data-target="#newitemRegModal" onclick='resetAll_regRawItemForm();'><span class="fa fa-pencil"></span>&nbsp;&nbsp;REGISTER</button>

                                        <form id="AddItem" class="form-horizontal" action="#" method="">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <label class="col-sm-2 label-on-left" style="margin-left: 15px;">Item</label>
                                                    <div class="col-sm-8">
                                                        <div class="form-group open" style="margin-left: 30px;">
                                                            <div class="select" aria-expanded="true">
                                                                <select class="form-control">
                                                                    <option>Select an Item</option>
                                                                    <option>Option 1</option>
                                                                    <option>Option 2</option>
                                                                    <option>Option 3</option>
                                                                    <option>Option 4</option>
                                                                    <option>Option 5</option>
                                                                </select>
                                                            </div>
                                                            <span class="material-input"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <div class="col-lg-6">
                                                        <label class="col-sm-3 label-on-left">Unit Price</label>
                                                        <div class="col-sm-3">
                                                            <div class="form-group label-floating is-empty">
                                                                <label class="control-label"></label>
                                                                <input class="form-control" type="number" name="number" number="true">
                                                                <span class="material-input"></span>
                                                            </div>
                                                        </div>

                                                        <label class="col-sm-3 label-on-left">Supplier Price</label>
                                                        <div class="col-sm-3">
                                                            <div class="form-group label-floating is-empty">
                                                                <label class="control-label"></label>
                                                                <input class="form-control" type="number" name="number" number="true">
                                                                <span class="material-input"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <label class="col-sm-3 label-on-left">Qty</label>
                                                        <div class="col-sm-3">
                                                            <div class="form-group label-floating is-empty">
                                                                <label class="control-label"></label>
                                                                <input class="form-control" type="number" name="number" number="true">
                                                                <span class="material-input"></span>
                                                            </div>
                                                        </div>

                                                        <label class="col-sm-3 label-on-left">Discount (%)</label>
                                                        <div class="col-sm-3">
                                                            <div class="form-group label-floating is-empty">
                                                                <label class="control-label"></label>
                                                                <input class="form-control" type="number" name="number" number="true">
                                                                <span class="material-input"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>


                                            <button class="btn btn-primary btn-sm" style="float: right;"><span class="fa fa-plus"></span>&nbsp;&nbsp;ADD</button>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center"></div>
                                </div>
                            </div>



                            <!-- GRN.Items -Table ================================================================ -->
                            <div class="col-md-12">
                                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                                    <div class="card-body">
                                        <table class="table table-sm" id="grnitemstable">
                                            <thead>
                                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                                    <td>ITEM</td>
                                                    <td>UNIT PRICE (Rs.)</td>
                                                    <td>SUPPLIER PRICE (Rs.)</td>
                                                    <td>QTY</td>
                                                    <td>DISCOUNT (%)</td>
                                                    <td>AMOUNT (Rs.)</td>
                                                </tr>
                                            </thead>
                                            <tbody id="grnitemstablebody"></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>




                            <!-- GRN.SUM -CARD ================================================================ -->
                            <div class="col-md-12">
                                <div class="card" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                                    <form id="TypeValidation" class="form-horizontal" action="#" method="">
                                        <div class="card-content">


                                            <div class="row">
                                                <div class="col-sm-3" style="float: right;">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label"></label>
                                                        <input class="form-control" type="text" name="number" number="true" disabled="true" value="0.00">
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                                <label class="col-sm-2 label-on-left" style="float: right;">Total Discount</label>
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-3" style="float: right;">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label"></label>
                                                        <input class="form-control" type="text" name="number" number="true" disabled="true" value="0.00">
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                                <label class="col-sm-2 label-on-left" style="float: right;">Total Amount</label>
                                            </div>

                                            <br>
                                            <div class="col-md-4" style="float: right; margin-right: -16px;">
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-success" id="save" style="margin-right: 20px;"><span class="fa fa-save mr-2"></span>&nbsp;&nbsp;SAVE&nbsp;</button>
                                                    <button type="button" class="btn btn-danger" id="cancel"><span class="fa fa-close mr-2"></span>&nbsp;&nbsp;CANCEL&nbsp;</button>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="card-footer text-center">
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- end content-->
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="includes/footer.jsp"%>








            <!-- NEW ITEM REGISTRATION -Modal-->
            <div class="modal fade" id="newitemRegModal" tabindex="-1" role="dialog" aria-labelledby="newitemRegModalLabel" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <h4 class="modal-title">Register New Item</h4>
                        </div>
                        <div class="modal-body">
                            <div class="card-content">

                                <div class="form-group label-floating is-empty">
                                    <label class="control-label">Item Name *</label>
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
                                                    onkeyup='checkValidations_regRawItemForm();'>

                                                    <option value="x">Select a Type</option>
                                                    <%  Criteria msrTypeCriteria = sess.createCriteria(MeasurementType.class);
                                                        List<MeasurementType> msrTypeList = msrTypeCriteria.list();
                                                        for (MeasurementType msrTypeObject : msrTypeList) { %>
                                                    <option value="<%out.print(msrTypeObject.getMeasurementTypeId());%>"><%out.print(msrTypeObject.getName());%>&nbsp;</option>
                                                    <% }%>
                                                </select>
                                            </div>
                                            <span class="material-input"></span></div>
                                    </div>
                                </div>
                                <div class="form-group label-floating is-empty">
                                    <label class="control-label">ROL *</label>
                                    <input 
                                        class="form-control" 
                                        type="number" 
                                        number="true" 
                                        required="true"
                                        autofocus="true"
                                        min="0.100"
                                        step="0.01"
                                        id="regRawItem_rol"
                                        onblur='currencyValidate(this);'
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
                                    onclick='execRegRawItemFormFunc("regRawItem_name=" + document.getElementById("regRawItem_name").value + "&" + "regRawItem_msrType=" + document.getElementById("regRawItem_msrType").value + "&" + "regRawItem_rol=" + document.getElementById("regRawItem_rol").value);'
                                    id="buttonSubmit_regRawItem">
                                &nbsp;&nbsp;Register&nbsp;&nbsp;
                            </button>
                        </div>
                    </div>
                </div>
            </div><!-- .end modal -->   

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
    </script>
    <script>
        $(window).load(function () {
            $('.preloader').fadeOut('slow');
        });

        $(document).ready(function () {
            $('#minimizeSidebar').click();
            $('#datatables').DataTable();
        });
    </script>

    <!-- === Utility Scripts ======================================================================================== -->
    <!-- ========================================================================================================================================== -->

    <!-- **************** REGISTER-RAW-ITEM FORM Scripts ***************************************************************************************************************** -->
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

    <!--   INPUT ELEMENT VALIDATIONS  -->
    <script>
        function currencyValidate(field) {
            field.value = parseFloat(field.value).toFixed(3)
        }
    </script>

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

            // @ finally all OK
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

                //  Display Msg
                if (outputData.split(":")[0] == 'Success') {
                    swal(outputData.split(":")[1], "success");
                } else if (outputData.split(":")[0] == 'Warning') {
                    swal("Oops!", outputData.split(":")[1], "warning");
                }

            });
        }
    </script>


</html>
