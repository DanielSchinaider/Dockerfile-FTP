# Utilizando como base uma imagem do SO Ubuntu 20:04
FROM ubuntu:20.04

# Instalando e o servico FTP (vsftpd), o editor de texto (VIM)
# e o servico de controle do sistema (systemctl)
RUN apt-get -q update && \
    apt-get install -q -y vsftpd && \
    apt-get install -q -y vim && \
    apt-get install -q -y systemctl

# Removendo o arquivo de configuracao padrao do vsftpd
RUN rm -r /etc/vsftpd.conf

# Copiando o arquivo de configuracao modificado
# para o local do padrao do vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# Criando um diretorio publico para acesso de usuarios
# anonimos
RUN mkdir /var/ftp && \
    mkdir /var/ftp/pub && \
    mkdir /var/ftp/pub/upload

# Definindo o proprietario do diretorio como root
RUN chown ftp:root /var/ftp/pub/upload

# Atribuindo todas as permissoes ao diretorio
RUN chmod 0777 /var/ftp/pub/upload
