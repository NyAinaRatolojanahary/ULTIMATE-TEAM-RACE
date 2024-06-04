<%-- 
    Document   : ListePenaliteEquipeAdmin
    Created on : 4 juin 2024, 09:08:09
    Author     : Ny Aina Ratolo
--%>

<%@page import="Models.Penalite" %>
<%@page import="java.util.ArrayList" %>

<%
    Penalite pnlt = new Penalite();
    ArrayList<Penalite> lspn = new ArrayList<>();
    lspn = pnlt.getAllPenalite(null);
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

                <h1 class="h3 mb-3">Penalite d'Equipe</h1>

                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Les Penalites</h5>
                            </div>
                            <div class="card-body">
                                <a class="btn btn-danger" href="FormulaireAjoutPenaliteAdmin.jsp">Ajouter Penalite</a>
                                <table class="table table-hover my-0">
                                    <thead>
                                        <tr>
                                            <th class="d-none d-xl-table-cell">Nom Etape</th>
                                            <th class="d-none d-xl-table-cell">Nom Equipe</th>
                                            <th class="d-none d-xl-table-cell">Penalite</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for(Penalite pn : lspn){ %>
                                        <tr>
                                            <td class="d-none d-xl-table-cell"><%= pn.getNomEtape() %></td>
                                            <td class="d-none d-xl-table-cell"><%= pn.getNomEquipe() %> </td>
                                            <td class="d-none d-xl-table-cell"><%= pn.getPenalite() %></td>
                                            <td>
                                                <form class="formulairePenalite" method="post">
                                                    <input id="idEtp" type="hidden" name="idEtape" value="<%= pn.getIdEtape() %>">
                                                    <input id="idEqp" type="hidden" name="idEquipe" value="<%= pn.getIdEquipe() %>">
                                                </form>
                                                <button class="deletePenalite btn btn-danger btn-sm">Supprimer</button>
                                                <div class="dropdown-menu dropdown-menu-end popup" style="display:none;">
                                                    <h2 class="text-danger">Confirmez vous la suppression?</h2>
                                                    <button class="oui btn btn-success btn-sm">Oui</button>
                                                    <button class="non btn btn-danger btn-sm">Non</button>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <script src="js/app.js"></script>
    <script>
        document.querySelectorAll('.deletePenalite').forEach((button, index) => {
            button.addEventListener('click', function () {
                const popup = document.querySelectorAll('.popup')[index];
                popup.style.display = 'block';

                const ouiButton = popup.querySelector('.oui');
                const nonButton = popup.querySelector('.non');
                const form = document.querySelectorAll('.formulairePenalite')[index];

                ouiButton.addEventListener('click', function () {
                    submitForm(form);
                });

                nonButton.addEventListener('click', function () {
                    popup.style.display = 'none';
                });
            });
        });

        function submitForm(form) {
            // var formData = new FormData(form);
            var idEquipe1 = document.getElementById("idEqp").value;
            var idEtape1 = document.getElementById("idEtp").value;
            var data = {
                idEquipe: idEquipe1,
                idEtape: idEtape1
            };

            fetch('/UltimateRaceTeam/SupprimerPenaliteEquipeServlet', {
                method: 'POST',
                 headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            }).then(response => {
                if (!response.ok) throw new Error('Il y a erreur');
                return response.json();
            }).then(data => {
                if (data.status === 'success') {
                    alert('Penalité supprimée avec succès');
                    window.location.reload();
                } else {
                    throw new Error(data.message);
                }
            }).catch(error => console.error('Erreur: ', error));
        }


    </script>

</body>

</html>
