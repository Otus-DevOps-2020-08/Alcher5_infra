# Alcher5_infra
Alcher5 Infra repository
## Домашние задание к лекции №7

### Выполненные действия

- Создана ветка **packer-base** в репозитории;

- Скрипты с прошлого ДЗ перенесены в **config-scripts**;

- Установлен **Packer**;

- Создан сервисный аккаунт **packeruser**, делегированы права,
создан и экспортирован **account-key**;

- Создан шаблон **ubuntu16.json** для **packer**;

- Созданы скрипты для **provision** образа;

- Выполнена проверка шаблона и запущена сборка;

- Исправлена ошибка, из-за которой сборка образа завершалась на:

```
Build 'yandex' errored: Failed to find instance ip address: instance has no one IPv4 external address.
```
- Создана ВМ на основе собранного образа;

- Установлено и проверено приложение **reddit**;

- Переменные
`service_account_key_file`, `folder_id` и `source_image_family`
вынесены в отдельный файл **variables.json**;

- Добавлены дополнительные опции:
`zone`, `preemptible`;

( Создан **bake** образ, с установленным приложением **reddit**; )

( Создан скрипт `create-reddit-vm.sh` для создания машины с помощью cli; )

## Домашнее задание к лекции №6

testapp_IP = 84.201.133.117

testapp_port = 9292

## Команда создания инстанса

```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./startup.yml
```

## Домашнее задание к лекции №5

### Адреса для подключения:

bastion_IP = 178.154.224.229

someinternalhost_IP = 10.130.0.16

### Проверено сквозное подключение с помощью SSH Agent Forwarding (опция -A):

**localworksation** -> **bastion** -> **someinternalhost**
```
$ ssh-add ~/.ssh/appuser
$ ssh -i ~/.ssh/appuser -A appuser@178.154.224.229
appuser@bastion:~$ ssh 10.132.0.16
```

### Самостоятельная проверка нескольких способов подключения от bastion к someinternalhost в одну команду:

#### 1). Использование ключа -J
```ssh -i ~/.ssh/appuser -J appuser@178.154.224.229 appuser@10.130.0.16```

#### 2). Использование ключа -t (Force pseudo-terminal allocation)
```ssh -i ~/.ssh/appuser -At appuser@178.154.224.229 ssh appuser@10.130.0.16```

#### 3). Настройкой в ~/.ssh/config на локальной машине:
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
#### После правки конфига, вход осуществляется командой:
```ssh someinternalhost```


#### Реализовано использование валидного сертификата (с помощью sslip.io / xip.io и Let’s Encrypt) для панели управления VPN-сервера:

https://178.154.224.229.sslip.io
