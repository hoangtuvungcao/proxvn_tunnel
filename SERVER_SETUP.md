# 🖥️ ProxVN Server Setup Guide

**Hướng dẫn chi tiết setup ProxVN Server từ đầu**

---

## 📋 Yêu Cầu Hệ Thống

### Phần Cứng Tối Thiểu:
- **CPU:** 1 core (2+ cores khuyến nghị)
- **RAM:** 512MB (1GB+ khuyến nghị)
- **Storage:** 100MB cho binary + logs
- **Network:** Public IP với 2 ports mở:
  - `8882` - Control plane (TCP)
  - `10000-65535` - Dynamic port allocation

### Hệ Điều Hành:
- ✅ **Linux** (Ubuntu 20.04+, Debian 10+, CentOS 7+)
- ✅ **Windows Server** (2016+, 2019, 2022)
- ✅ **macOS** (Intel/M1)

### Requirements:
- Go 1.21+ (nếu build từ source)
- Domain name (optional, cho HTTP tunneling)
- SSL Certificate (optional, cho HTTPS)

---

## 🚀 Bước 1: Download Server Binary

### Linux:
```bash
# Download
wget https://ed5d08.vutrungocrong.fun/downloads/proxvn-linux-server
chmod +x proxvn-linux-server

# Di chuyển vào /usr/local/bin
sudo mv proxvn-linux-server /usr/local/bin/proxvn-server
```

### Windows:
```powershell
# Download
Invoke-WebRequest -Uri "https://ed5d08.vutrungocrong.fun/downloads/proxvn-windows-server.exe" -OutFile "proxvn-server.exe"

# Di chuyển vào C:\Program Files\ProxVN\
New-Item -Path "C:\Program Files\ProxVN" -ItemType Directory -Force
Move-Item proxvn-server.exe "C:\Program Files\ProxVN\"
```

---

## ⚙️ Bước 2: Cấu Hình Server

### 2.1. Tạo File Config (Optional)

```bash
# Linux/macOS
mkdir -p /etc/proxvn
nano /etc/proxvn/config.env
```

```powershell
# Windows
New-Item -Path "C:\ProgramData\ProxVN" -ItemType Directory -Force
notepad "C:\ProgramData\ProxVN\config.env"
```

**Nội dung `config.env`:**
```bash
# Server Port
SERVER_PORT=8882

# HTTP Tunneling (Optional)
HTTP_DOMAIN=vutrungocrong.fun
HTTP_PORT=443

# Database (Optional - for user management)
DATABASE_URL=postgresql://user:pass@localhost/proxvn
```

### 2.2. Firewall Configuration

#### Linux (UFW):
```bash
# Allow control port
sudo ufw allow 8882/tcp

# Allow tunnel ports
sudo ufw allow 10000:65535/tcp
sudo ufw allow 10000:65535/udp

# Allow HTTP/HTTPS (if using HTTP tunneling)
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

#### Windows Firewall:
```powershell
# Allow control port
New-NetFirewallRule -DisplayName "ProxVN Control" -Direction Inbound -Protocol TCP -LocalPort 8882 -Action Allow

# Allow tunnel ports
New-NetFirewallRule -DisplayName "ProxVN Tunnels TCP" -Direction Inbound -Protocol TCP -LocalPort 10000-65535 -Action Allow
New-NetFirewallRule -DisplayName "ProxVN Tunnels UDP" -Direction Inbound -Protocol UDP -LocalPort 10000-65535 -Action Allow

# HTTP/HTTPS
New-NetFirewallRule -DisplayName "ProxVN HTTP" -Direction Inbound -Protocol TCP -LocalPort 80,443 -Action Allow
```

---

## 🔐 Bước 3: SSL/TLS Certificate Setup

### Option 1: Cloudflare Origin Certificate (Khuyến Nghị)

**Ưu điểm:**
- ✅ Miễn phí
- ✅ Tự động renew
- ✅ Wildcard support (`*.yourdomain.com`)
- ✅ Valid 15 years

**Cách tạo:**

1. Login vào Cloudflare Dashboard
2. Chọn domain của bạn
3. **SSL/TLS** → **Origin Server**
4. Click **Create Certificate**
5. Chọn:
   - **Hostnames:** `*.yourdomain.com, yourdomain.com`
   - **Certificate Validity:** 15 years
6. Click **Create**

7. **Lưu certificate:**

```bash
# Linux/macOS
sudo mkdir -p /etc/proxvn/certs
sudo nano /etc/proxvn/certs/wildcard.crt  # Paste Origin Certificate
sudo nano /etc/proxvn/certs/wildcard.key  # Paste Private Key
sudo chmod 600 /etc/proxvn/certs/wildcard.key
```

```powershell
# Windows
New-Item -Path "C:\ProgramData\ProxVN\certs" -ItemType Directory -Force
notepad "C:\ProgramData\ProxVN\certs\wildcard.crt"  # Paste Origin Certificate
notepad "C:\ProgramData\ProxVN\certs\wildcard.key"  # Paste Private Key
```

### Option 2: Let's Encrypt (Auto-Renew)

```bash
# Install certbot
sudo apt install certbot python3-certbot-dns-cloudflare  # Ubuntu/Debian
sudo yum install certbot python3-certbot-dns-cloudflare  # CentOS

# Get wildcard certificate
sudo certbot certonly --dns-cloudflare \
  --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
  -d '*.yourdomain.com' -d 'yourdomain.com'

# Copy certificates
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem /etc/proxvn/certs/wildcard.crt
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem /etc/proxvn/certs/wildcard.key
```

### Option 3: Self-Signed (Dev/Test Only)

Server tự động tạo self-signed cert nếu không tìm thấy certificate.

---

## 🎯 Bước 4: Chạy Server

### 4.1. Test Run (Foreground)

```bash
# Linux/macOS
proxvn-server

# Windows
cd "C:\Program Files\ProxVN"
.\proxvn-server.exe
```

**Output mong đợi:**
```
[server] 🚀 ProxVN Server v4.0.0
[server] 📡 Control plane listening on :8882
[server] 🌐 HTTP proxy enabled on *.vutrungocrong.fun:443
[server] ✅ Server ready!
```

### 4.2. Production Run (Background)

#### Linux - Systemd Service:

```bash
# Tạo service file
sudo nano /etc/systemd/system/proxvn.service
```

**Nội dung:**
```ini
[Unit]
Description=ProxVN Tunnel Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/usr/local/bin
ExecStart=/usr/local/bin/proxvn-server
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

# Security
NoNewPrivileges=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

**Start service:**
```bash
sudo systemctl daemon-reload
sudo systemctl enable proxvn
sudo systemctl start proxvn

# Check status
sudo systemctl status proxvn

# View logs
sudo journalctl -u proxvn -f
```

#### Windows - NSSM Service:

```powershell
# Download NSSM
Invoke-WebRequest -Uri "https://nssm.cc/release/nssm-2.24.zip" -OutFile "nssm.zip"
Expand-Archive nssm.zip
.\nssm\win64\nssm.exe install ProxVN "C:\Program Files\ProxVN\proxvn-server.exe"

# Start service
Start-Service ProxVN

# Check status
Get-Service ProxVN
```

#### Docker:

```bash
# Clone repo
git clone https://github.com/hoangtuvungcao/proxvn_tunnel
cd proxvn_tunnel

# Build image
docker build -t proxvn-server -f Dockerfile.server .

# Run container
docker run -d \
  --name proxvn \
  --restart unless-stopped \
  -p 8882:8882 \
  -p 10000-10100:10000-10100 \
  -v /etc/proxvn/certs:/app/certs \
  proxvn-server
```

---

## 🔍 Bước 5: Verify Server

### 5.1. Check Ports

```bash
# Linux
sudo netstat -tlnp | grep 8882
sudo ss -tlnp | grep 8882

# Windows
netstat -ano | findstr :8882
```

### 5.2. Test Connection

```bash
# From client machine
telnet your-server-ip 8882

# Or
nc -zv your-server-ip 8882
```

### 5.3. Check Certificate

```bash
echo | openssl s_client -connect your-server-ip:8882 -showcerts
```

---

## 📊 Bước 6: Monitoring & Logs

### View Logs:

#### Linux (Systemd):
```bash
# Real-time logs
sudo journalctl -u proxvn -f

# Last 100 lines
sudo journalctl -u proxvn -n 100

# Today's logs
sudo journalctl -u proxvn --since today
```

#### Windows (Event Viewer):
```powershell
# PowerShell logs
Get-EventLog -LogName Application -Source ProxVN -Newest 50
```

#### Docker:
```bash
docker logs -f proxvn
```

### Monitor Resources:

```bash
# Linux
top -p $(pgrep proxvn-server)
htop -p $(pgrep proxvn-server)

# Windows
Get-Process proxvn-server | Select-Object CPU, WorkingSet
```

---

## 🔐 Bước 7: Security Recommendations

### 7.1. Enable Firewall Rules

```bash
# Only allow specific IPs (optional)
sudo ufw allow from 1.2.3.4 to any port 8882
```

### 7.2. Fail2Ban (Optional)

```bash
# Install
sudo apt install fail2ban

# Create filter
sudo nano /etc/fail2ban/filter.d/proxvn.conf
```

```ini
[Definition]
failregex = \[server\] failed authentication from <HOST>
ignoreregex =
```

### 7.3. Rate Limiting

ProxVN đã có built-in rate limiting:
- Registration: 5/minute per IP
- HTTP requests: 100/second per IP
- UDP sessions: 50/minute per IP

---

## 🌐 Bước 8: DNS Configuration (Cho HTTP Tunneling)

### Cloudflare Setup:

1. Add A record:
   ```
   Type: A
   Name: @
   Value: YOUR_SERVER_IP
   Proxy: ✅ Enabled
   ```

2. Add wildcard record:
   ```
   Type: A
   Name: *
   Value: YOUR_SERVER_IP
   Proxy: ✅ Enabled
   ```

3. SSL/TLS Settings:
   - Encryption Mode: **Full (strict)**
   - Always Use HTTPS: **ON**
   - Minimum TLS Version: **TLS 1.2**

---

## 🔧 Bước 9: Advanced Configuration

### Environment Variables:

```bash
# Server config
export SERVER_PORT=8882
export HTTP_DOMAIN=yourdomain.com
export HTTP_PORT=443

# Database (optional)
export DATABASE_URL=postgresql://user:pass@localhost/proxvn

# Security
export RATE_LIMIT_ENABLED=true
export MAX_TUNNELS_PER_IP=10

# Logging
export LOG_LEVEL=info  # debug, info, warn, error
export LOG_FILE=/var/log/proxvn/server.log
```

---

## 📈 Performance Tuning

### Linux Kernel Parameters:

```bash
sudo nano /etc/sysctl.conf
```

```ini
# Increase connection tracking
net.netfilter.nf_conntrack_max = 262144

# TCP tuning
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 4096

# File descriptors
fs.file-max = 65536
```

```bash
sudo sysctl -p
```

### Ulimit:

```bash
# Add to /etc/security/limits.conf
* soft nofile 65536
* hard nofile 65536
```

---

## 🆘 Troubleshooting

### Server không start:

```bash
# Check port đã bị dùng
sudo lsof -i :8882

# Check permissions
ls -l /etc/proxvn/certs/

# Check logs
sudo journalctl -u proxvn -n 50
```

### Certificate errors:

```bash
# Verify certificate
openssl x509 -in /etc/proxvn/certs/wildcard.crt -text -noout

# Check expiry
openssl x509 -in /etc/proxvn/certs/wildcard.crt -noout -enddate
```

### High CPU/Memory:

```bash
# Check active tunnels
sudo systemctl status proxvn

# Restart service
sudo systemctl restart proxvn
```

---

## 📚 Next Steps

✅ Server setup xong!

**Tiếp theo:**
- 📖 [Client Setup Guide](CLIENT_GUIDE.md) - Hướng dẫn sử dụng client
- 🔐 [Security Best Practices](SECURITY.md)
- 🏠 [Self-Hosting FAQ](wiki/FAQ.md)

---

## 💬 Support

- 🐛 **Issues:** [GitHub Issues](https://github.com/hoangtuvungcao/proxvn_tunnel/issues)
- 📧 **Email:** trong20843@gmail.com
- 📖 **Docs:** [GitHub Wiki](https://github.com/hoangtuvungcao/proxvn_tunnel/wiki)

---

<div align="center">

**Server Setup Complete! 🎉**

[⬆ Back to Top](#️-proxvn-server-setup-guide)

</div>
