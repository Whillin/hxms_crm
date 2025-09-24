-- 完全清理合同、发票、回款相关的菜单数据
-- 执行前请备份数据库

-- 1. 根据权限标识删除菜单项
DELETE FROM system_menu WHERE permission LIKE '%contract%';
DELETE FROM system_menu WHERE permission LIKE '%invoice%';
DELETE FROM system_menu WHERE permission LIKE '%receivables%';

-- 2. 根据菜单名称删除（中文）
DELETE FROM system_menu WHERE name LIKE '%合同%';
DELETE FROM system_menu WHERE name LIKE '%发票%';
DELETE FROM system_menu WHERE name LIKE '%回款%';

-- 3. 根据路径删除
DELETE FROM system_menu WHERE path LIKE '%contract%';
DELETE FROM system_menu WHERE path LIKE '%invoice%';
DELETE FROM system_menu WHERE path LIKE '%receivables%';

-- 4. 根据组件路径删除
DELETE FROM system_menu WHERE component LIKE '%contract%';
DELETE FROM system_menu WHERE component LIKE '%invoice%';
DELETE FROM system_menu WHERE component LIKE '%receivables%';

-- 5. 删除具体的权限标识（根据截图中的权限标识）
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

-- 6. 删除相关的角色菜单关联（分步执行避免子查询问题）
-- 先获取要删除的菜单ID，然后删除角色菜单关联
DELETE rm FROM system_role_menu rm 
INNER JOIN system_menu m ON rm.menu_id = m.id 
WHERE m.permission LIKE '%contract%' OR 
      m.permission LIKE '%invoice%' OR 
      m.permission LIKE '%receivables%' OR
      m.name LIKE '%合同%' OR 
      m.name LIKE '%发票%' OR 
      m.name LIKE '%回款%';

-- 7. 删除合同、发票相关的字典数据（如果还有残留）
DELETE FROM system_dict_data WHERE dict_type IN ('contract_check_status', 'contract_handle_status');
DELETE FROM system_dict_type WHERE type IN ('contract_check_status', 'contract_handle_status');

-- 8. 查询验证清理结果
SELECT '=== 验证清理结果 ===' as info;
SELECT '菜单项剩余(按权限):' as type, COUNT(*) as count FROM system_menu WHERE permission LIKE '%contract%' OR permission LIKE '%invoice%' OR permission LIKE '%receivables%';
SELECT '菜单项剩余(按名称):' as type, COUNT(*) as count FROM system_menu WHERE name LIKE '%合同%' OR name LIKE '%发票%' OR name LIKE '%回款%';
SELECT '字典类型剩余:' as type, COUNT(*) as count FROM system_dict_type WHERE type LIKE '%contract%' OR type LIKE '%invoice%';
SELECT '字典数据剩余:' as type, COUNT(*) as count FROM system_dict_data WHERE dict_type LIKE '%contract%' OR dict_type LIKE '%invoice%';

-- 9. 显示所有包含contract、invoice、receivables的菜单项（用于确认清理）
SELECT '=== 检查是否还有相关菜单 ===' as info;
SELECT id, name, permission, path, component FROM system_menu WHERE 
    permission LIKE '%contract%' OR 
    permission LIKE '%invoice%' OR 
    permission LIKE '%receivables%' OR
    name LIKE '%合同%' OR 
    name LIKE '%发票%' OR 
    name LIKE '%回款%' OR
    path LIKE '%contract%' OR
    path LIKE '%invoice%' OR
    path LIKE '%receivables%' OR
    component LIKE '%contract%' OR
    component LIKE '%invoice%' OR
    component LIKE '%receivables%';