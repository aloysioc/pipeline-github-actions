resource "aws_key_pair" "key" {
  key_name   = "CE-Mapfre"
  public_key = file("./CE-Mapfre.pub")
}

resource "aws_instance" "ce_instance" {
  ami                         = var.ami_win_virg # ID da AMI do RHEL 9
  instance_type               = "t2.micro"       # Tipo de instância
  key_name                    = "CE-Mapfre"      # Nome da chave SSH
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_ids]
  iam_instance_profile        = "SSM-Access" # Role de acesso
  associate_public_ip_address = true         # Habilitar IP público  

  # Instalação do agente SSM após máquina provisionada
  user_data = <<-EOF
              <powershell>
              Set-NetFirewallrule -DisplayName 'Windows Remote Management (HTTP-In)' -RemoteAddress Any | where {($_.Profile -eq 'Public')};
              msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn
              [System.Net.ServicePointManager]::SecurityProtocol = 'TLS12'
              $progressPreference = 'silentlyContinue'
              Invoke-WebRequest https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe -OutFile $env:USERPROFILE\Desktop\SSMAgent_latest.exe
              Start-Process -FilePath $env:USERPROFILE\Desktop\SSMAgent_latest.exe -ArgumentList "/S"
              </powershell>              
              EOF

  tags = {
    Name = "CE-Mapfre-W2K19"
  }
}
