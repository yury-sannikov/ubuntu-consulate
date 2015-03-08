# A minimal Ubuntu base image modified for Docker-friendliness with preinstalled Consul

* Uses minimal [docker-friendly Ubuntu base image](https://github.com/phusion/baseimage-docker)
* Preinstalled [consul](https://github.com/hashicorp/consul)
* Preinstalled [consul-template](https://github.com/hashicorp/consul-template)
* Preinstalled [encconsul](https://github.com/hashicorp/envconsul)

## How it should be used
This is opinionated solution and might not fit your needs.
Consul and Registrator is good at cloud environment. Registrator automatically register all docker containers to the instance consul node. But you can have many different containers running inside one instance (VM or dynamo). If you want consul to display not only instance consul node but nodes for each instance container, you can specify CONSULATE_JOINTO to your instance consul server agent and specify CONSULATE_NODENAME to be associated with your container function. CONSULATE_NODENAME by default equal to container host name. If ONSULATE_JOINTO did not specified, consul agent will not be started.

## Usage (Fig)

    workernode:
      image: yury1sannikov/ubuntu-consulate
      command: /sbin/my_init [your-command-to-run]
      environment:
      - CONSULATE_JOINTO=consulmaster
      - CONSULATE_NODENAME=micro_workernode

* CONSULATE_JOINTO specifies consul server to join
* CONSULATE_NODENAME specifies current node name
