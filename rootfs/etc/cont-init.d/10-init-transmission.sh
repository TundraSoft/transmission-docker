#!/usr/bin/with-contenv sh
# Update config file
if [ -f /config/settings.json ]; then
  if [ ! -z "$USERNAME" ] && [ ! -z "$PASSWORD" ]; then
    sed -i '/rpc-authentication-required/c\  "rpc-authentication-required": true,' /config/settings.json
    sed -i "/rpc-username/c\  \"rpc-username\": \"$USERNAME\"," /config/settings.json
    sed -i "/rpc-password/c\  \"rpc-password\": \"$PASSWORD\"," /config/settings.json
  else
    sed -i '/rpc-authentication-required/c\  "rpc-authentication-required": false,' /config/settings.json
    sed -i "/rpc-username/c\  \"rpc-username\": \"\"," /config/settings.json
    sed -i "/rpc-password/c\  \"rpc-password\": \"\"," /config/settings.json
  fi
fi
