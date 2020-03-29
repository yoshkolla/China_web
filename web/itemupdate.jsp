<%-- 
    Document   : index
    Created on : Mar 19, 2020, 5:14:33 PM
    Author     : Chamara
--%>

<%@page import="resources.ItemStaffCost"%>
<%@page import="resources.ProductionSteps"%>
<%@page import="holder.ProductionPlanHolder"%>
<%@page import="holder.ProductionRawMatHolder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="resources.ItemsHasRawItems"%>
<%@page import="java.util.Set"%>
<%@page import="resources.Items"%>
<%@page import="resources.RawItems"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.MeasurementType"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="holder.LogedUserHolder"%>
<%@page import="holder.DetailsHolder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%
            String PAGE_NAME = "Update Item Details", NAME = "", USERNAME = "";
            int LOGED_USER_ID = 0;
            int STAF_ID = 0;
            LogedUserHolder luh;
            DetailsHolder dth;
            int i = 1;
            int j = 1;
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
            if (request.getSession().getAttribute("ppl") != null) {
                request.getSession().removeAttribute("ppl");
            }
            if (request.getSession().getAttribute("rrl") != null) {
                request.getSession().removeAttribute("ppl");
            }

            Session ses = connection.GetConnection.getSessionFactory().openSession();
            Items ITEM = null;
            if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
                ITEM = (Items) ses.load(Items.class, Integer.parseInt(request.getParameter("id")));
            } else {
                response.sendRedirect("items.jsp");
            }
            if (ITEM != null) {

                ArrayList<ProductionRawMatHolder> pph = new ArrayList();
                Set<ItemsHasRawItems> RI = ITEM.getItemsHasRawItemses();
                for (ItemsHasRawItems I : RI) {
                    if (I.getStatus() == 1) {
                        ProductionRawMatHolder h = new ProductionRawMatHolder();
                        h.setAmount(I.getAmount());
                        h.setId(0);
                        h.setName(I.getRawItems().getName());
                        h.setRow_id(I.getRawItems().getRawItemsId());
                        pph.add(h);
                        i++;
                    }
                }
                request.getSession().setAttribute("rrl", pph);

                ArrayList<ProductionPlanHolder> rrh = new ArrayList();
                Set<ProductionSteps> HI = ITEM.getProductionStepses();
                for (ProductionSteps I : HI) {
                    if (I.getStatus() == 1) {
                        double cost = 0.0;
                        Set<ItemStaffCost> sc = I.getItemStaffCosts();
                        for (ItemStaffCost c : sc) {
                            if (c.getStatus() == 1) {
                                cost = c.getCost();
                            }
                        }

                        ProductionPlanHolder h = new ProductionPlanHolder();
                        h.setCost(cost);
                        h.setId(0);
                        h.setName(I.getStepName());
                        rrh.add(h);
                        j++;
                    }
                }
                request.getSession().setAttribute("ppl", rrh);

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
                String curruntpage = "Update Item";
            %>
            <%@include file="includes/slidebar.jsp"%>
            <div class="main-panel">
                <%@include file="includes/navbar.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <nav aria-label="breadcrumb" style="font-size: 14px;">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.jsp"><span class="fa fa-home">&nbsp;</span>Home</a></li>
                                        <li class="breadcrumb-item active"><a href="viewitems.jsp?id=<%=ITEM.getItemsId()%>"><span class="fa fa-arrow-left">&nbsp;</span>Back</a></li>
                                        <li class="breadcrumb-item active">Update sales item</li>
                                    </ol>
                                </nav>

                            </div>

                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>UPDATE SALES ITEM</h4>
                                    </div>

                                    <div class="card-content">
                                        <!-- BEGIN FORM WIZARD -->
                                        <div id="formwizard_simple" class="form-wizard form-wizard-horizontal">

                                            <div class="form-wizard-nav">
                                                <div class="progress" style="width: 75%;">
                                                    <div class="progress-bar progress-bar-primary" style="width: 0%;"></div>
                                                </div>
                                                <ul class="nav nav-justified nav-pills">
                                                    <li class="active"><a href="#fws_tab1" data-toggle="tab"><span class="step">1</span> <span class="title">BASIC DETAILS</span></a></li>
                                                    <li><a href="#fws_tab2" data-toggle="tab"><span class="step">2</span> <span class="title">IMAGE</span></a></li>
                                                    <li><a href="#fws_tab3" data-toggle="tab"><span class="step">3</span> <span class="title">ROW MATERIAL</span></a></li>
                                                    <li><a href="#fws_tab4" data-toggle="tab"><span class="step">4</span> <span class="title">PRODUCTION PLAN</span></a></li>
                                                    <li><a href="#fws_tab5" data-toggle="tab"><span class="step">5</span> <span class="title">CONFIRM</span></a></li>
                                                </ul>
                                            </div>
                                            <!--end .form-wizard-nav -->
                                            <!-- <form action="SaveNewItemServlet" method="post" enctype="multipart/form-data" > -->
                                            <div class="tab-content clearfix p-30">
                                                <div class="tab-pane active" id="fws_tab1">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <input type="text" name="name" id="name" class="form-control" required="" value="<%=ITEM.getName()%>">
                                                                <label for="name" class="control-label">ITEM NAME</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <div class="form-group">
                                                                <input type="number" name="rol" id="rol" class="form-control" required="" value="<%= ITEM.getRol() %>">
                                                                <label for="rol" class="control-label">RE ORDER LEVEL</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <div class="form-group">
                                                                <select  name="type" id="type" class="form-control" required="">
                                                                    <%
                                                                        Criteria cr = ses.createCriteria(MeasurementType.class);
                                                                        cr.add(Restrictions.eq("status", 1));
                                                                        List<MeasurementType> list = cr.list();
                                                                        if (list.isEmpty()) {
                                                                    %>
                                                                    <option value="0" >PLEASE ADD TYPES FIRST</option>      
                                                                    <%
                                                                    } else {
                                                                        for (MeasurementType t : list) {
                                                                    %>
                                                                    <option value="<%=t.getMeasurementTypeId()%>" ><%=t.getName().toUpperCase()%></option>
                                                                    <%
                                                                            }
                                                                        }
                                                                    %>

                                                                </select>
                                                                <label for="type" class="control-label">MEASURING TYPE</label>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                                <!--end #tab1 -->
                                                <div class="tab-pane" id="fws_tab2">
                                                    <div class="row">
                                                        <div class="col-sm-5">

                                                        </div>
                                                        <div class="col-sm-3">
                                                            <legend class="text-center">PLEASE SELECT IMAGE FOR ITEM</legend>
                                                            <div class="fileinput text-center fileinput-new" data-provides="fileinput">
                                                                <div class="fileinput-new thumbnail">
                                                                    <img src="<%=ITEM.getImage()%>">
                                                                </div>
                                                                <div class="fileinput-preview fileinput-exists thumbnail" style=""></div>
                                                                <div>
                                                                    <span class="btn btn-round btn-file">
                                                                        <span class="fileinput-new">Select image</span>
                                                                        <span class="fileinput-exists">Change</span>
                                                                        <input type="hidden" value="" name="..."><input type="file" name="image" id="image">
                                                                        <div class="ripple-container"></div></span>
                                                                    <a href="#pablo" class="btn btn-danger btn-round fileinput-exists" data-dismiss="fileinput"><i class="fa fa-times"></i> Remove<div class="ripple-container"><div class="ripple ripple-on ripple-out" style="left: 57.9688px; top: 25px; background-color: rgb(255, 255, 255); transform: scale(13.4082);"></div></div></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-4">

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-pane" id="fws_tab3">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <select  name="ro" id="ro" class="form-control" required="">
                                                                    <%
                                                                        Criteria cr_row = ses.createCriteria(RawItems.class);
                                                                        cr_row.add(Restrictions.eq("status", 1));
                                                                        List<RawItems> list_row = cr_row.list();
                                                                        if (list_row.isEmpty()) {
                                                                    %>
                                                                    <option value="0" >PLEASE ADD ROW MATERIAL FIRST</option>      
                                                                    <%
                                                                    } else {
                                                                        for (RawItems t : list_row) {
                                                                    %>
                                                                    <option value="<%=t.getRawItemsId()%>" ><%=t.getName().toUpperCase() + "  (" + t.getMeasurementType().getName().toLowerCase() + ")"%></option>
                                                                    <%
                                                                            }
                                                                        }
                                                                    %>

                                                                </select>
                                                                <label for="ro" class="control-label">SELECT ROW MATERIAL</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <div class="form-group">
                                                                <input type="number" name="amount" id="amount" class="form-control">
                                                                <label for="amount" class="control-label">AMOUNT</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <button class="btn btn-sm btn-warning" type="button" id="add_ro"><span class="fa fa-plus">&nbsp;</span>ADD</button>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12"> 
                                                            <table class="" id="tbl2" style="width: 100%;">
                                                                <thead>
                                                                    <tr>
                                                                        <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">#</th>
                                                                        <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">MATERIAL NAME</th>
                                                                        <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">AMOUNT</th>
                                                                        <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">REMOVE</th>
                                                                    </tr>
                                                                <tbody>
                                                                    <%
                                                                      i=1; 
                                                                      if(request.getSession().getAttribute("rrl") != null ){ 
                                                                         ArrayList<ProductionRawMatHolder> pp = (ArrayList<ProductionRawMatHolder>) request.getSession().getAttribute("rrl");
                                                                         for(ProductionRawMatHolder p : pp){
                                                                         
                                                                         
                                                                    %>

                                                                    <tr>
                                                                        <td style="border: #2d3436 solid 1px !important;" ><%=i %></td>
                                                                        <td style="border: #2d3436 solid 1px !important;"><%=p.getName() %></td>
                                                                        <td style="border: #2d3436 solid 1px !important;"><%=p.getAmount() %></td>
                                                                        <td style="border: #2d3436 solid 1px !important;">
                                                                            <button style="margin: 2px 2px 2px 2px;background-color:#27ae60;color: white; border: none;border-radius: 6px; " type="button" class="delete_pr" data-ref="<%=i %>">REMOVE</button>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%
                                                                        i++; 
                                                                        }
                                                                           } 
                                                                    %>
                                                                </tbody>
                                                                </thead>
                                                            </table>
                                                        </div>

                                                    </div>


                                                </div>
                                                <!--end #tab2 -->

                                                <div class="tab-pane" id="fws_tab4">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <input type="text" name="step" id="step" class="form-control">
                                                                <label for="step" class="control-label">PRODUCTION STEP NAME</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <div class="form-group">
                                                                <input type="number" name="cost" id="cost" class="form-control">
                                                                <label for="cost" class="control-label">COST</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <div class="form-group">
                                                                <button class="btn btn-sm btn-warning" type="button" id="add_pr"><span class="fa fa-plus">&nbsp;</span>ADD</button>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="col-sm-12"> 
                                                            <table class="" id="tbl1" style="width: 100%;">

                                                                <tr>
                                                                    <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">#</th>
                                                                    <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">STEP NAME</th>
                                                                    <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">COST</th>
                                                                    <th style="border: #576574 solid 1px;padding: 2px 2px 2px 2px;">REMOVE</th>
                                                                </tr>

                                                                <tbody>
                                                                    <%
                                                                      j=1; 
                                                                      if(request.getSession().getAttribute("ppl") != null ){ 
                                                                         ArrayList<ProductionPlanHolder> rr = (ArrayList<ProductionPlanHolder>) request.getSession().getAttribute("ppl");
                                                                         for(ProductionPlanHolder p : rr){
                                                                         
                                                                         
                                                                    %>

                                                                    <tr>
                                                                        <td style="border: #2d3436 solid 1px !important;" ><%=j %></td>
                                                                        <td style="border: #2d3436 solid 1px !important;"><%=p.getName() %></td>
                                                                        <td style="border: #2d3436 solid 1px !important;"><%=p.getCost() %></td>
                                                                        <td style="border: #2d3436 solid 1px !important;">
                                                                            <button style="margin: 2px 2px 2px 2px;background-color:#27ae60;color: white; border: none;border-radius: 6px; " type="button" class="delete_pr" data-ref="<%=j %>">REMOVE</button>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%
                                                                        j++;
                                                                        }
                                                                           } 
                                                                    %>
                                                                </tbody>
                                                                </thead>
                                                            </table>
                                                        </div>

                                                    </div>
                                                </div>
                                                <!--end #tab3 -->

                                                <div class="tab-pane" id="fws_tab5">
                                                    <div class="row">
                                                        <div class="col-sm-5">

                                                        </div>
                                                        <div class="col-sm-2">
                                                            <button class="btn btn-warning" type="button" id="conf_a"><span class="fa fa-check">&nbsp;</span>CONFIRM AND UPDATE</button>
                                                        </div>
                                                        <div class="col-sm-5">

                                                        </div>
                                                    </div>
                                                </div>
                                                <!--end #tab4 -->

                                                <ul class="pager wizard ">
                                                    <li class="previous disabled"><a class="btn-raised btn btn-danger" href="javascript:void(0);"><span class="fa fa-arrow-left">&nbsp;&nbsp;</span>Previous</a></li>
                                                    <li class="next"><a class="btn-raised btn btn-info" href="javascript:void(0);">Next&nbsp;&nbsp;<span class="fa fa-arrow-right"></span></a></li>
                                                </ul>
                                            </div>
                                            <!-- </form> -->
                                            <!--end .tab-content -->



                                        </div>
                                        <!--end #rootwizard -->
                                        <!-- END FORM WIZARD -->

                                    </div>
                                </div>
                            </div>
                            <% }%>
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

        });
    </script>

    <script>
        $(document).ready(function () {
            //Add blue animated border and remove with condition when focus and blur
            if ($('.fg-line')[0]) {
                $('body').on('focus', '.form-control', function () {
                    $(this).closest('.fg-line').addClass('fg-toggled');
                })

                $('body').on('blur', '.form-control', function () {
                    var p = $(this).closest('.form-group');
                    var i = p.find('.form-control').val();

                    if (p.hasClass('fg-float')) {
                        if (i.length == 0) {
                            $(this).closest('.fg-line').removeClass('fg-toggled');
                        }
                    } else {
                        $(this).closest('.fg-line').removeClass('fg-toggled');
                    }
                });
            }

            //Add blue border for pre-valued fg-flot text feilds
            if ($('.fg-float')[0]) {
                $('.fg-float .form-control').each(function () {
                    var i = $(this).val();

                    if (!i.length == 0) {
                        $(this).closest('.fg-line').addClass('fg-toggled');
                    }

                });
            }


            /*   Form Wizard Functions  */
            /*--------------------------*/
            _handleTabShow = function (tab, navigation, index, wizard) {
                var total = navigation.find('li').length;
                var current = index + 0;
                var percent = (current / (total - 1)) * 100;
                var percentWidth = 100 - (100 / total) + '%';

                navigation.find('li').removeClass('done');
                navigation.find('li.active').prevAll().addClass('done');

                wizard.find('.progress-bar').css({
                    width: percent + '%'
                });
                $('.form-wizard-horizontal').find('.progress').css({
                    'width': percentWidth
                });
            };

            _updateHorizontalProgressBar = function (tab, navigation, index, wizard) {
                var total = navigation.find('li').length;
                var current = index + 0;
                var percent = (current / (total - 1)) * 100;
                var percentWidth = 100 - (100 / total) + '%';

                wizard.find('.progress-bar').css({
                    width: percent + '%'
                });
                wizard.find('.progress').css({
                    'width': percentWidth
                });
            };

            /* Form Wizard - Example 1  */
            /*--------------------------*/
            $('#formwizard_simple').bootstrapWizard({
                onTabShow: function (tab, navigation, index) {
                    _updateHorizontalProgressBar(tab, navigation, index, $('#formwizard_simple'));
                }
            });

            /* Form Wizard - Example 2  */
            /*--------------------------*/

            $('#formwizard_validation').bootstrapWizard({
                onNext: function (tab, navigation, index) {
                    var form = $('#formwizard_validation').find("form");
                    var valid = true;

                    if (index == 1) {
                        var fname = form.find('#firstname');
                        var lastname = form.find('#lastname');

                        if (!fname.val()) {
                            swal("You must enter your first name!");
                            fname.focus();
                            return false;
                        }

                        if (!lastname.val()) {
                            swal("You must enter your last name!");
                            lastname.focus();
                            return false;
                        }
                    }

                    if (!valid) {
                        return false;
                    }
                },
                onTabShow: function (tab, navigation, index) {
                    _updateHorizontalProgressBar(tab, navigation, index, $('#formwizard_validation'));
                }
            });

            //page JS
            var NAME = "";
            var ROL = 0;
            var TYPE = 0;

            $('#name').focus();
            $('#name').keypress(function (key) {
                if (key.which === 13) {
                    NAME = $('#name').val();
                    if (NAME !== "") {
                        $('#rol').focus();
                    } else {
                        swal("Please Enter Item Name !").then(function (e) {
                            $('#name').focus();
                        });

                    }
                }
            });
            $('#rol').keypress(function (key) {
                if (key.which === 13) {
                    ROL = $('#rol').val();
                    if (ROL !== "") {
                        $('#type').focus();
                    } else {
                        swal("Please Enter Re Order Level !").then(function (e) {
                            $('#rol').focus();
                        });

                    }
                }
            });

            $('#type').change(function () {
                TYPE = $('#type').val();
            });
            $('#type').keypress(function (key) {
                if (key.which === 13) {
                    TYPE = $('#type').val();
                    if (TYPE !== "0") {
                        $('.next').click();
                    } else {
                        swal("Please Select Type !").then(function (e) {
                            $('#rol').focus();
                        });

                    }
                }
            });

            //production plan
            $('#add_pr').click(function (key) {
                onAddPressPlan();
            });
            $('#step').keypress(function (key) {
                if (key.which === 13) {
                    $('#cost').focus();
                }
            });
            var i = <%=j%>;
            function onAddPressPlan() {

                var PLAN_NAME = $('#step').val();
                var PLAN_COST = $('#cost').val();
                $.ajax({
                    url: "addSalesProductionPlanServlet",
                    data: {name: PLAN_NAME, cost: PLAN_COST},
                    success: function (data) {
                        if (data === "0") {
                            swal({
                                title: "Empty Data !",
                                text: "Some data are missing please retry.",
                                icon: "error",
                                button: "OK"
                            });
                        } else if (data === "1") {
                            $('#tbl1 > tbody:last-child').append('<tr><td style="border: #2d3436 solid 1px !important;" >' + i + '</td><td style="border: #2d3436 solid 1px !important;">' + PLAN_NAME + '</td><td style="border: #2d3436 solid 1px !important;">' + PLAN_COST + '</td><td style="border: #2d3436 solid 1px !important;"><button style="margin: 2px 2px 2px 2px;background-color:#27ae60;color: white; border: none;border-radius: 6px; " type="button" class="delete_pr" data-ref="' + i + '">REMOVE</button></td></tr>');
                            $('#step').val("");
                            $('#cost').val("");
                            $('#step').focus();
                            i++;
                        } else if (data === "2") {

                        }
                    }
                });
            }

            $("#tbl1").on("click", ".delete_pr", function () {
                $.ajax({
                    url: "removeSalesProductionPlanServlet",
                    data: {id: $(this).attr('data-ref')},
                    success: function (data) {
                        if (data == "1") {
                            //$('#companyAllowance').removeAttr('disabled');
                        }
                    }
                });
                $(this).closest("tr").remove();
            });
            //production plan
            //metirel plan
            $('#add_ro').click(function (key) {
                onAddPressRo();
            });
            $('#ro').change(function (key) {
                $('#amount').focus();
            });

            var j = <%=i%>;
            function onAddPressRo() {

                var ROL_ID = $('#ro').val();
                var ROL_NAME = $('#ro').text();
                var AMOUNT = $('#amount').val();
                $.ajax({
                    url: "addRowMatItemsServlet",
                    data: {rol: ROL_ID, amount: AMOUNT},
                    success: function (data) {
                        if (data === "0") {
                            swal({
                                title: "Empty Data !",
                                text: "Some data are missing please retry.",
                                icon: "error",
                                button: "OK"
                            });
                        } else if (data === "1") {
                            $('#tbl2 > tbody:last-child').append('<tr><td style="border: #2d3436 solid 1px !important;" >' + j + '</td><td style="border: #2d3436 solid 1px !important;">' + ROL_NAME + '</td><td style="border: #2d3436 solid 1px !important;">' + AMOUNT + '</td><td style="border: #2d3436 solid 1px !important;"><button style="margin: 2px 2px 2px 2px;background-color:#27ae60;color: white; border: none;border-radius: 6px; " type="button" class="delete_ro" data-ref="' + j + '">REMOVE</button></td></tr>');
                            $('#amount').val("");
                            $('#ro').focus();
                            j++;
                        } else if (data === "2") {

                        }
                    }
                });
            }
            $("#tbl2").on("click", ".delete_ro", function () {
                $.ajax({
                    url: "removeRawMatItemaServlet",
                    data: {id: $(this).attr('data-ref')},
                    success: function (data) {
                        if (data == "1") {
                            //$('#companyAllowance').removeAttr('disabled');
                        }
                    }
                });
                $(this).closest("tr").remove();
            });
            //metirel plan
            //confirm
            $('#conf_a').click(function (key) {

                var NAME_S = $('#name').val();
                var ROL_S = $('#rol').val();
                var TYPE_S = $('#type').val();

                var dataimg = new FormData();
                dataimg.append('name', NAME_S);
                dataimg.append('rol', ROL_S);
                dataimg.append('type', TYPE_S);
                dataimg.append('img', $("#image")[0].files[0]);

                $.ajax({
                    url: "SaveNewItemServlet",
                    type: "post",
                    enctype: 'multipart/form-data',
                    cache: false,
                    contentType: false,
                    processType: false,
                    data: dataimg,
                    processData: false,
                    success: function (data) {
                        if (data == "1") {
                            swal({
                                title: "Good job!",
                                text: "You saved new item to list",
                                buttonsStyling: false,
                                confirmButtonClass: "btn btn-success",
                                type: "success"
                            }).then(function () {
                                location.replace('items.jsp');
                            });

                        } else {
                            swal({
                                title: 'Empty Data !',
                                text: 'Some data are missing please retry !',
                                type: 'error',
                                confirmButtonClass: "btn btn-info",
                                buttonsStyling: false
                            });

                        }
                    }
                });




            });
            //confirm
        });



        //page JS


    </script>

    <!-- for pre loader -->
</html>
