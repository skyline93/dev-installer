## 一、NFS客户端安装(REHL)
1）安装nfs客户端工具
```bash
yum install -y nfs-utils
```

2）使用`showmount`命令查看nfs服务器的共享目录，例如：
```bash
showmount -e 192.168.1.123
```

3）挂载到本地路径，如下将vol1挂载到本地`/mnt/share`目录
```bash
mount -t nfs 192.168.1.123:/vol1 /mnt/share
```

4）在`/etc/fstab`配置下增加如下行，开机启动后即可自动挂载
```bash
192.168.1.123:/vol1  /mnt/share    nfs     defaults        0 0
```

## 二、firewalld防火墙管理

1）端口管理

```bash
firewall-cmd --list-ports                     # 列出开通的端口号
firewall-cmd --permanent --add-port=22/tcp    # 添加端口号
firewall-cmd --permanent --remove-port=22/tcp # 移除端口号
firewall-cmd --reload                         # 重载，添加或删除后需要reload才能生效
```

2）关闭防火墙，并禁用开机自启动
```bash
systemctl stop firewalld
systemctl disable firewalld
```

## 三、Python3安装

### 3.1、编译安装
指定安装的python版本
```bash
export python_version='3.9.13'
```

安装系统依赖
```bash
yum install -y \
    gcc \
    make \
    bzip2-devel \
    ncurses-devel \
    sqlite-devel \
    gdbm-devel \
    xz-devel \
    tk-devel \
    readline-devel \
    openssl \
    openssl-devel \
    hdf5-devel \
    libffi-devel
```

```bash
curl -O https://mirrors.huaweicloud.com/python/$python_version/Python-$python_version.tar.xz
tar -xvf Python-$python_version.tar.xz;cd Python-$python_version
./configure --prefix=/usr/bin/openssl --prefix=/usr/local/python$python_version
make;make install
ln -s /usr/local/python$python_version/bin/python3 /usr/local/bin/python3
```

**附**：也可以使用如下命令脚本一键安装
```bash
curl -sSL https://files-cdn.cnblogs.com/files/greene/python-install.sh | sh -s 3.9.13
```

### 3.2、配置pypi源
```bash
mkdir $HOME/.pip
touch $HOME/.pip/pip.conf

tee -a $HOME/.pip/pip.conf <<'EOF'
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF
```
