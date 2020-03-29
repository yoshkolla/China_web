<%-- 
    Document   : invoiceprint
    Created on : Mar 28, 2020, 1:16:12 AM
    Author     : SCORFi3LD
--%>

<%@page import="resources.Customer"%>
<%@page import="help.Helper"%>
<%@page import="resources.Details"%>
<%@page import="java.util.List"%>
<%@page import="resources.InvoiceItem"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Invoice"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" rel="stylesheet"/>
        <style type="text/css">
            @page {
                size: A4;
                margin: 0 30px 0 30px;;
            }
            @media print {
                html, body {
                    width: 210mm;
                    height: 297mm;
                }
            }
            body{
                font-family: 'Roboto',serif;
            }
            #header{
                height: 15px;
                width: 100%;
                margin: 20px 0;
                background: #222;
                text-align: center;
                color: #fff;
                font: 700 15px Helvetica,Sans-Serif;
                text-transform: uppercase;
                letter-spacing: 20px;
                padding: 8px 0
            }

            .table{
                border-collapse: collapse;
                width: 100%;
            }

            .table td{
                border: 1px solid #222;
                padding: 8px;
            }

            .item{
                border-collapse: collapse;
                width: 100%;
            }

            .item th{
                border: 1px solid #222;
                padding: 8px;
            }

            .item td{
                padding: 8px;
            }
        </style>
        <%
            DecimalFormat df = new DecimalFormat("#,##0.00");
            Session s = GetConnection.getSessionFactory().openSession();
            Details d = (Details) s.createCriteria(Details.class).add(Restrictions.eq("iddetails", 1)).uniqueResult();
            if (request.getParameter("inv") == null) {
                return;
            }
            Invoice in = (Invoice) s.createCriteria(Invoice.class).add(Restrictions.eq("invoiceId", Integer.parseInt(request.getParameter("inv")))).uniqueResult();
            Customer c = in.getCustomer();
        %>
    </head>
    <body class="print">
        <h1 id="header">INVOICE</h1>
        <table border="0" width='100%'>
            <tbody>
                <tr>
                    <td>
                        <strong><%=d.getName()%></strong><br/>
                        <%=d.getAddress()%><br/>
                        Phone: <%=d.getTp()%><br/><br/>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <strong><%=c.getName()%></strong><br/>
                        <%=c.getAddress()%><br/>
                        Phone: <%=c.getMobile()%>
                    </td>
                    <td width='30%'>
                        <table class="table">
                            <tr>
                                <td width='40%' style="background-color: #dddddd">Invoice #</td>
                                <td width='60%' align='right'><%=new DecimalFormat("0000").format(in.getInvoiceId())%></td>
                            </tr>
                            <tr>
                                <td width='40%' style="background-color: #dddddd">Date</td>
                                <td width='60%' align='right'><%=in.getDate()%></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height:20px;"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table class="item">
                            <thead>
                                <tr>
                                    <th style="background-color: #dddddd" width='10%'>#ID</th>
                                    <th style="background-color: #dddddd" width='60%'>Item</th>
                                    <th style="background-color: #dddddd" width='10%'>Unit Price</th>
                                    <th style="background-color: #dddddd" width='10%'>Quantity</th>
                                    <th style="background-color: #dddddd" width='10%'>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<InvoiceItem> iList = s.createCriteria(InvoiceItem.class).add(Restrictions.eq("invoice", in)).list();
                                    for (InvoiceItem ii : iList) {
                                %>
                                <tr style="border: 1px solid #222">
                                    <td><%=ii.getStock().getItems().getItemsId()%></td>
                                    <td><%=ii.getStock().getItems().getName()%></td>
                                    <td align="right"><%=df.format(ii.getUnitPrice())%></td>
                                    <td align="center"><%=ii.getQty()%></td>
                                    <td align="right"><%=df.format(ii.getNetTotal())%></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr style="border: 1px solid #222">
                                    <td colspan="2" rowspan="3">&nbsp;</td>
                                    <td colspan="3" style="border: 1px solid #222;padding:0">
                                        <table width='100%'>
                                            <tr>
                                                <td>Subtotal</td>
                                                <td width='50%' align="right"><%=df.format(in.getTotal())%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="border: 1px solid #222">
                                    <td colspan="3" style="border: 1px solid #222;padding:0">
                                        <table width='100%'>
                                            <tr>
                                                <td>Amount Paid</td>
                                                <td width='50%' align="right"><%=df.format(in.getCash())%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="border: 1px solid #222">
                                    <td colspan="3" style="border: 1px solid #222;background: #dddddd;;padding:0">
                                        <table width='100%'>
                                            <tr>
                                                <td>Balance Due</td>
                                                <td width='50%' align="right"><%=df.format(in.getBalance() == 0d ? in.getDue() : in.getBalance())%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        window.print();
    </script>
</body>
</html>
