<%-- 
    Document   : ListeDetailIndividuelParEtape
    Created on : 3 juin 2024, 18:53:33
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.Equipe" %>
<%@page import="Models.EtapeCourse" %>
<%@page import="Models.CoureurEtape" %>
<%@page import="java.util.ArrayList" %>

<%
    HttpSession sess = request.getSession();
    
    Equipe e = new Equipe();
    e = (Equipe)sess.getAttribute("equipe");
    int idEquipe = e.getIdequipe();
    
    EtapeCourse etp = new EtapeCourse();
    ArrayList<EtapeCourse> lsetapes = new ArrayList<>();
    lsetapes = etp.getEtapeEquipe(idEquipe);
    

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

					<h1 class="h3 mb-3">Les Etapes avec Temps du courses</h1>

					<div class="row">
                                            <%for(EtapeCourse ec : lsetapes){%>
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Etapes du course</h5>
								</div>
								<div class="card-body">
                                                                        <h3 class="card-title mb-0"><%=ec.getNometape()%> / <%=ec.getLongueur()%>km  /<%=ec.getNbrcoureurequipe()%> coureur(s)</h3>
									<%
                                                                            CoureurEtape cetape = new CoureurEtape();
                                                                            ArrayList<CoureurEtape> lscetapes = new ArrayList<>();
                                                                            lscetapes = cetape.tempsPasseCoureurEtape(idEquipe,ec.getIdetape());
                                                                        %>
                                                                        <table class="table table-hover my-0">
										<thead>
											<tr>
												<th class="d-none d-xl-table-cell">Nom Coureur</th>
												<th class="d-none d-xl-table-cell">Temps</th>
											</tr>
										</thead>
										<tbody>
                                                                                    <% for(CoureurEtape cetp : lscetapes){%>
											<tr>
                                                                                            <td class="d-none d-xl-table-cell"><%= cetp.getNomCoureur()%></td>
                                                                                            <td class="d-none d-xl-table-cell"><%= cetp.getTempsPasse()%> </td>
                                                                                        </tr>
                                                                                    <%}%>
										</tbody>
									</table>
                                                                        <form action="/UltimateRaceTeam/FormulaireAffectationCoureurServlet" method="post">
                                                                            <input type="hidden" name="idEtape" value="<%= ec.getIdetape()%>">
                                                                            <input type="hidden" name="nomEtape" value="<%= ec.getNometape()%>">
                                                                            <button class="btn btn-success btn-sm">Affecter Coureur</button>
                                                                        </form>
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

