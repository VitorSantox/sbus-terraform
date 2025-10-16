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
## 💡 O Projeto Prático: Desacoplamento com Azure Service Bus (SBUS)

Este repositório foi criado como um laboratório de SRE/DevOps para provisionar e testar um sistema de mensageria na Azure. O foco principal é entender o conceito de **Desacoplamento de Serviços** e a importância do **Dead-Letter Queue (DLQ)** para a confiabilidade.

### 🗺️ Arquitetura Provisionada

O Terraform orquestra a criação de uma arquitetura de microsserviços básica, com forte separação de responsabilidades (modularidade):

| Módulo/Recurso | Função no Projeto | Ponto de Controle (IaC) |
| :--- | :--- | :--- |
| **`modules/rg`** | **Resource Group (RG)** | A base; contêiner lógico de todos os recursos. |
| **`modules/network`** | **VNet e Subnet** | Cria a rede privada isolada (fundação). |
| **`modules/sbus`** | **Azure Service Bus (Namespace & Queue)** | O serviço de mensageria. Fila principal com **DLQ ativada** (SKU Standard). |
| **`vm_produtor`** | **Worker Produtor (VM)** | Simula o envio de mensagens (pedidos) para o S-Bus. |
| **`vm_consumidor`** | **Worker Consumidor (VM)** | Simula o serviço que processa as mensagens da fila. |

### 🔑 Ponto de Aprendizado em Destaque (SRE/Mensageria)

O módulo **`sbus`** é o coração deste projeto. Ele foi configurado no Tier **Standard** para habilitar o recurso de **DLQ (Dead-Letter Queue)**.

O DLQ é essencial para a **confiabilidade**: se uma mensagem falhar no processamento (por expiração, erro de código, etc.), ela não é descartada; é automaticamente movida para a DLQ. Isso permite que SREs e equipes de suporte inspecionem a mensagem, corrijam a causa raiz e a reprocessem, garantindo que nenhum dado seja perdido no sistema.

### ⚙️ Como Subir a Infraestrutura

1.  **Pré-requisitos:** Instale Terraform e configure suas credenciais da Azure (via `az login` ou Service Principal).
2.  **Variáveis:** Preencha os valores únicos em `terraform.tfvars`.
3.  **Execução:** Na raiz do projeto, execute a sequência de comandos para deploy (após o `init`):
    ```bash
    terraform plan
    terraform apply --auto-approve
    ```
4.  **Destruição (FinOps):** Lembre-se sempre de destruir o ambiente após o uso para evitar custos de recursos ociosos:
    ```bash
    terraform destroy --auto-approve
    ```

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


💡-Sempre declare suas variáveis em variables.tf (para documentação e validação)
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
