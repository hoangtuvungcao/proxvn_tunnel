# ProxVN - Giải Pháp Tunnel Việt Nam Premium
> **Phiên bản 2.0.0** - Developed by **TrongDev**

ProxVN là công cụ **Tunneling** mạnh mẽ, miễn phí, giúp bạn đưa các dịch vụ trong mạng nội bộ (Localhost) ra Internet công cộng chỉ với một câu lệnh.

![ProxVN Logo](icon.png)

---

## 🌟 Tính Năng Chính

*   **Hỗ Trợ Đa Giao Thức:**
    *   **TCP:** Cho Web Server (NodeJS, Python, XAMPP...), API, RDP.
    *   **UDP:** Cho Game Server (Minecraft PE, CS:GO, Palworld...), DNS.
*   **Đa Nền Tảng:** Chạy mượt trên Windows, Linux, macOS và Android.
*   **Tự Động Kết Nối Lại:** Không lo rớt mạng.

---

## 🚀 1. Hướng Dẫn Build (Cài Đặt)

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
| `--proto` | `tcp` | Giao thức: `tcp` hoặc `udp` |
| `--host` | `localhost` | IP nội bộ cần public (vd: 127.0.0.1) |
| `--id` | `(auto)` | Tự đặt tên định danh cho Client |
| `--port` | `80` | Port nội bộ (nếu không nhập ở cuối lệnh) |

### 💡 Các Ví Dụ Thông Dụng (Copy là chạy)

#### 1. Public Web Server (HTTP)
Chạy website ở port 80 hoặc 3000, 8080...
```powershell
# Public port 80
.\proxvn.exe 80

# Public port 3000 (NodeJS/React)
.\proxvn.exe 3000
```

#### 2. Public Game Minecraft PE (UDP) 🎮
Minecraft Bedrock chạy port 19132 UDP. Cần thêm cờ `--proto udp`.
```powershell
# Chạy Minecraft PE
.\proxvn.exe --proto udp --host 127.0.0.1 19132
```
> **Lưu ý:** Với Game UDP, hãy chắc chắn VPS đã mở Firewall UDP và tắt Rate Limit cho IP của bạn.

#### 3. Remote Desktop (RDP) 🖥️
Điều khiển máy tính từ xa qua Internet an toàn.
```powershell
# Public port 3389 (RDP)
.\proxvn.exe 3389
```
*Kết nối bằng Remote Desktop Connection tới địa chỉ Public được cấp.*

#### 4. Kết Nối Tới Server Khác
Nếu bạn có VPS riêng đã cài ProxVN Server.
```powershell
.\proxvn.exe --server [IP_VPS_CUA_BAN]:8882 80
```

---

## 🖥️ 3. Hướng Dẫn Sử Dụng Server

Dành cho bạn nào muốn tự build hệ thống Tunnel riêng trên VPS.

### Cài Đặt Server (Deploy)
1.  Tải file **`bin/server.tar.gz`** lên VPS của bạn.
2.  Giải nén:
    ```bash
    tar -xzvf server.tar.gz
    chmod +x proxvn-linux-server
    ```
3.  Chạy Server:
    ```bash
    ./proxvn-linux-server
    ```

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

# Chạy
./proxvn-linux-client 80

# Tạo Shortcut Desktop (Nếu dùng giao diện)
# Copy file proxvn-linux.desktop ra màn hình và chọn "Allow Launching"
```

### Android (Termux)
1.  Cài App **Termux**.
2.  Copy file `proxvn-android` vào bộ nhớ máy.
3.  Mở Termux, gõ lệnh:
    ```bash
    cp /sdcard/Download/proxvn-android .
    chmod +x proxvn-android
    ./proxvn-android --server 103.77.246.111:8882 80
    ```

---

## ❓ Câu Hỏi Thường Gặp (FAQ)

**Q: Tại sao tôi không vào được game Minecraft?**
A: Kiểm tra xem bạn đã thêm `--proto udp` chưa. Game bắt buộc phải dùng UDP.

**Q: Làm sao để chia sẻ file giữa 2 máy dùng ProxVN?**
A: Bạn chạy Web Server (ví dụ `python -m http.server 8000`) trên máy chứa file, sau đó dùng ProxVN public port 8000. Máy kia truy cập vào link Public để tải file. Không dùng SMB (Share folder Windows) vì lý do bảo mật.

**Q: Antivirus báo file có virus?**
A: Do phần mềm sử dụng kỹ thuật mạng (Tunneling) và nén file (UPX) nên đôi khi bị Windows Defender nhận diện nhầm. Hãy thêm folder vào Exclusion (vùng tin cậy).

---
## ⚠️ LICENSE NOTICE

This project is **FREE TO USE – NON-COMMERCIAL ONLY**.

✅ You can download, run, and modify it  
❌ You are NOT allowed to sell or monetize it in any form  

Commercial use requires permission from the author.
---
© 2026 **ProxVN** • Developed by **TrongDev**
