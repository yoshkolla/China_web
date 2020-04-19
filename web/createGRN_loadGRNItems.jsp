<%-- 
    Document   : createGRN_loadGRNItems
    Created on : Apr 1, 2020, 9:59:15 AM
    Author     : AKILA
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="holder.GRN_ITEM_OBJ"%>
<%@page import="java.util.ArrayList"%>
<%@page import="holder.GRNItems_DataHolder"%>
<div id="DataTable_Remover">


    <%
        // GRN-ITEMS DATA_HOLDER ***********************************************
        DecimalFormat dfPrice = new DecimalFormat("0.00");
        DecimalFormat dfQty = new DecimalFormat("0.000");
        GRNItems_DataHolder dtHolder;
        if (session.getAttribute("GrnItems") != null) {
            dtHolder = (GRNItems_DataHolder) session.getAttribute("GrnItems");
        } else {
            dtHolder = new GRNItems_DataHolder();
            request.getSession().setAttribute("GrnItems", dtHolder);
        }
        // *****************************************************************************
    %>


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
                            <td></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<GRN_ITEM_OBJ> grntItemsArray = dtHolder.getHolder();
                            if (dtHolder.getHolder().size() != 0) {
                                for (GRN_ITEM_OBJ grntItems : grntItemsArray) {%>

                        <tr role="row">
                            <td><%=grntItems.getRawItem().getName()%></td>
                            <td><%= dfPrice.format(grntItems.getUnitPrice())%></td>
                            <td><%= dfPrice.format(grntItems.getSupplierPrice())%></td>
                            <td><%= dfQty.format(grntItems.getQty())%></td>
                            <td><%= dfPrice.format(grntItems.getAmount())%></td>
                            <td><%= dfPrice.format(grntItems.getDiscount())%></td>
                            <td><%= dfPrice.format(grntItems.getTotalAmount())%></td>
                            <td>
                                <button class="btn btn-danger btn-round btn-sm" 
                                        onclick='removeItemFromListFunc(
                                                        "rmvItem_RawItemID=" + "<%=grntItems.getRawItem().getRawItemsId()%>" + "&" +
                                                        "rmvItem_UnitPrice=" + "<%=grntItems.getUnitPrice()%>" + "&" +
                                                        "rmvItem_SupplierPrice=" + "<%=grntItems.getSupplierPrice()%>" + "&" +
                                                        "rmvItem_Discount=" + "<%=grntItems.getDiscount()%>"
                                                        );'>
                                    <span class="fa fa-close"></span></button>
                            </td>
                        </tr>

                        <% }
                            }%>
                    </tbody>
                </table>

            </div>
        </div>
    </div>

</div>



<!--  REMOVE SELECTED ITEM FROM GRN_items.LIST -->
<script type="text/javascript">
    function removeItemFromListFunc(param) {
        $.post("RemoveItemFromGRNServlet", param, function (outputData) {
            // Post Actions..
            if (outputData.split(":")[0] == 'success') {
                execCal_GRNSUM();
                load_GRNItemsTableData();
            } else {
                //  Show output-Message [ Title : MsgText : MsgType ]
                swal(outputData.split(":")[1], outputData.split(":")[2], outputData.split(":")[0]);
            }
        });
    }
</script>