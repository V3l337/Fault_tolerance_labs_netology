# Задание 1

### Описание действий

1. Установил на Windows terraform
2. Добавил PATH: export PATH=$PATH:C:\Users\valen\terraform.exe
3. Создал файл terraform.rc
```yaml
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = &#91;"registry.terraform.io/*/*"]
  }
  direct {
    exclude = &#91;"registry.terraform.io/*/*"]
  }
}
```
4. terraform init
5. Создал файл main.tf

6. Создал файл varible.tf

7. Создал файл terraform.tfvars
   
8. Создал файл cloud-conf.yaml
    
9. Создал файл outputs.tf
