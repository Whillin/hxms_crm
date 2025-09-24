# 华星名仕集团CRM系统部署指南

## 项目概述

华星名仕集团CRM系统是一个基于Spring Boot 3 + Vue 3的现代化客户关系管理系统，专为汽车销售集团设计，支持多品牌、多区域、多门店的复杂组织架构管理。

## 系统架构

### 组织架构特点
- **五级部门架构**：集团 → 品牌 → 销售部门 → 区域 → 门店
- **多品牌支持**：一汽奥迪、上汽奥迪、小鹏汽车
- **区域覆盖**：云南区域、河北区域、重庆区域、川边区域
- **分级权限**：10种角色，支持不同数据访问范围

## 环境要求

### 开发环境
- **JDK**: 17+
- **MySQL**: 8.0+
- **Redis**: 6.0+
- **Node.js**: 16+
- **Maven**: 3.8+

### 生产环境
- **服务器**: Linux/Windows Server
- **内存**: 最低4GB，推荐8GB+
- **存储**: 最低50GB可用空间
- **网络**: 支持HTTP/HTTPS访问

## 部署步骤

### 1. 数据库准备

#### 创建数据库
```sql
CREATE DATABASE yshop_crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 导入数据
1. 导入基础表结构（sql文件位于项目根目录）
2. 系统已包含完整的组织架构数据：
   - 50个部门记录
   - 13个岗位记录
   - 10个角色记录

### 2. 后端部署

#### 配置文件修改
编辑 `yshop-server/src/main/resources/application-prod.yml`：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/yshop_crm?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai
    username: your_username
    password: your_password
  
  redis:
    host: localhost
    port: 6379
    password: your_redis_password
```

#### 构建和启动
```bash
# 进入后端目录
cd yshop-crm

# 构建项目
mvn clean package -Dmaven.test.skip=true

# 启动服务
java -jar yshop-server/target/yshop-server.jar --spring.profiles.active=prod
```

### 3. 前端部署

#### 构建前端
```bash
# 进入前端目录
cd yshop-crm-vue

# 安装依赖
npm install

# 构建生产版本
npm run build
```

#### Nginx配置
```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        root /path/to/yshop-crm-vue/dist;
        index index.html;
        try_files $uri $uri/ /index.html;
    }
    
    location /api/ {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## 系统配置

### 默认管理员账号
- **用户名**: admin
- **密码**: admin123
- **角色**: 超级管理员

### 组织架构说明

#### 部门层级
```
华星名仕集团 (1000)
├── 一汽奥迪 (1100)
│   ├── 一汽奥迪销售部门 (1110)
│   │   ├── 云南区域 (1111)
│   │   │   ├── 同德店 (1111001)
│   │   │   └── 华星店 (1111002)
│   │   └── 河北区域 (1112)
│   │       └── 廊坊店 (1112001)
├── 上汽奥迪 (1200)
│   ├── 上汽奥迪销售部门 (1210)
│   │   ├── 云南区域 (1211)
│   │   │   ├── 同德店 (1211001)
│   │   │   └── 华星店 (1211002)
│   │   ├── 河北区域 (1212)
│   │   │   └── 廊坊店 (1212001)
│   │   └── 重庆区域 (1213)
│   │       └── 重庆店 (1213001)
├── 小鹏 (1300)
│   ├── 小鹏销售部门 (1310)
│   │   ├── 川边区域 (1311)
│   │   │   └── 泸州店 (1311001)
│   │   └── 河北区域 (1312)
│   │       └── 廊坊店 (1312001)
└── 信息管理部门 (1400)
```

#### 角色权限
- **超级管理员**: 全部数据权限
- **集团管理员**: 集团及以下数据权限
- **品牌管理员**: 品牌及以下数据权限
- **区域管理员**: 区域及以下数据权限
- **门店管理员**: 门店数据权限
- **销售经理**: 部门数据权限
- **销售顾问**: 个人数据权限

## 监控和维护

### 日志管理
- 应用日志位置: `logs/yshop.log`
- 错误日志位置: `logs/error.log`
- 建议配置日志轮转

### 数据备份
```bash
# 数据库备份
mysqldump -u username -p yshop_crm > backup_$(date +%Y%m%d).sql

# 定期备份脚本
0 2 * * * /path/to/backup_script.sh
```

### 性能优化
- 配置Redis缓存
- 数据库索引优化
- 静态资源CDN加速

## 故障排除

### 常见问题
1. **数据库连接失败**: 检查数据库配置和网络连接
2. **Redis连接失败**: 检查Redis服务状态和配置
3. **前端页面空白**: 检查Nginx配置和静态资源路径
4. **权限问题**: 检查用户角色和部门分配

### 联系支持
- 技术支持: tech@huaxing.com
- 系统管理: admin@huaxing.com

## 更新日志

### v1.0.0 (2024-01-XX)
- 初始版本发布
- 完整组织架构实现
- 基础CRM功能
- 多品牌多区域支持

---

**华星名仕集团技术部**  
更新时间: 2024年1月