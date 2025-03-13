FROM jenkins/jenkins:lts

# Permitir el acceso como usuario root
USER root

# Instalar dependencias adicionales
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Crear y establecer permisos del directorio de Jenkins
RUN mkdir -p /var/jenkins_home && chown -R jenkins:jenkins /var/jenkins_home

# Configurar las variables de entorno
ENV JENKINS_HOME=${JENKINS_HOME:-/var/jenkins_home}
ENV JAVA_OPTS=${JAVA_OPTS:--Djenkins.install.runSetupWizard=false}
ENV JENKINS_USER=${JENKINS_USER:-admin}
ENV JENKINS_PASS=${JENKINS_PASS:-admin}
ENV JENKINS_PORT=${JENKINS_PORT:-8080}
ENV JENKINS_AGENT_PORT=${JENKINS_AGENT_PORT:-50000}
ENV JENKINS_PLUGINS=${JENKINS_PLUGINS:-git,workflow-aggregator,docker-workflow}

# Agregar permisos a Jenkins para ejecutar comandos como sudo sin contraseña
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Cambiar usuario de nuevo a Jenkins antes de ejecutar
USER jenkins

# Ejecutar Jenkins
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
