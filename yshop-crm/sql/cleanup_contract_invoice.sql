-- 清理合同、发票相关的数据库配置
-- 执行前请备份数据库

-- 1. 删除合同、发票相关的字典数据
DELETE FROM system_dict_data WHERE dict_type IN ('contract_check_status', 'contract_handle_status');

-- 2. 删除合同、发票相关的字典类型
DELETE FROM system_dict_type WHERE type IN ('contract_check_status', 'contract_handle_status');

-- 3. 删除可能存在的合同、发票相关菜单项（如果有的话）
DELETE FROM system_menu WHERE name LIKE '%合同%' OR name LIKE '%发票%' OR name LIKE '%回款%';
DELETE FROM system_menu WHERE path LIKE '%contract%' OR path LIKE '%invoice%' OR path LIKE '%receivables%';

-- 4. 删除相关的角色菜单关联（如果有的话）
DELETE FROM system_role_menu WHERE menu_id IN (
    SELECT id FROM system_menu WHERE name LIKE '%合同%' OR name LIKE '%发票%' OR name LIKE '%回款%'
);

-- 5. 清理可能存在的权限数据
DELETE FROM system_menu WHERE permission LIKE '%contract%' OR permission LIKE '%invoice%' OR permission LIKE '%receivables%';

-- 查询验证清理结果
SELECT '=== 验证清理结果 ===' as info;
SELECT '字典类型剩余:' as type, COUNT(*) as count FROM system_dict_type WHERE type LIKE '%contract%' OR type LIKE '%invoice%';
SELECT '字典数据剩余:' as type, COUNT(*) as count FROM system_dict_data WHERE dict_type LIKE '%contract%' OR dict_type LIKE '%invoice%';
SELECT '菜单项剩余:' as type, COUNT(*) as count FROM system_menu WHERE name LIKE '%合同%' OR name LIKE '%发票%' OR name LIKE '%回款%';