Ansible-Role: libreswan-vpn
=========

This role builds out a libreswan VPN that can be used to allow both Mac and Windows clients to connect.  It is based on Lin Song's [setup-isec-vpn](https://github.com/hwdsl2/setup-ipsec-vpn) script for Centos.  The primary motivation for moving to a Ansible role rather than just use the script is so I could add multple users rather than just one.

Requirements
------------

This role is written for CentOS 7 (ami-6d1c2007).  I may revisit later and add Ubuntu or AWS Linux.

Role Variables
--------------

The role will run without any variables, but there are a few that you will probably want to set.  The two primary variables that need to be changes are related to the credentials.

     vpn_ipsec_psk: grandmascookies
     vpn_users:
       - { 'username': 'vpnuser','password': 'p@ssw0rd', 'encpasswd': '$1$Xc6iJu8M$syQ.4M2hsXv3qmdNn4K7.0' }

You can encrypt the password for encpassword with OpenSSL.

     openssl passwd -1 p@ssw0rd

Since password are stored in clear text, they should never be checked in to github (without encryption, at least).

For the networks, I use the the blocks listed below.  If they clash with any of your current networks you will probably want to change them.

     vpn_l2tp_net: 192.168.42.0/24                   # Network for l2tp
     vpn_l2tp_local: 192.168.42.1                    # Local l2tp address
     vpn_l2tp_pool: 192.168.42.10-192.168.42.250     # DHCP pool for l2tp
     vpn_xauth_net: 192.168.43.0/24                  # Network for Xauth
     vpn_xauth_pool: 192.168.43.10-192.168.43.250    # DHCP pool for Xauth
     vpn_dns_srv1: 8.8.8.8                           # DNS Server 1
     vpn_dns_srv2: 8.8.4.4                           # DNS Server 2

You 

Dependencies
------------

None

Example Playbook
----------------


     - hosts: all
       become: true
       vars:
          vpn_ipsec_psk: grandmascookies
          vpn_users:
            - { 'username': 'vpnuser','password': 'p@ssw0rd', 'encpasswd': '$1$Xc6iJu8M$syQ.4M2hsXv3qmdNn4K7.0' }
         
       roles:
         - austincloudguru.libreswan-vpn

License
-------

MIT

Author Information
------------------

Mark Honomichl aka [AustinCloudGuru](https://austincloud.guru)
Created in 2016
