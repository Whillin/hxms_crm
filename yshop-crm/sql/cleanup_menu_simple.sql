-- 分步清理合同、发票、回款相关的菜单数据
-- 执行前请备份数据库

-- 第一步：删除具体的权限标识菜单项
DELETE FROM system_menu WHERE permission = 'crm:contract:query';
DELETE FROM system_menu WHERE permission = 'crm:contract-receivables:query';
DELETE FROM system_menu WHERE permission = 'crm:invoice:query';
DELETE FROM system_menu WHERE permission = 'crm:contract:create';
DELETE FROM system_menu WHERE permission = 'crm:contract-receivables:create';
DELETE FROM system_menu WHERE permission = 'crm:invoice:create';
DELETE FROM system_menu WHERE permission = 'crm:contract:update';
DELETE FROM system_menu WHERE permission = 'crm:contract-receivables:update';
DELETE FROM system_menu WHERE permission = 'crm:invoice:update';
DELETE FROM system_menu WHERE permission = 'crm:contract:delete';
DELETE FROM system_menu WHERE permission = 'crm:contract-receivables:delete';
DELETE FROM system_menu WHERE permission = 'crm:invoice:delete';
DELETE FROM system_menu WHERE permission = 'crm:contract:export';
DELETE FROM system_menu WHERE permission = 'crm:contract-receivables:export';
DELETE FROM system_menu WHERE permission = 'crm:invoice:export';

-- 第二步：删除包含关键词的菜单项
DELETE FROM system_menu WHERE permission LIKE '%contract%';
DELETE FROM system_menu WHERE permission LIKE '%invoice%';
DELETE FROM system_menu WHERE permission LIKE '%receivables%';

-- 第三步：删除中文名称的菜单项
DELETE FROM system_menu WHERE name LIKE '%合同%';
DELETE FROM system_menu WHERE name LIKE '%发票%';
DELETE FROM system_menu WHERE name LIKE '%回款%';

-- 第四步：删除路径相关的菜单项
DELETE FROM system_menu WHERE path LIKE '%contract%';
DELETE FROM system_menu WHERE path LIKE '%invoice%';
DELETE FROM system_menu WHERE path LIKE '%receivables%';

-- 第五步：删除组件相关的菜单项
DELETE FROM system_menu WHERE component LIKE '%contract%';
DELETE FROM system_menu WHERE component LIKE '%invoice%';
DELETE FROM system_menu WHERE component LIKE '%receivables%';

-- 验证清理结果
SELECT '=== 验证清理结果 ===' as info;
SELECT '菜单项剩余(按权限):' as type, COUNT(*) as count FROM system_menu WHERE permission LIKE '%contract%' OR permission LIKE '%invoice%' OR permission LIKE '%receivables%';
SELECT '菜单项剩余(按名称):' as type, COUNT(*) as count FROM system_menu WHERE name LIKE '%合同%' OR name LIKE '%发票%' OR name LIKE '%回款%';