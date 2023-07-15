# RadarPlane.com feed client

- These scripts aid in setting up your current ADS-B receiver to feed RadarPlaner.com.
- They will not disrupt any existing feed clients already present

## 1: Find coordinates / elevation:

<https://www.freemaptools.com/elevation-finder.htm>

## 2: Install the radarplane.com feed client

```
curl -L -o /tmp/rdpfeed.sh https://radarplane.com/feed.sh
sudo bash /tmp/rdpfeed.sh
```


### If you encounter issues, please do a reboot and then supply these logs on the forum (last 20 lines for each is sufficient):

```
sudo journalctl -u radarplane-feed --no-pager
sudo journalctl -u radarplane-mlat --no-pager
```


### Display the configuration

```
cat /etc/default/radarplane
```

### Restart

```
sudo systemctl restart radarplane-feed
sudo systemctl restart radarplane-mlat
```


### Systemd Status

```
sudo systemctl status radarplane-mlat
sudo systemctl status radarplane-feed
```


### Removal / disabling the services:

```
sudo bash /usr/local/share/radarplane/uninstall.sh
```

If the above doesn't work, you may be using an old version that didn't have the uninstall script, just disable the services and the scripts won't run anymore:

```
sudo systemctl disable --now radarplane-feed
sudo systemctl disable --now radarplane-mlat
```
