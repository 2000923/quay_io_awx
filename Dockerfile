# Imagen base oficial de Ansible AWX EE
FROM quay.io/ansible/awx-ee:latest

LABEL maintainer="Enrique Flores Bautista <eflores.unmsm.fisi@gmail.com>"
LABEL version="1.0"
LABEL description="Execution Environment personalizado para EXTRACTORES"

USER root

# Instalación de paquetes adicionales
RUN dnf install -y jq
RUN dnf clean all

COPY requirements.yml /tmp/requirements.yml
COPY requirements.txt /tmp/requirements.txt
RUN ansible-galaxy collection install -r /tmp/requirements.yml
RUN pip install -r /tmp/requirements.txt
USER 1000
