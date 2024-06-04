<%-- 
    Document   : ClassementGeneralParEquipePointsEquipe
    Created on : 4 juin 2024, 05:10:07
    Author     : Ny Aina Ratolo
--%>

<%-- 
    Document   : ClassementGeneral
    Created on : 2 juin 2024, 18:32:13
    Author     : Ny Aina Ratolo
--%>
<%@page import="Models.Categorie" %>
<%@page import="Models.ClassementEquipeCategorie" %>
<%@page import="java.util.ArrayList" %>

<%
    Categorie cg = new Categorie();
    ArrayList<Categorie> lscg = new ArrayList<>();
    lscg = cg.getAllCategorie();
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
	<link rel="shortcut icon" href="img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/pages-blank.html" />

	<title>Blank Page</title>

	<link href="css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
	<div class="wrapper">
	    <%@include file="HeaderEquipe.jsp"%>
			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h3 mb-3">Clasement d'Equipe par categorie</h1>

					<div class="row">
                                            <%for(Categorie categ : lscg){%>
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Le Classement</h5>
								</div>
								<div class="card-body">
                                                                        <h3 class="card-title mb-0"><%=categ.getNomCategorie()%></h3>
									<%
                                                                            ClassementEquipeCategorie ci = new ClassementEquipeCategorie();
                                                                            ArrayList<ClassementEquipeCategorie> lsclass = new ArrayList<>();
                                                                            lsclass = ci.getClassementEquipeParCategorie(categ.getIdCategorie());
                                                                        %>
                                                                        <table class="table table-hover my-0">
										<thead>
											<tr>
												<th class="d-none d-xl-table-cell">Nom Equipe</th>
												<th class="d-none d-xl-table-cell">Nom Categorie</th>
                                                                                                <th class="d-none d-xl-table-cell">Points</th>
                                                                                                <th class="d-none d-xl-table-cell">Classement</th>
											</tr>
										</thead>
										<tbody>
                                                                                    <% for(ClassementEquipeCategorie cetp : lsclass){%>
											<tr>
                                                                                            <td class="d-none d-xl-table-cell"><%= cetp.getNomEquipe()%></td>
                                                                                            <td class="d-none d-xl-table-cell"><%= cetp.getNomCategorie()%> </td>
                                                                                            <td class="d-none d-xl-table-cell"><%= cetp.getTotalPoints()%></td>
                                                                                            <td class="d-none d-xl-table-cell"><%= cetp.getClassement()%> </td>
                                                                                        </tr>
                                                                                    <%}%>
										</tbody>
									</table>
								</div>
							</div>
						</div>
                                            <%}%>
					</div>

				</div>
			</main>
		</div>

	<script src="js/app.js"></script>

</body>

</html>