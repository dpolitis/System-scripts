# Disable DHCP servers
/etc/init.d/odhcpd disable
/etc/init.d/dnsmasq disable

cat >> /etc/sysctl.conf << EOF

# disable ipv6
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1

# fix kernel verbosity
kernel.printk = 1 4 1 7
EOF

# Remove all firewall rules
uci delete firewall.@zone[2]
uci delete firewall.@zone[1]
uci delete firewall.@zone[0]
uci delete firewall.@forwarding[0]
for j in $(seq 0 20); do uci delete firewall.@rule[0]; done

# Remove WAN interface
uci delete network.wan
uci delete network.wan6

# Reconfigure DHCP client for bridge over LAN and WAN ports
uci delete network.lan.ipaddr
uci delete network.lan.netmask
uci delete network.lan.ip6assign
uci delete network.globals.ula_prefix
uci delete network.@switch_vlan[1]
uci set network.lan.proto=dhcp
uci set network.lan.ipv6=0
uci set network.lan.ifname='eth0'
uci set network.lan.stp=1

# Disable switch tagging and bridge all ports
uci set network.@switch[0].enable_vlan=0
uci set network.@switch_vlan[0].ports='0 1 2 3 4 5 6'

# Enable wireless
uci delete wireless.radio0.disabled
uci delete wireless.radio1.disabled

# Radio ordering differs among models
case $(uci get wireless.radio0.hwmode) in
  11a) uci rename wireless.radio0=radio5ghz;;
  11g) uci rename wireless.radio0=radio2ghz;;
esac
case $(uci get wireless.radio1.hwmode) in
  11a) uci rename wireless.radio1=radio5ghz;;
  11g) uci rename wireless.radio1=radio2ghz;;
esac

# Reset virtual SSID-s
uci delete wireless.@wifi-iface[1]
uci delete wireless.@wifi-iface[0]
for band in 2ghz 5ghz; do
uci set wireless.lan$band=wifi-iface
uci set wireless.lan$band.mode=ap
uci set wireless.lan$band.device=radio$band
uci set wireless.lan$band.encryption=psk2
uci set wireless.lan$band.ssid=KoodurProtected
uci set wireless.lan$band.key='salakala'
uci set wireless.lan$band.network=lan
done

# Generate unique hostname based on wireless MAC
uci set system.@system[0].hostname=tp-link-$(cat /sys/class/net/wlan1/address | cut -d : -f 4- | sed -e 's/://g')
uci set network.lan.hostname=$(uci get system.@system[0].hostname)

# Commit changes
uci commit

# Skip following to keep guests network disabled

# Create bridge for guests
uci set network.guest=interface
uci set network.guest.proto='static'
uci set network.guest.address='0.0.0.0'
uci set network.guest.type='bridge'
uci set network.guest.ifname='eth0.156 eth1.156' # tag id 156 for guest network
uci set network.guest.ipaddr='0.0.0.0'
uci set network.guest.ipv6=0
uci set network.guest.stp=1

# Add guest SSID-s
for band in 2ghz 5ghz; do
uci set wireless.guest$band=wifi-iface
uci set wireless.guest$band.mode=ap
uci set wireless.guest$band.device=radio$band
uci set wireless.guest$band.encryption=none
uci set wireless.guest$band.ssid=KoodurPublic
uci set wireless.guest$band.network=guest
done

uci commit

For lazy people convenience hack for adding SSH keys:

# Create script for fetching SSH keys once interface goes up
cat > /etc/hotplug.d/iface/update-ssh-authorized-keys << EOF
wget https://www.koodur.com/authorized_keys -O /etc/dropbear/authorized_keys.part
mv /etc/dropbear/authorized_keys.part /etc/dropbear/authorized_keys
EOF

opkg update
opkg install openssl-util nano htop

opkg install luci-ssl


uci set uhttpd.main.listen_http=0.0.0.0:80
uci set uhttpd.main.listen_https='0.0.0.0:443'
uci set uhttpd.main.redirect_https='1'
uci commit

/etc/init.d/uhttpd restart
