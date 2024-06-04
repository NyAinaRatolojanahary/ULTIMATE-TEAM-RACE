<%-- 
    Document   : Certificat
    Created on : 4 juin 2024, 15:35:54
    Author     : Ny Aina Ratolo
--%>

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
        <style>
            #myCertificate{
                background-image: url('img/Bordure.png');
                width: 800px;
                height: 500px;
            }
            
            #title{
                margin-left: 200px;
                margin-top: 10px;
                font-family: Arial;
                font-size: 70px;
                color: blue;
            }
            #nomEquipe{
                margin-left: 300px;
                margin-top: 10px;
                font-family: Arial;
                font-size: 30px;
            }
            #divTexte{
                width:600px;
                margin-left: 120px;
                margin-top: 30px;
            }
            #texte{
                font-family: Arial;
                font-size: 20px;
            }
            #rank{
                margin-left: 300px;
                margin-top: 40px;
            }
            #point{
                margin-left: 300px;
                margin-top: 40px;
            }
        </style>
</head>


<body>
    <main class="content">
            <div class="container-fluid p-0">
                    <div class="row">
                            <div class="col-12">
                                <div class="card" id="myCertificate">
                                            <!--<img class="card-img-top" src="img/photos/unsplash-1.jpg" alt="Unsplash">-->
<!--                                            <div class="card-header">
                                                    <h5 class="card-title mb-0">Card with image and links</h5>
                                            </div>-->
                                            <div class="card-body">
                                                <h1 id="title">CHAMPION</h1>
                                                <h3 id="nomEquipe">Nom Equipe</h3>
                                                <div id="divTexte"><p id="texte">Pour votre participation a <strong>Ultimate Race Team</strong> nous vous decernons ce certificate en guise de felicitation.</p></div>
                                                <h3 id="rank"><strong>RANG : </strong> 1 er</h3>
                                                <h3 id="point"><strong>Point : </strong> 1000</h3>
                                            </div>
                                    </div>
                            </div>
                    </div>
            </div>
    </main>
    <script src="js/app.js"></script>
</body>

</html>