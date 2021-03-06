# Alcher5_infra
Alcher5 Infra repository

## Домашнее задание к лекции №13

### Выполненные действия

- Установлен **Vagrant**, описана локальная инфраструктура через `Vagrantfile`

- Написан провижининг для `dbserver` и `appserver`

- Переделан из файла в шаблон (добавлено .j2 расширение) unit файл `puma.service` , для того чтобы его параметризировать.

- Добавлена переменная `extra_vars` в `Vagrantfile`, которая имеет наивысший приоритет и переопределяет переменную `deploy_user` из **Ansible** и с ее помощью пользователь задается в едином месте.

- Задание со **`*`**: В переменную `extra_vars` добавлены настройки для **Nginx** по проксированию приложения на 80 порту.

- Добавлена **Melecule**, тесты на **testinfra** и протестирована роль `db`



## Домашнее задание к лекции №12

### Выполненные действия

- Перенесены плейбуки прошлого ДЗ в раздельные роли в соответсвии со структурой принятой в Ansible Galaxy

- Описано два окружения `stage` и `prod`. Определены переменные групп хостов этих окружений.

- Организована отдельная директория `playbooks` согласно **best practices**

- Поправлены шаблоны `app` и `db` используемые **Packer**

- Проверена сборка окружений `stage` и `prod`

- Добавлена роль **nginx**

- Добавлен `users.yml` для создания пользователей, данные внутри зашифрованы с помощью **ansible-vault**

- Задание со **`*`**: Насртроены динамические `inventory.json` для окружения `stage` и `prod`

- Задание со **`**`**: Добавлены проверки для **TravisCI**


## Домашнее задание к лекции №11

### Выполненные действия

- Cоздан плейбук `reddit_app.yml` с одним сценарием и управляемый опциями `--limit` и `--tags`

- Создан плейбук `reddit_app2.yml` с тремя сценариями в котором объеденины задачи по тегам `db-tag` , `app-tag` и `deploy-tag`. (доустанавливается GIT)

- Сценарии вынесены в отдельные плейбуки `app.yml` `db.yml` `deploy.yml` и для
удобства запуска объединены в главном плейбуке `site.yml`

- В задании со `*` из прошлого ДЗ взят inventory.json и значение передано  переменной `db_host` внутреннего ip базы данных для использования в провижининге.

- Изменен provision в **Packer** заменены bash скрипты на **Ansible** плейбуки, поправлена конфигурация в `app.json` и `db.json`. Сделан билд с использонванием нового провижинера.

- Запущена и проверена сборка окружения **terraform/stage** на основе новых созданых образов **app** и **db** . Приложение деплоится и работает.



## Домашнее задание к лекции №10

### Выполненные действия

- Написан ansible-playbook clone.yml и inventory файл;

- На VM app была применена комманда, которая клонировала репозиторий с **github**;

- Была применена команда удаления репозитория **reddit** через модуль `-m command -a 'rm -rf ~/reddit' `

- и выполнен плейбук `ansible-playbook clone.yml`

- в результате измения были применены к одному пункту **Clone repo** , так как `~/reddit` был удален предыдущей командой;

- Добавлен `inventory.json` в динамическом формате;

## Домашнее задание к лекции №9

### Выполненные действия

- Создан образ с приложением: `packer build -var-file="./packer/variables.json" ./packer/app.json`

- Создан образа с базой данных: `packer build -var-file="./packer/variables.json" ./packer/db.json`

- Созданы terraform модули: **app, db, vpc**;

- Созданы окружения: **prod, stage**;

- Добавлено использование внешнего backend;

- Добавлен deploy приложения: `modules/db/files` `modules/app/files`

## Домашнее задание к лекции №8

### Выполненные действия

- Подготовлена конфигурация **Terraform**;

- Cоздан инстанc в **Yandex Cloud** с **Reddit app**;

- Настроен **load-balancer** для одного и для двух инстансов;

## Домашнее задание к лекции №7

### Выполненные действия

- Создана ветка **packer-base** в репозитории;

- Скрипты с прошлого ДЗ перенесены в папку **config-scripts**;

- Установлен **Packer**;

- Создан сервисный аккаунт **packeruser**, делегированы права, создан и экспортирован **account-key**;

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

Создан **bake** образ, с установленным приложением **reddit**;

Создан скрипт `create-reddit-vm.sh` для создания машины с помощью Yandex.Cloud CLI ;

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
