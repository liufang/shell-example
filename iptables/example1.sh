#!/bin/bash
# iptables for normal web sever
# you should modify it according to your purpose
# by Jarett
# 2012.9.3

echo "clean all rules before"
iptables -F
iptables -X

echo "setting up default rules"
iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

echo "setting up input chain"
/sbin/iptables -A INPUT -i lo -j ACCEPT #allow local address
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT #allow exist connection
#/sbin/iptables -A INPUT -s 1.2.3.4 -j ACCEPT #while list
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT #ssh
/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT #http
/sbin/iptables -A INPUT -p udp --sport 53  -j ACCEPT #DNS
/sbin/iptables -A INPUT -p udp --sport 123 -j ACCEPT #ntp
/sbin/iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT   #ping
/sbin/iptables -P INPUT DROP

echo "setting up output chain"
/sbin/iptables -A OUTPUT -o lo -j ACCEPT #allow local address
/sbin/iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT #allow exist connection
/sbin/iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT #yum
/sbin/iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT #https
/sbin/iptables -A OUTPUT -p udp --dport 53  -j ACCEPT #DNS
/sbin/iptables -A OUTPUT -p udp --dport 123 -j ACCEPT #ntp
/sbin/iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT #ping
/sbin/iptables -P OUTPUT DROP 

/sbin/service iptables save
iptables -vnL
