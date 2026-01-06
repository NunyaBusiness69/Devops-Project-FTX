# Minecraft Server – DevOps Project

Dit project beschrijft de opzet van een Minecraft server in de AWS-cloud, gerealiseerd met behulp van moderne DevOps-tools en -methodieken. Het doel is om infrastructuur, configuratie en applicatiebeheer zoveel mogelijk te automatiseren, reproduceerbaar te maken en efficiënt te beheren.

Alle technische bestanden, inclusief Terraform-, Ansible-, Docker- en Jenkins-configuraties, zijn terug te vinden in deze repository. Daarnaast zijn in de bijbehorende PowerPoint-presentatie screenshots opgenomen van de server, de Docker-containers, de monitoring in CloudWatch en de uitvoering van de Jenkins-pipeline.

## Gebruikte tools en software

- AWS Cloudshell

- Amazon Linux EC2  (t3.micro)

- Git

- Terraform

- Ansible

- Docker

- Jenkins

- AWS CloudWatch

- SSM

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

De substructuur van de map "minecraft-ansible" is direct overgenomen vanuit onze EC2-instance. Dit betekent dat alle bestanden op dezelfde plaats gezet zijn zoals op onze EC2 Amazon Linux. Mocht het niet duidelijk zijn waar de bestanden in deze map zitten; er is een bestand in de map "Notities en Kanban" waar de locatie van elk bestand duidelijk genoteerd staat.

## Projectarchitectuur

- Terraform zet de infrastructuur op in AWS, inclusief VPC, subnet, EC2-instance, security groups en CloudWatch-monitoring.

- De EC2-instance draait Docker, waarin de Minecraft-server container wordt uitgevoerd.

- Ansible installeert Docker en beheert de Minecraft-server via rollen en playbooks. De lifecycle van de server kan apart worden uitgevoerd met de playbooks minecraft-start.yml, minecraft-stop.yml en minecraft-restart.yml. Custom tasks zijn gedefinieerd in roles/minecraft/tasks/main.yml.

- Docker Compose zorgt voor persistente opslag en maakt het beheer van zowel Minecraft- als backup-services overzichtelijk en stabiel.

- Jenkins automatiseert het proces via een pipeline, die veranderingen in de GitHub-repository detecteert, de Terraform- en Ansible-configuratie valideert en automatisch toepast.

- AWS CloudWatch monitort CPU- en RAM-gebruik, netwerkactiviteit en logs, met alarms bij overschrijding van ingestelde drempelwaarden.

- Toegang tot de server verloopt via AWS SSM, waardoor handmatige SSH-configuratie niet nodig is.

## Doel van het project

Dit project is onderdeel van onze groepsopdracht voor het vak DevOps en heeft als doel het toepassen van de geleerde vaardigheden in een cloudomgeving. Er is bijzondere aandacht besteed aan:

Automatisering van infrastructuur en applicatiebeheer

Herhaalbaarheid van deployments en configuraties

Beheerbaarheid van de server en monitoring

Door deze aanpak hebben we een stabiele en reproduceerbare Minecraft-server opgezet, volledig geïntegreerd met moderne DevOps-principes.
