# Usar la imagen oficial de Jenkins LTS
FROM jenkins/jenkins:lts

# Exponer los puertos de Jenkins
EXPOSE 8080 50000

# Definir el directorio de Jenkins
ENV JENKINS_HOME=/var/jenkins_home

# Ejecutar Jenkins
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
