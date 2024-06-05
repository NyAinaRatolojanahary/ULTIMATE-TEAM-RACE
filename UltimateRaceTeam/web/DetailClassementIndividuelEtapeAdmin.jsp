<%-- 
    Document   : DetailClassementIndividuelEtape
    Created on : 5 juin 2024, 10:32:33
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.DetailClassementIndividuelEtape" %>
<%@page import="java.util.ArrayList" %>

<%
    ArrayList<DetailClassementIndividuelEtape> lsclass = new ArrayList<>();
    lsclass = (ArrayList<DetailClassementIndividuelEtape>) request.getAttribute("listeDetail");
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
	    <%@include file="HeaderAdmin.jsp"%>
			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h3 mb-3">Classement Individuel</h1>
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Rang etapes du course : <%= lsclass.get(0).getNomEtape()%></h5>
								</div>
								<div class="card-body">
                                                                    <table class="table table-hover my-0">
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="d-none d-xl-table-cell">Nom Coureur</th>
                                                                                <th class="d-none d-xl-table-cell">Genre</th>
                                                                                <th class="d-none d-xl-table-cell">Chrono</th>
                                                                                <th class="d-none d-xl-table-cell">Penalite</th>
                                                                                <th class="d-none d-xl-table-cell">Temps final</th>
                                                                                <th class="d-none d-xl-table-cell">Rang</th>
                                                                            </tr>
                                                                        </thead>
                                                                            <tbody>
                                                                                <% for(DetailClassementIndividuelEtape cli : lsclass){%>
                                                                                    <tr>
                                                                                        <td class="d-none d-xl-table-cell"><%= cli.getNomCoureur()%></td>
                                                                                        <td class="d-none d-xl-table-cell"><%= cli.getGenre()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getChrono()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getPenalite()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getTempsFinal()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getRang()%></td>
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
