<%-- 
    Document   : FormulaireAffectationCoureur
    Created on : 1 juin 2024, 12:32:24
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.Coureur" %>
<%@page import="java.util.ArrayList" %>

<%
    int idEtape = (int)request.getAttribute("idEtape");
    ArrayList<Coureur> lscr = new ArrayList<>();
    lscr = (ArrayList<Coureur>) request.getAttribute("listeCoureur");
    int nombreCoureur = (int)request.getAttribute("nombreCoureur");
    
%>

<%
    Exception exp = (Exception)request.getAttribute("erreur");
    String errMess = null;
    if(exp!= null){
        errMess = exp.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<!--<link rel="preconnect" href="https://fonts.gstatic.com">-->
	<link rel="shortcut icon" href="./img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-blank.html" />

	<title>Blank Page</title>

        <link href="./css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<div class="wrapper">
	    <%@include file="HeaderEquipe.jsp"%>
            <main class="content">
                <div class="container-fluid p-0">
            
                    <h1 class="h3 mb-3">Formulaire d'ajout de coureur</h1>
            
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-body">
                                        <div class="m-sm-4">
                                            <form action="/UltimateRaceTeam/AjouterCoureurEtapeServlet" method="post">
                                                <input type="hidden" name="idEtape" value="<%=idEtape%>">
                                                <%for(int i=0; i<nombreCoureur; i++){%>
                                                <div class="mb-3">
                                                    <label class="form-label">Coureur <%=i+1%></label>
                                                    <select class="form-select mb-3" name="coureur[]">
                                                        <%for(Coureur cr : lscr){%>
                                                        <option value="<%=cr.getIdcoureur()%>"><%=cr.getNomcoureur()%> <%=cr.getNumero()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <%}%>
                                                <% if(errMess!= null){%>
                                                <div class="mb-3">
                                                    <div class="badge bg-danger"><%= errMess%></div>
                                                </div>
                                                <%}%>
                                                <div class="mb-3">
                                                    <input class="form-control form-control-lg" type="submit" value="Save" />
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            
                </div>
            </main>
        </div>

	<script src="./js/app.js"></script>

</body>

</html>
