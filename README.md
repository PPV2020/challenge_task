# Challenge – Infraestructura AWS EKS

## Descripción
Infraestructura creada con Terraform para un clúster EKS:
- VPC con subnets públicas (para acceso a Internet) y privadas (para los nodos EKS).
- IRSA (IAM Roles for Service Accounts), asignar roles directamente a los pods.
- Cifrado de secretos con KMS.
- Logging habilitado (API, audit, scheduler, controllerManager).
- Nodos en subnets privadas.

- Add-ons esenciales: 
	- Metrics Server: Para monitoreo de rendimiento necesario para escalado HPA.
	- ALB Controller:  Gestión de ALB / NLB en aws desde Kubernetes.
	- Cluster Autoscaler: Escalamiento de nodos.

Configurados los valores en terraform.tfvars. 
Las descripciones están en variables.tf

# PREX Challenge – Aplicación en Kubernetes

## Descripción
Aplicación realizada FastApi para probar comunicación interna entre servicios en Kubernetes

- /back/main.py expone el endpoint /api/status y muestra el estado del servicio. Responde un JSON.
- /front/index.html estático servido en NGINX
- default.conf define el proxy del frontend hacia el backend dentro del cluster:
	proxy_pass http://prex-challenge.default.svc.cluster.local:8000

# K8S

back-deployment.yaml: Deployment del backend
back-service.yaml: Service tipo ClusterIP (backend interno)
front-deployment.yaml: Deployment del frontend
front-service.yaml: Service tipo NodePort (expuesto en puerto 30081)

# Ejecutar en minikube

BUILD DE IMAGENES
docker build -t challenge2-backend -f Dockerfile.back .
docker build -t challenge2-frontend -f Dockerfile.front .

LOAD DE IMAGENES
minikube image load challenge2-backend:latest
minikube image load challenge2-frontend:latest

APPLY DE LOS MANIFIESTOS
kubectl apply -f back-deployment.yaml
kubectl apply -f back-service.yaml
kubectl apply -f front-deployment.yaml
kubectl apply -f front-service.yaml

ACCESO A ULR
minikube service challenge2-frontend
