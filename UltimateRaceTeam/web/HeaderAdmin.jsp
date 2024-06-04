<%-- 
    Document   : Header
    Created on : 1 juin 2024, 11:32:10
    Author     : Ny Aina Ratolo
--%>

<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
            <span class="align-middle">Admin</span>
        </a>
            <ul class="sidebar-nav">
                <li class="sidebar-header">
                        Pages
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="AccueilAdmin.jsp">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboard</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ListeEtapeCourseAdmin.jsp">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Liste Etape Course</span>
                    </a>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link" href="ClassementIndividuelAdmin.jsp">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Classement Individuel</span>
                    </a>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link" href="ClassementGeneralAdmin.jsp">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Classement General</span>
                    </a>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link" href="ClassementGeneralParEquipePointsAdmin.jsp">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Classement General par categorie</span>
                    </a>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link" href="ListePenaliteEquipeAdmin.jsp">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Liste Penalite par Equipe</span>
                    </a>
                </li>
                

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ImportEtapeResultatAdmin.jsp">
                        <i class="align-middle" data-feather="folder-plus"></i> <span class="align-middle">Import Etape et Resultat</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ImportPointsAdmin.jsp">
                        <i class="align-middle" data-feather="folder-plus"></i> <span class="align-middle">Import Points</span>
                    </a>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link" >
                    <!--<i class="align-middle" data-feather="folder-plus"></i>-->
                    <div class="align-middle">    
                        <form action="/UltimateRaceTeam/GenerationCategorieServlet" method="post">
                            <button class="btn btn-success btn-sm">Generer Categorie</button>
                        </form>   
                    </div>
                    </a>
                </li>
                
                <li class="sidebar-item">
                    <form class="sidebar-link" action="/UltimateRaceTeam/ResetDatabase" method="post">
                        <button class="btn btn-danger btn-sm">Reset Database</button>
                    </form>
                </li>

                
                <!--

                <li class="sidebar-header">
                        Tools & Components
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ListeTypeFinition.jsp">
                        <i class="align-middle" data-feather="menu"></i> <span class="align-middle">Liste Type Finition</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ListeTravaux.jsp">
                        <i class="align-middle" data-feather="menu"></i> <span class="align-middle">Liste Type Travaux</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ui-cards.html">
                        <i class="align-middle" data-feather="grid"></i> <span class="align-middle">Cards</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="ui-typography.html">
                        <i class="align-middle" data-feather="align-left"></i> <span class="align-middle">Typography</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="icons-feather.html">
                        <i class="align-middle" data-feather="coffee"></i> <span class="align-middle">Icons</span>
                    </a>
                </li>

                <li class="sidebar-header">
                        Plugins & Addons
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="charts-chartjs.html">
                        <i class="align-middle" data-feather="bar-chart-2"></i> <span class="align-middle">Charts</span>
                    </a>
                </li>

                <li class="sidebar-item">
                    <a class="sidebar-link" href="maps-google.html">
                        <i class="align-middle" data-feather="map"></i> <span class="align-middle">Maps</span>
                    </a>
                </li>-->
            </ul>

    </div>
</nav>

<div class="main">
    <nav class="navbar navbar-expand navbar-light navbar-bg">
        <a class="sidebar-toggle js-sidebar-toggle">
            <i class="hamburger align-self-center"></i>
        </a>

        <div class="navbar-collapse collapse">
                <ul class="navbar-nav navbar-align">
                    <li class="nav-item dropdown">
                        <a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
                            <i class="align-middle" data-feather="settings"></i>
                        </a>

                        <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                            <span class="text-dark">Parameter</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="/UltimateRaceTeam/LogoutAdmin">Log out</a>
                        </div>
                    </li>
                </ul>
        </div>
    </nav>
        
