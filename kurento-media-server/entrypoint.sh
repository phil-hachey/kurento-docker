#!/bin/bash
set -e

if [ ! -z "$STUN_TCP_ADDR" ]; then
  if [ ! -z "$STUN_TCP_PORT" ]; then
    # Generate WebRtcEndpoint configuration
    echo "stunServerAddress=$STUN_TCP_ADDR" > /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini
    echo "stunServerPort=$STUN_TCP_PORT" >> /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini
  fi
fi

if [ ! -z "$TURN_TCP_ADDR" ]; then
  if [ ! -z "$TURN_TCP_PORT" ]; then
    # Generate WebRtcEndpoint configuration
    echo "turnURL=kurento:kurento@$TURN_TCP_ADDR:$TURN_TCP_PORT" >> /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini
  fi
fi

# Remove ipv6 local loop until ipv6 is supported
cat /etc/hosts | sed '/::1/d' | tee /etc/hosts > /dev/null

exec /usr/bin/kurento-media-server "$@"
