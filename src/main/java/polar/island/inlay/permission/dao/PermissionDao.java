package polar.island.inlay.permission.dao;

import org.apache.ibatis.annotations.Param;
import polar.island.core.dao.BasicDao;
import polar.island.database.DAO;
import polar.island.inlay.permission.entity.PermissionEntity;

import java.util.List;
import java.util.Map;

/**
 * 权限的持久化层。
 *
 * @author PolarLoves
 */
@DAO(value = "permissionDao")
public interface PermissionDao extends BasicDao<PermissionEntity, PermissionEntity> {
    /**
     * 由于仅有物理删除，此删除方法被移除
     */
    @Deprecated
    public Long deleteByIdLogic(@Param(value = "id") String id);

    /**
     * 由于仅有物理删除，此删除方法被移除
     */
    @Deprecated
    public Long deleteByConditionLogic(Map<String, Object> condition);

    /**
     * 获取所有的权限
     *
     * @return 所有的权限
     */
    public List<polar.island.core.entity.TreeEntity> allPermission();

    /**
     * 依据权限编号删除角色的权限信息
     *
     * @param permissionId 权限编号
     * @return 删除的条目
     */
    public Long deleteRolePermissionByPermissionId(@Param(value = "permissionId") String permissionId);

    /**
     * 依据角色编号删除关联的权限信息
     *
     * @param roleId 角色编号
     * @return 删除条目
     */
    public Long deleteRolePermissionByRoleId(@Param(value = "roleId") String roleId);

    /**
     * 获取角色的所有权限
     *
     * @param roleId 角色编号
     * @return 查询到的权限
     */
    public List<PermissionEntity> rolePermissions(@Param(value = "roleId") String roleId);

    /**
     * 获取部门的所有权限
     *
     * @param orgId 部门编号
     * @return 查询到的权限
     */
    public List<PermissionEntity> orgPermissions(@Param(value = "orgId") String orgId);

    /**
     * 获取资源的所有权限
     *
     * @param resourceId 资源编号
     * @return 资源权限
     */
    public List<PermissionEntity> resourcePermissions(@Param(value = "resourceId") String resourceId);

    /**
     * 添加角色的权限
     *
     * @param condition 角色权限信息
     * @return 添加结果
     */
    public Long insertRolePermission(Map<String, Object> condition);

    /**
     * 依据资源编号删除资源的所有权限信息
     *
     * @param resourceId 资源编号
     * @return 删除结果
     */
    public Long deleteResourcePermissionByResourceId(@Param(value = "resourceId") String resourceId);

    /**
     * 添加资源的权限信息
     *
     * @param condition 资源权限信息
     * @return 添加结果
     */
    public Long insertResourcePermission(Map<String, Object> condition);

    /**
     * 获取最大的排序号
     *
     * @return 最大的排序号
     */
    public Long maxOrderNum();

    /**
     * 添加部门的权限
     *
     * @param condition 部门权限信息
     * @return 添加结果
     */
    public Long insertOrgPermission(Map<String, Object> condition);

    /**
     * 依据部门编号删除部门的所有权限信息
     *
     * @param orgId 部门编号
     * @return 删除结果
     */
    public Long deleteOrgPermissionByOrgId(@Param(value = "orgId") String orgId);
}
