#!/bin/bash

# Cập nhật danh sách các gói
sudo apt-get update
if [ $? -ne 0 ]; then
  echo "Lỗi trong quá trình cập nhật danh sách gói."
  exit 1
fi

# Cài đặt các gói phụ thuộc
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Tạo thư mục /etc/apt/keyrings
sudo mkdir -p /etc/apt/keyrings

# Tải khóa GPG của Docker và lưu nó vào /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Thêm nguồn dữ liệu Docker vào /etc/apt/sources.list.d/docker.list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cập nhật danh sách các gói lại sau khi đã thêm nguồn dữ liệu Docker
sudo apt-get update

# Cài đặt Docker và Docker Compose
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose

# Kiểm tra xem Docker đã được cài đặt thành công hay không
if [ -x "$(command -v docker)" ]; then
  echo "Docker tải thành công."
else
  echo "Docker tải không thành công."
fi

# Kiểm tra phiên bản của Docker
docker -v
# Kiểm tra xem Docker đã được cài đặt thành công hay không
if [ -x "$(command -v docker-compose)" ]; then
  echo "Docker Compose tải thành công."
else
  echo "Docker Compose tải không thành công."
fi

# Kiểm tra phiên bản của Docker
docker-compose -v
exit 0