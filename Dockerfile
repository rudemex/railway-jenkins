# Usar la imagen oficial de Jenkins LTS
FROM jenkins/jenkins:lts

# Exponer los puertos de Jenkins
EXPOSE 8080 50000

# Definir el directorio de Jenkins
ENV JENKINS_HOME=${JENKINS_HOME:-/var/jenkins_home}
ENV JAVA_OPTS=${JAVA_OPTS:--Djenkins.install.runSetupWizard=false}
ENV JENKINS_USER=${JENKINS_USER:-admin}
ENV JENKINS_PASS=${JENKINS_PASS:-admin}
ENV JENKINS_PORT=${JENKINS_PORT:-8080}
ENV JENKINS_AGENT_PORT=${JENKINS_AGENT_PORT:-50000}
ENV JENKINS_PLUGINS=${JENKINS_PLUGINS:-git,workflow-aggregator,docker-workflow}

# Ejecutar Jenkins
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
