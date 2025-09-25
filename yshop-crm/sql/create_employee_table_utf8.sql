-- 员工信息表，用于注册时验证员工身份
DROP TABLE IF EXISTS `system_employee`;
CREATE TABLE `system_employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '员工姓名',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号码',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `brand_dept` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '品牌部门',
  `info_dept` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '信息部门',
  `region` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区域',
  `store` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '门店',
  `position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位',
  `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '是否在职（0离职 1在职）',
  `entry_date` date DEFAULT NULL COMMENT '入职日期',
  `leave_date` date DEFAULT NULL COMMENT '离职日期',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_mobile_tenant` (`mobile`, `tenant_id`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE,
  KEY `idx_dept_id` (`dept_id`) USING BTREE,
  KEY `idx_is_active` (`is_active`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='员工信息表';

-- 插入示例员工数据
INSERT INTO `system_employee` (`name`, `mobile`, `dept_id`, `brand_dept`, `info_dept`, `region`, `store`, `position`, `is_active`, `entry_date`, `creator`) VALUES
('张三', '13800138001', 103, '华星名仕', '信息部', '深圳区域', '福田店', '销售顾问', 1, '2024-01-01', 'admin'),
('李四', '13800138002', 104, '华星名仕', '市场部', '深圳区域', '南山店', '市场专员', 1, '2024-01-15', 'admin'),
('王五', '13800138003', 105, '华星名仕', '技术部', '广州区域', '天河店', '技术支持', 1, '2024-02-01', 'admin'),
('赵六', '13800138004', 106, '华星名仕', '财务部', '深圳区域', '总部', '财务专员', 1, '2024-02-15', 'admin'),
('钱七', '13800138005', 103, '华星名仕', '信息部', '上海区域', '浦东店', '销售经理', 0, '2024-01-01', 'admin');