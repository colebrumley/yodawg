# Local docker-in-docker swarm

Run `docker-compose up -d` on this repo to create a 2 node docker-in-docker swarm. You can then run `docker-compose scale apprentice=N` to add more worker nodes. The "joiner" container will dynamically add workers to the swarm as they're brought up.

I like to add `alias swarm='docker exec yodawg_master_1 docker'` to my shell for convenience.

> Clearly this is for testing. Nobody in their right mind would use this outside of development, _right_?
