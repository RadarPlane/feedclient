#!/bin/bash
set -x

IPATH=/usr/local/share/radarplane

systemctl disable --now radarplane-mlat
systemctl disable --now radarplane-mlat2 &>/dev/null
systemctl disable --now radarplane-feed

if [[ -d /usr/local/share/tar1090/html-rp ]]; then
    bash /usr/local/share/tar1090/uninstall.sh rp
fi

rm -f /lib/systemd/system/radarplane-mlat.service
rm -f /lib/systemd/system/radarplane-mlat2.service
rm -f /lib/systemd/system/radarplane-feed.service

cp -f "$IPATH/rp-uuid" /tmp/rp-uuid
rm -rf "$IPATH"
mkdir -p "$IPATH"
mv -f /tmp/rp-uuid "$IPATH/rp-uuid"

set +x

echo -----
echo "radarplane feed scripts have been uninstalled!"
