# Usamos la imagen oficial de Jenkins LTS
FROM jenkins/jenkins:lts

# Usuario root para instalar dependencias
USER root

# Instalar herramientas necesarias
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    unzip \
    fontconfig \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de Jenkins y asignar permisos
RUN mkdir -p /var/jenkins_home && chown -R jenkins:jenkins /var/jenkins_home

# Establecer variables de entorno
ENV JENKINS_HOME="/var/jenkins_home"
ENV JENKINS_PORT="8080"
ENV JENKINS_AGENT_PORT="50000"
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Agregar Jenkins al grupo sudo y permitir ejecución sin contraseña
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Cambiar al usuario Jenkins
USER jenkins

# Exponer los puertos de Jenkins
EXPOSE 8080 50000

# Ejecutar Jenkins
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
