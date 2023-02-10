#!/bin/bash
SERVICE="/lib/systemd/system/radarplane-mlat2.service"

if [[ -z ${1} ]]; then
    echo --------------
    echo ERROR: requires a parameter
    exit 1
fi

cat >"$SERVICE" <<"EOF"
[Unit]
Description=radarplane-mlat2
Wants=network.target
After=network.target

[Service]
User=radarplane
EnvironmentFile=/etc/default/radarplane
ExecStart=/usr/local/share/radarplane/venv/bin/mlat-client \
    --input-type $INPUT_TYPE --no-udp \
    --input-connect $INPUT \
    --server feed.radarplane.com:SERVERPORT \
    --user $USER \
    --lat $LATITUDE \
    --lon $LONGITUDE \
    --alt $ALTITUDE \
    $UUID_FILE \
    $PRIVACY \
    $RESULTS
Type=simple
Restart=always
RestartSec=30
StartLimitInterval=1
StartLimitBurst=100
SyslogIdentifier=radarplane-mlat2
Nice=-1

[Install]
WantedBy=default.target
EOF

sed -i -e "s/SERVERPORT/${1}/" "$SERVICE"
if [[ -n ${2} ]]; then
    sed -i -e "s/\$RESULTS/${2}/" "$SERVICE"
fi

systemctl enable radarplane-mlat2
systemctl restart radarplane-mlat2
