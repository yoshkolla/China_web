<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.GrnChequeDetails"%>
<%@page import="resources.GrnPayment"%>
<%@page import="resources.GrnItem"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="resources.Grn"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="help.Helper"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>

<style>
    .txtBold{
        font-weight: bolder;
    }
    .txtWhite{
        color: white;;
    }
    .txtGray{
        color: gray;
    }
    .txtlg{
        font-size: medium;
    }
    .txtHglt_G{
        background-color: #9c9c9c;
        color: white;
    }
    .txtHglt_R{
        background-color: #f44336d9;
        color: white;
    }
</style>

<%

    DecimalFormat dfPrice = new DecimalFormat("0.00");
    DecimalFormat dfQty = new DecimalFormat("0.000");
    DecimalFormat dfGRNno = new DecimalFormat("0000");
    Session ssn = GetConnection.getSessionFactory().openSession();
    String type = request.getParameter("type");
%>

<div>
    <%
        if (type.equals("VwGRN")) {
            Grn grnObjc = (Grn) ssn.load(Grn.class, Integer.parseInt(request.getParameter("id")));
    %>
    <!-- ==== GRN-DETAILS MODE ========================================================================================== -->
    <h4 class="modal-title">GRN DETAILS</h4>
    <hr style="margin-top: 0px; border-top: 3px solid #eee;">

    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- GRN-Info -->
                <div class="col-md-12">
                    <div class="card" style="background-color: #CDDC39; padding: 10px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                        <label class="txtBold txtlg">GRN :&nbsp;#<%=dfGRNno.format(grnObjc.getGrnId())%></label><br>
                        <label class="txtBold">Supplier :&nbsp;<%=grnObjc.getSupplier().getName()%></label><br>
                        <label class="txtBold">Date :&nbsp;<%=grnObjc.getDate()%></label>
                        <label class="txtBold">&nbsp;|&nbsp;Time :&nbsp;<%=grnObjc.getTime()%></label>
                        <label class="txtBold">&nbsp;|&nbsp;User :&nbsp;<%=grnObjc.getUser().getUsername()%></label>
                    </div>
                </div>

                <!-- GRN-Items-Data-Table -->
                <div class="col-md-12">
                    <div class="card" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                        <div class="card-body">
                            <table class="table table-sm" id="grnitemstable">
                                <thead>
                                    <tr style="background-color: #10ac84 !important; color: white !important; ">
                                        <td>ITEM</td>
                                        <td>UNIT PRICE (Rs.)</td>
                                        <td>SUPPLIER PRICE (Rs.)</td>
                                        <td>QTY</td>
                                        <td>AMOUNT (Rs.)</td>
                                        <td>DISCOUNT (%)</td>
                                        <td>TOTAL AMOUNT (Rs.)</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<GrnItem> grnList = ssn.createCriteria(GrnItem.class).add(Restrictions.eq("grn", grnObjc)).list();
                                        for (GrnItem grntItems : grnList) {
                                    %>
                                    <tr role="row">
                                        <td><%=grntItems.getRawStock().getRawItems().getName()%></td>
                                        <td><%= dfPrice.format(grntItems.getUnitPrice())%></td>
                                        <td><%= dfPrice.format(grntItems.getCost())%></td>
                                        <td><%= dfQty.format(grntItems.getQty())%></td>
                                        <td><%= dfPrice.format(grntItems.getTotal())%></td>
                                        <td><%= dfPrice.format(grntItems.getDiscount())%></td>
                                        <td><%= dfPrice.format(grntItems.getNetTotal())%></td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- GRN-SUM-Data -->
                <div class="col-md-12">
                    <div class="card" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                        <div class="form-horizontal">
                            <div class="card-content">

                                <div class="row">
                                    <div class="col-sm-3" style="float: right;">
                                        <div class="form-group label-floating is-empty">
                                            <label class="control-label"></label>
                                            <input class="form-control" type="text" disabled="true" value="<%=dfPrice.format(grnObjc.getTotal())%>">
                                            <span class="material-input"></span>
                                        </div>
                                    </div>
                                    <label class="col-sm-2 label-on-left" style="float: right;">Total Amount (Rs.)</label>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3" style="float: right;">
                                        <div class="form-group label-floating is-empty">
                                            <label class="control-label"></label>
                                            <input class="form-control" type="text" disabled="true" value="<%=dfPrice.format(grnObjc.getDiscount())%>">
                                            <span class="material-input"></span>
                                        </div>
                                    </div>
                                    <label class="col-sm-2 label-on-left" style="float: right;">Total Discount (Rs.)</label>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3" style="float: right;">
                                        <div class="form-group label-floating is-empty">
                                            <label class="control-label"></label>
                                            <input class="form-control" style="font-weight: bolder;" type="text" disabled="true" value="<%=dfPrice.format(grnObjc.getNetTotal())%>">
                                            <span class="material-input"></span>
                                        </div>
                                    </div>
                                    <label class="col-sm-2 label-on-left" style="float: right; font-weight: bolder;">Net Total (Rs.)</label>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!--./End details view-->                            
            </div>
        </div>
    </div>

    <%
    } else if (type.equals("VwPayments")) {
        Grn grnObjc = (Grn) ssn.load(Grn.class, Integer.parseInt(request.getParameter("id")));
    %>
    <!-- ==== GRN-PAYMENT-DETAILS MODE ========================================================================================== -->
    <h4 class="modal-title">PAYMENT DETAILS</h4>
    <hr style="margin-top: 0px; border-top: 3px solid #eee;">

    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- GRN-&-Payment SUM Info -->
                <div class="col-md-12">
                    <div class="card" style="background-color: #CDDC39; padding: 10px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">    
                        <label class="txtBold txtlg">GRN :&nbsp;#<%=dfGRNno.format(grnObjc.getGrnId())%></label><br>
                        <label class="txtBold">Supplier :&nbsp;<%=grnObjc.getSupplier().getName()%></label><br>
                        <label class="txtBold">Net Total :&nbsp;Rs.<%=dfPrice.format(grnObjc.getNetTotal())%></label>
                        <label class="txtBold">&nbsp;|&nbsp;Paid Amount :&nbsp;Rs.<%=dfPrice.format(grnObjc.getCash())%></label>
                        <label class="txtBold">&nbsp;|&nbsp;Due Amount :&nbsp;Rs.<%=dfPrice.format(grnObjc.getBalance())%></label>
                    </div>
                </div>

                <!-- GRN-Payments-Data-Table -->
                <div class="col-md-12">
                    <div class="card" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                        <div class="card-body">
                            <table class="table table-sm" id="grnitemstable">
                                <thead>
                                    <tr style="background-color: #10ac84 !important; color: white !important; ">
                                        <td>#</td>
                                        <td>PAYMENT TYPE</td>
                                        <td>PAID AMOUNT (Rs.)</td>
                                        <td>DATE</td>
                                        <td>TIME</td>
                                        <td></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  int rowCntID = 0;
                                        List<GrnPayment> grnPaymentsList = ssn.createCriteria(GrnPayment.class).add(Restrictions.eq("grn", grnObjc)).list();
                                        for (GrnPayment grnPmntRecord : grnPaymentsList) {
                                            rowCntID += 1;
                                    %>
                                    <tr role="row">
                                        <td><%=rowCntID%></td>
                                        <td><%=grnPmntRecord.getPaymentType().getName()%></td>
                                        <td><%= dfPrice.format(grnPmntRecord.getAmount())%></td>
                                        <td><%=grnPmntRecord.getDate()%></td>
                                        <td><%=grnPmntRecord.getTime()%></td>
                                        <td class="text-right">
                                            <% if (grnPmntRecord.getPaymentType().getPaymentTypeId() == 2) {
                                                    GrnChequeDetails grnChequeDetObjc = null;
                                                    Criteria crtGrnChqDet = ssn.createCriteria(GrnChequeDetails.class);
                                                    crtGrnChqDet.add(Restrictions.eq("grnPayment", grnPmntRecord));
                                                    if (crtGrnChqDet.uniqueResult() != null) {
                                                        grnChequeDetObjc = (GrnChequeDetails) crtGrnChqDet.uniqueResult();
                                                    }
                                            %>
                                            <a class="btn btn-info btn-xs btn_VwChqPrvw" data-ref-VwChqPrvw="<%=grnChequeDetObjc.getGrnChequeDetailsId()%>">View Cheque</a>
                                            <% } else {%>
                                            &nbsp;
                                            <%}%>
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!--./End details view-->                            
            </div>
        </div>
    </div>


    <!-- CHEQUE-PREVIEW Modal -->
    <div class="modal fade" id="expandChqPrvModal" role="dialog" style="display: none;" data-backdrop="false">
        <div class="modal-dialog">   
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><button type="button" class="close" onclick="$('#expandChqPrvModal').modal('hide');" style="margin-bottom: 20px;"><i class="fa fa-close"></i></button></h4>
                </div>
                <div class="modal-body" id="expandChqPrvBox">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin:auto;background:#fff;display:block;" width="200px" height="200px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
                    <circle cx="50" cy="50" r="32" stroke-width="8" stroke="#fe718d" stroke-dasharray="50.26548245743669 50.26548245743669" fill="none" stroke-linecap="round" transform="rotate(179.178 50 50)">
                    <animateTransform attributeName="transform" type="rotate" repeatCount="indefinite" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50"></animateTransform>
                    </circle>
                    </svg>
                </div>
            </div>
        </div>
    </div>      
    <script>
        $('.btn_VwChqPrvw').click(function () {
            var id = $(this).attr('data-ref-VwChqPrvw');
            $('#expandChqPrvModal').modal('show');
            $('#expandChqPrvBox').load('viewGrnsNPayments_loadDetailsModal.jsp?id=' + id + '&type=VwChequePrvw');
        });
    </script>

    <%
    } else if (type.equals("VwChequePrvw")) {
        GrnChequeDetails grnChqDetailsObjct = (GrnChequeDetails) ssn.load(GrnChequeDetails.class, Integer.parseInt(request.getParameter("id")));
    %>

    <!-- ==== GRN-PAYMENT >> CHEQUE-DETAILS-PREVIEW MODE ========================================================================================== -->
    <table width="100%" cellspacing="5">
        <tbody><tr>
                <td width="50%">
                    <label>Cheque Type</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" disabled="true" value="<%=grnChqDetailsObjct.getType()%>">
                        <span class="material-input"></span>
                    </div>
                    <label>Cheque No</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" disabled="true" value="<%=grnChqDetailsObjct.getChequeNo()%>">
                        <span class="material-input"></span>
                    </div>
                    <label>Date</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" disabled="true" value="<%=grnChqDetailsObjct.getChequeDate()%>">
                        <span class="material-input"></span>
                    </div>
                    <label>Bank</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" disabled="true" value="<%=grnChqDetailsObjct.getBank()%>">
                        <span class="material-input"></span>
                    </div>
                    <label>Branch</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" disabled="true" value="<%=grnChqDetailsObjct.getBranch()%>">
                        <span class="material-input"></span>
                    </div>
                    <label>Amount (Rs.)</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" disabled="true" value="<%=dfPrice.format(grnChqDetailsObjct.getAmount())%>">
                        <span class="material-input"></span>
                    </div>
                </td>
                <td width="50%" align="center" valign="top">
                    <div class="fileinput fileinput-new text-center" data-provides="fileinput">
                        <div class="fileinput-new thumbnail">
                            <img src="<%=grnChqDetailsObjct.getChequeImage()%>" alt="...">
                        </div>
                    </div>
                </td>
            </tr></tbody>
    </table>

    <%}%>
</div>

