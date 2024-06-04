<%-- 
    Document   : ClassementGeneralParEquipePointsAdmin
    Created on : 4 juin 2024, 05:55:28
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.Categorie"%>
<%@page import="Models.ClassementEquipeCategorie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin & Dashboard Template based on Bootstrap 5">
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
            <h1 class="h3 mb-3">Classement d'Equipe par categorie</h1>
            <% 
                Categorie cg = new Categorie();
                ArrayList<Categorie> lscg = new ArrayList<>();
                lscg = cg.getAllCategorie();
                for(Categorie categ : lscg) {
                    ClassementEquipeCategorie ci = new ClassementEquipeCategorie();
                    ArrayList<ClassementEquipeCategorie> lsclass = ci.getClassementEquipeParCategorie(categ.getIdCategorie());
            %>
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Le Classement</h5>
                        </div>
                        <div class="card-body">
                            <h3 class="card-title mb-0"><%=categ.getNomCategorie()%></h3>
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
                <div class="col-12 col-md-6">
                    <%
                        List<String> labels = new ArrayList<>();
                        List<Integer> dataValues = new ArrayList<>();
                        for (ClassementEquipeCategorie item : lsclass) {
                            labels.add("\""+item.getNomEquipe()+"\"");
                            dataValues.add(item.getTotalPoints());
                        }
                    %>
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">Classement <%=categ.getNomCategorie()%></h5>
                        </div>
                        <div class="card-body">
                            <div class="chart chart-sm">
                                <canvas id="chartjs-pie-<%=categ.getIdCategorie()%>"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </main>
</div>
<script src="js/app.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        <% 
            for(Categorie categ : lscg) {
                List<String> allLabels = new ArrayList<>();
                List<Integer> allDataValues = new ArrayList<>();
                ClassementEquipeCategorie ci = new ClassementEquipeCategorie();
                ArrayList<ClassementEquipeCategorie> lsclass = ci.getClassementEquipeParCategorie(categ.getIdCategorie());
                List<String> labels = new ArrayList<>();
                List<Integer> dataValues = new ArrayList<>();
                for (ClassementEquipeCategorie item : lsclass) {
                    labels.add("\""+item.getNomEquipe()+"\"");
                    dataValues.add(item.getTotalPoints());
                }
                allLabels.addAll(labels);
                allDataValues.addAll(dataValues);
        %>
        var data<%=categ.getIdCategorie()%> = {
            labels: <%= new org.json.JSONArray(allLabels) %>,
            datasets: [{
                data: <%= new org.json.JSONArray(allDataValues) %>,
                backgroundColor: [
                    window.theme.primary,
                    window.theme.warning,
                    window.theme.danger,
                    "#dee2e6"
                ],
                borderColor: "transparent"
            }]
        };

        new Chart(document.getElementById("chartjs-pie-<%=categ.getIdCategorie()%>"), {
            type: "pie",
            data: data<%=categ.getIdCategorie()%>,
            options: {
                maintainAspectRatio: false,
                legend: {
                    display: true
                }
            }
        });
        <% } %>
    });
</script>

</body>
</html>
