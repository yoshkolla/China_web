<div class="sidebar">
    <div class="logo">
        <a href="#" class="simple-text">
            <%=NAME%>
        </a>
    </div>
    <div class="logo logo-mini">
        <a href="#" class="simple-text">
            <%="R"%>
        </a>
    </div>
    <div class="sidebar-wrapper">
        <ul class="nav">
            <li class="<%=curruntpage.equals("Dashboard") ? "active" : ""%>">
                <a href="index.jsp">
                    <i class="material-icons">dashboard</i>
                    <p>Dashboard</p>
                </a>
            </li>

            <li class="<%=curruntpage.equals("Sales") ? "active" : ""%>">
                <a data-toggle="collapse" href="#sales" class="collapsed" aria-expanded="false">
                    <i class="material-icons">add_shopping_cart</i>
                    <p>Sales <b class="caret"></b></p>
                </a>
                <div class="collapse" id="sales" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href="createinvoice.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Create Invoice</a>
                        </li>
                        <li>
                            <a href="cancelinvoice.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Cancel Invoice</a>
                        </li>
                        <li>
                            <a href="paymentinvoice.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Invoice Payment</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("Purchase") ? "active" : ""%>">
                <a data-toggle="collapse" href="#purchase" class="collapsed" aria-expanded="false">
                    <i class="material-icons">attach_money</i>
                    <p>Purchases <b class="caret"></b></p>
                </a>
                <div class="collapse" id="purchase" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href="createGRN.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Create GRN</a>
                        </li>
                        <li>
                            <a href="grnPayments.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>GRN Payment</a>
                        </li>
                        <li>
                            <a href="viewGrnsNPayments.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>View GRNs & Payments</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("Production") ? "active" : ""%>">
                <a data-toggle="collapse" href="#production" class="collapsed" aria-expanded="false">
                    <i class="material-icons">library_books</i>
                    <p>Productions <b class="caret"></b></p>
                </a>
                <div class="collapse" id="production" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href="production.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Create Production</a>
                        </li>
                        <li>
                            <a href=""><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Productions</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("Create") ? "active" : ""%>">
                <a data-toggle="collapse" href="#create" class="collapsed" aria-expanded="false">
                    <i class="material-icons">note_added</i>
                    <p>Create<b class="caret"></b></p>
                </a>
                <div class="collapse" id="create" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href="customer_reg.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Customers</a>
                        </li>
                        <li>
                            <a href="supplier_reg.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Suppliers</a>
                        </li>
                        <li>
                            <a href=""><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Raw Materials</a>
                        </li>
                        <li>
                            <a href="items.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Sales Items</a>
                        </li>
                        <li>
                            <a href="staff_reg.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Staff Management</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("User") ? "active" : ""%>">
                <a data-toggle="collapse" href="#user" class="collapsed" aria-expanded="false">
                    <i class="material-icons">supervisor_account</i>
                    <p>User Management <b class="caret"></b></p>
                </a>
                <div class="collapse" id="user" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href="user_reg.jsp"><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Create User</a>
                        </li>
                        <li>
                            <a href=""><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Account Settings</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("Cheque") ? "active" : ""%>">
                <a data-toggle="collapse" href="#cheque" class="collapsed" aria-expanded="false">
                    <i class="material-icons">local_atm</i>
                    <p>Cheque Management <b class="caret"></b></p>
                </a>
                <div class="collapse" id="cheque" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href=""><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Released Cheque</a>
                        </li>
                        <li>
                            <a href=""><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Reserved Cheque</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("Report") ? "active" : ""%>">
                <a data-toggle="collapse" href="#report" class="collapsed" aria-expanded="false">
                    <i class="material-icons">assessment</i>
                    <p>Reports <b class="caret"></b></p>
                </a>
                <div class="collapse" id="report" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href=""><span class="fa fa-arrow-right">&nbsp;&nbsp;</span>Report 1</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</div>
