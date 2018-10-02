#!/bin/bash

# 0. Pre Flight Checks
sudo mkdir /var/edx
sudo ln -s /var/edx /edx
sudo chown 0:0 /edx
sudo chown -R 0:0 /var/edx
sudo mkdir -p /edx/app/{ecommerce,insights}
sudo chown -R 0:0 /edx/app

cd /edx/app/ecommerce
sudo git clone http://github.com/edx/ecommerce.git
cd ecommerce
sudo git checkout 83088e688d9e7c80ef9df856a4b3cfabfbc57fa2
sudo su -c 'cat > /edx/app/ecommerce/ecommerce/.bowerrc << EOCONF1
{
  "directory": "ecommerce/static/bower_components",
  "interactive": false,
  "registry": "https://registry.bower.io"
}
EOCONF1'
sudo chown -R 1005:33 /edx/app/ecommerce

cd /edx/app/insights
sudo git clone http://github.com/edx/edx-analytics-dashboard.git
cd edx-analytics-dashboard
sudo git checkout 10c6afa58d4ee46b3b2becf12c237875108655dc
sudo su -c 'cat > /edx/app/insights/edx-analytics-dashboard/.bowerrc << EOCONF2
{
  "directory": "analytics_dashboard/static/bower_components",
  "interactive": false,
  "registry": "https://registry.bower.io",
  "scripts": {
    "postinstall": "./bower-post-install.sh"
  }
}
EOCONF2'
sudo chown -R 1008:33 /edx/app/insights

sudo mkdir -p /usr/share/ca-certificates/incommon
sudo su -c 'cat > /usr/share/ca-certificates/incommon/InCommonServerCA.crt << EOCERT
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            7f:71:c1:d3:a2:26:b0:d2:b1:13:f3:e6:81:67:64:3e
        Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=SE, O=AddTrust AB, OU=AddTrust External TTP Network, CN=AddTrust External CA Root
        Validity
            Not Before: Dec  7 00:00:00 2010 GMT
            Not After : May 30 10:48:38 2020 GMT
        Subject: C=US, O=Internet2, OU=InCommon, CN=InCommon Server CA
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
            RSA Public Key: (2048 bit)
                Modulus (2048 bit):
                    00:97:7c:c7:c8:fe:b3:e9:20:6a:a3:a4:4f:8e:8e:
                    34:56:06:b3:7a:6c:aa:10:9b:48:61:2b:36:90:69:
                    e3:34:0a:47:a7:bb:7b:de:aa:6a:fb:eb:82:95:8f:
                    ca:1d:7f:af:75:a6:a8:4c:da:20:67:61:1a:0d:86:
                    c1:ca:c1:87:af:ac:4e:e4:de:62:1b:2f:9d:b1:98:
                    af:c6:01:fb:17:70:db:ac:14:59:ec:6f:3f:33:7f:
                    a6:98:0b:e4:e2:38:af:f5:7f:85:6d:0e:74:04:9d:
                    f6:27:86:c7:9b:8f:e7:71:2a:08:f4:03:02:40:63:
                    24:7d:40:57:8f:54:e0:54:7e:b6:13:48:61:f1:de:
                    ce:0e:bd:b6:fa:4d:98:b2:d9:0d:8d:79:a6:e0:aa:
                    cd:0c:91:9a:a5:df:ab:73:bb:ca:14:78:5c:47:29:
                    a1:ca:c5:ba:9f:c7:da:60:f7:ff:e7:7f:f2:d9:da:
                    a1:2d:0f:49:16:a7:d3:00:92:cf:8a:47:d9:4d:f8:
                    d5:95:66:d3:74:f9:80:63:00:4f:4c:84:16:1f:b3:
                    f5:24:1f:a1:4e:de:e8:95:d6:b2:0b:09:8b:2c:6b:
                    c7:5c:2f:8c:63:c9:99:cb:52:b1:62:7b:73:01:62:
                    7f:63:6c:d8:68:a0:ee:6a:a8:8d:1f:29:f3:d0:18:
                    ac:ad
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier:
                keyid:AD:BD:98:7A:34:B4:26:F7:FA:C4:26:54:EF:03:BD:E0:24:CB:54:1A

            X509v3 Subject Key Identifier:
                48:4F:5A:FA:2F:4A:9A:5E:E0:50:F3:6B:7B:55:A5:DE:F5:BE:34:5D
            X509v3 Key Usage: critical
                Certificate Sign, CRL Sign
            X509v3 Basic Constraints: critical
                CA:TRUE, pathlen:0
            X509v3 Certificate Policies:
                Policy: X509v3 Any Policy

            X509v3 CRL Distribution Points:
                URI:http://crl.usertrust.com/AddTrustExternalCARoot.crl

            Authority Information Access:
                CA Issuers - URI:http://crt.usertrust.com/AddTrustExternalCARoot.p7c
                CA Issuers - URI:http://crt.usertrust.com/AddTrustUTNSGCCA.crt
                OCSP - URI:http://ocsp.usertrust.com

    Signature Algorithm: sha1WithRSAEncryption
        93:66:21:80:74:45:85:4b:c2:ab:ce:32:b0:29:fe:dd:df:d6:
        24:5b:bf:03:6a:6f:50:3e:0e:1b:b3:0d:88:a3:5b:ee:c4:a4:
        12:3b:56:ef:06:7f:cf:7f:21:95:56:3b:41:31:fe:e1:aa:93:
        d2:95:f3:95:0d:3c:47:ab:ca:5c:26:ad:3e:f1:f9:8c:34:6e:
        11:be:f4:67:e3:02:49:f9:a6:7c:7b:64:25:dd:17:46:f2:50:
        e3:e3:0a:21:3a:49:24:cd:c6:84:65:68:67:68:b0:45:2d:47:
        99:cd:9c:ab:86:29:11:72:dc:d6:9c:36:43:74:f3:d4:97:9e:
        56:a0:fe:5f:40:58:d2:d5:d7:7e:7c:c5:8e:1a:b2:04:5c:92:
        66:0e:85:ad:2e:06:ce:c8:a3:d8:eb:14:27:91:de:cf:17:30:
        81:53:b6:66:12:ad:37:e4:f5:ef:96:5c:20:0e:36:e9:ac:62:
        7d:19:81:8a:f5:90:61:a6:49:ab:ce:3c:df:e6:ca:64:ee:82:
        65:39:45:95:16:ba:41:06:00:98:ba:0c:56:61:e4:c6:c6:86:
        01:cf:66:a9:22:29:02:d6:3d:cf:c4:2a:8d:99:de:fb:09:14:
        9e:0e:d1:d5:c6:d7:81:dd:ad:24:ab:ac:07:05:e2:1d:68:c3:
        70:66:5f:d3
-----BEGIN CERTIFICATE-----
MIIEwzCCA6ugAwIBAgIQf3HB06ImsNKxE/PmgWdkPjANBgkqhkiG9w0BAQUFADBv
MQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFk
ZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBF
eHRlcm5hbCBDQSBSb290MB4XDTEwMTIwNzAwMDAwMFoXDTIwMDUzMDEwNDgzOFow
UTELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUludGVybmV0MjERMA8GA1UECxMISW5D
b21tb24xGzAZBgNVBAMTEkluQ29tbW9uIFNlcnZlciBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAJd8x8j+s+kgaqOkT46ONFYGs3psqhCbSGErNpBp
4zQKR6e7e96qavvrgpWPyh1/r3WmqEzaIGdhGg2GwcrBh6+sTuTeYhsvnbGYr8YB
+xdw26wUWexvPzN/ppgL5OI4r/V/hW0OdASd9ieGx5uP53EqCPQDAkBjJH1AV49U
4FR+thNIYfHezg69tvpNmLLZDY15puCqzQyRmqXfq3O7yhR4XEcpocrFup/H2mD3
/+d/8tnaoS0PSRan0wCSz4pH2U341ZVm03T5gGMAT0yEFh+z9SQfoU7e6JXWsgsJ
iyxrx1wvjGPJmctSsWJ7cwFif2Ns2Gig7mqojR8p89AYrK0CAwEAAaOCAXcwggFz
MB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0GA1UdDgQWBBRIT1r6
L0qaXuBQ82t7VaXe9b40XTAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB
/wIBADARBgNVHSAECjAIMAYGBFUdIAAwRAYDVR0fBD0wOzA5oDegNYYzaHR0cDov
L2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMIGz
BggrBgEFBQcBAQSBpjCBozA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1
c3QuY29tL0FkZFRydXN0RXh0ZXJuYWxDQVJvb3QucDdjMDkGCCsGAQUFBzAChi1o
dHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RVVE5TR0NDQS5jcnQwJQYI
KwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEF
BQADggEBAJNmIYB0RYVLwqvOMrAp/t3f1iRbvwNqb1A+DhuzDYijW+7EpBI7Vu8G
f89/IZVWO0Ex/uGqk9KV85UNPEerylwmrT7x+Yw0bhG+9GfjAkn5pnx7ZCXdF0by
UOPjCiE6SSTNxoRlaGdosEUtR5nNnKuGKRFy3NacNkN089SXnlag/l9AWNLV1358
xY4asgRckmYOha0uBs7Io9jrFCeR3s8XMIFTtmYSrTfk9e+WXCAONumsYn0ZgYr1
kGGmSavOPN/mymTugmU5RZUWukEGAJi6DFZh5MbGhgHPZqkiKQLWPc/EKo2Z3vsJ
FJ4O0dXG14HdrSSrrAcF4h1ow3BmX9M=
-----END CERTIFICATE-----
EOCERT'

# 1. Set the OPENEDX_RELEASE variable:
export OPENEDX_RELEASE="open-release/ginkgo.2"

# 2. Bootstrap the Ansible installation:
wget http://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/ansible-bootstrap.sh
sed -i 's/keyserver.ubuntu.com/hkp:\/\/keyserver.ubuntu.com:80/g' ansible-bootstrap.sh
cat ansible-bootstrap.sh | sudo -E bash
rm ~/ansible-bootstrap.*

# 3. (Optional) If this is a new installation, randomize the passwords:
wget http://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/generate-passwords.sh -O - | bash

# Look for a server-vars.yml file in the home directory
if [[ -f server-vars.yml ]]; then
   echo "found server-vars.yml. Copying to /edx/app/edx_ansible/server-vars.yml";
   sudo cp server-vars.yml /edx/app/edx_ansible/server-vars.yml
fi
rm ~/generate-passwords.*

# 4. Install Open edX. For Ginkgo and older, this will be a 404, and you need to use sandbox.sh instead of native.sh
sudo su -c 'cat > /var/tmp/edx.patch << EOPATCH
diff -ur --no-dereference configuration.old/docker/build/go-agent/files/docker_install.sh configuration/docker/build/go-agent/files/docker_install.sh
--- configuration.old/docker/build/go-agent/files/docker_install.sh	2018-10-01 20:14:32.456763066 +0300
+++ configuration/docker/build/go-agent/files/docker_install.sh	2018-10-01 13:46:33.148662474 +0300
@@ -31,7 +31,7 @@
 key_servers="
 ha.pool.sks-keyservers.net
 pgp.mit.edu
-keyserver.ubuntu.com
+hkp://keyserver.ubuntu.com:80
 "

 command_exists() {
diff -ur --no-dereference configuration.old/playbooks/roles/ad_hoc_reporting/defaults/main.yml configuration/playbooks/roles/ad_hoc_reporting/defaults/main.yml
--- configuration.old/playbooks/roles/ad_hoc_reporting/defaults/main.yml	2018-10-01 20:14:32.464763066 +0300
+++ configuration/playbooks/roles/ad_hoc_reporting/defaults/main.yml	2018-10-01 13:46:33.148662474 +0300
@@ -42,7 +42,7 @@
   - mysql-python

 MONGODB_APT_KEY: "7F0CEB10"
-MONGODB_APT_KEYSERVER: "keyserver.ubuntu.com"
+MONGODB_APT_KEYSERVER: "hkp://keyserver.ubuntu.com:80"
 MONGODB_REPO: "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse"
 mongo_version: 3.2.12

diff -ur --no-dereference configuration.old/playbooks/roles/common_vars/defaults/main.yml configuration/playbooks/roles/common_vars/defaults/main.yml
--- configuration.old/playbooks/roles/common_vars/defaults/main.yml	2018-10-01 20:15:45.908763383 +0300
+++ configuration/playbooks/roles/common_vars/defaults/main.yml	2018-10-01 13:46:33.148662474 +0300
@@ -51,10 +51,10 @@
 COMMON_PIP_VERBOSITY: ''
 COMMON_PYPI_MIRROR_URL: 'https://pypi.python.org/simple'
 COMMON_NPM_MIRROR_URL: 'https://registry.npmjs.org'
-COMMON_UBUNTU_APT_KEYSERVER: "http://keyserver.ubuntu.com/pks/lookup?op=get&fingerprint=on&search="
+COMMON_UBUNTU_APT_KEYSERVER: "hkp://keyserver.ubuntu.com:80/pks/lookup?op=get&fingerprint=on&search="

 COMMON_EDX_PPA: "deb http://ppa.edx.org {{ ansible_distribution_release }} main"
-COMMON_EDX_PPA_KEY_SERVER: "keyserver.ubuntu.com"
+COMMON_EDX_PPA_KEY_SERVER: "hkp://keyserver.ubuntu.com:80"
 COMMON_EDX_PPA_KEY_ID: "69464050"

 #The git checkout url in most roles is constructed from these values
diff -ur --no-dereference configuration.old/playbooks/roles/edxapp/defaults/main.yml configuration/playbooks/roles/edxapp/defaults/main.yml
--- configuration.old/playbooks/roles/edxapp/defaults/main.yml	2018-10-01 20:15:45.912763383 +0300
+++ configuration/playbooks/roles/edxapp/defaults/main.yml	2018-10-01 13:46:33.148662474 +0300
@@ -1227,7 +1227,7 @@
 edxapp_theme_version: 'master'

 # make this the public URL instead of writable
-edx_platform_repo: "https://{{ COMMON_GIT_MIRROR }}/edx/edx-platform.git"
+edx_platform_repo: "http://{{ COMMON_GIT_MIRROR }}/edx/edx-platform.git"
 # \`edx_platform_version\` can be anything that git recognizes as a commit
 # reference, including a tag, a branch name, or a commit hash
 edx_platform_version: 'release'
diff -ur --no-dereference configuration.old/playbooks/roles/edx_service/tasks/main.yml configuration/playbooks/roles/edx_service/tasks/main.yml
--- configuration.old/playbooks/roles/edx_service/tasks/main.yml	2018-10-01 20:15:45.912763383 +0300
+++ configuration/playbooks/roles/edx_service/tasks/main.yml	2018-10-01 15:14:37.988685310 +0300
@@ -127,6 +127,7 @@
   action: ec2_facts
   tags:
     - to-remove
+  ignore_errors: yes

 - name: Tag instance
   ec2_tag_local:
diff -ur --no-dereference configuration.old/playbooks/roles/forum/tasks/deploy.yml configuration/playbooks/roles/forum/tasks/deploy.yml
--- configuration.old/playbooks/roles/forum/tasks/deploy.yml	2018-10-01 20:15:45.912763383 +0300
+++ configuration/playbooks/roles/forum/tasks/deploy.yml	2018-10-01 17:10:40.168715394 +0300
@@ -70,6 +70,7 @@
   tags:
     - migrate
     - migrate:db
+  ignore_errors: yes

 - name: rebuild elasticsearch indexes
   command: "{{ forum_code_dir }}/bin/rake search:rebuild_index"
diff -ur --no-dereference configuration.old/playbooks/roles/git_clone/tasks/main.yml configuration/playbooks/roles/git_clone/tasks/main.yml
--- configuration.old/playbooks/roles/git_clone/tasks/main.yml	2018-10-01 20:15:45.916763383 +0300
+++ configuration/playbooks/roles/git_clone/tasks/main.yml	2018-10-01 19:06:45.020745490 +0300
@@ -71,9 +71,9 @@
     - install
     - install:code

-- name: Checkout code over https
+- name: Checkout code over http
   git:
-    repo: "https://{{ item.DOMAIN }}/{{ item.PATH }}/{{ item.REPO }}"
+    repo: "http://{{ item.DOMAIN }}/{{ item.PATH }}/{{ item.REPO }}"
     dest: "{{ item.DESTINATION }}"
     version: "{{ item.VERSION }}"
     depth: 1
diff -ur --no-dereference configuration.old/playbooks/roles/mongo_2_6/defaults/main.yml configuration/playbooks/roles/mongo_2_6/defaults/main.yml
--- configuration.old/playbooks/roles/mongo_2_6/defaults/main.yml	2018-10-01 20:14:32.508763066 +0300
+++ configuration/playbooks/roles/mongo_2_6/defaults/main.yml	2018-10-01 13:46:33.148662474 +0300
@@ -13,7 +13,7 @@
 mongo_user: mongodb

 MONGODB_APT_KEY: "7F0CEB10"
-MONGODB_APT_KEYSERVER: "keyserver.ubuntu.com"
+MONGODB_APT_KEYSERVER: "hkp://keyserver.ubuntu.com:80"
 MONGODB_REPO: "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"

 # Vars Meant to be overridden
diff -ur --no-dereference configuration.old/playbooks/roles/mongo_3_0/defaults/main.yml configuration/playbooks/roles/mongo_3_0/defaults/main.yml
--- configuration.old/playbooks/roles/mongo_3_0/defaults/main.yml	2018-10-01 20:15:45.916763383 +0300
+++ configuration/playbooks/roles/mongo_3_0/defaults/main.yml	2018-10-01 13:46:33.148662474 +0300
@@ -16,7 +16,7 @@

 MONGODB_REPO: "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.0 multiverse"
 MONGODB_APT_KEY: "7F0CEB10"
-MONGODB_APT_KEYSERVER: "keyserver.ubuntu.com"
+MONGODB_APT_KEYSERVER: "hkp://keyserver.ubuntu.com:80"

 mongodb_debian_pkgs:
   - "mongodb-org={{ mongo_version }}"
diff -ur --no-dereference configuration.old/playbooks/roles/rabbitmq/tasks/main.yml configuration/playbooks/roles/rabbitmq/tasks/main.yml
--- configuration.old/playbooks/roles/rabbitmq/tasks/main.yml	2018-10-01 20:15:45.920763383 +0300
+++ configuration/playbooks/roles/rabbitmq/tasks/main.yml	2018-10-01 13:46:33.148662474 +0300
@@ -301,7 +301,7 @@
 #
 - name: Install admin tools
   get_url:
-    url: "http://localhost:{{ rabbitmq_management_port }}/cli/rabbitmqadmin"
+    url: "https://github.com/rabbitmq/rabbitmq-management/blob/rabbitmq_v3_6_9/bin/rabbitmqadmin"
     dest: "/usr/local/bin/rabbitmqadmin"
   tags:
     - "install"
diff -ur --no-dereference configuration.old/util/install/ansible-bootstrap.sh configuration/util/install/ansible-bootstrap.sh
--- configuration.old/util/install/ansible-bootstrap.sh	2018-10-01 20:15:45.924763383 +0300
+++ configuration/util/install/ansible-bootstrap.sh	2018-10-01 13:46:33.148662474 +0300
@@ -48,7 +48,7 @@
 ANSIBLE_DIR="/tmp/ansible"
 CONFIGURATION_DIR="/tmp/configuration"
 EDX_PPA="deb http://ppa.edx.org precise main"
-EDX_PPA_KEY_SERVER="keyserver.ubuntu.com"
+EDX_PPA_KEY_SERVER="hkp://keyserver.ubuntu.com:80"
 EDX_PPA_KEY_ID="B41E5E3969464050"

 cat << EOF
diff -ur --no-dereference configuration.old/util/vpc-tools/abbey.py configuration/util/vpc-tools/abbey.py
--- configuration.old/util/vpc-tools/abbey.py	2018-10-01 20:15:45.924763383 +0300
+++ configuration/util/vpc-tools/abbey.py	2018-10-01 13:46:33.148662474 +0300
@@ -331,7 +331,7 @@
 PIP_VERSION="8.1.2"
 SETUPTOOLS_VERSION="24.0.3"
 EDX_PPA="deb http://ppa.edx.org precise main"
-EDX_PPA_KEY_SERVER="keyserver.ubuntu.com"
+EDX_PPA_KEY_SERVER="hkp://keyserver.ubuntu.com:80"
 EDX_PPA_KEY_ID="B41E5E3969464050"

 cat << EOF
EOPATCH'

cd /var/tmp
git clone https://github.com/edx/configuration
cd configuration
git checkout $OPENEDX_RELEASE
cd /var/tmp
patch -p0 < edx.patch
cd
wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/sandbox.sh
sed -i 's/git clone/#git clone/g' sandbox.sh
cat sandbox.sh | bash
rm ~/sandbox.*
sudo rm /var/tmp/edx.patch
