-- 华星名仕集团组织架构数据清理和初始化脚本
-- 执行前请备份数据库
-- 设置字符集
SET NAMES utf8mb4;

-- ========================================
-- 第一部分：清理现有数据
-- ========================================

-- 1. 清理用户岗位关联
DELETE FROM system_user_post WHERE post_id IN (SELECT id FROM system_post);

-- 2. 清理用户角色关联（保留超级管理员的关联）
DELETE FROM system_user_role WHERE role_id NOT IN (1);

-- 3. 清理角色菜单关联（保留超级管理员的关联）
DELETE FROM system_role_menu WHERE role_id NOT IN (1);

-- 4. 清理现有岗位数据
DELETE FROM system_post;

-- 5. 清理现有角色数据（保留超级管理员）
DELETE FROM system_role WHERE id NOT IN (1);

-- 6. 更新用户部门关联为NULL（避免外键约束）
UPDATE system_users SET dept_id = NULL;

-- 7. 清理现有部门数据
DELETE FROM system_dept;

-- ========================================
-- 第二部分：创建华星名仕集团部门架构
-- ========================================

-- 1. 集团总部
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1000, '华星名仕集团', 0, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 2. 品牌层级
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1100, '一汽奥迪', 1000, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1200, '上汽奥迪', 1000, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1300, '小鹏', 1000, 3, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 3. 信息管理部（品牌级别）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1110, '一汽奥迪信息管理部', 1100, 1, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1210, '上汽奥迪信息管理部', 1200, 1, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1310, '小鹏信息管理部', 1300, 1, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 4. 区域层级（一汽奥迪）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1120, '一汽奥迪华南区', 1100, 2, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1130, '一汽奥迪华东区', 1100, 3, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1140, '一汽奥迪华北区', 1100, 4, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 5. 区域层级（上汽奥迪）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1220, '上汽奥迪华南区', 1200, 2, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1230, '上汽奥迪华东区', 1200, 3, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 6. 区域层级（小鹏）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1320, '小鹏华南区', 1300, 2, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1330, '小鹏华东区', 1300, 3, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 7. 门店层级（示例：一汽奥迪华南区）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1121, '深圳福田店', 1120, 1, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1122, '深圳南山店', 1120, 2, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1123, '广州天河店', 1120, 3, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 8. 门店层级（示例：上汽奥迪华南区）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1221, '深圳罗湖店', 1220, 1, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1222, '广州越秀店', 1220, 2, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 9. 门店层级（示例：小鹏华南区）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1321, '深圳宝安店', 1320, 1, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1322, '广州番禺店', 1320, 2, NULL, NULL, NULL, 0, 'admin', NOW(), 'admin', NOW(), 0, 1);

-- ========================================
-- 第三部分：创建岗位数据
-- ========================================

-- 集团级岗位
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1, 'GROUP_PRESIDENT', '集团总裁', 1, 0, '集团最高管理者', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (2, 'GROUP_VP', '集团副总裁', 2, 0, '集团副总裁', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 品牌级岗位
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (10, 'BRAND_GM', '品牌总经理', 10, 0, '品牌总经理', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (11, 'BRAND_DGM', '品牌副总经理', 11, 0, '品牌副总经理', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 信息管理部岗位
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (20, 'IT_DIRECTOR', '信息管理部总监', 20, 0, '信息管理部总监', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (21, 'SYSTEM_ENGINEER', '系统工程师', 21, 0, '系统工程师', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 区域级岗位
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (30, 'REGION_MANAGER', '区域经理', 30, 0, '区域经理', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (31, 'REGION_SUPERVISOR', '区域主管', 31, 0, '区域主管', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 门店级岗位
INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (40, 'STORE_MANAGER', '店长', 40, 0, '门店店长', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (41, 'FRONT_DESK', '前台', 41, 0, '门店前台', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (42, 'SALES_MANAGER', '销售经理', 42, 0, '门店销售经理', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (43, 'SALES_CONSULTANT', '销售顾问', 43, 0, '门店销售顾问', 'admin', NOW(), 'admin', NOW(), 0, 1);

INSERT INTO system_post (id, code, name, sort, status, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (44, 'APPOINTMENT_SPECIALIST', '预约专员', 44, 0, '门店预约专员', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- ========================================
-- 第四部分：创建角色数据
-- ========================================

-- 集团级角色
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (10, '集团管理员', 'GROUP_ADMIN', 10, 1, '', 0, 2, '集团级管理员，拥有全部数据权限', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 品牌级角色
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (20, '品牌管理员', 'BRAND_ADMIN', 20, 2, '', 0, 2, '品牌级管理员，拥有本部门及下级部门数据权限', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 区域级角色
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (30, '区域管理员', 'REGION_ADMIN', 30, 2, '', 0, 2, '区域级管理员，拥有本部门及下级部门数据权限', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 门店级角色
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (40, '门店管理员', 'STORE_ADMIN', 40, 3, '', 0, 2, '门店级管理员，拥有本部门数据权限', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- 普通员工角色
INSERT INTO system_role (id, name, code, sort, data_scope, data_scope_dept_ids, status, type, remark, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (50, '普通员工', 'EMPLOYEE', 50, 5, '', 0, 2, '普通员工，只能查看自己的数据', 'admin', NOW(), 'admin', NOW(), 0, 1);

-- ========================================
-- 验证数据
-- ========================================

-- 查询验证结果
SELECT '=== 部门数据验证 ===' as info;
SELECT id, name, parent_id, sort FROM system_dept ORDER BY id;

SELECT '=== 岗位数据验证 ===' as info;
SELECT id, code, name, sort FROM system_post ORDER BY sort;

SELECT '=== 角色数据验证 ===' as info;
SELECT id, name, code, data_scope FROM system_role ORDER BY id;