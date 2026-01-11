# ProxVN - Giải Pháp Tunnel Việt Nam Premium
> **Phiên bản 4.0.0** - Developed by **TrongDev**

ProxVN là công cụ **Tunneling** mạnh mẽ, miễn phí, giúp bạn đưa các dịch vụ trong mạng nội bộ (Localhost) ra Internet công cộng chỉ với một câu lệnh .

## 🌐 Website & Tải Về

**🔗 Truy cập:** [https://1b9b90.vutrungocrong.fun](https://1b9b90.vutrungocrong.fun)

- ⬇️ **Tải file thực thi** cho Windows, Linux, macOS, Android
- 📖 **Hướng dẫn sử dụng** chi tiết từng bước
- 🚀 **Quick Start** - Chạy ngay trong 1 phút
- 💬 **Community & Support** - Hỗ trợ trực tuyến

---

![ProxVN Logo](icon.png)

---

## 🌟 Tính Năng Chính

*   **Hỗ Trợ Đa Giao Thức:**
    *   **HTTP (MỚI!):** Nhận subdomain HTTPS tự động (vd: `https://abc123.vutrungocrong.fun`)
    *   **TCP:** Cho Web Server (NodeJS, Python, XAMPP...), API, RDP, SSH.
    *   **UDP:** Cho Game Server (Minecraft PE, CS:GO, Palworld...), DNS.
*   **Đa Nền Tảng:** Chạy mượt trên Windows, Linux, macOS và Android.
*   **Tự Động Kết Nối Lại:** Không lo rớt mạng.
*   **Bảo Mật TLS:** Mã hóa end-to-end cho tất cả kết nối tunnel.

---

## 🚀 1. Tải Về & Cài Đặt

### Cách Nhanh Nhất - Từ Website

Truy cập **[vutrungocrong.fun](https://vutrungocrong.fun)** và tải file phù hợp với hệ điều hành của bạn:

- **Windows:** `proxvn.exe` (Client) hoặc `svproxvn.exe` (Server)
- **Linux:** `proxvn-linux-client` hoặc `proxvn-linux-server`
- **macOS:** `proxvn-mac-m1` (Apple Silicon) hoặc `proxvn-mac-intel`
- **Android:** `proxvn-android` (Termux)

### Hoặc Build Từ Source Code

Dự án cung cấp bộ công cụ build tự động "All-in-One". Bạn cần cài đặt [Go (Golang)](https://go.dev/dl/) trước.

### Bước 1: Chạy Script Build

Trên Windows, chạy file **`scripts/build.bat`** (Click đúp hoặc chạy trong CMD).

### Bước 2: Nhận Kết Quả

Vào thư mục **`bin/`** để lấy file chạy cho nền tảng của bạn:

| Hệ Điều Hành | Server (Máy Chủ) | Client (Máy Bạn) | Ghi Chú |
| :--- | :--- | :--- | :--- |
| **Windows** | `svproxvn.exe` | `proxvn.exe` | Đã có sẵn Icon |
| **Linux (VPS)** | `proxvn-linux-server` | `proxvn-linux-client` | Kèm file `.desktop` |
| **macOS** | - | `proxvn-mac-m1` / `intel` | |
| **Android** | - | `proxvn-android` | Chạy trên Termux |

---

## 📖 2. Hướng Dẫn Sử Dụng Client

Đây là phần mềm bạn chạy trên máy tính cá nhân để public port.

### Cú Pháp Lệnh Cơ Bản
```bash
./proxvn.exe [OPTIONS] [LOCAL_PORT]
```

### Danh Sách Tham Số (Options)
| Tham Số | Mặc Định | Mô Tả |
| :--- | :--- | :--- |
| `--server` | `103.77.246.111:8882` | Địa chỉ Tunnel Server (IP:Port) |
| `--proto` | `tcp` | Giao thức: `tcp`, `udp`, hoặc `http` |
| `--host` | `localhost` | IP nội bộ cần public (vd: 127.0.0.1) |
| `--id` | `(auto)` | Tự đặt tên định danh cho Client |
| `--port` | `80` | Port nội bộ (nếu không nhập ở cuối lệnh) |

### 💡 Các Ví Dụ Thông Dụng (Copy là chạy)

#### 🆕 1. HTTP Tunnel - Nhận Subdomain HTTPS Tự Động
Mode HTTP cấp cho bạn subdomain `https://` ngay lập tức, đẹp và dễ chia sẻ!

```powershell
# Public website ở port 80
.\proxvn.exe --proto http 80

# Public website ở port 3000 (React/Node.js)
.\proxvn.exe --proto http 3000

# Public HTTPS website ở port 443 (XAMPP/Apache)
.\proxvn.exe --proto http 443
```

**Kết quả:** Bạn sẽ nhận được subdomain như `https://a1b2c3.vutrungocrong.fun` để chia sẻ ngay!

> **Lưu ý:** Subdomain tự động **XÓA** khi bạn tắt client. Mỗi lần chạy lại sẽ được cấp subdomain mới.

#### 2. TCP Tunnel - Public Web Server Qua IP:Port
```powershell
# Public port 80
.\proxvn.exe 80

# Public port 3000 (NodeJS/React)
.\proxvn.exe 3000
```

**Kết quả:** Nhận địa chỉ dạng `103.77.246.111:10000` để truy cập.

#### 3. UDP Tunnel - Game Minecraft PE 🎮
Minecraft Bedrock chạy port 19132 UDP. Cần thêm cờ `--proto udp`.
```powershell
# Chạy Minecraft PE
.\proxvn.exe --proto udp --host 127.0.0.1 19132
```
> **Lưu ý:** Với Game UDP, hãy chắc chắn VPS đã mở Firewall UDP.

#### 4. Remote Desktop (RDP) 🖥️
Điều khiển máy tính từ xa qua Internet an toàn.
```powershell
# Public port 3389 (RDP)
.\proxvn.exe 3389
```
*Kết nối bằng Remote Desktop Connection tới địa chỉ Public được cấp.*

#### 5. Kết Nối Tới Server Khác
Nếu bạn có VPS riêng đã cài ProxVN Server.
```powershell
.\proxvn.exe --server [IP_VPS_CUA_BAN]:8882 --proto http 80
```

---

## 🖥️ 3. Hướng Dẫn Sử Dụng Server

Dành cho bạn nào muốn tự build hệ thống Tunnel riêng trên VPS.

### Cài Đặt Server (Deploy)

#### Windows Server:
1. Copy file `bin/svproxvn.exe` lên VPS
2. Đặt biến môi trường (nếu dùng HTTP mode):
   ```powershell
   $env:HTTP_DOMAIN="yourdomain.com"
   .\svproxvn.exe
   ```

#### Linux Server:
1. Tải file **`bin/server.tar.gz`** lên VPS của bạn.
2. Giải nén và chạy:
    ```bash
    tar -xzvf server.tar.gz
    chmod +x proxvn-linux-server
    
    # Chạy (Nếu dùng HTTP mode, set domain trước)
    export HTTP_DOMAIN="yourdomain.com"
    ./proxvn-linux-server
    ```

### Cấu Hình HTTP Tunneling (Tùy chọn)

Để kích hoạt tính năng HTTP Tunnel với subdomain tự động, bạn cần:

#### Bước 1: Cấu hình Domain
```bash
# Linux
export HTTP_DOMAIN="vutrungocrong.fun"

# Windows
$env:HTTP_DOMAIN="vutrungocrong.fun"
```

#### Bước 2: Chuẩn bị SSL Certificate

**Cách 1: Dùng Cloudflare Origin Certificate (Khuyến nghị)**
1. Vào Cloudflare Dashboard → SSL/TLS → Origin Server
2. Tạo Origin Certificate
3. Lưu file:
   - `wildcard.crt` (Certificate)
   - `wildcard.key` (Private Key)
4. Đặt 2 file này vào cùng thư mục với `svproxvn.exe`

**Cách 2: Dùng Let's Encrypt**
```bash
# Cài certbot với DNS plugin
sudo apt install python3-certbot-dns-cloudflare

# Tạo API credentials
sudo mkdir -p /root/.secrets
sudo nano /root/.secrets/cloudflare.ini
# Nhập: dns_cloudflare_api_token = YOUR_TOKEN

# Tạo cert
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /root/.secrets/cloudflare.ini \
  -d '*.yourdomain.com' \
  -d 'yourdomain.com'

# Copy cert
sudo cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem wildcard.crt
sudo cp /etc/letsencrypt/live/yourdomain.com/privkey.pem wildcard.key
```

#### Bước 3: Cấu hình DNS

Tạo bản ghi DNS trên Cloudflare (hoặc nhà cung cấp DNS của bạn):

| Type | Name | Content | Proxy Status |
|------|------|---------|--------------|
| A | `@` | `IP_VPS_CUA_BAN` | 🟠 Proxied |
| CNAME | `*` | `yourdomain.com` | 🟠 Proxied |

> **Quan trọng:** Phải bật **Cloudflare Proxy** (đám mây màu cam) để tránh lỗi SSL!

#### Bước 4: Cấu hình SSL Mode trên Cloudflare

SSL/TLS → Overview → **Full (strict)**

### Cú Pháp
```bash
./svproxvn.exe [OPTIONS]
```

### Tham Số Server
| Tham Số | Mặc Định | Mô Tả |
| :--- | :--- | :--- |
| `-port` | `8881` | Port cho Dashboard & API |

*(Port Tunnel sẽ tự động là Port Dashboard + 1. Ví dụ Dashboard 8881 thì Tunnel là 8882).*

### Dashboard Quản Lý
Sau khi chạy Server, truy cập Web:
*   **URL:** `http://localhost:8881` (hoặc `http://[IP_VPS]:8881`)
*   **Tính năng:** Xem danh sách client, ngắt kết nối, theo dõi lưu lượng mạng Real-time 3D.

---

## 🐧 4. Hướng Dẫn Nâng Cao Cho Linux/macOS/Android

### Linux (Ubuntu/CentOS)
```bash
# Cấp quyền chạy
chmod +x proxvn-linux-client

# Chạy HTTP mode
./proxvn-linux-client --proto http 80

# Tạo Shortcut Desktop (Nếu dùng giao diện)
# Copy file proxvn-linux.desktop ra màn hình và chọn "Allow Launching"
```

### macOS
```bash
# Cấp quyền (Có thể cần xác nhận trong System Preferences)
chmod +x proxvn-mac-m1

# Chạy
./proxvn-mac-m1 --proto http 3000
```

### Android (Termux)
1.  Cài App **Termux**.
2.  Copy file `proxvn-android` vào bộ nhớ máy.
3.  Mở Termux, gõ lệnh:
    ```bash
    cp /sdcard/Download/proxvn-android .
    chmod +x proxvn-android
    ./proxvn-android --proto http 8080
    ```

---

## ❓ Câu Hỏi Thường Gặp (FAQ)

### **Q: Làm sao để share website của tôi nhanh nhất?**
A: Dùng **HTTP mode**! Chỉ cần chạy:
```bash
.\proxvn.exe --proto http 80
```
Bạn sẽ nhận ngay subdomain HTTPS dạng `https://abc123.vutrungocrong.fun` để chia sẻ!

### **Q: Subdomain có thay đổi mỗi lần chạy không?**
A: **CÓ**. Subdomain là ngẫu nhiên và **ephemeral** (tạm thời). Khi bạn tắt client, subdomain sẽ bị xóa. Lần chạy sau sẽ được cấp subdomain mới.

### **Q: Tại sao trình duyệt báo lỗi SSL khi vào subdomain?**
A: Bạn cần bật **Cloudflare Proxy** (đám mây màu cam 🟠) cho bản ghi DNS wildcard (`*.domain.com`). Xem hướng dẫn ở phần "Cấu hình HTTP Tunneling".

### **Q: HTTP mode có khác gì TCP mode?**
A:
- **HTTP mode:** Nhận subdomain HTTPS đẹp (`https://abc.domain.com`), dễ chia sẻ, tự động SSL.
- **TCP mode:** Nhận IP:Port (`103.77.246.111:10000`), phù hợp cho SSH, RDP, databases.

### **Q: Có thể tự đặt subdomain không?**
A: Hiện tại chưa hỗ trợ. Subdomain được sinh ngẫu nhiên để tránh xung đột. Tính năng custom subdomain sẽ có trong phiên bản sau.

### **Q: Tại sao tôi không vào được game Minecraft?**
A: Kiểm tra xem bạn đã thêm `--proto udp` chưa. Game bắt buộc phải dùng UDP.

### **Q: Làm sao để chia sẻ file giữa 2 máy dùng ProxVN?**
A: Bạn chạy Web Server (ví dụ `python -m http.server 8000`) trên máy chứa file, sau đó dùng ProxVN public port 8000 với HTTP mode. Máy kia truy cập vào subdomain HTTPS để tải file.

### **Q: Antivirus báo file có virus?**
A: Do phần mềm sử dụng kỹ thuật mạng (Tunneling) và nén file (UPX) nên đôi khi bị Windows Defender nhận diện nhầm. Hãy thêm folder vào Exclusion (vùng tin cậy).

### **Q: Port 443 bị chiếm bởi Apache/XAMPP, làm sao?**
A: Nếu bạn muốn dùng ProxVN Server để phục vụ HTTP Tunnel trên port 443, bạn phải stop Apache/XAMPP trên VPS trước:
```bash
# Linux
sudo systemctl stop apache2

# Windows (CMD Admin)
net stop Apache2.4
```

---

## 🛠️ Troubleshooting - Xử Lý Sự Cố

### Lỗi: "Connection refused" khi kết nối tới server
**Nguyên nhân:** Firewall chặn port hoặc server chưa chạy.

**Giải pháp:**
- Kiểm tra server có đang chạy không
- Mở firewall cho port 8882 (Tunnel) và 8881 (Dashboard)
```bash
# Linux (ufw)
sudo ufw allow 8882/tcp
sudo ufw allow 8881/tcp
sudo ufw allow 443/tcp  # Nếu dùng HTTP mode

# Windows: Mở Windows Firewall → Inbound Rules → New Rule
```

### Lỗi: "Failed to start HTTPS proxy: bind: address already in use"
**Nguyên nhân:** Port 443 đã bị chiếm bởi web server khác (Apache/Nginx/IIS).

**Giải pháp:**
```bash
# Linux - Dừng Apache
sudo systemctl stop apache2
sudo systemctl stop nginx

# Linux - Kiểm tra process chiếm port 443
sudo lsof -i :443

# Windows - Dừng IIS
net stop W3SVC
```

### Lỗi: Subdomain không hoạt động / "ERR_NAME_NOT_RESOLVED"
**Nguyên nhân:** DNS chưa được cấu hình đúng hoặc chưa propagate.

**Giải pháp:**
1. Kiểm tra DNS bằng `nslookup`:
   ```bash
   nslookup yourdomain.com
   ```
2. Đảm bảo có bản ghi CNAME `*` trỏ về root domain
3. Đợi 2-5 phút để DNS propagate

### Lỗi: "SSL Certificate Error" khi vào subdomain
**Nguyên nhân:** Chứng chỉ không hợp lệ hoặc Cloudflare Proxy chưa bật.

**Giải pháp:**
1. Bật **Cloudflare Proxy** (đám mây cam) cho bản ghi DNS
2. Đảm bảo SSL Mode là **Full (strict)**
3. Nếu dùng Let's Encrypt, kiểm tra cert còn hạn
   ```bash
   sudo certbot certificates
   ```

---

## 📊 So Sánh Với Ngrok

| Tính Năng | ProxVN | Ngrok |
|-----------|--------|-------|
| **Miễn phí** | ✅ Hoàn toàn | ⚠️ Giới hạn |
| **HTTP Tunnel** | ✅ | ✅ |
| **TCP Tunnel** | ✅ | ✅ (Premium) |
| **UDP Tunnel** | ✅ | ✅ (Premium) |
| **Custom Domain** | ✅ (Self-hosted) | 💰 Phải trả phí |
| **Không giới hạn băng thông** | ✅ | ❌ |
| **Self-hosted** | ✅ | ❌ |
| **Open Source** | ✅ | ❌ |

---

## ⚠️ LICENSE NOTICE

This project is **FREE TO USE – NON-COMMERCIAL ONLY**.

✅ You can download, run, and modify it  
❌ You are NOT allowed to sell or monetize it in any form  

Commercial use requires permission from the author.

---

## 🔧 Đóng Góp (Contributing)

Nếu bạn muốn đóng góp vào dự án:
1. Fork repository
2. Tạo branch mới (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Tạo Pull Request

---

## 📞 Liên Hệ & Hỗ Trợ

- **Email:** trong20843@gmail.com
- **GitHub Issues:** [Report bugs](https://github.com/yourusername/proxvn/issues)

---

© 2026 **ProxVN** • Developed by **TrongDev**
