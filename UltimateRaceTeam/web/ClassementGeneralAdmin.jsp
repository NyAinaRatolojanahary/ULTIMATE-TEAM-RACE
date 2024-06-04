<%-- 
    Document   : ClassementGeneral
    Created on : 2 juin 2024, 18:32:55
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.ClassementGeneral" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>

<%
    ClassementGeneral ci = new ClassementGeneral();
    ArrayList<ClassementGeneral> lsclass = new ArrayList<>();
    lsclass = ci.getClassementGeneral();
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
	    <%@include file="HeaderAdmin.jsp"%>
			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h3 mb-3">Classement General</h1>

					<div class="row">
						<div class="col-12 col-md-6">
							<div class="card">
								<div class="card-body">
                                                                    <form action="/UltimateRaceTeam/PreGenerationPDFServlet" method="post">
                                                                        <button class="btn btn-success btn-lg"><i class="align-middle" data-feather="file"></i>PDF Certificat</button>
                                                                    </form>
                                                                    <table class="table table-hover my-0">
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="d-none d-xl-table-cell">Nom Equipe</th>
                                                                                <th class="d-none d-xl-table-cell">Rang</th>
                                                                                <th class="d-none d-xl-table-cell">Point</th>
                                                                            </tr>
                                                                        </thead>
                                                                            <tbody>
                                                                                <% for(ClassementGeneral cli : lsclass){%>
                                                                                    <tr>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getNomEquipe()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getRang()%></td>
                                                                                        <td class="d-none d-md-table-cell"><%= cli.getPoint()%></td>
                                                                                    </tr>
                                                                                <%}%>
                                                                            </tbody>
                                                                    </table>
								</div>
							</div>
						</div>
                                                <div class="col-12 col-md-6">
                                                    <%
                                                        List<String> labels = new ArrayList<>();
                                                        List<Integer> dataValues = new ArrayList<>();
                                                        for (ClassementGeneral item : lsclass) {
                                                          // Assuming you have a field named "libelle" in ClassementGeneral to represent labels
                                                          labels.add("\""+item.getNomEquipe()+"\"");
                                                          dataValues.add(item.getPoint()); // Assuming you have a field named "value" for data
                                                        }
                                                    %>
                                                    <div class="card">
                                                        <div class="card-header">
                                                                <h5 class="card-title">Classement Equipe par point</h5>
                                                                <!--<h6 class="card-subtitle text-muted">Pie charts are excellent at showing the relational proportions between data.</h6>-->
                                                        </div>
                                                        <div class="card-body">
                                                                <div class="chart chart-sm">
                                                                        <canvas id="chartjs-pie"></canvas>
                                                                </div>
                                                        </div>
                                                    </div>
						</div>
					</div>

				</div>
			</main>
		</div>

	<script src="js/app.js"></script>
        <script>
		document.addEventListener("DOMContentLoaded", function() {
			var data = {
                            labels: <%= labels %>,
                            datasets: [{
                              data: <%= dataValues %>,
                              backgroundColor: [
                                window.theme.primary,
                                window.theme.warning,
                                window.theme.danger,
                                "#dee2e6"
                              ],
                              borderColor: "transparent"
                            }]
                          };

                          new Chart(document.getElementById("chartjs-pie"), {
                            type: "pie",
                            data: data,
                            options: {
                              maintainAspectRatio: false,
                              legend: {
                                display: true
                              }
                            }
                          });
		});
	</script>

</body>

</html>
