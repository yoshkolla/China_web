<nav class="navbar navbar-default navbar-absolute" data-topbar-color="blue">
    <div class="container-fluid">
        <div class="navbar-minimize">
            <button id="minimizeSidebar" class="btn btn-round btn-white btn-fill btn-just-icon">
                <i class="material-icons visible-on-sidebar-regular f-26">keyboard_arrow_left</i>
                <i class="material-icons visible-on-sidebar-mini f-26">keyboard_arrow_right</i>
            </button>
        </div>
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"> <%=PAGE_NAME%> </a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons">person</i>
                        <p class="hidden-lg hidden-md">
                            Profile <b class="caret"></b>
                        </p>
                        <div class="ripple-container"></div></a>
                    <ul class="dropdown-menu">
                        
                        <li>
                            <a href="#"><i class="material-icons">account_circle</i> My Profile</a>
                        </li>
                        <li>
                            <a href="#"><i class="material-icons">vpn_key</i> Change Password</a>
                        </li>
                        <li>
                            <a href="#"><i class="material-icons">exit_to_app</i> Logout</a>
                        </li>
                    </ul>
                </li>
                
                <li class="separator hidden-lg hidden-md"></li>
            </ul>
        </div>
    </div>
</nav>
