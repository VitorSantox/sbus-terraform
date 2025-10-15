##🌍 Um pouco sobre Terraform


O Terraform é uma ferramenta de Infraestrutura como Código (IaC) usada para provisionar e gerenciar recursos de infraestrutura de forma declarativa.
Com ele, é possível criar e manter ambientes completos — por exemplo:

- Provisionar um cluster Kubernetes (AKS, GKE, EKS)

- Criar um banco de dados PostgreSQL

- Gerar um Key Vault (Azure)

- Subir máquinas virtuais (VMs)

- Configurar redes, buckets, storage accounts, e muito mais.

Em resumo: Terraform = código + estado + automação.
Você descreve como quer que a infraestrutura seja, e o Terraform cuida do “como fazer”.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#📁 Estrutura típica de arquivos

🧩 main.tf
É o arquivo principal, onde geralmente se orquestra os módulos e recursos que serão criados.
Aqui você pode declarar diretamente os recursos (resource), ou apontar para módulos que contêm os recursos específicos.

💡-Pense no main.tf como o “roteador” do seu projeto — ele conecta as peças (módulos) e define a lógica principal da infraestrutura.

Exemplo simples:
module "network" {
  source = "./modules/network"
  vnet_name = var.vnet_name
}


🧱 Módulos
Dentro do diretório modules/, cada módulo contém seus próprios arquivos (main.tf, variables.tf, outputs.tf) — eles são como componentes reutilizáveis da infraestrutura.
💡-Modularizar facilita a reutilização e padronização entre ambientes (dev, stg, prod).


📤 outputs.tf
Define saídas (outputs), ou seja, valores que o Terraform retorna ao final do apply.

💡-Os outputs são úteis para integrar módulos entre si ou exportar dados para outras ferramentas (ex: Ansible, CI/CD).

Exemplo: se você provisiona uma VM, pode querer saber o nome, IP ou ID dela.
output "vm_name" {
  value = azurerm_linux_virtual_machine.example.name
}


☁️ provider.tf
Arquivo que configura o provedor de nuvem (Azure, AWS, GCP etc).
É aqui que o Terraform entende onde e como aplicar os recursos.

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

💡-Cada provedor tem suas credenciais e configuração próprias.
Em pipelines, prefira service principals e service connections em vez de credenciais fixas.


⚙️ variables.tf e terraform.tfvars

Esses dois trabalham juntos para gerenciar variáveis.

variables.tf: define o nome, tipo e descrição de cada variável.

terraform.tfvars: define os valores reais dessas variáveis.

Exemplo (variables.tf):

variable "location" {
  type        = string
  description = "Região onde os recursos serão criados"
}


Exemplo (terraform.tfvars):

location = "eastus"


💡 Insight:

Sempre declare suas variáveis em variables.tf (para documentação e validação)
e sobrescreva os valores em terraform.tfvars (ou via CLI em -var-file).


🚀 Conclusão

Resumindo o raciocínio:
| Arquivo            | Função principal                                | Insight rápido                           |
| ------------------ | ----------------------------------------------- | ---------------------------------------- |
| `main.tf`          | Controla o que será criado e referencia módulos | O “roteador” da infra                    |
| `provider.tf`      | Define a conexão com a nuvem                    | Um por provedor, cuidado com credenciais |
| `variables.tf`     | Declara variáveis de entrada                    | Pense como “contrato de entrada”         |
| `terraform.tfvars` | Define valores concretos                        | Um por ambiente (dev, stg, prod)         |
| `outputs.tf`       | Expõe resultados do apply                       | Conecta módulos e automações             |
| `modules/`         | Contém infra modularizada                       | Reuso e padrão entre ambientes           |

💬 Dica SRE:
Organize seus ambientes com pastas separadas, ex:
/environments
  /dev
    main.tf
    terraform.tfvars
  /prod
    main.tf
    terraform.tfvars
Sempre execute:
terraform fmt && terraform validate
antes do terraform plan.
Isso garante código padronizado e evita erros simples antes do provisionamento.