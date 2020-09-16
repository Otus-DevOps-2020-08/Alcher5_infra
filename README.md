# Alcher5_infra
Alcher5 Infra repository

# Домашнее задание к лекции №5

## Адреса для подключения:

bastion_IP = 178.154.224.229

someinternalhost_IP = 10.130.0.16

## Проверено сквозное подключение с помощью SSH Agent Forwarding (опция -A):

**localworksation** -> **bastion** -> **someinternalhost**
```
$ ssh-add ~/.ssh/appuser
$ ssh -i ~/.ssh/appuser -A appuser@178.154.224.229
appuser@bastion:~$ ssh 10.132.0.16
```

## Самостоятельная проверка нескольких способов подключения от bastion к someinternalhost в одну команду:

### 1). Использование ключа -J
```ssh -i ~/.ssh/appuser -J appuser@178.154.224.229 appuser@10.130.0.16```

### 2). Использование ключа -t (Force pseudo-terminal allocation)
```ssh -i ~/.ssh/appuser -At appuser@178.154.224.229 ssh appuser@10.130.0.16```

### 3). Настройкой в ~/.ssh/config на локальной машине:
```
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
```
### После правки конфига, вход осуществляется командой:
```ssh someinternalhost```

## Реализовано использование валидного сертификата (с помощью sslip.io xip.io и Let’s Encrypt) для панели управления VPN-сервера:

https://178.154.224.229.sslip.io
