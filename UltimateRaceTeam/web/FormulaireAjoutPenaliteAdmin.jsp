<%-- 
    Document   : FormulaireAjoutPenaliteAdmin
    Created on : 4 juin 2024, 10:29:31
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.EtapeCourse" %>
<%@page import="Models.Equipe" %>
<%@page import="java.util.ArrayList" %>

<%
    EtapeCourse etp = new EtapeCourse();
    ArrayList<EtapeCourse> lset = new ArrayList<>();
    lset = etp.getAllEtape(null);
    
    Equipe eqp = new Equipe();
    ArrayList<Equipe> lseq = new ArrayList<>();
    lseq = eqp.getAllEquipe(null);
    

    
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
	    <%@include file="HeaderAdmin.jsp"%>
            <main class="content">
                <div class="container-fluid p-0">
            
                    <h1 class="h3 mb-3">Formulaire d'ajout de Penalite</h1>
            
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-body">
                                        <div class="m-sm-4">
                                            <form action="/UltimateRaceTeam/AjoutPenalitesEquipeServlet" method="post">
                                                <div class="mb-3">
                                                    <label class="form-label">Etape</label>
                                                    <select class="form-select mb-3" name="idEtape">
                                                        <%for(EtapeCourse etc : lset){%>
                                                        <option value="<%=etc.getIdetape()%>"><%=etc.getNometape()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Equipe</label>
                                                    <select class="form-select mb-3" name="idEquipe">
                                                        <%for(Equipe e : lseq){%>
                                                        <option value="<%=e.getIdequipe()%>"><%=e.getNomequipe()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Temps de Penalite</label>
                                                    <input class="form-control form-control-lg" type="time" step="1" name="tempsPenalite"/>
                                                </div>
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

	<script src="$./js/app.js"></script>

</body>

</html>

