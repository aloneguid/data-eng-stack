FROM ubuntu:24.04

# Install OpenSSH Server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Setup User "dev" with password "dev"
RUN useradd -m -s /bin/bash dev && \
    echo 'dev:dev' | chpasswd

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin no' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'PermitEmptyPasswords no' >> /etc/ssh/sshd_config

# Adjust permissions
RUN chown -R dev:dev /home/dev && \
    chmod 700 /home/dev

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D", "-d"]