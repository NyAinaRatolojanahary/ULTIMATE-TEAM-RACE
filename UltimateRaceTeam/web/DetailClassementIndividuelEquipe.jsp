<%-- 
    Document   : DetailClassementIndividuel
    Created on : 2 juin 2024, 22:30:12
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.DetailClassementIndividuel" %>
<%@page import="java.util.ArrayList" %>

<%
    ArrayList<DetailClassementIndividuel> lsclass = new ArrayList<>();
    lsclass = (ArrayList<DetailClassementIndividuel>) request.getAttribute("listeDetail");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-blank.html" />

	<title>Blank Page</title>

	<link href="${pageContext.request.contextPath}/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<div class="wrapper">
	    <%@include file="HeaderEquipe.jsp"%>
			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h3 mb-3">Classement Individuel</h1>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Etapes du course</h5>
								</div>
								<div class="card-body">
                                                                    <h1 class="card-title mb-0">Coureur: <%= lsclass.get(0).getNomCoureur()%> </h1><h1 class="card-title mb-0">Equipe : <%= lsclass.get(0).getNomEquipe()%></h1>
                                                                    <table class="table table-hover my-0">
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="d-none d-xl-table-cell">Nom Etape</th>
                                                                                <th class="d-none d-xl-table-cell">DateHeure de depart</th>
                                                                                <th class="d-none d-xl-table-cell">DateHeure d'arrivee</th>
                                                                                <th class="d-none d-xl-table-cell">Temps Passe</th>
                                                                                <th class="d-none d-xl-table-cell">Rang</th>
                                                                                <th class="d-none d-xl-table-cell">Point</th>
                                                                            </tr>
                                                                        </thead>
                                                                            <tbody>
                                                                                <% for(DetailClassementIndividuel cli : lsclass){%>
                                                                                    <tr>
                                                                                        <td class="d-none d-xl-table-cell"><%= cli.getNomEtape()%></td>
                                                                                        <td class="d-none d-xl-table-cell"><%= cli.getDateHeureDepart()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getDateHeureArrivee()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getDuree()%> Heures</td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getClassement()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getPoint()%></td>
                                                                                    </tr>
                                                                                <%}%>
                                                                            </tbody>
                                                                    </table>
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

