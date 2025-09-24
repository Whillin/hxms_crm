-- 华星名仕集团部门架构数据插入脚本（修正版）
SET NAMES utf8mb4;

-- 1. 集团总部
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1000, '华星名仕集团', 0, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 2. 品牌层级
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1100, '一汽奥迪', 1000, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1200, '上汽奥迪', 1000, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1300, '小鹏', 1000, 3, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 3. 信息管理部（品牌级别）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1110, '一汽奥迪信息管理部', 1100, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1210, '上汽奥迪信息管理部', 1200, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1310, '小鹏信息管理部', 1300, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 4. 区域层级（一汽奥迪）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1120, '一汽奥迪华南区', 1100, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1130, '一汽奥迪华东区', 1100, 3, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1140, '一汽奥迪华北区', 1100, 4, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 5. 区域层级（上汽奥迪）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1220, '上汽奥迪华南区', 1200, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1230, '上汽奥迪华东区', 1200, 3, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 6. 区域层级（小鹏）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1320, '小鹏华南区', 1300, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1330, '小鹏华东区', 1300, 3, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 7. 门店层级（示例：一汽奥迪华南区）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1121, '深圳福田店', 1120, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1122, '深圳南山店', 1120, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1123, '广州天河店', 1120, 3, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 8. 门店层级（示例：上汽奥迪华南区）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1221, '深圳罗湖店', 1220, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1222, '广州越秀店', 1220, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 9. 门店层级（示例：小鹏华南区）
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1321, '深圳宝安店', 1320, 1, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
       (1322, '广州番禺店', 1320, 2, NULL, NULL, NULL, 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);