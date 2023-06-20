# WikiAWS
Repositório de IaC criado para subir uma aplicação [wiki.js](https://js.wiki/) em um ambiente AWS.

**Stack**
- Networking (VPC, Subnet, Gateways)
- Wiki.js (EC2)
- Postgres (RDS)

## Deploy da aplicação

1. Necessário que a máquina tenha instalado:
   - Terraform (Versão testada: v1.4.6)
   - AWS CLI (Versão testada: 2.11.18)


2. Configurar o AWS CLI com as credenciais da conta. Basta executar o comando `aws configure` no terminal.

3. Executar o comando `terraform init` no diretório do projeto.

4. Exportar variáveis de ambiente, responsáveis por armazenar informações sensíveis.

   - `export TF_VAR_db_user=`{Usuário do banco de dados}
   - `export TF_VAR_db_password=`{Senha do banco de dados}
   - `export TF_VAR_wiki_pubkey=`{Public key para acesso via ssh}

5. Execute o comando `terraform plan` para validar o deploy.

6. Execute o comando `terraform apply` para realizar o deploy.

7. Para remover a aplicação e toda a sua infraestrutura, basta utilizar o comando `terraform destroy`.

## Acessando a aplicação

Para acessar a aplicação, basta copiar o IP público da EC2 que está rodando a aplicação wiki.js e acessar esse IP junto com a porta da aplicação. Por exemplo, se o IP público da instância é 54.100.0.10 e a porta utilizada pelo wiki.js é a porta 3000, basta colar o seguinte endereço no navegador: `54.100.0.10:3000`.

Por padrão, a porta utilizada é a porta 3000.




<!-- # WikiAWS
Repositorio de Iaac criado para subir uma aplicacao [wiki.js](https://js.wiki/) em um ambiente AWS.

**Stack**
- Networking (VPC, Subnet, Gateways)
- Wiki.js (EC2) 
- Postgres (RDS) 

## Deploy da aplicacao

1. Nescessario que a maquina tenha instalado:
    - Terraform (Versao testada: v1.4.6)
    - AWS CLI (Versao testada: 2.11.18)
  

2. Configurar o AWS CLI com as credenciais da conta, basta executar no terminal o comando ```aws configure```.

3. Executar o comando ```terraform init``` no diretorio do projeto.

4. Exportar variaveis de ambiente, reponsaveis por amazenar informacoes sensiveis.

    - ```export TF_VAR_db_user=```{Usuario do banco de dados}
    - ```export TF_VAR_db_password=```{Senha do banco de dados}
    - ``` export TF_VAR_wiki_pubkey=```{Public key para acesso via ssh}

5. Execute o comando ```terraform plan``` para validar o deploy.

6. Execute o comando ```terraform apply``` para realizar deploy.

7. Para remover a aplicacao e toda sua infraestrutura, basta utilizar o comando ```terraform destroy```.

## Acessando a aplicacao

Para acessar a aplicacao basta copiar o ip publico da EC2 que esta rodando a aplicacao wiki.js e acessar esse ip junto com a porta da aplicacao. Por exemplo, se o ip publico da instancia e 54.100.0.10 e porta utilizada pelo wiki.js e a por 300. Basta colar o seguinte endereco no browser 54.100.0.10:3000.

Por padrao a porta utilizada e a porta 3000. -->
