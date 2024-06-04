<%-- 
    Document   : FormulaireAffectationHeureCoureur
    Created on : 2 juin 2024, 12:41:26
    Author     : Ny Aina Ratolo
--%>
<%@page import="Models.CoureurEtape" %>
<%@page import="java.util.ArrayList" %>

<%
    Exception exp = (Exception)request.getAttribute("erreur");
    String errMess = null;
    if(exp!= null){
        errMess = exp.getMessage();
    }
    
    int idEtape = (int) request.getAttribute("idEtape");
    
    ArrayList<CoureurEtape> lsce = new ArrayList<>();
    lsce = (ArrayList<CoureurEtape>) request.getAttribute("listeCoureur");
    
    if(lsce == null){
        CoureurEtape cr = new CoureurEtape();
        lsce = cr.getAllCoureurNonArriveeEtape(idEtape);
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

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-blank.html" />

	<title>Blank Page</title>

        <link href="${pageContext.request.contextPath}/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<div class="wrapper">
            <%@include file="HeaderAdmin.jsp"%>
                <main class="content">
                <div class="container-fluid p-0">
            
                    <h1 class="h3 mb-3">Affectation Temps d'arrivee</h1>
            
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="card-body">
                                        <div class="m-sm-4">
                                            <p class=" text-danger">NB : Si l'input est vide; c'est que les participant de cette etape sont tous arrive a destination</p>
                                            <form action="/UltimateRaceTeam/AjouterTempsCoureurEtapeServlet" method="post">
                                                <div id="coord" style="margin-top: 50px;">
                                                    <div class="input-group-text">
                                                        <input type="hidden" name="idEtape" value="<%=idEtape%>">
                                                        <span class="input-group-text">Coureur</span>
                                                            <select class="form-control" name="idCoureur[]">
                                                                <% for (CoureurEtape cr : lsce) { %>
                                                                <option value="<%=cr.getIdCoureur()%>"><%=cr.getNomCoureur()%> <%=cr.getNumero()%></option>
                                                                <%}%>
                                                            </select>
                                                        <span class="input-group-text">Temps</span>
                                                        <input type="datetime-local" name="temps[]" class="form-control">
                                                    </div>
                                                </div>
                                                <% if(errMess!= null){%>
                                                <div class="mb-3">
                                                    <div class="badge bg-danger"><%= errMess%></div>
                                                </div>
                                                <%}%>
                                                <input type="button" class="btn btn-success" value="Ajouter Temps" style="margin-top: 20px" onclick="addTemps()">
                                                <input type="submit" class="btn btn-primary" value="Enregistrer" style="margin-top: 20px">
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
	<script src="${pageContext.request.contextPath}/js/app.js"></script>

</body>

</html>

<script>
    function addTemps() {
    var coordinatesDiv = document.getElementById("coord");

    // Création d'un élément de groupe
    var grp = document.createElement("div");
    grp.setAttribute("class", "input-group-text");
    coordinatesDiv.appendChild(grp);

    // Création d'un élément de label pour les coureurs
    var finitionsLabel = document.createElement("span");
    finitionsLabel.setAttribute("class", "input-group-text");
    finitionsLabel.textContent = "Coureur";
    grp.appendChild(finitionsLabel);

    // Création d'un élément de sélection pour les coreurs
    var finitionsSelect = document.createElement("select");
    finitionsSelect.setAttribute("class", "form-control");
    finitionsSelect.setAttribute("name", "idCoureur[]");
    grp.appendChild(finitionsSelect);

    // Ajout des options de sélection dynamiquement
    <% for (CoureurEtape cr : lsce) { %>
    var option = document.createElement("option");
    option.value = "<%=cr.getIdCoureur()%>";
    option.text = "<%=cr.getNomCoureur()%> <%=cr.getNumero()%>";
    finitionsSelect.appendChild(option);
    <% } %> 

    // Création d'un élément de label pour le temps
    var dateLabel = document.createElement("span");
    dateLabel.setAttribute("class", "input-group-text");
    dateLabel.textContent = "Temps";
    grp.appendChild(dateLabel);

    // Création d'un élément d'input pour le temps
    var dateInput = document.createElement("input");
    dateInput.setAttribute("type", "datetime-local");
    dateInput.setAttribute("name", "temps[]");
    dateInput.setAttribute("class", "form-control");
    grp.appendChild(dateInput);
    
}



</script>
