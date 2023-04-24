<!DOCTYPE html>
<html>
<head>
	<title>Afficher l'adresse IP d'un conteneur Docker avec JavaScript</title>
</head>
<body>
	<p>L'adresse IP du conteneur "my-container" est : <span id="ip-address"></span></p>

	<script type="text/javascript">
		// Fonction pour récupérer l'adresse IP d'un conteneur Docker
		function getContainerIpAddress(containerName) {
			// Créer une requête HTTP pour l'API Docker
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "/containers/" + containerName + "/json", false);

			// Envoyer la requête HTTP et récupérer les informations du conteneur
			xhr.send();
			var containerInfo = JSON.parse(xhr.responseText);

			// Extraire l'adresse IP du conteneur à partir des informations réseau
			var ipAddress = containerInfo.NetworkSettings.Networks.bridge.IPAddress;

			return ipAddress;
		}

		// Récupérer l'adresse IP du conteneur "my-container"
		var ipAddress = getContainerIpAddress("my-container");

		// Afficher l'adresse IP dans la page
		document.getElementById("ip-address").innerHTML = ipAddress;
	</script>
</body>
</html>



<!DOCTYPE html>
<html lang="EN" xml:lang="en">
<head>
<title>Page DevOps</title>
 <style type="text/css">
   
   #header, #footer {
			font-size: 40px;;
			padding: 0.3em;
			background: #ecc814;
		}
   
   
 </style>
</head>


  
  
<body>
	
<header id="header">
	<p>Deployment @Devops@   TALYS  pipeline 99 webhook jenkins: DevOps Tools Engineer | LPI...</p>
	<center><p>Votre adresse IP du conteneur est : <span id="ip-address"></span></p></center>

	</header>
	</br></br>

  <center> 
	  
	  
	  <h1 >  Groupe devops :)------------->Tests Jenkins |> <img src="good.png"  height="50" width="50"> </h1> 
	  
	  </br>
          <img src="Jenkins.png"  height="300" width="300"> 
  



</br>
<header id="footer">
<center><SCRIPT LANGUAGE="JavaScript">
		var maintenant=new Date();
		var jour=maintenant.getDate();
		var mois=maintenant.getMonth()+1;
		var an=maintenant.getFullYear();
		var heure=maintenant.getHours();
		var minute=maintenant.getMinutes();
		var seconde=maintenant.getSeconds();
        //document.write("Nous sommes le ",jour,"/",mois,"/",an,".");
		document.write("Nous sommes le ",jour,"/",mois,"/",an," et il est ",heure,":",minute,":",seconde,".");
	</SCRIPT></center>
	
</header>
  
</body>
</html>


