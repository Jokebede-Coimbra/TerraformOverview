terraform{

}
# Este bloco é usado para configurar o provedor de nuvem que você está usando, como AWS, Azure, Google Cloud, etc..
provider "aws" {
 region = "us-east-1"

}

# Ele é usado para definir os recursos que você deseja criar, como instâncias de servidor, redes, bancos de dados, etc.
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

// Este bloco é usado para consultar informações existentes na sua infraestrutura ou em serviços externos, como imagens de máquinas virtuais disponíveis, informações de rede, etc.
data "aws_ami" "web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Ele permite encapsular configurações e funcionalidades para facilitar a reutilização e a modularidade do código.
module "web_server" {
  source = "./modules/web_server"
  instance_count = 3
}


# Este bloco é usado para definir variáveis que você pode usar em seu arquivo de configuração Terraform.
variable "region" {
  type    = string
  default = "us-east-1"
}


#  Este bloco é usado para definir valores que você deseja expor após a execução do Terraform, como endereços IP, IDs de recursos, etc. 
output "instance_ip" {
  value = aws_instance.web.public_ip
}

# Este bloco é usado para definir variáveis locais dentro do seu arquivo de configuração Terraform. 
# Essas variáveis locais são úteis para armazenar valores que são usados várias vezes em seu arquivo de configuração, mas que você não deseja repetir várias vezes.
locals {
  instance_type = "t2.micro"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}



