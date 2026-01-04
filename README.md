# Minecraft Server – DevOps Project

Dit project beschrijft de opzet van een Minecraft server in de AWS-cloud, gerealiseerd met behulp van DevOps-tools en -methodieken. Het doel is om infrastructuur, configuratie en applicatiebeheer zoveel mogelijk te automatiseren.

## Gebruikte technologieën

Terraform: het opzetten van de AWS infrastructuur

Ansible: configuratiebeheer en het beheren van Docker containers

Docker: het draaien van de Minecraft server

Jenkins: CI/CD automatisering

AWS CloudWatch: monitoring

AWS Systems Manager (SSM): beheer zonder SSH

## Repository structuur
.

├── ansible/

├── docker/

├── terraform/

├── jenkins/

└── notities en kanban/

## Architectuur

De infrastructuur wordt opgezet met Terraform in AWS. Een EC2-instance draait Docker, waarin de Minecraft server als container wordt uitgevoerd. Ansible wordt gebruikt om Docker te installeren en de container te starten, stoppen en herstarten. Jenkins automatiseert dit proces via een CI/CD-pipeline. Monitoring van de instance gebeurt via CloudWatch. Toegang tot de server verloopt via AWS SSM.

## Doel van het project

Dit project is onderdeel van een groepsopdracht en heeft als doel het toepassen van DevOps-principes in een realistische cloudomgeving, met nadruk op automatisering, herhaalbaarheid en beheerbaarheid.
