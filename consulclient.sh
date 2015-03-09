#!/bin/sh
if [ -z "$CONSULATE_JOINTO" ]; then
  echo "Skipping starting consul agent due empty CONSULATE_JOINTO variable"
  # Emulate daemon running for my_init
  while :; do sleep 10; done
else
  CONSULATE_NODENAME="${CONSULATE_NODENAME:-$(echo $HOSTNAME)}" 
  echo "Stating consul agent. Join to consul server: $CONSULATE_JOINTO, consul node name: $CONSULATE_NODENAME"
  consul agent -config-dir=/config -retry-join $CONSULATE_JOINTO -node $CONSULATE_NODENAME
fi

