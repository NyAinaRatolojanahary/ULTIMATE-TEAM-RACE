<%-- 
    Document   : ClassementGeneralParEquipePointsFiltreAdmin
    Created on : 5 juin 2024, 13:59:29
    Author     : Ny Aina Ratolo
--%>

<%@ page import="Models.Categorie" %>
<%@ page import="Models.ClassementEquipeCategorie" %>
<%@ page import="Models.ClassementGeneral" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>

<%
    // Conversion de l'ID de la catégorie en int, avec gestion de l'exception
    int idCategorie = -1;
    try {
        String idCategorieStr = request.getParameter("idCategorie");
        if (idCategorieStr != null) {
            idCategorie = Integer.parseInt(idCategorieStr);
        }
    } catch (NumberFormatException e) {
        // Gérer l'erreur de conversion si nécessaire
    }

    Categorie cg = new Categorie();
    ArrayList<Categorie> lscg = cg.getAllCategorie();

    List<ClassementGeneral> lsclassg = new ArrayList<>();
    List<ClassementEquipeCategorie> lsclass = new ArrayList<>();
    Categorie categ = null;

    if (idCategorie == -1) {
        ClassementGeneral ci = new ClassementGeneral();
        lsclassg = ci.getClassementGeneral();
    } else {
        ClassementEquipeCategorie ci = new ClassementEquipeCategorie();
        lsclass = ci.getClassementEquipeParCategorie(idCategorie);
        categ = cg.getCategorieById(idCategorie);
    }
%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin & Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <link rel="shortcut icon" href="img/icons/icon-48x48.png" />
    <link rel="canonical" href="https://demo-basic.adminkit.io/pages-blank.html" />

    <title>Classement Général</title>

    <link href="css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>

<body>
    <div class="wrapper">
        <%@ include file="HeaderAdmin.jsp" %>
        <main class="content">
            <div class="container-fluid p-0">
                <h1 class="h3 mb-3">Classement Général</h1>
                <form action="/UltimateRaceTeam/AjouterCoureurEtapeServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label">Catégorie</label>
                        <select class="form-select mb-3" name="coureur[]">
                            <option value=" ">Général</option>
                            <% for (Categorie cr : lscg) { %>
                                <option value="<%= cr.getIdCategorie() %>"><%= cr.getNomCategorie() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <input class="form-control form-control-lg" type="submit" value="Save" />
                    </div>
                </form>

                <% if (!lsclassg.isEmpty()) { %>
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
                                                <th class="d-none d-xl-table-cell">Nom Équipe</th>
                                                <th class="d-none d-xl-table-cell">Rang</th>
                                                <th class="d-none d-xl-table-cell">Point</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (ClassementGeneral cli : lsclassg) { %>
                                                <tr>
                                                    <td class="d-none d-md-table-cell"><%= cli.getNomEquipe() %></td>
                                                    <td class="d-none d-md-table-cell"><%= cli.getRang() %></td>
                                                    <td class="d-none d-md-table-cell"><%= cli.getPoint() %></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <%
                                List<String> labels = new ArrayList<>();
                                List<Integer> dataValues = new ArrayList<>();
                                for (ClassementGeneral item : lsclassg) {
                                    labels.add("\"" + item.getNomEquipe() + "\"");
                                    dataValues.add(item.getPoint());
                                }
                            %>
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Classement Équipe par point</h5>
                                </div>
                                <div class="card-body">
                                    <div class="chart chart-sm">
                                        <canvas id="chartjs-pie"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>

                <% if (!lsclass.isEmpty()) { %>
                    <div class="row">
                        <div class="col-12 col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Le Classement</h5>
                                </div>
                                <div class="card-body">
                                    <h3 class="card-title mb-0"><%= categ.getNomCategorie() %></h3>
                                    <table class="table table-hover my-0">
                                        <thead>
                                            <tr>
                                                <th class="d-none d-xl-table-cell">Nom Équipe</th>
                                                <th class="d-none d-xl-table-cell">Nom Catégorie</th>
                                                <th class="d-none d-xl-table-cell">Points</th>
                                                <th class="d-none d-xl-table-cell">Classement</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (ClassementEquipeCategorie cetp : lsclass) { %>
                                                <tr>
                                                    <td class="d-none d-xl-table-cell"><%= cetp.getNomEquipe() %></td>
                                                    <td class="d-none d-xl-table-cell"><%= cetp.getNomCategorie() %></td>
                                                    <td class="d-none d-xl-table-cell"><%= cetp.getTotalPoints() %></td>
                                                    <td class="d-none d-xl-table-cell"><%= cetp.getClassement() %></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <%
                                labels = new ArrayList<>();
                                dataValues = new ArrayList<>();
                                for (ClassementEquipeCategorie item : lsclass) {
                                    labels.add("\"" + item.getNomEquipe() + "\"");
                                    dataValues.add(item.getTotalPoints());
                                }
                            %>
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Classement <%= categ.getNomCategorie() %></h5>
                                </div>
                                <div class="card-body">
                                    <div class="chart chart-sm">
                                        <canvas id="chartjs-pie-<%= categ.getIdCategorie() %>"></canvas>
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
        document.addEventListener("DOMContentLoaded", function () {
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

            <% for (Categorie cat : lscg) { %>
                new Chart(document.getElementById("chartjs-pie-<%= cat.getIdCategorie() %>"), {
                    type: "pie",
                    data: data,
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
