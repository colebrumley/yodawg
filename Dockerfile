FROM docker:dind
COPY swarmup.sh /
CMD ["/swarmup.sh"]