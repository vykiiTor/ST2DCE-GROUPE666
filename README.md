# ST2DCE-PRJ-2324S9-SE1

GROUPE 666

# Etapes a faire question 2 etape 1 :

- VM avec debian 12
- installer docker version moins de 25, car minikube image load ne fonctionne pas avec les versions superieur
- installer minikube + kubectl + git + buildpacks + java 17
- Avec docker faire un container jenkins (docker run -d --name jenkins -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_data:/var/jenkins_home jenkins/jenkins:lts-jdk17)
- faire une pipeline et config le pipeline script avec le jenkinsFile fournis
- faire un agent avec le meme nom que celui dans le jenkinsFile (jenkins-slave)
- renseigner le absolute path pour l agent
- copier la commande de creation de l agent
- lancer la pipeline
