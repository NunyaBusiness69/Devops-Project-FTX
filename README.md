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
    ├── minecraft-ansible/
        ├── inventories
            └── production
                ├── group_vars
                └── hosts.ini   
        ├── playbooks
        └── roles
            └── minecraft
                ├── tasks    
                └── templates
    ├── terraform/
    ├── jenkins/
    └── notities en kanban/

De substructuur van de map "minecraft-ansible" is direct overgenomen vanuit onze EC2-instance. Dit betekent dat alle bestanden op dezelfde plaats gezet zijn zoals op onze EC2 Amazon Linux. Mocht het niet duidelijk zijn waar wat zit, er is een bestand in de map "Notities en Kanban" waar de locatie van alle bestanden duidelijk genoteerd staan.

## Projectarchitectuur

De infrastructuur wordt opgezet met Terraform in AWS. Een EC2-instance draait Docker, waarin de Minecraft server als container wordt uitgevoerd. Ansible wordt gebruikt om Docker te installeren en de container te starten, stoppen en herstarten. Jenkins automatiseert dit proces via een pipeline. Monitoring van de instance gebeurt via AWS CloudWatch. Toegang tot de server verloopt via AWS SSM.

## Doel van het project

Dit project is onderdeel van onze groepsopdracht voor het vak Devops en heeft als doel het toepassen van de geleerde vaardigheden in een cloudomgeving, met in het bijzonder aandacht op automatisering, herhaalbaarheid en beheerbaarheid.
