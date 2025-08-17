# Imagen base oficial de Ansible AWX EE
FROM quay.io/ansible/awx-ee:latest

LABEL maintainer="Enrique Flores Bautista <eflores.unmsm.fisi@gmail.com>"
LABEL version="1.0"
LABEL description="Execution Environment personalizado para EXTRACTORES"

USER root

# Actualizar el sistema base y eliminar paquetes obsoletos
RUN dnf -y update && \
    dnf -y upgrade && \
    dnf clean all

# Instalación de paquetes adicionales
RUN dnf install -y jq
RUN dnf clean all

# Actualizar pip, setuptools y wheel a versiones sin vulnerabilidades
RUN python3 -m pip install --upgrade pip==24.0 setuptools==78.1.1 wheel

# Instalar MinIO Client (mc)
RUN curl -L https://dl.min.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc

RUN pip install --upgrade ansible-core

COPY requirements.yml /tmp/requirements.yml
COPY requirements.txt /tmp/requirements.txt
# ← aquí instalamos en el path global
RUN ansible-galaxy collection install \
      -p /usr/share/ansible/collections \
      -r /tmp/requirements.yml
RUN pip install --upgrade -r /tmp/requirements.txt
# Asegurar que el usuario ansible (UID 1000) puede leer las colecciones
RUN chown -R 1000:0 /usr/share/ansible/collections
USER 1000
