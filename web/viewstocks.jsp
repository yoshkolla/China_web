<%@page import="holder.InvoiceItemHolder"%>
<%@page import="resources.InvoiceItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="help.Helper"%>
<%@page import="java.util.List"%>
<%@page import="resources.Items"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Stock"%>
<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Session s = GetConnection.getSessionFactory().openSession();

    Items it = (Items) s.load(Items.class, id);
%>

<div class="row">
    <div class="col-md-6">
        <div class="input-group">
            <span class="input-group-addon" style="padding: 6px 12px;background-color: #eee;border: 1px solid #ccc;">Qty</span>
            <input type="number" id="qty" class="form-control" value="1" min="1" style="height: 34px;padding: 6px 12px;font-size: 14px;line-height: 1.42857143;background-image: none;border: 1px solid #ccc;border-radius: 4px;"/>
        </div>
    </div>
    <div class="col-md-6">
        <div class="input-group">
            <span class="input-group-addon" style="padding: 6px 12px;background-color: #eee;border: 1px solid #ccc;">Discount</span>
            <input type="number" id="dis" class="form-control" value="0" min="0" max="100" style="height: 34px;padding: 6px 12px;font-size: 14px;line-height: 1.42857143;background-image: none;border: 1px solid #ccc;border-radius: 4px;">
        </div>
    </div>
</div>
<div class="row" style="margin-top:10px;height:400px;overflow-y:auto">
    <%
        InvoiceItemHolder holder;
        if (session.getAttribute("cart") != null) {
            holder = (InvoiceItemHolder) session.getAttribute("cart");
        } else {
            holder = new InvoiceItemHolder();
        }
        request.getSession().setAttribute("cart", holder);

        List<Stock> sList = s.createCriteria(Stock.class).add(Restrictions.eq("items", it)).list();
        for (Stock st : sList) {
            double qty = 0;
            for (InvoiceItem item : holder.getHolder()) {
                if (st.getStockId() == item.getStock().getStockId()) {
                    qty = item.getQty();
                }
            }
    %>
    <div class="col-md-4">
        <button class="btn btn-block btn-success" onclick="addToCart('<%=st.getStockId()%>', '<%=st.getQty() - qty%>')">
            <%=st.getStockId()%><br>
            Rs. <%=Helper.priceFormt.format(st.getPrice())%><br>
            <%
                double cartQty = 0;
                ArrayList<InvoiceItem> cartItems = holder.getHolder();
                for (InvoiceItem item : cartItems) {
                    if (item.getStock().getStockId() == st.getStockId()) {
                        cartQty = item.getQty();
                    }
                }
            %>
            <span class="badge badge-primary"><%=Helper.intFormat.format(st.getQty() - cartQty)%></span>
        </button>
    </div>
    <%
        }
    %>
</div>