package polar.island.inlay.permission.service;

import polar.island.core.service.BasicService;
import polar.island.inlay.permission.entity.PermissionEntity;

import java.util.List;
import java.util.Map;

/**
 * 权限的服务类，其实现类标签为：permissionService,删除模式为：仅物理删除。
 *
 * @author PolarLoves
 */
public interface PermissionService extends BasicService<PermissionEntity, PermissionEntity> {
    /**
     * 由于仅有物理删除，此删除方法被移除
     */
    @Deprecated
    public Long deleteByIdLogic(String id);

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
     * 获取角色的所有权限
     *
     * @param roleId 角色编号
     * @return 角色权限
     */
    public List<PermissionEntity> rolePermissions(String roleId);

    /**
     * 获取资源的所有权限
     *
     * @param resourceId 资源编号
     * @return 资源权限
     */
    public List<PermissionEntity> resourcePermissions(String resourceId);

    /**
     * 更新角色的权限
     *
     * @param permissionIds 权限编号
     * @param roleId        角色编号
     */
    public void updateRolePermissions(String roleId, String[] permissionIds);

    /**
     * 更新资源的权限信息
     *
     * @param resourceId    资源编号
     * @param permissionIds 权限编号
     */
    public void updateResourcePermissions(String resourceId, String[] permissionIds);

    /**
     * 获取部门的所有权限
     *
     * @param orgId 部门编号
     * @return 查询到的权限
     */
    public List<PermissionEntity> orgPermissions(String orgId);


    /**
     * 更新部门的权限信息
     *
     * @param orgId         部门编号
     * @param permissionIds 权限编号
     */
    public void updateOrgPermissions(String orgId, String[] permissionIds);


}