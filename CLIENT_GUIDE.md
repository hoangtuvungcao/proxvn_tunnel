# 💻 ProxVN Client Guide

**Hướng dẫn sử dụng ProxVN Client từ cơ bản đến nâng cao**

---

## 📖 Mục Lục

- [Quick Start](#-quick-start-30-giây)
- [Installation](#-installation)
- [Basic Usage](#-basic-usage)
- [Advanced Options](#-advanced-options)
- [Certificate Pinning](#-certificate-pinning)
- [Using Scripts](#-using-scripts)
- [Use Cases](#-use-cases)
- [Troubleshooting](#-troubleshooting)

---

## ⚡ Quick Start (30 Giây)

### Windows:
```powershell
# 1. Download
Invoke-WebRequest -Uri "https://ed5d08.vutrungocrong.fun/downloads/proxvn.exe" -OutFile "proxvn.exe"

# 2. Chạy (ví dụ: web server port 3000)
.\proxvn.exe --proto http 3000

# ✅ Nhận ngay URL: https://xyz789.vutrungocrong.fun
```

### Linux/macOS:
```bash
# 1. Download
wget https://ed5d08.vutrungocrong.fun/downloads/proxvn-linux-client
chmod +x proxvn-linux-client

# 2. Chạy
./proxvn-linux-client --proto http 8080
```

---

## 📥 Installation

### 💾 Download Pre-built Binaries

| Platform | Download Link |
|----------|---------------|
| **Windows** | [proxvn.exe](https://ed5d08.vutrungocrong.fun/downloads/proxvn.exe) |
| **Linux (amd64)** | [proxvn-linux-client](https://ed5d08.vutrungocrong.fun/downloads/proxvn-linux-client) |
| **macOS (M1/M2/M3)** | [proxvn-mac-m1](https://ed5d08.vutrungocrong.fun/downloads/proxvn-mac-m1) |
| **macOS (Intel)** | [proxvn-mac-intel](https://ed5d08.vutrungocrong.fun/downloads/proxvn-mac-intel) |
| **Android (Termux)** | [proxvn-android](https://ed5d08.vutrungocrong.fun/downloads/proxvn-android) |

### 🔧 Build Từ Source

```bash
# Clone repository
git clone https://github.com/hoangtuvungcao/proxvn_tunnel
cd proxvn_tunnel

# Build
cd scripts
./build.bat  # Windows
./build.sh   # Linux/macOS

# Binary sẽ ở bin/proxvn.exe (hoặc proxvn-linux-client)
```

---

## 🎯 Basic Usage

### Syntax Cơ Bản:

```bash
proxvn [OPTIONS] [PORT]
```

### 1️⃣ HTTP Tunneling (Web Development)

**Use case:** Share localhost web app lên Internet với HTTPS tự động

```bash
# Basic
proxvn --proto http 3000
# Output: https://a1b2c3.vutrungocrong.fun → http://localhost:3000

# Với custom host
proxvn --proto http --host 192.168.1.100 --port 8080
# Output: https://xyz789.vutrungocrong.fun → http://192.168.1.100:8080
```

**Examples:**
```bash
# Next.js / React
npm run dev
proxvn --proto http 3000

# Python Flask
flask run --port 5000
proxvn --proto http 5000

# Node.js Express
node server.js  # listening on 8080
proxvn --proto http 8080

# Laravel
php artisan serve --port 8000
proxvn --proto http 8000
```

### 2️⃣ TCP Tunneling (Remote Access)

**Use case:** Expose TCP services (SSH, RDP, databases...)

```bash
# Basic
proxvn 22
# Output: 103.77.246.111:10001 → localhost:22

# SSH Server
proxvn 22
# Connect: ssh user@103.77.246.111 -p 10001

# Windows RDP
proxvn 3389
# Connect: mstsc /v:103.77.246.111:10002

# MySQL Database
proxvn 3306
# Connect: mysql -h 103.77.246.111 -P 10003 -u root -p

# PostgreSQL
proxvn 5432
# Connect: psql -h 103.77.246.111 -p 10004 -U postgres
```

### 3️⃣ UDP Tunneling (Gaming & VoIP)

**Use case:** Game servers, voice chat, P2P apps

```bash
# Basic
proxvn --proto udp 19132
# Output: 103.77.246.111:10005 → localhost:19132

# Minecraft Bedrock Edition
proxvn --proto udp 19132

# Minecraft Java (Query port)
proxvn --proto udp 25565

# Voice Chat / VoIP
proxvn --proto udp 5060

# CS:GO / Source Games
proxvn --proto udp 27015
```

**✅ Security:** UDP traffic được mã hóa AES-GCM 256-bit tự động!

---

## ⚙️ Advanced Options

### Tất Cả Options:

```bash
proxvn [OPTIONS] [PORT]

Options:
  --server <ip:port>    Server address (default: 103.77.246.111:8882)
  --host <ip>           Local host to forward (default: 127.0.0.1)
  --port <port>         Local port to forward
  --proto <protocol>    Protocol: tcp, udp, http (default: tcp)
  --id <client-id>      Custom client ID (optional)
  --cert-pin <hash>     Certificate pinning (SHA256 fingerprint)
  --insecure            Skip TLS verification (NOT recommended)
  --ui=false            Disable TUI (for background mode)
```

### Examples:

#### Custom Server:
```bash
proxvn --server your-server.com:8882 --proto http 3000
```

#### Forward Different Host:
```bash
# Forward server khác trong LAN
proxvn --host 192.168.1.100 --port 8080 --proto http
```

#### Background Mode (No UI):
```bash
# Linux/macOS
nohup ./proxvn-linux-client --proto http 3000 --ui=false > proxvn.log 2>&1 &

# Windows
start /B proxvn.exe --proto http 3000 --ui=false
```

#### Custom Client ID:
```bash
proxvn --id my-laptop --proto http 3000
```

---

## 🔐 Certificate Pinning

**Tại sao cần?** Chống Man-in-the-Middle attacks trong production.

### Production Server Fingerprint:

```
8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071
```

### Sử Dụng:

```bash
# HTTP tunnel với cert pinning
proxvn --proto http 3000 \
       --cert-pin 8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071

# TCP tunnel với cert pinning
proxvn 22 \
       --cert-pin 8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071
```

### Verify Certificate (Optional):

#### Windows PowerShell:
```powershell
$cert = (New-Object System.Net.Sockets.TcpClient("103.77.246.111", 8882)).GetStream()
$sslStream = New-Object System.Net.Security.SslStream($cert, $false, {$true})
$sslStream.AuthenticateAsClient("103.77.246.111")
$remoteCert = $sslStream.RemoteCertificate
$hash = [System.Security.Cryptography.SHA256]::Create()
$certHash = $hash.ComputeHash($remoteCert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert))
$fingerprint = -join ($certHash | ForEach-Object { $_.ToString("x2") })
Write-Host "Fingerprint: $fingerprint"
$sslStream.Close()
$cert.Close()
```

#### Linux/macOS:
```bash
echo | openssl s_client -connect 103.77.246.111:8882 2>/dev/null | \
  openssl x509 -fingerprint -sha256 -noout | \
  cut -d'=' -f2 | tr -d ':' | tr '[:upper:]' '[:lower:]'
```

**Expected Output:**
```
8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071
```

**📖 Chi tiết:** [CERT_PINNING.md](CERT_PINNING.md)

---

## 🎬 Using Scripts

### Windows - Interactive Launcher

ProxVN includes một script Windows để dễ dàng sử dụng:

```powershell
cd scripts
.\run_client.bat
```

**Script sẽ hỏi:**
```
➤ Host   [127.0.0.1]:       ← Enter (localhost) hoặc nhập IP khác
➤ Port   [vd: 3389 / 80]:   ← Nhập port (ví dụ: 3000)
➤ Proto  [tcp / udp /http]: ← Chọn protocol (ví dụ: http)
```

**Features:**
- ✅ Interactive prompts
- ✅ Certificate pinning built-in
- ✅ Input validation
- ✅ User-friendly UI

**Script content** (`scripts/run_client.bat`):
```batch
@echo off
chcp 65001 >nul
setlocal

:: Certificate fingerprint (có sẵn)
set CERT_PIN=8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071

:: Prompts
set /p HOST=➤ Host [127.0.0.1]: 
set /p PORT=➤ Port [vd: 3389 / 80]: 
set /p PROTO=➤ Proto [tcp / udp /http]: 

:: Run
proxvn.exe --host %HOST% --port %PORT% --proto %PROTO% --cert-pin %CERT_PIN%
```

### Linux/macOS - Shell Script

Tự tạo script tương tự:

```bash
#!/bin/bash
# run_proxvn.sh

CERT_PIN="8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071"

echo "ProxVN Launcher"
echo "---------------"

read -p "Host [127.0.0.1]: " HOST
HOST=${HOST:-127.0.0.1}

read -p "Port: " PORT
if [ -z "$PORT" ]; then
    echo "Error: Port is required"
    exit 1
fi

read -p "Protocol [tcp/udp/http]: " PROTO
PROTO=${PROTO:-tcp}

echo ""
echo "Starting ProxVN..."
./proxvn-linux-client --host $HOST --port $PORT --proto $PROTO --cert-pin $CERT_PIN
```

```bash
chmod +x run_proxvn.sh
./run_proxvn.sh
```

---

## 💡 Use Cases

### 👨‍💻 Web Development

```bash
# Live preview cho client
npm run dev              # Start dev server (port 3000)
proxvn --proto http 3000
# Share: https://xyz.vutrungocrong.fun

# Test webhooks (Stripe, GitHub, PayPal...)
proxvn --proto http 3000
# Webhook URL: https://xyz.vutrungocrong.fun/webhook

# Demo app cho team
proxvn --proto http 8080
# Share with team globally
```

### 🏠 Homelab & Self-Hosting

```bash
# Home Assistant
proxvn --proto http 8123
# Access: https://xyz.vutrungocrong.fun

# Plex Media Server
proxvn --proto http 32400

# Synology NAS
proxvn --proto http 5000

# Pi-hole Admin
proxvn --proto http 80
```

### 🎮 Gaming

```bash
# Minecraft Bedrock
proxvn --proto udp 19132
# Friends connect: 103.77.246.111:10001

# Minecraft Java
proxvn 25565
# Friends connect: 103.77.246.111:10002

# Palworld
proxvn --proto udp 8211

# Valheim
proxvn --proto udp 2456
```

### 🖥️ Remote Access

```bash
# SSH
proxvn 22
# ssh user@103.77.246.111 -p 10001

# Windows RDP
proxvn 3389
# mstsc /v:103.77.246.111:10002

# VNC
proxvn 5900
# Connect to: 103.77.246.111:10003
```

### 🗄️ Databases

```bash
# MySQL
proxvn 3306
# mysql -h 103.77.246.111 -P 10001 -u root -p

# PostgreSQL
proxvn 5432
# psql -h 103.77.246.111 -p 10002 -U postgres

# MongoDB
proxvn 27017
```mongodb://103.77.246.111:10003/mydb

# Redis
proxvn 6379
# redis-cli -h 103.77.246.111 -p 10004
```

---

## 📊 Understanding Output

### HTTP Mode:
```
[client] ⚠️  Certificate verification failed, retrying in INSECURE mode...
[client] ⚠️  This is normal for self-signed certificates in dev/test
✓ Đã kết nối tới ProxVN Server
✓ HTTP Tunnel: https://a1b2c3.vutrungocrong.fun
  → Forwards to: http://localhost:3000
  
Traffic:
  ↑ Upload:   1.2 MB
  ↓ Download: 3.4 MB
  
Active Sessions: 2
```

**Giải thích:**
- ⚠️ **Certificate warning:** Normal cho dev/test (tự động retry)
- ✓ **Public URL:** URL để share
- **Traffic:** Real-time bandwidth 
- **Sessions:** Số kết nối đang active

### TCP/UDP Mode:
```
✓ Đã kết nối tới ProxVN Server
✓ Public Endpoint: 103.77.246.111:10001
  → Forwards to: localhost:22
  
Active Sessions: 1
Total Sessions:  5
Uptime: 2h 15m
```

---

## 🛑 Stopping ProxVN

```bash
# Nhấn Ctrl+C trong terminal
^C
[client] Shutting down gracefully...
[client] Closing 2 active sessions...
[client] Goodbye!
```

---

## 🔧 Configuration Files

### Save Defaults (Optional):

Create `proxvn.conf`:

```bash
# ~/.proxvn.conf (Linux/macOS)
# %USERPROFILE%\.proxvn.conf (Windows)

SERVER=103.77.246.111:8882
CERT_PIN=8ff1f269fa914ff6a6467ee7f9b8d7822408c67cbc6fd0c656532c9e68f3d071
PROTOCOL=http
```

Then run:
```bash
proxvn 3000  # Sẽ đọc config từ file
```

---

## 🆘 Troubleshooting

### 1. "Connection refused"

**Nguyên nhân:** Không kết nối được server

**Giải pháp:**
```bash
# Test connection
telnet 103.77.246.111 8882
# Hoặc
nc -zv 103.77.246.111 8882

# Check internet
ping 103.77.246.111

# Tắt firewall tạm thời
# Windows: Settings → Firewall → Turn off
# Linux: sudo ufw disable
```

### 2. "Certificate verification failed"

**Nguyên nhân:** TLS certificate không valid

**Giải pháp:** Client tự động retry với insecure mode. Nếu muốn bỏ warning:
```bash
# Option 1: Dùng cert pinning
proxvn --cert-pin 8ff1f269... --proto http 3000

# Option 2: Insecure mode (not recommended)
proxvn --insecure --proto http 3000
```

### 3. "Port already in use"

**Nguyên nhân:** Port đã được dùng bởi app khác

**Giải pháp:**
```bash
# Check port usage (Linux)
sudo lsof -i :3000

# Check port usage (Windows)
netstat -ano | findstr :3000

# Kill process or dùng port khác
proxvn --proto http 3001
```

### 4. HTTP không tạo được URL

**Nguyên nhân:** Server không hỗ trợ HTTP tunneling

**Giải pháp:** Contact admin để enable HTTP feature

### 5. Slow performance

**Giải pháp:**
- Check bandwidth: `speedtest-cli`
- Try different server: `--server other-server.com:8882`
- Check local app performance

---

## 📈 Performance Tips

### 1. Minimize Latency
```bash
# Chọn server gần nhất
proxvn --server asia-server.com:8882 --proto http 3000
```

### 2. Reduce Bandwidth
```bash
# Compress responses (app-level)
# Enable gzip trong web server
```

### 3. Multiple Tunnels
```bash
# Run multiple clients
./proxvn --proto http 3000 &
./proxvn --proto http 8080 &
./proxvn 22 &
```

---

## 🔒 Security Best Practices

### ✅ DOs:
- ✅ Dùng **certificate pinning** cho production
- ✅ Chỉ tunnel **localhost** nếu có thể
- ✅ **Monitor traffic** để phát hiện bất thường
- ✅ **Update client** thường xuyên
- ✅ **Strong passwords** cho services được tunnel

### ❌ DON'Ts:
- ❌ Tunnel services có **sensitive data** qua public server
- ❌ Share **public URLs** publicly nếu không cần
- ❌ Dùng `--insecure` mode trong production
- ❌ Expose **admin panels** qua tunnel
- ❌ Forward services có **default passwords**

---

## 📚 Advanced Topics

### Multi-Tenancy:
```bash
# Nhiều clients trên cùng máy
proxvn --id laptop-1 --proto http 3000
proxvn --id laptop-2 --proto http 8080
```

### Load Balancing:
```bash
# Connect to different servers
proxvn --server server1.com:8882 --proto http 3000
proxvn --server server2.com:8882 --proto http 3000
```

### Automation:
```bash
# Auto-start with systemd (Linux)
sudo nano /etc/systemd/system/proxvn.service

[Unit]
Description=ProxVN Client
After=network.target

[Service]
Type=simple
User=your-user
ExecStart=/usr/local/bin/proxvn-linux-client --proto http 3000
Restart=always

[Install]
WantedBy=multi-user.target
```

---

## 📖 Related Docs

- 🏠 **[Server Setup](SERVER_SETUP.md)** - Setup your own server
- 🔐 **[Certificate Pinning](CERT_PINNING.md)** - Advanced security
- ❓ **[FAQ](wiki/FAQ.md)** - Common questions
- 📘 **[HTTP Tunneling](wiki/HTTP-Tunneling.md)** - HTTP deep dive

---

## 💬 Getting Help

- 💡 **Discussions:** [GitHub Discussions](https://github.com/hoangtuvungcao/proxvn_tunnel/discussions)
- 🐛 **Bug Reports:** [GitHub Issues](https://github.com/hoangtuvungcao/proxvn_tunnel/issues)
- 📧 **Email:** trong20843@gmail.com
- 📖 **Documentation:** [GitHub Wiki](https://github.com/hoangtuvungcao/proxvn_tunnel/wiki)

---

<div align="center">

**Happy Tunneling! 🚀**

[⬆ Back to Top](#-proxvn-client-guide)

</div>
