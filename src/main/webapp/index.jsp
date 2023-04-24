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
