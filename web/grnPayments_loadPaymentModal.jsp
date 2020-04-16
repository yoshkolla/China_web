<%@page import="resources.Grn"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="help.Helper"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>

<style>
    .txtBold{
        font-weight: bolder;
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
    int id = Integer.parseInt(request.getParameter("id"));
    String type = request.getParameter("type");

    Helper h = new Helper();
    DecimalFormat dfGRNno = new DecimalFormat("0000");
    Session ssn = GetConnection.getSessionFactory().openSession();
    Grn grnObjc = (Grn) ssn.load(Grn.class, id);
%>

<div>
    <label class="txtBold txtlg txtHglt_G">&nbsp;GRN #<%=dfGRNno.format(grnObjc.getGrnId())%>&nbsp;&nbsp;</label>
    <label class="txtBold txtlg txtHglt_R">&nbsp;Due Amount : Rs.<%=Helper.priceFormt.format(grnObjc.getBalance())%>&nbsp;&nbsp;</label>
    <hr style="margin-top: 0px; border-top: 3px solid #eee;">

    <label>Payment Type *</label>
    <div class="form-group" style="margin-top:0;">
        <div class="radio">
            <label>
                <input type="radio" name="pt" <%=(type.equals("cash") ? "checked" : "")%> id="rbcash" data-ref="<%=grnObjc.getGrnId()%>"> Cash Payment
                <span class="circle"></span>
                <span class="check"></span>
            </label>
        </div>
        <div class="radio">
            <label>
                <input type="radio" name="pt" <%=(type.equals("cheque") ? "checked" : "")%> id="rbcheque" data-ref="<%=grnObjc.getGrnId()%>"> Cheque Payment
                <span class="circle"></span>
                <span class="check"></span>
            </label>

        </div>
    </div>
    <%
        if (type.equals("cash")) {
    %>
    <!-- ==== CASH PAYMENT MODE ========================================================================================== -->
    <hr>
    <label class="txtBold txtGray">Payments (Rs.) *</label>
    <div class="form-group" style="margin-top:0;" id="cashpayform">
        <input type="number" class="form-control txtGray" style="font-weight: bolder;" required="true" min="0.01" step="0.01" max="<%=Helper.priceFormt.format(grnObjc.getBalance())%>" onblur='priceValFormatting(this);' id="cashpay">
        <span class="material-input"></span>
    </div>
    <div class="text-right">
        <input type="submit" class="btn btn-success" id="cash_checkout">
    </div>
    <%
    } else if (type.equals("cheque")) {
    %>
    <!-- ==== CHEQUE PAYMENT MODE ========================================================================================== -->
    <hr>
    <table width="100%" cellspacing="5">
        <tbody><tr>
                <td width="50%">
                    <label>Cheque Type <small>*</small></label>
                    <div class="form-group open" style="margin-bottom: 0;margin-top: 0;">
                        <div class="select" aria-expanded="true">
                            <select class="form-control" id="chqtype">
                                <option>CASH CHEQUE</option>
                                <option>DATE CHEQUE</option>
                            </select>
                        </div>
                        <span class="material-input"></span>
                    </div>
                    <label>Cheque No <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" required="true" id="chqno">
                        <span class="material-input"></span>
                    </div>
                    <label>Date <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="date" class="form-control" required="true" value="<%=h.getDate()%>" id="chqdate">
                        <span class="material-input"></span>
                    </div>
                    <label>Bank <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" required="true" id="bank">
                        <span class="material-input"></span>
                    </div>
                    <label>Branch <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" required="true" id="branch">
                        <span class="material-input"></span>
                    </div>
                    <label class="txtBold txtGray">Amount (Rs.) <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="number" class="form-control txtGray" style="font-weight: bolder;" required="true" min="0.01" step="0.01" max="<%=Helper.priceFormt.format(grnObjc.getBalance())%>" onblur='priceValFormatting(this);' id="chqpay">
                        <span class="material-input"></span>
                    </div>
                </td>
                <td width="50%" align="center" valign="top">
                    <div class="fileinput fileinput-new text-center" data-provides="fileinput">
                        <div class="fileinput-new thumbnail">
                            <img src="assets/img/image_placeholder.jpg" alt="...">
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="" id="chqimg"></div>
                        <div>
                            <span class="btn btn-round btn-file">
                                <span class="fileinput-new">Select image</span>
                                <span class="fileinput-exists">Change</span>
                                <input type="hidden"><input type="file" name="...">
                                <div class="ripple-container"></div>
                            </span>
                            <a href="#" class="btn btn-danger btn-round fileinput-exists" data-dismiss="fileinput"><i class="fa fa-times"></i> Remove</a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-right">
                    <input type="submit" class="btn btn-success" id="cheque_checkout">
                </td>
            </tr>
        </tbody>
    </table>
    <%
        }
    %>
</div>

<!-- load Modal .Content On Payment-Mode Selections -->
<script type="text/javascript">
    $('#rbcash').click(function () {
        var id = $(this).attr('data-ref');
        $('#paybox').load('grnPayments_loadPaymentModal.jsp?id=' + id + '&type=cash');
    });
    $('#rbcheque').click(function () {
        var id = $(this).attr('data-ref');
        $('#paybox').load('grnPayments_loadPaymentModal.jsp?id=' + id + '&type=cheque');
    });
</script>

<!--   INPUT ELEMENT VALUES FORMATTING  -->
<script>
    function priceValFormatting(field) {
        field.value = parseFloat(field.value).toFixed(2);
    }
</script>

<!-- ==== Save Payments [ Cash ] =================================================================================== -->
<script>
    $('#cash_checkout').click(function () {
        var flagSubmitSts = false;
        // check value validations ---Payment_Amount
        if (!document.getElementById('cashpay').checkValidity()) {
            flagSubmitSts = false;
        } else if (document.getElementById('cashpay').value.toString().trim().length == 0) {
            flagSubmitSts = false;
        } else if (document.getElementById('cashpay').value.toString().trim() == "NaN") {
            document.getElementById("cashpay").value = "0.01";
            flagSubmitSts = false;
        } else if (document.getElementById('cashpay').value < 0.01) {
            flagSubmitSts = false;
        }
        // when all OK
        else {
            flagSubmitSts = true;
        }

        //  === Actions @Submit  =============================
        if (!flagSubmitSts) {
            swal({title: "Oops! Invalid Amount",
                text: "Please insert valid payment amount.",
                icon: "warning",
                timer: 1500,
                buttons: false
            });
        } else {
            swal({
                title: "Are you sure?",
                text: "You want to save this cash-payment.",
                icon: "warning",
                buttons: true,
                dangerMode: true
            }).then(confirm => {
                if (confirm) {
                    // start >> Save process...
                    $.ajax({
                        url: "SaveGRNPayments_CashServlet",
                        data: {id:<%=grnObjc.getGrnId()%>, amount: $('#cashpay').val()},
                        success: function (outputData) {
                            //  Show output-Message [ Title : MsgText : MsgType ]
                            swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                            // Post Actions..
                            setTimeout(function () {
                                if (outputData.split(":")[0] == 'success') {
                                    location.reload();
                                }
                            }, 1000);
                        }
                    });
                    // end << Save process...
                }
            });
        }
    });
</script>

<!-- ==== Save Payments [ Cheque ] =================================================================================== -->
<script type="text/javascript">
    $('#cheque_checkout').click(function () {
        var flagSubmitSts = false;

        // check value validations ---ChequeNo
        if (!document.getElementById('chqno').checkValidity()) {
            flagSubmitSts = false;
        } else if (document.getElementById('chqno').value == null) {
            flagSubmitSts = false;
        } else if (document.getElementById('chqno').value.toString().trim().length == 0) {
            flagSubmitSts = false;
        }
        // check value validations ---ChequeDate
        else if (!document.getElementById('chqdate').checkValidity()) {
            flagSubmitSts = false;
        } else if (document.getElementById('chqdate').value == null) {
            flagSubmitSts = false;
        } else if (document.getElementById('chqdate').value.toString().trim().length == 0) {
            flagSubmitSts = false;
        }
        // check value validations ---Bank
        else if (!document.getElementById('bank').checkValidity()) {
            flagSubmitSts = false;
        } else if (document.getElementById('bank').value == null) {
            flagSubmitSts = false;
        }
        // check value validations ---Branch
        else if (!document.getElementById('branch').checkValidity()) {
            flagSubmitSts = false;
        } else if (document.getElementById('branch').value == null) {
            flagSubmitSts = false;
        }
        // check value validations ---Payment_Amount
        else if (!document.getElementById('chqpay').checkValidity()) {
            flagSubmitSts = false;
        } else if (document.getElementById('chqpay').value.toString().trim().length == 0) {
            flagSubmitSts = false;
        } else if (document.getElementById('chqpay').value.toString().trim() == "NaN") {
            document.getElementById("chqpay").value = "0.01";
            flagSubmitSts = false;
        } else if (document.getElementById('chqpay').value < 0.01) {
            flagSubmitSts = false;
        }

        // when all OK
        else {
            flagSubmitSts = true;
        }

        //  === Actions @Submit  =============================
        if (!flagSubmitSts) {
            swal({title: "Oops!",
                text: "Please fill all required fields.",
                icon: "warning",
                timer: 1500,
                buttons: false
            });
        } else {
            swal({
                title: "Are you sure?",
                text: "You want to save this cheque-payment.",
                icon: "warning",
                buttons: true,
                dangerMode: true
            }).then(confirm => {
                if (confirm) {
                    // start >> Save process...

                    // assign Cheque-Image...
                    var chequeimg = 'assets/img/image_placeholder.jpg';
                    if ($('#chqimg').find('img').attr('src') != null) {
                        chequeimg = $('#chqimg').find('img').attr('src');
                    }

                    $.ajax({
                        type: 'POST',
                        url: "SaveGRNPayments_ChequeServlet",
                        data: {
                            grnid:<%=grnObjc.getGrnId()%>,
                            chqtype: $('#chqtype').val(),
                            chqno: $('#chqno').val(),
                            chqdate: $('#chqdate').val(),
                            bank: $('#bank').val(),
                            branch: $('#branch').val(),
                            chqpay: $('#chqpay').val(),
                            chqimg: chequeimg
                        },
                        success: function (outputData) {
                            //  Show output-Message [ Title : MsgText : MsgType ]
                            swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
                            // Post Actions..
                            setTimeout(function () {
                                if (outputData.split(":")[0] == 'success') {
                                    location.reload();
                                }
                            }, 1000);
                        }
                    });
                    // end << Save process...
                }
            });
        }
    });
</script>