-- 华星名仕集团部门架构数据插入脚本
-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 1. 集团总部
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1000, '华星名仕集团', 0, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 2. 品牌层级
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1100, '一汽奥迪', 1000, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1200, '上汽奥迪', 1000, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1300, '小鹏', 1000, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1400, '信息管理部门', 1000, 4, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 3. 一汽奥迪销售部门
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1110, '一汽奥迪销售部门', 1100, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 4. 一汽奥迪区域
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1111, '成都区域', 1110, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1112, '川边区域', 1110, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1113, '云南区域', 1110, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1114, '贵州区域', 1110, 4, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1115, '河北区域', 1110, 5, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1116, '湖南区域', 1110, 6, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1117, '安徽区域', 1110, 7, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 5. 一汽奥迪成都区域门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1111001, '羊西店', 1111, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1111002, '龙潭店', 1111, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1111003, '新都店', 1111, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1111004, '温江店', 1111, 4, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 6. 一汽奥迪川边区域门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1112001, '德阳店', 1112, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1112002, '高坪店', 1112, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1112003, '南充店', 1112, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1112004, '广安店', 1112, 4, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1112005, '眉山店', 1112, 5, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1112006, '泸州店', 1112, 6, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 7. 一汽奥迪云南区域门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1113001, '驰泰店', 1113, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1113002, '华星店', 1113, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1113003, '红河店', 1113, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 8. 一汽奥迪其他区域门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1114001, '贵阳店', 1114, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1115001, '廊坊店', 1115, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1115002, '三河店', 1115, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1116001, '岳阳店', 1116, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1117001, '马鞍山店', 1117, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 9. 上汽奥迪销售部门
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1210, '上汽奥迪销售部门', 1200, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 10. 上汽奥迪区域
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1211, '成都区域', 1210, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1212, '云南区域', 1210, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1213, '河北区域', 1210, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1214, '重庆区域', 1210, 4, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 11. 上汽奥迪成都区域门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1211001, '万象城店', 1211, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1211002, '武侯店', 1211, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1211003, '高新店', 1211, 3, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1211004, '鹭洲里店', 1211, 4, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1211005, '金牛店', 1211, 5, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 12. 上汽奥迪其他区域门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1212001, '同德店', 1212, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1212002, '华星店', 1212, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1213001, '廊坊店', 1213, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1214001, '重庆店', 1214, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 13. 小鹏销售部门
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES (1310, '小鹏销售部门', 1300, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 14. 小鹏区域
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1311, '川边区域', 1310, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1312, '河北区域', 1310, 2, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);

-- 15. 小鹏门店
INSERT INTO system_dept (id, name, parent_id, sort, leader_user_id, phone, email, status, creator, create_time, updater, update_time, deleted, tenant_id) 
VALUES 
(1311001, '泸州店', 1311, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1),
(1312001, '廊坊店', 1312, 1, NULL, '', '', 0, 'admin', '2024-01-01 00:00:00', 'admin', '2024-01-01 00:00:00', 0, 1);