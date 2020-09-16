# Alcher5_infra
Alcher5 Infra repository

Homework №5

bastion_IP = 178.154.224.229
someinternalhost_IP = 10.130.0.16

Проверено сквозное подключение с Bastion host к серверу по внтуреннему адресу с помощью SSH Agent Forwarding (опция -A):
localworksation -> bastion -> someinternalhost

Самостоятельная проверка нескольких способов подключения от bastion к someinternalhost в одну команду:

1). Использование ключа -J
ssh -i ~/.ssh/appuser -J appuser@178.154.224.229 appuser@10.130.0.16

2). Использование ключа -t (Force pseudo-terminal allocation)
ssh -i ~/.ssh/appuser -At appuser@178.154.224.229 ssh appuser@10.130.0.16

3). Настройкой в ~/.ssh/config на локальной машине:

Host bastion
    HostName 178.154.224.229
    User appuser
    IdentityFile ~/.ssh/appuser

Host someinternalhost
    HostName 10.130.0.16
    User appuser
    IdentityFile ~/.ssh/appuser
    ForwardAgent yes
    ProxyJump bastion

После правки конфига, вход осуществляется командой:
ssh someinternalhost
