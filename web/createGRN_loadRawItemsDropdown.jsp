<%-- 
    Document   : createGRN_loadRawItemsDropdown
    Created on : Apr 18, 2020, 11:38:45 PM
    Author     : AKILA
--%>

<%@page import="org.hibernate.Session"%>
<%@page import="connection.GetConnection"%>
<%@page import="resources.RawItems"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>

<div id="Dropdown_Remover">

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
                    <%
                        Session ssnDrpDwn = GetConnection.getSessionFactory().openSession();
                        Criteria RawItemCriteria = ssnDrpDwn.createCriteria(RawItems.class);
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
