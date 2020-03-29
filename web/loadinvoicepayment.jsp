<%@page import="java.text.DecimalFormat"%>
<%@page import="help.Helper"%>
<%@page import="resources.Invoice"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String type = request.getParameter("type");

    Helper h = new Helper();
    DecimalFormat df = new DecimalFormat("0000");
    Session s = GetConnection.getSessionFactory().openSession();
    Invoice inv = (Invoice) s.load(Invoice.class, id);
%>

<div>
    <label>Invoice No</label>
    <div class="form-group" style="margin-top:0;">
        <input type="text" class="form-control" value="<%=df.format(inv.getInvoiceId())%>" disabled>
        <span class="material-input"></span>
    </div>
    <label>Payment Type</label>
    <div class="form-group" style="margin-top:0;">
        <div class="radio">
            <label>
                <input type="radio" name="pt" <%=(type.equals("cash") ? "checked" : "")%> id="rbcash" data-ref="<%=inv.getInvoiceId()%>"> Cash Payment
                <span class="circle"></span>
                <span class="check"></span>
            </label>
        </div>
        <div class="radio">
            <label>
                <input type="radio" name="pt" <%=(type.equals("cheque") ? "checked" : "")%> id="rbcheque" data-ref="<%=inv.getInvoiceId()%>"> Cheque Payment
                <span class="circle"></span>
                <span class="check"></span>
            </label>

        </div>
    </div>
    <%
        if (type.equals("cash")) {
    %>
    <hr>
    <label>Due Amount</label>
    <div class="form-group" style="margin-top:0;">
        <input type="text" class="form-control" value="<%=Helper.priceFormt.format(inv.getDue())%>" id="cashdue" disabled>
        <span class="material-input"></span>
    </div>
    <label>Payment</label>
    <div class="form-group" style="margin-top:0;" id="cashpayform">
        <input type="number" class="form-control" min="1" max="<%=Helper.priceFormt.format(inv.getDue())%>" id="cashpay">
        <span class="material-input"></span>
    </div>
    <div class="text-right">
        <input type="submit" class="btn btn-success" id="cash_checkout">
    </div>
    <%
    } else if (type.equals("cheque")) {
    %>
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
                        <input type="text" class="form-control" id="chqno">
                        <span class="material-input"></span>
                    </div>
                    <label>Date<small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="date" class="form-control" value="<%=h.getDate()%>" id="chqdate">
                        <span class="material-input"></span>
                    </div>
                    <label>Bank <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" id="bank">
                        <span class="material-input"></span>
                    </div>
                    <label>Branch <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" id="branch">
                        <span class="material-input"></span>
                    </div>
                    <label>Due Amount</label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="text" class="form-control" value="<%=Helper.priceFormt.format(inv.getDue())%>" id="chqdue" disabled>
                        <span class="material-input"></span>
                    </div>
                    <label>Amount <small>*</small></label>
                    <div class="form-group" style="margin-top:0;">
                        <input type="number" class="form-control" max="<%=inv.getDue()%>" id="chqpay">
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

<script type="text/javascript">
    $('#rbcash').click(function () {
        var id = $(this).attr('data-ref');
        $('#paybox').load('loadinvoicepayment.jsp?id=' + id + '&type=cash');
    });
    $('#rbcheque').click(function () {
        var id = $(this).attr('data-ref');
        $('#paybox').load('loadinvoicepayment.jsp?id=' + id + '&type=cheque');
    });
    $('#cash_checkout').click(function () {
        var amount = $('#cashpay').val();
        if ($('#cashpayform').hasClass("has-error")) {
            swal("Oops!", "Please enter valid amount!", "error");
            return;
        }
        swal({
            title: "Are you sure?",
            text: "Are you sure that you want to save payments?",
            icon: "warning",
            buttons: true,
            dangerMode: true
        }).then(confirm => {
            if (confirm) {
                $.ajax({
                    url: "SaveCashPaymnetServlet",
                    data: {id:<%=inv.getInvoiceId()%>, amount: amount},
                    success: function (data) {
                        if (data == "0") {
                            swal("Oops!", "Something went wrong!", "error");
                        }
                        if (data == "1") {
                            swal("Done!", "Payment added successfuly!", "success").then(function () {
                                location.reload();
                            });
                        }
                    }
                });
            }
        });
    });
</script>