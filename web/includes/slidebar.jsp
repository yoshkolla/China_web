<div class="sidebar">
    <div class="logo">
        <a href="#" class="simple-text">
            <%=NAME %>
        </a>
    </div>
    <div class="logo logo-mini">
        <a href="#" class="simple-text">
            <%=NAME.substring(0, 1) %>
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
                            <a href="">Create Invoice</a>
                        </li>
                        <li>
                            <a href="">Return Invoice</a>
                        </li>
                        <li>
                            <a href="">Create Payment</a>
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
                            <a href="">Create GRN</a>
                        </li>
                        <li>
                            <a href="">Supplier Return</a>
                        </li>
                        <li>
                            <a href="">Supplier Payment</a>
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
                            <a href="production.jsp">Create Production</a>
                        </li>
                        <li>
                            <a href="">Production Management</a>
                        </li>
                    </ul>
                </div>
            </li>

            <li class="<%=curruntpage.equals("Create") ? "active" : ""%>">
                <a data-toggle="collapse" href="#create" class="collapsed" aria-expanded="false">
                    <i class="material-icons">note_added</i>
                    <p>Create New <b class="caret"></b></p>
                </a>
                <div class="collapse" id="create" aria-expanded="false" style="height: 0px;">
                    <ul class="nav">
                        <li>
                            <a href="">Customer Management</a>
                        </li>
                        <li>
                            <a href="">Supplier Management</a>
                        </li>
                        <li>
                            <a href="">Raw Material Management</a>
                        </li>
                        <li>
                            <a href="">Sales Items Management</a>
                        </li>
                        <li>
                            <a href="">Staff Management</a>
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
                            <a href="">Create User</a>
                        </li>
                        <li>
                            <a href="">Change Account Settings</a>
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
                            <a href="">Released Cheque</a>
                        </li>
                        <li>
                            <a href="">Reserved Cheque</a>
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
                            <a href="">Report 1</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</div>
