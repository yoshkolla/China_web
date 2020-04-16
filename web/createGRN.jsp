<%-- 
    Document   : createGRN
    Created on : Mar 28, 2020, 2:16:28 AM
    Author     : AKILA
--%>

<%@page import="resources.RawItems"%>
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
        <!-- Select2-->
        <link href="assets/vendors/select2/select2.min.css" rel="stylesheet" type="text/css"/>

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
                                                <span style="text-align: left; font-size: 15px; font-weight: bolder;">&nbsp;Supplier</span>
                                                <div class="form-group open" style="padding-left: 10px; margin-top: -28px; margin-left: 85px;">
                                                    <div class="select" aria-expanded="true">
                                                        <select class="form-control"
                                                                required="true"
                                                                autofocus="true"
                                                                id="grn_supplier"
                                                                onclick='execCal_GRNSUM();'>

                                                            <option value="x">Select A Supplier</option>
                                                            <%  Criteria suppCriteria = sess.createCriteria(Supplier.class);
                                                                suppCriteria.add(Restrictions.eq("status", 1));
                                                                List<Supplier> supplierList = suppCriteria.list();
                                                                for (Supplier supplierObject : supplierList) { %>
                                                            <option value="<%out.print(supplierObject.getSupplierId());%>"><%out.print(supplierObject.getName());%>&nbsp;</option>
                                                            <% }%>
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
                                <div class="card" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                                    <div class="card-header card-header-text">
                                        <h5 class="card-title" style="background-color: #8BC34A; color: white; padding-left: 10px; padding-right: 20px; margin-left: -20px;">Add Items</h5>
                                    </div>
                                    <div class="form-horizontal">
                                        <div class="card-content">
                                            <button class="btn btn-danger btn-sm" style="float: right; margin-top: -45px; margin-right: -10px;" data-toggle="modal" data-target="#newitemRegModal" onclick='resetAll_regRawItemForm();'>
                                                <span class="fa fa-pencil"></span>&nbsp;&nbsp;REGISTER
                                            </button>
                                            <!--Item-Name-->
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group" style="margin-left: 7px;">
                                                        <label class="control-label" style="font-size: 14px; font-weight: bolder;">Item</label>
                                                        <div class="select" aria-expanded="true">
                                                            <select 
                                                                class="form-control" 
                                                                required="true"
                                                                autofocus="true"
                                                                id="addItem_Item"
                                                                onclick='checkValidations_addItemToList();'
                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_unitPrice");'>

                                                                <option value="x">Select an Item</option>
                                                                <%  Criteria RawItemCriteria = sess.createCriteria(RawItems.class);
                                                                    RawItemCriteria.add(Restrictions.eq("status", 1));
                                                                    List<RawItems> RawItemList = RawItemCriteria.list();
                                                                    for (RawItems RawItemObject : RawItemList) { %>
                                                                <option value="<%out.print(RawItemObject.getRawItemsId());%>"><%out.print(RawItemObject.getName());%>&nbsp;</option>
                                                                <% }%>
                                                            </select>
                                                        </div>
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <!--Unit-Price-->
                                                    <div class="col-lg-3">
                                                        <div class="form-group">
                                                            <label class="control-label" style="font-size: 14px; font-weight: bolder;">Unit Price</label>
                                                            <input 
                                                                class="form-control" 
                                                                type="number" 
                                                                number="true" 
                                                                required="true"
                                                                autofocus="true"
                                                                min="0.01"
                                                                step="0.01"
                                                                id="addItem_unitPrice"
                                                                onblur='priceValFormatting(this);'
                                                                onkeyup='checkValidations_addItemToList();'
                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_supplierPrice");'>
                                                            <span class="material-input"></span>
                                                        </div>
                                                    </div>
                                                    <!--Supplier-Price-->
                                                    <div class="col-lg-3">
                                                        <div class="form-group">
                                                            <label class="control-label" style="font-size: 14px; font-weight: bolder;">Supplier Price</label>
                                                            <input 
                                                                class="form-control" 
                                                                type="number" 
                                                                number="true" 
                                                                required="true"
                                                                autofocus="true"
                                                                min="0.01"
                                                                step="0.01"
                                                                id="addItem_supplierPrice"
                                                                onblur='priceValFormatting(this);'
                                                                onkeyup='checkValidations_addItemToList();'
                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_qty");'>
                                                            <span class="material-input"></span>
                                                        </div>
                                                    </div>
                                                    <!--Qty-->
                                                    <div class="col-lg-3">
                                                        <div class="form-group">
                                                            <label class="control-label" style="font-size: 14px; font-weight: bolder;">Qty</label>
                                                            <input 
                                                                class="form-control" 
                                                                type="number" 
                                                                number="true" 
                                                                required="true"
                                                                autofocus="true"
                                                                min="0.001"
                                                                step="0.001"
                                                                id="addItem_qty"
                                                                onblur='qtyValFormatting(this);'
                                                                onkeyup='checkValidations_addItemToList();'
                                                                onkeydown='setElementFocus_addItemToList(event, "addItem_discount");'>
                                                            <span class="material-input"></span>
                                                        </div>
                                                    </div>
                                                    <!--Discount-->
                                                    <div class="col-lg-3">
                                                        <div class="form-group">
                                                            <label class="control-label" style="font-size: 14px; font-weight: bolder;">Discount (%)</label>
                                                            <input 
                                                                class="form-control" 
                                                                type="number" 
                                                                number="true" 
                                                                required="true"
                                                                autofocus="true"
                                                                min="0.00"
                                                                step="0.01"
                                                                id="addItem_discount"
                                                                onblur='priceValFormatting(this);'
                                                                onkeyup='checkValidations_addItemToList();'
                                                                onkeydown='setElementFocus_addItemToList(event, "buttonSubmit_addItemToList");'>
                                                            <span class="material-input"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer text-right">
                                        <button class="btn btn-primary btn-sm" 
                                                type="submit" 
                                                disabled="true"
                                                onmouseover='checkValidations_addItemToList();'
                                                onclick ='execAddItemToListFunc(
                                                                "addItem_ItemID=" + document.getElementById("addItem_Item").value + "&" +
                                                                "addItem_unitPrice=" + document.getElementById("addItem_unitPrice").value + "&" +
                                                                "addItem_supplierPrice=" + document.getElementById("addItem_supplierPrice").value + "&" +
                                                                "addItem_qty=" + document.getElementById("addItem_qty").value + "&" +
                                                                "addItem_discount=" + document.getElementById("addItem_discount").value
                                                                );'
                                                id="buttonSubmit_addItemToList">
                                            <span class="fa fa-plus"></span> &nbsp;&nbsp;ADD&nbsp;&nbsp;
                                        </button>
                                        <button class="btn btn-default btn-sm"
                                                style="margin-left:15px;"
                                                onclick='resetAll_addItemToList();'
                                                id="buttonReset_addItemToList">
                                            <span class="fa fa-undo"></span> &nbsp;RESET
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- GRN.Items -Table ================================================================ -->
                            <div id="DataTable_Includer">
                                <%@include file="createGRN_loadGRNItems.jsp"%>
                            </div>

                            <!-- GRN.SUM -CARD ================================================================ -->
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="form-horizontal">
                                        <div class="card-content">
                                            <!-- ==== SUM Values ========================================= -->
                                            <div class="row">
                                                <div class="col-sm-4" style="float: right;">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label"></label>
                                                        <input class="form-control" type="text" disabled="true" id="grn_totalAmount">
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                                <label class="col-sm-3 label-on-left" style="float: right;">Total Amount (Rs.)</label>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4" style="float: right;">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label"></label>
                                                        <input class="form-control" type="text" disabled="true" id="grn_totalDisc">
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                                <label class="col-sm-3 label-on-left" style="float: right;">Total Discount (Rs.)</label>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4" style="float: right;">
                                                    <div class="form-group label-floating is-empty">
                                                        <label class="control-label"></label>
                                                        <input class="form-control" style="font-weight: bold;" type="text" disabled="true" id="grn_netTotal">
                                                        <span class="material-input"></span>
                                                    </div>
                                                </div>
                                                <label class="col-sm-3 label-on-left" style="float: right; font-weight: bold;">Net Total (Rs.)</label>
                                            </div>
                                        </div>

                                        <div class="card-footer text-center">
                                            <div class="col-md-4" style="float: right; margin-right: -16px;">
                                                <div class="btn-group" role="group">
                                                    <button
                                                        class="btn btn-success"  
                                                        style="margin-right: 20px;"
                                                        type="submit" 
                                                        disabled="true"
                                                        id="buttonSubmit_saveGRN" 
                                                        onmouseover='execCal_GRNSUM();'
                                                        onclick='execSaveGRNFunc(
                                                                        "grn_supplier=" + document.getElementById("grn_supplier").value + "&" +
                                                                        "grn_totalAmount=" + document.getElementById("grn_totalAmount").value + "&" +
                                                                        "grn_totalDisc=" + document.getElementById("grn_totalDisc").value + "&" +
                                                                        "grn_netTotal=" + document.getElementById("grn_netTotal").value
                                                                        );'>
                                                        <span class="fa fa-save mr-2"></span>&nbsp;&nbsp;SAVE&nbsp;
                                                    </button>
                                                    <button type="button" class="btn btn-danger" id="buttonSubmit_cancelGRN" onclick='execCancelGRN();'><span class="fa fa-close mr-2"></span>&nbsp;&nbsp;CANCEL&nbsp;</button>
                                                </div>
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

                                <div class="form-group">
                                    <label class="control-label" style="font-size: 14px;">Item Name *</label>
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
            resetAll();
        });
    </script>

    <!-- ========================================================================================================================================== -->
    <!-- === UTILITY SCRIPTS  ============================================================================================================================== -->
    <!-- ========================================================================================================================================== -->

    <!--   INPUT ELEMENT VALUES FORMATTING  -->
    <script>
        function priceValFormatting(field) {
            field.value = parseFloat(field.value).toFixed(2);
        }
        function qtyValFormatting(field) {
            field.value = parseFloat(field.value).toFixed(3);
        }
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
            });
        }
    </script>


    <!-- =========ADD-ITEM-TO-GRN_items.LIST FORM Scripts ==================================================================================== -->

    <!-- SET FOCUS TO ELEMENTS -->
    <script>
        function setElementFocus_addItemToList(event, fcsElement) {
            // Enter Key
            if (event.keyCode == 13) {
                document.getElementById('buttonSubmit_addItemToList').disabled = true;  //  disable it ( 4 disable auto Form submits )
                document.getElementById(fcsElement).focus();
                document.getElementById('buttonSubmit_addItemToList').disabled = false;
            }
        }
    </script>

    <!-- RESET ADDING-ITEM FORM-->
    <script>
        function resetAll_addItemToList() {
            document.getElementById("addItem_Item").value = "x";
            document.getElementById("addItem_unitPrice").value = "0.01";
            document.getElementById("addItem_supplierPrice").value = "0.01";
            document.getElementById("addItem_qty").value = "0.001";
            document.getElementById("addItem_discount").value = "0.00";
            document.getElementById("buttonSubmit_addItemToList").disabled = true; // disable it
        }
    </script>

    <!-- CHECK ELEMENTs VALUEs IN ADDING-ITEMs FROM -->
    <script>
        function checkValidations_addItemToList() {
            var flagSubmitSts = false;
            // value validations
            if (document.getElementById('addItem_Item').value == "x") {
                flagSubmitSts = false;
            } else if (!document.getElementById('addItem_unitPrice').checkValidity()) {
                flagSubmitSts = false;
            } else if (!document.getElementById('addItem_supplierPrice').checkValidity()) {
                flagSubmitSts = false;
            } else if (!document.getElementById('addItem_qty').checkValidity()) {
                flagSubmitSts = false;
            } else if (!document.getElementById('addItem_discount').checkValidity()) {
                flagSubmitSts = false;
            }

            // check DoubleValues ----UNIT_PRICE
            else if (document.getElementById('addItem_unitPrice').value.toString().trim().length == 0) {
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_unitPrice').value.toString().trim() == "NaN") {
                document.getElementById("addItem_unitPrice").value = "0.01";
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_unitPrice').value < 0.01) {
                flagSubmitSts = false;
            }

            // check DoubleValues ----SUPPLIER_PRICE
            else if (document.getElementById('addItem_supplierPrice').value.toString().trim().length == 0) {
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_supplierPrice').value.toString().trim() == "NaN") {
                document.getElementById("addItem_supplierPrice").value = "0.01";
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_supplierPrice').value < 0.01) {
                flagSubmitSts = false;
            }

            // check DoubleValues ----QTY
            else if (document.getElementById('addItem_qty').value.toString().trim().length == 0) {
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_qty').value.toString().trim() == "NaN") {
                document.getElementById("addItem_qty").value = "0.001";
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_qty').value < 0.001) {
                flagSubmitSts = false;
            }

            // check DoubleValues ----DISCOUNT
            else if (document.getElementById('addItem_discount').value.toString().trim().length == 0) {
                flagSubmitSts = false;
            } else if (document.getElementById('addItem_discount').value.toString().trim() == "NaN") {
                document.getElementById("addItem_discount").value = "0.00";
                flagSubmitSts = false;
            }

            // @ finally all OK
            else {
                flagSubmitSts = true;
            }

            //  == set submit btn status ==================
            if (flagSubmitSts) {
                document.getElementById('buttonSubmit_addItemToList').disabled = false;  //  enable submit !!!
            } else {
                document.getElementById('buttonSubmit_addItemToList').disabled = true;  //  disable submit 
            }
        }
    </script>

    <!--  ADD ITEM TO GRN_items.LIST -->
    <script type="text/javascript">
        function execAddItemToListFunc(param) {
            $.post("AddItemToGRNServlet", param, function (outputData) {
                // Post Actions..
                if (outputData.split(":")[0] == 'success') {
                    resetAll_addItemToList();
                    execCal_GRNSUM();
                    document.getElementById("addItem_Item").focus();
                    load_GRNItemsTableData();
                } else {
                    //  Show output-Message [ Title : MsgText : MsgType ]
                    swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                }
            });
        }
    </script>


    <!-- ========= GRN MAIN-Scripts ==================================================================================== -->

    <!-- LOAD GRN.Items Table_Data -->
    <script>
        function load_GRNItemsTableData() {
            document.getElementById("DataTable_Remover").outerHTML = "";
            $('#DataTable_Includer').load('createGRN_loadGRNItems.jsp');
        }
    </script>

    <!-- RESET All Elements -->
    <script>
        function resetAll() {
            resetAll_addItemToList();
            document.getElementById("grn_supplier").value = "x";
            document.getElementById("grn_totalAmount").value = "0.00";
            document.getElementById("grn_totalDisc").value = "0.00";
            document.getElementById("grn_netTotal").value = "0.00";
            document.getElementById("buttonSubmit_addItemToList").disabled = true; // disable it
            document.getElementById("buttonSubmit_saveGRN").disabled = true; // disable it

            execCal_GRNSUM();
        }
    </script>

    <!--  Cancel GRN -->
    <script type="text/javascript">
        function execCancelGRN() {
            swal({
                title: 'Are you sure?',
                text: "You want to Cancel this GRN",
                icon: 'warning',
                buttons: true,
                dangerMode: true,
            }).then(confirm => {
                if (confirm) {
                    $.post("CancelGRNServlet", function (outputData) {
                        //  Show output-Message [ Title : MsgText : MsgType ]
                        if (outputData.split(":")[0] != 'success') {
                            swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                        }
                        // Post Actions..
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    });
                }
            });
        }
    </script>

    <!--  Calculate SUM Values of GRN -->
    <script type="text/javascript">
        function execCal_GRNSUM() {
            $.post("GetGRNSUMServlet", function (outputData) {
                // Post Actions..
                if (outputData.split(":")[0] == 'success') {
                    document.getElementById("grn_totalAmount").value = outputData.split(":")[1];
                    document.getElementById("grn_totalDisc").value = outputData.split(":")[2];
                    document.getElementById("grn_netTotal").value = outputData.split(":")[3];

                    // set Save Func. Enable/ Disable 
                    if (outputData.split(":")[4] == 'true') {
                        if (document.getElementById("grn_supplier").value == 'x') {
                            document.getElementById("buttonSubmit_saveGRN").disabled = true; // disable it
                        } else {
                            document.getElementById("buttonSubmit_saveGRN").disabled = false; // enable it
                        }
                    } else {
                        document.getElementById("buttonSubmit_saveGRN").disabled = true; // disable it
                    }

                } else {
                    //  Show output-Message [ Title : MsgText : MsgType ]
                    swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                    document.getElementById("buttonSubmit_saveGRN").disabled = true; // disable it
                }
            });
        }
    </script>

    <!--  SAVE GRN -->
    <script type="text/javascript">
        function execSaveGRNFunc(param) {
            swal({
                title: 'Are you sure?',
                text: "You want to Save this GRN now",
                icon: 'warning',
                buttons: true,
                dangerMode: true,
            }).then(confirm => {
                if (confirm) {
                    $.post("SaveGRNServlet", param, function (outputData) {
                        //  Show output-Message [ Title : MsgText : MsgType ]
                        swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                        // Post Actions..
                        setTimeout(function () {
                            if (outputData.split(":")[0] == 'success') {
                                location.reload();
                            } else {
                                document.getElementById("buttonSubmit_saveGRN").disabled = true; // disable it
                            }
                        }, 1000);
                    });
                }
            });
        }
    </script>

</html>
